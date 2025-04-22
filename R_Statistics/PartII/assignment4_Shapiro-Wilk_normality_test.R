Task 2:
# Needed data:
birds <- c( 57,31,25,32,33,10,18,9,12,14,10,26,4,16,13)
altitude <- c(2397,1264,1170,1060,1900,460,1998,700,735,613,662,1502,750,2275,552)

lin_model <- lm(altitude~birds)
residuals_ <- lin_model$residuals


# We shall use this package to check out the residuals: 
#install.packages("nortest") # install the needed package
library(nortest) # load package


# 1. Anderson_Darling test for normality:
p1 <- ad.test(residuals_)$p.value

# 2. Cramer-von Mises test for normality:
p2 <- cvm.test(residuals_)$p.value

# 3. Lilliefors (Kolmogorov-Smirnov) test for normality:
p3 <- lillie.test(residuals_)$p.value

# 4. Pearson chi-square test for normality:
p4 <- pearson.test(residuals_, n.classes=length(residuals_))$p.value # hiier noch was einfügen???????????? 
p5 <- sf.test(residuals_)$p.value


p_average <- (p1+p2+p3+p4+p5)/5


Task 3:

# Inspired by https://at.fuelo.net/?lang=en:
time <- c(1,2,3,4,5,6,7)
price <- c(1.695, 1.69,1.675,1.68,1.685,1.72,1.69)

petrol_model <- lm(price~time)

petrol_residuals <- petrol_model$residuals

# Reuse the test techniques from task 2 again: 

p1_p <- ad.test(petrol_residuals)$p.value

# 2. Cramer-von Mises test for normality:
p2_p <- cvm.test(petrol_residuals)$p.value

# 3. Lilliefors (Kolmogorov-Smirnov) test for normality:
p3_p <- lillie.test(petrol_residuals)$p.value

# 4. Pearson chi-square test for normality:
p4_p <- pearson.test(petrol_residuals, n.classes=length(petrol_residuals))$p.value

# 5. Shapiro_Francia test for normality:
p5_p <- sf.test(petrol_residuals)$p.value


p_average_p <- (p1_p+p2_p+p3_p+p4_p+p5_p)/5

shapiro_wilk_test <- shapiro.test(petrol_residuals)
saphiro_wilk <- ks.test(petrol_residual, "pnorm"p_)

price2 <- price[-1] # remove first element from price vector
price3 <- price[-length(price)] # remove last element

jump <- price2-price3
jump_model <- lm(jump~time[-1])
plot(jump)


jump_residuals <- jump_model$residuals


shapiro_wilk_test2 <- shapiro.test(jump_residuals)
