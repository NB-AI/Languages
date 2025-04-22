i <- 1; ende <- 2; final_sum <- 0;
while(i < ende){ende=(ende+1); current_value <- (1/2**(2*i)); if(final_sum==(current_value+final_sum)){print("Final i is: ");print(i); break};final_sum = (current_value + final_sum); if(is.infinite(final_sum)){print("Final i is: ");print(i); break}; i=(i+1); print(final_sum)}
