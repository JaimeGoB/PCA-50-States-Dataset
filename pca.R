library(PerformanceAnalytics)
library(skimr) # to view report on data
library(beeswarm) # plot points in boxplot
library(ggplot2)
library(maps)

# state.x77:
#   matrix with 50 rows and 8 columns giving the following statistics in the respective columns.
# 
# Population:
#   population estimate as of July 1, 1975
# 
# Income:
#   per capita income (1974)
# 
# Illiteracy:
#   illiteracy (1970, percent of population)
# 
# Life Exp:
#   life expectancy in years (1969–71)
# 
# Murder:
#   murder and non-negligent manslaughter rate per 100,000 population (1976)
# 
# HS Grad:
#   percent high-school graduates (1970)
# 
# Frost:
#   mean number of days with minimum temperature below freezing (1931–1960) in capital or large city
# 
# Area:
#   land area in square miles

##################################################
# (a) Perform an exploratory analysis of the data.
##################################################

#Reading dataset
states <- data.frame(state.x77)
#Checking the datatypes from predictor variables
str(states)

# Mean, Variance & SD
Mean <- apply(states, 2, mean)
Variance<- apply(states, 2, var)
Standard_Deviation <- apply(states, 2, sd)

stats_states <- cbind(Mean, Variance, Standard_Deviation)
stats_states

# Correlation coefficient (r) - The strength of the relationship.
# p-value - The significance of the relationship. Significance codes 0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# Histogram with kernel density estimation and rug plot.
# Scatter plot with fitted line.
chart.Correlation(states, histogram=TRUE, pch=19)

# Plotting Box plots for all values
par(mfrow=c(2,4))
for (i in 1:length(states)) {
  boxplot(states[,i], main=names(states[i]), type="l", col = "#F8766D")
  #plotting points
  beeswarm(states[,i], add=T, col = "#00BFC4", pch = 16)
  
}
par(mfrow=c(1,1))


##################################################
# (b) Do you think standardizing the variables before performing the 
# analysis would be a good idea?
##################################################

# Yes, because the variables are all on different scales. 
# The variables with biggest values will take over.
states <- scale(states)
states
##################################################
# (c) Regardless of your answer in (b), standardize the variables, 
# and perform a principal components analysis (PCA) of the data. 
# Summarize the results using appropriate tables and graphs. 
# How many PCs would you recommend?
##################################################


#Loading matrix ( 8x8)
#8 eigen values each eigven value gives a eigen vector of size 8
#First Column is first eigen vector
# By default, eigenvectors in R point in the negative direction.
principle_component_states <- prcomp(states, center = TRUE, scale = TRUE)
principle_component_states

# The point of PCA is to significantly reduce the number of variables, 
# we want to use the smallest number of principal components possible 
# to explain most of the variability.


##################################################
# (d) Focus on the first two PCs obtained in (c). 
# Prepare a table showing the correlations of the standardized variables
# with the components and the cumulative percentage of 
# the total variability explained by the two components. 
# Also, display the scores on the two components and the loadings on 
# them using a biplot. Interpret the results. 
# Can you identify, for example, a “southern” component?
##################################################

# table-correlations of the standardized variables with the components and 
score_cov_matrix <- round(cov(principle_component_states$x), 3)
score_cov_matrix 

###### correlation between x's and pc1 ###### 
covariance_pc_predictors <- c()

#Iterating thorugh PC's
for(j in 1:dim(principle_component_states$x)[2]){
  #initializing an empty vector to store covariances
  cov_j_i <- c()
  #Iterating through all predictors
  for (i in 1:length(states)) {
    # COV( Z_j , x_j)
    cov_j_i <- cov(principle_component_states$x[,j] , states[,])
  }
  #store covariances for each pc_j vs predictors
  covariance_pc_predictors <- rbind(covariance_pc_predictors, cov_j_i)
}

rownames(covariance_pc_predictors) <- c("PC1", "PC2","PC3","PC4","PC5","PC6","PC7","PC8")
covariance_pc_predictors

###### the cumulative percentage of the total variability explained by the two components ######
principle_component_var <- principle_component_states$sdev^2
proportion_variance_explained_pc <- principle_component_var/sum(principle_component_var)
proportion_variance_explained_pc_total <- cumsum(proportion_variance_explained_pc)

proportion_variance_explained_pc_total


par(mfrow=c(1,1))
###### Displaying scores of components ######
plot(proportion_variance_explained_pc_total, 
     main = "Number of Principle Components VS \nCumulative Proportion of Variance Explained",
     xlab = "Principal Component", 
     ylab = "Cumulative Proportion of Variance Explained", 
     ylim = c(0,1), 
     type = 'b',
     lty = 5,
     pch = 16,
     col = "red"
     )
legend("bottomright", pch = 16, legend = "Principle Component", col = "red")


####### Plotting first two principle components #######
biplot(principle_component_states, scale = 0)

#Reference:
#https://liuyanguu.github.io/post/2019/04/17/ggplot-heatmap-us-50-states-map-and-china-province-map/
library(ggplot2)
library(maps)
library(usmap)
library(data.table)
library(ggsn) # for scale bar `scalebar`
library(ggrepel) # if need to repel labels 

state_illiteracy_df <- as.data.table(copy(state.x77))
state_illiteracy_df$state <- tolower(rownames(state.x77))
state_illiteracy_df <- state_illiteracy_df[,.(state, Illiteracy)]
# only need state name and variable to plot in the input file:
str(state_illiteracy_df) 
us_map <- usmap::us_map() # used to add map scale

usmap::plot_usmap(data = state_illiteracy_df, values = "Illiteracy", labels = T)+
                  labs(fill = 'Illiteracy Percent') + 
                  ggtitle("Illiteracy Percentage per State")+
                  theme(plot.title = element_text(lineheight=.8, face="bold", hjust = .5)) +
                  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90",
                  guide = guide_colourbar(barwidth = 25, barheight = 0.4,
                  title.position = "top")) +
# map scale
ggsn::scalebar(data = states, dist = 500, dist_unit = "km",
               border.size = 0.4, st.size = 4,
               box.fill = c('black','white'),
               transform = FALSE, model = "WGS84")  + 
# put legend at the bottom, adjust legend title and text font sizes
theme(legend.position = "bottom",
      legend.title=element_text(size=12), 
      legend.text=element_text(size=10))
