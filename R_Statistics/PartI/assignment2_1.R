13a
start <- c(0, 10, 20, 30, 50, 100)
end <- c(10, 20, 30, 50, 100, 0)
start+end
class_mark = (start+end)/2
lengthd <- end - start
13b
number <- c(47996, 191492, 124498, 104428, 67988, 31125)
table_13 <- cbind(number_of_people = number, income_classmark = class_mark, start=start, end=end, length_class = lengthd, relative_frequency =rel_fre_13)
rel_fre_13 <- prop.table(number))
13c part 1
ff <- start < 30
dframe <- data.frame(number, ff)
fff <- subset(dframe, ff == TRUE)
sum_not_rich = sum(fff)
fff_richer <- subset(dframe, ff == FALSE)
remaining_sum_richer <- sum(fff_richer)
final_sum = sum_not_rich + remaining_sum_richer
percentage_smaller_30 <- sum_not_rich*100/final_sum
13c part 2
start_until_30 <- start < 50
dframe2 <- data.frame(number, start_until_30)
subset_normal <- subset(dframe2, start_until_30 == TRUE)
normal_income_people <- sum(subset_normal$number)
subset_rich <- subset(dframe2, start_until_30 == FALSE)
rich_income_people <- sum(subset_rich)
normal_income <- normal_income_people*100/final_sum
13c part 3:
rich_income_people <- sum(subset_rich)
rich_percentage <- rich_income_people*100/final_sum
 


