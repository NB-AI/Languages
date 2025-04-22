#R as a calculator
2+4
sqrt(4)
log(2)
exp(0.6931472)
factorial(3)

#assign data to objects called weight and height
weight=c(60,72,57,90,95,72)
height<-c(1.75,1.81,1.65,1.91,1.75,1.90)

#calculations based on these objects
bmi<-weight/height^2
round(bmi,0)
length(bmi)

#logical operations
bmi>30
bmi==30


#vector containing text
gender <-c("m","f","m","m","f","m")
table(gender)

#sequence of numbers
seq(3,9,2)

3:9

#repeated sequences
rep(1:3,c(5,5,6))

c(rep("m",3),rep("f",3))


#matrix object
x<-c(1:12)
x
dim(x)<-c(3,4)

#or use the command matrix 
x<-matrix(1:12,6,2)
x

#assign names to the rows and columns
rownames(x)<-LETTERS[1:6]
colnames(x)<-c("C1","C2")

t(x)

#combine vectors to a matrix
cbind(A=1:4,B=5:6,C=9:12)

rbind(A=1:4,B=5:6,C=9:12)

#constructing a data frame based on 2 variables
x<-rnorm(10,mean=0,sd=1)
y<-rnorm(10,5,1)
help(rnorm)
d<-data.frame(x,y)
View(d)


mean(d$x)

#accessing specific variables of a data frame
d$x

d$y

#you can also use d[1] or d[2] to access the first
#or second column of the data frame
d[1] 
d[2]


d$y[2]#second element of variable y

d$y[c(1,2)]

d$y[-2]



#filtering (subsetting)
d[d$x>1,]


d[d$x>0&d$y<5,]#and
d[d$x>0|d$y<5,]#or 



#define a working directory
setwd("/Users/tfk/R-Working")
getwd()


#import a csv-file from working directory
pain_med <- read.csv("pain_data.csv",dec=",",sep=";",header=TRUE)

#subset all female patients
subset(pain_med,gender =="Female")

#subset all female patients over 50 years
subset(pain_med,gender =="Female" & age >50)


#subset all patients with poor or fair health
#order by age
x<-subset(pain_med, health =="Poor" | health =="Fair")
x[order(x$age),] 


#number of caries teeth from 30 children
x<-c(1,3,3,3,6,0,1,0,0,1,1,3,0,4,3,1,4,6,4,2,1,1,1,0,1,1,1,1,0,3)
table(x)
round(table(x)/length(x)*100,2)
prop.table(table(x))
round(prop.table(table(x)),2)

#cumulated frequencies
h1<-table(x)
cumsum(h1)

h2<-round(table(x)/length(x)*100,2)
cumsum(h2)

#or use a package
#install.packages("Hmisc")#install package before first time use
library(Hmisc)#load package
describe(x)

#sink the output to a text file in the working directory
sink("output.txt")
table(x)

sink(file=NULL) 
#sink the output to the console again
table(x)

#sink the output to a text file and show on console
sink("output_both.txt",split=TRUE)
table(x)


#export a table as csv-file
write.table(table(x),file="export.csv",sep=";",row.names=FALSE)

#export a table as html-file or create a latex-code
library(xtable)#load package
tab<-xtable(table(x))
print(tab,file="table1.html",type="html")
print(tab,file="table1.tex",type="latex")

