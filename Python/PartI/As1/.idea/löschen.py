def add(a, b): # argument a and argument b
    # This code is executed when calling the function. Variables created here
    # are not available outside of the function.
    c = a + b  # This variable "c" exists only within this function
    return c

print(add(1, b=2))
result = add(b=9, a=1)
print(result)
#print(add(1,_))
_=add(6, 6)
print(_)

def add(a: int, b: int = 1):  # """ sting over lines:
# control and q and then you get information about function when you mark it
    """Adding two variables (small description) # doc string # click on function name then control q --> a small pop-up with a description and pycharm uses it for
    the debug, makes use of specified variables in description
    This function adds two variables via the + operator. (long description)
    Parameters
    -------------
    a : int # through that python knows that a have to be an integer, when above is nothing standing
        First argument
    b : int
        Second argument
    Returns
    -------------
    int
        Returns a+b
    """
    c = a + b
    return c
print(add(3, 2))

def my_sum(*args):
    result = 0
    # Iterating over the Python args tuple
    for x in args:
        result += x
    return result

print(my_sum(1, 2, 3))

def concatenate(**kwargs):
    result = ""
    # Iterating over the Python kwargs dictionary
    for arg in kwargs.values():
        result += arg
    return result

print(concatenate(a="Real", b="Python", c="Is", d="Great", e="!"))

def return_values():
    return 1, 2, 3, 4

first, *second = return_values()
second
print(second)
print(first)


def modlist(somelist):
    # somelist =[1,2,3] with that the mylist will not be changed, it's only a variable within the function
    somelist[0] = 55
mylist = [1, 2, 3]
modlist(mylist)
print(mylist)



def add(*args):
    a = args[0]
    if len(args[1:]) == 1:
        b = args[1]
    else:
        b = add(args[1], *args[2:])
    c = a + b
    return c
print(add(1,2,3,4))


#if __name__ == '__main__':
#print("This code will not be executed when this file is imported")
#print(f"Example: add([1, 2, 3, 4]) -> {add([1, 2, 3, 4])}")






for iteration, current_element in enumerate(range(5, 10)): #enumerate function from int 5 to 10,to each of this elements gets a iteration, for the element 5 a 0
    # because its the first element
    # von hinten rum for i in a[..-1]:
    # print(i)
    print("loop iteration: {} element: {}".format(iteration, current_element))