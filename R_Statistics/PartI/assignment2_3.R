15:
tree <- c(37,46,42,51,83,79,58,102,130,141,149,152,149,169,171,186,153,190)
hist(tree, freq = FALSE, ylim = c(0, 0.01), xlim = c(0,200),c(0,30,60,90,150,180,200), main = "Histogram: size christmas trees", xlab = "height in cm")


16: part 1:
number_resi <- c(1,2,3)
population <- 1000
number_three_residences <- 50
number_one_residence <- 80*population/100
number_two_residences <- population - number_one_residence - number_three_residences
number_residences <- c(number_one_residence, number_two_residences, number_three_residences)

rel_resi <- prop.table(number_residences)*100
cumu_table <- cumsum(rel_resi)
finaltable <- cbind(number_of_residences = number_resi, relative_frequency=rel_resi, cumulated_relative_frequency = cumu_table)
16 part 2:
new_number <- c(rep(1,number_one_residence), rep(2,number_two_residences), rep(3, number_three_residences))
plot.stepfun(new_number, main = "Cumulative relative frequencies for the number of residences", ylab="", xlab="Number of residences")

17: part 1:
four <-c(rep(seq(0,20,0.1),10),rep(seq(20,40, 0.1),30), rep(seq(40,60, 0.1),40),rep(seq(60,80, 0.1),20))
plot.stepfun(four, main = "empirical cumulative distribution function", xlab = "age", xlim = c(0,80))
part 2:
hist(four, c(0,20,40,60,80), main = "Histogram: age distribution of 100 persons", xlab="age intervals")

intervals: https://cran.r-project.org/web/packages/intervals/intervals.pdf
> f1 <- Intervals( 1:2, type = "Z" )
> adjust_closure(f1, close_left = TRUE, close_right = FALSE)
In general!!!!: plot(y-achsenwunsch ~ x-achsenwunsch)
plot(Function,a,b)#Erzeugt einen Plot vonFunctionim Intervall von a bis b
curve(Function,a,b)#Erzeugt einen Plot vonFunctionim Intervall von a bis b
seq(10, 20, by=1.5)

