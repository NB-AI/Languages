#18. a)
#ges: harmonic mean
distance <- c(39,35,25,37,15,36,50,52,37,51,39)
harm_mean <- function(distance) {length(distance)/sum(1/distance)}
harm_mean(distance)
# ges: arithmetic mean
mean(distance)

# 18. b)
# anscheinends ist diese Funktion wie die in Python:
# Diese Funktion gibt uns nur einen von zwei modes!!!
 getmode <- function(x) {
        uniq <- unique(x) 
        uniq[which.max(tabulate(match(x, uniq)))]
        }
mode <- getmode(distance)

# try it with data frame
abs <- table(distance) # absolute values in table
dt <- data.frame(abs)
m <- max(abs)
sub <- subset(dt, Freq == m)
sub$distance

# 18. c)
summary(distance)


# 19. a)
# Assumption discrete attribute:
values <- c(rep(2, 3), rep(3,6), rep(4,3), rep(5,2), rep(6,4))
mean(values)

# 19. b)
# Assumption continuous attribute:
start <- c(2,3,4,5,6)
end <- c(3,4,5,6,7)
classmark <- (start+end)/2

fi <- c(3,6,3,2,4)
total_samples <- sum(fi)

sum(classmark*fi)/total_samples


# 20. a)
priceperkg <- c(1.14,1.32,1.45)
# normal arithmetic mean
mean(priceperkg)

# 20. b)
quantity <- c(30,10,5)
total_costs <- quantity * priceperkg
# weighted mean =
sum((quantity/sum(quantity)*priceperkg)/(sum(quantity/sum(quantity))))


# 21. a)
rev <- c(121,152,136,140,122,131,136)
mean(rev)

# 21. b)
average_growth_rate <- (((rev[7]/rev[1])^(1/6)) -1)*100

# 22. a)
salary <- c(1390,1780,1511,1688,1621,1410,1320, 9735)
summary(salary)
# or:
mean(salary)
median(salary)


# 23. a)
telecosts <- c(71.92,74.20,81.60,218.40,72.46,73.68,60.88,63.36,81.08,63.20,74.32,77.88)
mean(telecosts)

# 23. b)
median(telecosts)
telecosts2 <- telecosts[-4]
mean(telecosts2)
average_growth_rate2 <- ((telecosts[12]/telecosts[1])^(1/11) -1)*100
summary(telecosts)


# 24.


# 25. a)
class_lunch <- c(0,1,2,3,4,5)
fre_rel_lunch <- c(0.1,0.3,0.3,0.1,0.2,0.0)
mean_lunch <- sum(class_lunch*fre_rel_lunch)

# 25. b)
summary(class_lunch*fre_rel_lunch)
try <-  c(rep(0,1),rep(1,3),rep(2,3),rep(3,1),rep(4,2),rep(5,0))
mean(try)
median(try)


# 26. a)
fa <- c(0,10,26,28,25,11,0)
fb <- c(3,5,24,40,20,4,4)
fc <- c(0,4,24,40,20,4,8)
start <- c(1,6,11,16,21,26,31)
end <- c(6,11,16,21,26,31,36)
  
sumfa <- sum(fa)
sumfb <- sum(fb)
sumfc <- sum(fc)

arimeanfa <- (sum(fa*((start+end)/2)))/sumfa
arimeanfb <- (sum(fb*((start+end)/2)))/sumfb
arimeanfc <- (sum(fc*((start+end)/2)))/sumfc

# 26. b)
lengthd <- end-start
cumufa <- cumsum(fa)
cumufb <- cumsum(fb)
cumufc <- cumsum(fc)

tablefa <- cbind(length = lengthd, start=start, end=end, cumulated = cumufa, absolute = fa)
lengthd <- end-start
cumufa <- cumsum(fa)
cumufb <- cumsum(fb)
cumufc <- cumsum(fc)

tablefa <- cbind(length = lengthd, start=start, end=end, cumulated = cumufa, absolute = fa)


lengthd <- end-start
cumufa <- cumsum(fa)
cumufb <- cumsum(fb)
cumufc <- cumsum(fc)

tablefa <- cbind(length = lengthd, start=start, end=end, cumulated = cumufa, absolute = fa)

tablefb <- cbind(length = lengthd, start=start, end=end, cumulated = cumufb, absolute = fb)
tablefc <- cbind(length = lengthd, start=start, end=end, cumulated = cumufc, absolute = fc)
# rest on exercise sheet

# 26. c):
# calculated on exercise sheet


# 27: