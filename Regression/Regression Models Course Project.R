library(car)
library(ggplot2)

##prep data
dat <- mtcars
dat$am <- as.factor(dat$am)
levels(dat$am) <- c("automatic", "manual")
dat$vs <- as.factor(dat$vs)

##boxplot
ggplot(dat, aes(am, mpg)) + 
  geom_boxplot(fill = "light blue") + 
  ggtitle("Transmission: Auto[0] vs Manual[1]") + xlab("transmission")

##pairs plot
pairs(dat)

##correlation matrix
cor(dat[,c(2:7,10:11)])

##calculate variance inflation for each variable (except vs and am)
sqrt(vif(glm((mpg*10) ~ . -am, "poisson", dat)))

##generate models without vs
fit2.1 <- glm((mpg*10) ~ am + wt -1, "poisson", dat)
fit2.2 <- update(fit2.1, (mpg*10) ~ am + wt + qsec - 1)
fit2.3 <- update(fit2.1, (mpg*10) ~ am + wt + qsec + carb - 1)
fit2.4 <- update(fit2.1, (mpg*10) ~ am + wt + qsec + carb + drat - 1)
fit2.5 <- update(fit2.1, (mpg*10) ~ am + wt + qsec + carb + drat + gear - 1)
##model 2.2 wins

##evaluate variance; test models
anova(fit2.1, fit2.2, fit2.3, fit2.4, fit2.5, test = "Chisq")
##model 2.2 wins

##model diagnostics includes plot of Residuals vs Fitted
par(mfrow = c(2, 2))
plot(fit2.2)

##create confidence interval
exp(confint(fit2.2))