
import numpy as np

my_nested_list = [[1, 2, 3, 4], [1, 2, 3, 4], [1, 2, 3, 4]]
my_2d_array = np.array(my_nested_list)
print(my_2d_array)
"""
import re
import os
import numpy as np
filename = "example.config"
with open(filename, 'r') as f:
    content = f.read
    for gf in re.findall('\n\".*?\"\n', content, re.S):
    #for gf in re.findall('\n\".*?\"\n', content, re.S):
        lines = content.split(os.linesep)  # file in einer einzigen Zeile
        for line in [l for l in lines if l.startswith(
                tuple(items))]:  # Wenn Zeile mit einen Element aus Itemsdict, wie z. B. 'n_iterations' startet
            key, value = line.split(
                ':')  # hier wird festgelegt, dass 'n_iterations' key ist und das, was nach Doppelpunkt folgt value
            items[key] = value.replace('"', '').strip() if value else None  # Liste in ein dictionary umgewandelt!

        print(items['gamefield'])  # Das ganze gamefield ohne Titel steht nun in einer Zeile

        items['state_seed'] = np.array([list(i) for i in items['gamefield'].split(
            ',')])  # split gibt an, ab welchem Symbol eine neue Zeile im array begonnen wird.
        items['state_as_bool'] = items['state_seed'] == items['symbol_live']
        print(items)






import re
filename = "example.config"
with open(filename, 'r') as fh:
    file_content = fh.read()


first_list = []
first_int = 'm'
find_iterations = []
find_live = []
find_dead = []
for line in file_content.split('\n'):
    new_line = line.replace(' ', ',')

    pattern = '(n_iterations:)+'
    text = new_line
    matchobject_a = re.search(pattern, text)
    if matchobject_a:
        find_iterations.append(matchobject_a)
    else:
        pass

    pattern = '(symbol_live:)+'
    text = new_line
    matchobject_b = re.search(pattern, text)
    if matchobject_b:
        find_live.append(matchobject_b)
    else:
        pass

    pattern = '(symbol_dead:)+'
    text = new_line
    matchobject_c = re.search(pattern, text)
    if matchobject_c:
        find_dead.append(matchobject_c)
    else:
        pass


print(find_iterations)
if len(find_iterations) == 0:
    raise AttributeError('There is no line that starts with "n_iterations".')
else:
    pass

print(find_live)
if len(find_live) == 0:
    raise AttributeError('There is no line that starts with "symbol_live".')
else:
    pass

print(find_dead)
if len(find_dead) == 0:
    raise AttributeError('There is no line that starts with "symbol_dead".')
else:
    pass



for line in file_content.split('\n'):
    new_line = line.replace(' ', ',')

    if new_line.startswith("n_iterations"):
        iter = new_line.split(',')
        print(iter[1])
        i = 0

        while i < len(iter):
            remain_strings = str(iter[i])
            try:
                first_int = int(iter[i])
            except:
                remain_strings = str(iter[i])
            i = i + 1

    elif new_line.startswith("symbol_live:"):
        newer_line = new_line.replace('"', ',')
        live_line = newer_line.split(',')
        j = 1 # There is no j = 0 because it is in any case legal
        while j < len(live_line):
            if len(live_line[j])== 1:
                live_object = live_line[j]
                print(live_object, 'this is alive')
            elif len(live_line[j]) > 1:
                print(live_line[j])
                raise AttributeError("The live symbol is too long!")
            else:
                pass
            j = j + 1

    elif new_line.startswith("symbol_dead:"):
        newer_line = new_line.replace('"', ',')
        live_line = newer_line.split(',')
        h = 1  # There is no j = 0 because it is in any case legal
        while h < len(live_line): # You can use the live_line again
            if len(live_line[h]) == 1:
                dead_object = (live_line[h])
                print(dead_object, 'this is dead')
            elif len(live_line[h]) > 1:
                print(live_line[h])
                raise AttributeError("The dead symbol is too long!")
            else:
                pass
            h = h + 1

items = {'live_symbol': live_object}

looong_content = file_content.split('\n')
gamefield_one = [looong_content]
print(gamefield_one)


integer_dict = {"Searched_integer": first_int, "remaining_strings": remain_strings}
print(integer_dict)
if first_int == 'm':
    raise AttributeError('The integer is missing or no integer.')
else:
    print(first_int)


items = {'n_iterations': first_int, 'live_symbol': live_object, 'dead_symbol': dead_object}
print(items)







"""


"""
for line in file_content.split('\n'):
    a_line = line.replace(' ', ',')
    an_line = a_line.replace('\n', dead_object)
    new_line = line.replace(' ', ',')
    newer_line = new_line.replace('"', ',')
    newest_line = newer_line.replace('\n', ';')
    na_line = newest_line.split(';')
    if new_line.startswith(dead_object) and new_line.endswith(dead_object):
        gamer_list.append(line)
    if new_line.startswith(live_object) and new_line.endswith(live_object):
        gamer_list.append(line)
    if new_line.startswith(live_object) and new_line.endswith(dead_object):
        gamer_list.append(line)
    if new_line.startswith(dead_object) and new_line.endswith(live_object):
        gamer_list.append(line)
  
"""

"""
import csv
with open('ex.config', 'r', newline='\n') as csvfile:
    # We then create our reader object with '\t' as delimiter between columns
    csvreader = csv.reader(csvfile, delimiter='\n')
    first = []
    # We now we can iterate over the rows in csvreader, where each 'row' is
    # a list of separated column elements.
    for row in csvreader:
        # Here we print the list of elements in this line
        print(f"{row}")  # out: for every row are the different columns
        first.append(row)
print(first)
"""
"""
#for v in gamefield_one:
gamefield_two = []
for num, element in enumerate(file_content.split('\n')):

    pattern = '(gamefield:)+'
    text = element
    matchobject_game = re.search(pattern, text)
    if matchobject_game:
        print('ys')
        g = int(num)
        gamefield_two.append(element)
        print("index: {}, content: {}".format(num, element))  # num ist bereits als int gespeichert
        #g = (num)
    if num < g:
        print("index: {}, content: {}".format(num, element))
        gamefield_two.append(element)
        print('newnumber')
    #gu = g + 1
        if num > g:
            print("index: {}, content: {}".format(num, element))
            gamefield_two.append(element)
            print('newnumber')
 #   if num > g:
  #      print('new hello')
print(gamefield_two)




#print(gamefield_one)
#matching = [s for s in gamefield_one[v] if "gamefield:" in s]
#if matching:
 #   print(gamefield_one[v])
  #  print('yes')
#else:
 #   raise ValueError(f"There is no string named '# ID:' in the list")




"""


"""
keys = ['Searched_integer']
print(first_int)
print(resultdict)
values = list(resultdict.values())
print(values)

print(first_list)
a = 0
while a<len(first_list):
    if int(first_list[a]) == True:
        print('yes')
"""
"""   
first_list = []

for line in file_content.split('\n'): # now you have the single lines of the file
    if line.startswith("n_iterations"):
        iter = line.split(' ')
        print(iter[0])
        try:
            int(iter[1])
        except:
            raise AttributeError('The integer is missing.')

   # are_there_iter = line.startswith("n_iterations")
  #  if not line.startswith("n_iterations").exists():
   #     raise AttributeError('There is no line that starts with "n_itaertaions".')
    #else:
     # continue

    pattern = '(n_iterations:)+'
    text = line
    matchobject_a = re.search(pattern, text)
    if matchobject_a == False:
      raise AttributeError('There is no line that starts with "n_itaertaions".')

    else:
      pass
"""""
