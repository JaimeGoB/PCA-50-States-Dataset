# PCA-50-States-Dataset

## Dataset - United Sates- Life Quality 1977

- **state.x77:**

  matrix with 50 rows and 8 columns giving the following statistics in the respective columns.

- **Population:**
  
  population estimate as of July 1, 1975

- **Income:**
  
  per capita income (1974)

- **Illiteracy:**
  
  illiteracy (1970, percent of population)

- **Life Exp:**
  
  life expectancy in years (1969–71)

- **Murder:**
  
  murder and non-negligent manslaughter rate per 100,000 population (1976)

- **HS Grad:**
  
  percent high-school graduates (1970)

- **Frost:**
  
  mean number of days with minimum temperature below freezing (1931–1960) in capital or large city

- **Area:**
  
  land area in square miles


# Exploratory Data Analysis

## Statistics from Dataset

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/stats.png"  />

## Covariance Matrix, Scatterplots and Histograms of Dataset

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/cov-histogram-scatter-plots.png"  />

## Boxplots

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/boxplots.png"  />

## Principle Component Analysis on the Dataset

The dataset has 8 predictor variables. Therefore the minimum amount of Principle Components are 8 ( min(n-1, p)).

We are able to see that the first 4 principle components have unique values. After the fourth component they start using predictors already used.
Therefore, we will only care up to PC4, thus slashing the predictors in half.

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/pca.png"  />

##  Correlation among Principle Components

We are also able to see that none of the principle components are correlated to each other. This can be seen because only the diagonal elements are non-zero.

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/cov_matrix.png"  />

## Correlation between Principle Components and Predictors


I noted that highest covariance values represent the eigenvectors with strongest relationship to that dimension.

It is also evident to see that the higher the PC the weaker the covariance.

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/correlation_pc_predictors.png"  />

## Proportion of Variance Explained By Each Principle Component

The Cumulative sum explained by each PC is:
<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/pve-values.png"  />


<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/pve.png"  />

## PCA1 vs PCA2

<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/pca1-vs-pc2.png"  />


## Find a trend in "southern states"

From the previous plot it is evident to see that illiteracy rates are a commen trend for southern states.
<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/southern.png"  />

# From a map of the US with its Percent of Illiteracy rates we can conclude that southern states have higher illetaracy rates.
<img src="https://github.com/JaimeGoB/PCA-50-States-Dataset/blob/main/data/illiteracy.png"  />







