#------------------------------------------
#Creating Charts with R
#------------------------------------------


#number of caries teeth from 30 children
x<-c(1,3,3,3,6,0,1,0,0,1,1,3,0,4,3,1,4,6,4,2,1,1,1,0,1,1,1,1,0,3)
table(x)

#pie chart
pie(table(x))
pie(table(x),col = gray(seq(0.4, 1.0, length = 6)))
pie(table(x),col = c("red","green"),main="Our not so beautiful Pie-Chart")

#bar chart
barplot(table(x),main="Number of Caries Teeth",ylab="absolute frequency",xlab="attribute values")

#histogram
hist(x)
hist(x,freq=FALSE,main="Histogram")
hist(x,breaks=3)
hist(x,c(0,2,6))#user defined breaks
#hist(x,c(1,2,6))#error because the data is not completely classified

#empirical cumulative distribution function
plot(ecdf(x))
plot.stepfun(x,ylab="F(x)",col="red",pch=16)

#simulating some normally distributed random variables
y<-rnorm(1000,mean=0,sd=1)
hist(y)
plot(ecdf(y))
plot.stepfun(y,ylab="F(x)",col="red",pch=16)

#exporting a chart as jpeg
x<-c(1,3,3,3,6,0,1,0,0,1,1,3,0,4,3,1,4,6,4,2,1,1,1,0,1,1,1,1,0,3)
jpeg(file = "my_barplot.jpeg",width = 680, height = 480) 
barplot(table(x),col="green",main="Number of Caries Teeth",ylab="f(x)")
dev.off()



#------------------------------------------
#Measures of Location
#------------------------------------------

x<-c(2,3,5,1,6)

#arithmetic mean
mean(x)


y<-c(1.2,1.25,2/3)
#function for calculating the geometric mean
geo_mean<-function(x) {prod(x)^(1/length(x))}
geo_mean(y)

#or use a package for calculating the geometric mean 
library(psych)
geometric.mean(x)

y<-c(40,80)
#function for calculating harmonic mean 
har_mean<-function(x) {length(x)/sum(1/x)}
har_mean(y)


#---------------------------------
#age of 20 people
y<-c(34,39,35,25,20,37,15,22,28,25,33,31,19,29,27,21,22,28,22,11)

#tables with summary statistics
#the 20 people are splitted into 2 groups
group<-c(rep("A",length(y)/2),rep("B",length(y)/2))
library(RcmdrMisc)
numSummary(y,groups=group)
numSummary(y,groups=group,statistics=c("mean","quantiles"), quantiles=c(0.5))

#adding gender to the 20 people
gender<-as.factor(round(runif(20,1,2)))#uniform distributed random variables
levels(gender)<-c("male","female")
gender

table(gender)
table(group)
table(group,gender)

#create compact tables representing the mean
tapply(y,group,mean)
round(tapply(y,list("Treatment Group"=group,"Gender"=gender),mean),2)

#or use aggregate 
dat<-data.frame(y,group,gender)
aggregate(y~group,dat, FUN="mean")
aggregate(y~gender+group,dat, FUN="mean")


#creating a chart vizualising mean and median
means<-tapply(y,gender,mean)
medians<-tapply(y,gender,median) 
r<-t(rbind(means,medians))
#object containg mean and median
r

barplot(r)
b<-barplot(r,col=c("blue","red"),ylim=c(0,50),beside=T,axisnames=FALSE,main="Age in Years") 
legend("topright",c("male","female"),col=c("blue","red"),pch=15) 
text(x=b,y=c(r[1],r[2],r[3],r[4]),labels=c(round(r[1],2), round(r[2],2),round(r[3],2),round(r[4],2)),pos=3,col="black",cex=1.25)
axis(1,labels=c("mean-male","mean-female","median-male","median-female"), at = b, tick= TRUE)
box()



#------------------------------------------
#Measure of Location for Grouped Data
#------------------------------------------

#some continuous grouped data
#f ... frequency
#x ... class mark
f<-c(0,10,26,28,25,11,0)
x<-c(3.5,8.5,13.5,18.5,23.5,28.5,33.5)
#creating an estimator for the raw data list
raw<-rep(x,f)
table(raw)

#calculating the mean based on our formula
sum(x*f)/sum(f)
#or use ...
mean(raw)




#------------------------------------------
#Quantiles for Raw Data
#------------------------------------------

#age of 20 people
y<-c(34,39,35,25,20,37,15,22,28,25,33,31,19,29,27,21,22,28,22,11)

#Tukey's five numbers
fivenum(y)
summary(y)

#quantiles
quantile(y)
quantile(y,type=5) #type 5 = similar to tukey, default is  type 7
quantile(y,type=5,probs=c(0.5)) 



#------------------------------------------
#Quantiles for Grouped Data
#------------------------------------------

#some continuous grouped data
#f ... frequency
#x ... class mark
f<-c(0,10,26,28,25,11,0)
x<-c(3.5,8.5,13.5,18.5,23.5,28.5,33.5)
#creating an estimator for the raw data list
raw<-rep(x,f)
table(raw)

#our estimator for calculating quantiles is not implemented in R
#biased quantiles
quantile(raw,probs=c(0.25,0.5,0.75))
fivenum(raw)


