# 32 a):
year1 <- c(5,3,10,9,13,18,21,27,10,5)
year2 <- c(35,24,13,8,9,4,2,0,0,2)
start <- c(0,1,2,3,4,5,6,7,8,9)
end <-  c(1,2,3,4,5,6,7,8,9,10)
length <- end - start
class <- (start + end)/2
year11 <- c(rep(class,year1))
year22 <- c(rep(class,year2))

cumradio11 <- cumsum(year1)
cumradio111 <- cumsum(round(table(year11)/length(year11)*100,2))
cumradio22 <- cumsum(year2) 
cumradio222 <- cumsum(round(table(year22)/length(year22)*100,2))
                                          
sum1 <- sum(year1)
sum2 <- sum(year2)

cumulated1 <- cumsum(year1)
cumulated2 <- cumsum(year2)

table1 <- cbind(length = length, start=start, end=end, cumulated = cumradio11, cumrel=cumradio111, absolute = year1)
table2 <- cbind(length = length, start=start, end=end, cumulated = cumradio22, cumrel=cumradio222, absolute = year2)

arimean1 <- (sum(year1*((start+end)/2)))/sum1
arimean2 <- (sum(year2*((start+end)/2)))/sum2

# 34 a):
bmi <- c(3,21,19,5,2)
start <- c(16,20,24,28,32)
end <- c(20,24,28,32,36)
sumbmi <- sum(bmi)
arimean <- (sum(bmi*((start+end)/2)))/sumbmi
# c):
bmiclass <- (start+end)/2
bminew <- c(rep(bmiclass, bmi))

cumfrerel <- cumsum(round(table(bminew)/length(bminew)*100,2))
tablebmi <- cbind(start=start, end=end, cumulated = cumfrerel, absolute = bmi)

# 35:
bacf <- c(30,40,30,50)
start <- c(50,150,200,250)
end <- c(150,200,250,300)
baclength <- end - start
bacclass <- (start+end)/2
bac <- c(rep(bacclass, bacf))
cumbacrel <- cumsum(round(table(bac)/length(bac)*100,2))
sumbac <- sum(bacf)
tablebac <- cbind(start=start, end=end, class = bacclass, length=baclength, cumulated = cumbacrel, absolute = bacf)