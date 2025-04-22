taylor_function <-function(x)
{i <- 0; not_matters <-3; sum_old <- 0; sum_now<-0;while(not_matters<4){next_summand<-x^i/factorial(i);sum_now<- sum_old + next_summand;i<-i+1;if(abs(next_summand)<(.Machine$double.eps^(1/2)*abs(sum_old))){not_matters<-5};sum_old<-sum_now}; return(sum_now)}


	
taylor_series3b <- function(x,x_0)
	{

	x_0<-x_0;i <- 0; not_matters <-3; sum_old <- 0; sum_now<-0
	to_derivate <- sqrt(x+1)

	while(not_matters<4)

		{

		to_derivate <- expression(to_derivate)
		current_derivate <- D(to_derivate, "x")
		back_x <- x
		x <- x_0 # to evaluate the derivative by x_0

		next_summand <- eval(current_derivate)/factorial(i) * (x-x_0)^i
		
		x <- back_x

		sum_now <- sum_old + next_summand

		if(abs(next_summand)<(.Machine$double.eps^(1/2)*abs(sum_old)))
			{break}
		
		to_derivate <- current_derivate
		sum_old <- sum_now
		i <-i +1
		}
	

	return(sum_now)
	}

verbessert:

taylor_series3b <- function(x,x_0)
 {
     
     x_0<-x_0;i <- 0; not_matters <-3; sum_old <- 0; sum_now<-0
     to_derivate <- expression(sqrt(x+1))
     
     while(not_matters<4)
         
     {   print(to_derivate)
         
         #to_derivate <- expression(to_derivate)
         current_derivate <- D(to_derivate, "x")
         print(current_derivate)
         to_derivate2 <- expression(current_derivate)
         print(paste("next thing to derivate", to_derivate2))
         back_x <- x
         x <- x_0 # to evaluate the derivative by x_0
         
         next_summand <- eval(current_derivate)/factorial(i) * (x-x_0)^i
         print(paste('next s:',next_summand))
         x <- back_x
         sum_now <- sum_old + next_summand
         print(sum_now)
         print('############')
         if(abs(next_summand)<(.Machine$double.eps^(1/2)*abs(sum_old)))
         {print('done');break}
         
         to_derivate <- to_derivate2
         sum_old <- sum_now
         i <-i +1
     }
     
     
     return(sum_now)
 }




taylor_series3b <- function(x,x_0)
{
    
    x_0<-x_0;i <- 0; not_matters <-3; sum_old <- 0; sum_now<-0
    to_derivate <- expression(sqrt(xe+1))
    
    while(not_matters<4)
        
    {   print(paste("to derive this time:", to_derivate))
        
        #to_derivate <- expression(to_derivate)
        current_derivate <- D(to_derivate, "xe")
        print(paste("current deri:",current_derivate))
        to_derivate2 <- current_derivate
        print(paste("next thing to derivate/current derivative", to_derivate2))
        back_x <- x
        xe <- x_0 # to evaluate the derivative by x_0
        
        next_summand <- eval(current_derivate)/factorial(i) * (x-x_0)^i
        print(paste("current deri after x_0 in it",current_derivate))
        rm(xe)
        print(paste('next s:',next_summand))
        x <- back_x
        sum_now <- sum_old + next_summand
        print(sum_now)
        print('############')
        if(abs(next_summand)<(.Machine$double.eps^(1/2)*abs(sum_old)))
        {print('done');break}
        
        to_derivate <- to_derivate2
        sum_old <- sum_now
        i <-i +1
    }
    
    
    return(sum_now)
}


Finally:

taylor_series3b <- function(x,x_0,f) # please write f down as: expression(formula(xe)) # not allowed: x_0 = 0; x = 0
{
    
    x_0<-x_0;i <- 1; not_matters <-3; sum_now<-0
    to_derivate <- f
    # First of all taylor sum starts with the 0-th derivative:
    #next_summand <- sqrt(1+x_0)/factorial(0) * (x-x_0)^0
    xe <- x_0
    next_summand <- eval(f)/factorial(0) * (x-x_0)^0
    rm(xe)
    sum_old <- next_summand
    while(not_matters<4)
        
    {  
        
       
        current_derivate <- D(to_derivate, "xe")

        to_derivate2 <- current_derivate
        
        back_x <- x
        xe <- x_0 # to evaluate the derivative by x_0
        
        next_summand <- eval(current_derivate)/factorial(i) * (x-x_0)^i

	if(is.nan(next_summand))
		{print("calculation got too long");break}


        
        rm(xe)
        print(paste('next s:',next_summand))
        x <- back_x
        sum_now <- sum_old + next_summand
        print(paste("sum now",sum_now))
        print('############')
        if(abs(next_summand)<(.Machine$double.eps^(1/2)*abs(sum_old)))
        	{print('done');break}
        
        to_derivate <- to_derivate2
        sum_old <- sum_now
        i <-i +1
    }
    
    print("final sum")
    return(sum_now)
}


small_x = c(10^(-32),10^(-28),10^(-22),10^(-18),10^(-12),10^(-8),10^(-4),10^(-2))

vector_3b <- c()
for(one_small_x in small_x)
	{
	formula <-  expression(sqrt(xe+1))
	result <- task3b(one_small_x,0.1,formula)
	vector_3b <- append(vector_3b, result)
	}


vector_3c <- c()
for(one_small_x in small_x)
	{
	formula <-  expression((sqrt(xe+1)-1)/xe)
	result <- task3c(one_small_x,0.1,formula)
	vector_3c <- append(vector_3c, result)
	}

