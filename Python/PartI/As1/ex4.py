
#
# Start of code block that should not be modified.
#

# The next 4 lines will ask the user for input through the console and set the variables operation, datatype, value1,
# and value2 to the input the user typed in the console. These values will be of datatype string, so if you want to do
# computations with them, you will need to convert them to a fitting datatype.
# See the assignment sheet for more details.
operation = input('Select an operation (type "addition", "subtraction", "multiplication", or "division" and hit enter)')
datatype = input('Select a datatype (type "int" or "float" and hit enter)')
value1 = input('Value 1:')
value2 = input('Value 2:')
result = None  # This variable should be overwritten with the result of your operation later.

#
# End of code block that should not be modified.
#

# Place your code here. Store the result in the variable "result".
if datatype == "int":
    value1 = int(value1)
    value2 = int(value2)
elif datatype == "float":
    value1 = float(value1)
    value2 = float(value2)


if operation == "addition":
    result = value1 + value2
elif operation == "subtraction":
    result = value1 - value2
elif operation == "multiplication":
    result = value1 * value2
elif operation == "division":
    result = value1 / value2

if datatype == "int":
    result = int(result)
elif datatype == "float":
    result = float(result)


#
# Do not modify the code below this line.
#

# This will print the result to the console.
print(f"Result: {result}")
