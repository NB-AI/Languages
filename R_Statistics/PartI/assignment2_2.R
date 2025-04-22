14a):
size <- c(1,2,3,4,5)
household_number <- c(380131, 182838,87444,52033,20235)
sec_rel <- prop.table(household_number)
table_finfin <- cbind(household_size = size, absolute_frequencies = household_number, relative_frequencies = sec_rel
munich <- barplot(sec_rel, main = "Relative frequencies to the houshold size in Munich", xlab="Householdsize", ylim=c(0,0.6), col = "aquamarine")
axis(1, labels = c("1","2","3","4","5 or more"), at = munich, tick = TRUE)

14b):
not_alone <- sum(household_number[2], household_number[3], household_number[4], household_number[5])
big_sum <- sum(household_number)
not_alone_percent <- not_alone*100/big_sum
alone_percent <- 100 - not_alone_percent