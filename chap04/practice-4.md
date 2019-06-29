Practice 4
================

Data import and preprocess

``` r
set.seed(123)

N1 <- 30
N2 <- 20
Y1 <- rnorm(n=N1, mean=0, sd=5)
Y2 <- rnorm(n=N2, mean=1, sd=4)
```

## Visualize (Assignment 1)

``` r
# Preprocess and visualize
d1 <- data.frame(Y=Y1, G=factor(1))
d2 <- data.frame(Y=Y2, G=factor(2))
d <- rbind(d1, d2)

d %>%
    ggplot(aes(y=Y, x=G)) +
    geom_boxplot()
```

![](practice-4_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

## Make a model (Assignment 2)

  - \(\mu[n] = b_1 + b_2 G[n]\) (transformed parameter)
  - \(Y[n] \gets Normal(\mu[n], \sigma)\)

## Make stan files and excute them (Assignment 3)

``` r
data <- list(N1 = N1,
             N2 = N2,
             Y1 = Y1,
             Y2 = Y2)
fit <- stan(file='model/practice-4-3.stan', data=data, seed=1234)
```

    ## hash mismatch so recompiling; make sure Stan code ends with a blank line

``` r
save.image(file="output/practice-4-3.RData")
summary(fit)$summary[c("mu1","mu2","sigma"),]
```

    ##             mean     se_mean        sd       2.5%        25%        50%
    ## mu1   -0.2426412 0.013965211 0.8321035 -1.9010176 -0.7935954 -0.2269076
    ## mu2    1.6242532 0.016576077 0.9954570 -0.2927636  0.9313742  1.6158343
    ## sigma  4.4861548 0.007858947 0.4648794  3.6857177  4.1665195  4.4448107
    ##             75%    97.5%    n_eff      Rhat
    ## mu1   0.3177925 1.363310 3550.256 0.9997081
    ## mu2   2.2793784 3.619429 3606.463 1.0003757
    ## sigma 4.7685733 5.518103 3499.064 0.9996355

## Culculate P(mu\_1 \< mu\_2) (Assignment 4)

``` r
# fit
load("output/practice-4-3.RData")

# mcmc sample
ms <- rstan::extract(fit)

# calculate True==1, False==0
mean(ms$mu1 < ms$mu2)
```

    ## [1] 0.932

## different sigma (Assignment 5)

``` r
fit.2 <- stan(file='model/practice-4-5.stan', data=data, seed=1234)
```

    ## hash mismatch so recompiling; make sure Stan code ends with a blank line

``` r
save.image(file="output/practice-4-5.RData")
summary(fit.2)$summary[c("mu1","mu2","sigma1","sigma2"),]
```

    ##              mean    se_mean        sd        2.5%       25%        50%
    ## mu1    -0.2395227 0.01542570 0.9346314 -2.06589686 -0.870488 -0.2340006
    ## mu2     1.6380104 0.01398156 0.8454731 -0.05917425  1.086932  1.6336501
    ## sigma1  5.1189436 0.01124781 0.6941237  3.98317704  4.627935  5.0389683
    ## sigma2  3.6283112 0.01141876 0.6485638  2.63222500  3.164670  3.5438581
    ##              75%    97.5%    n_eff      Rhat
    ## mu1    0.3913031 1.618546 3671.056 1.0003785
    ## mu2    2.1931292 3.328190 3656.690 0.9992783
    ## sigma1 5.5320654 6.675487 3808.357 1.0009125
    ## sigma2 3.9852044 5.150714 3226.022 0.9993150

``` r
# fit
load("output/practice-4-5.RData")

# mcmc sample
ms.2 <- rstan::extract(fit.2)

# calculate True==1, False==0
mean(ms.2$mu1 < ms.2$mu2)
```

    ## [1] 0.93725
