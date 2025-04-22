
import re
filename = "ex7_testfiles/invalidformat_0.seq.raw"
with open(filename, 'r') as fh:
    file_content = fh.read()

def parse_file_metadata(data_as_string: str):
    list_a = []
    b = -1
    c = -1
    a = -1
    d = -1
    for num, line in enumerate(data_as_string.split('\n')):

        pattern = '(# SeqHeadStart)+'
        text = line
        matchobject_a = re.search(pattern, text)
        if matchobject_a:
            print("index: {}, content: {}".format(num, line))  # num ist bereits als int gespeichert
            #print(f'{text} + {pattern} -> {matchobject}')
            a_first = list_a.append(line)
            a_first

            a = (num)
        elif matchobject_a == False:
            raise ValueError(f"'# SeqHeadStart' doesn't appear in the file!")

        pattern = '(# SeqHeadEnd)+'
        text = line
        matchobject_b = re.search(pattern, text)
        if matchobject_b:
            print("index: {}, content: {}".format(num, line))
            b_first = list_a.append(line)
            b_first
            b = (num)
        elif matchobject_b ==  False:
            raise ValueError(f"'# SeqHeadEnd' doesn't appear in the file!")

        pattern = '(# Data end)+'
        text = line
        matchobject_c = re.search(pattern, text)
        if matchobject_c:
            print("index: {}, content: {}".format(num, line))
            c_first = list_a.append(line)
            c_first
            c = (num)
        elif matchobject_c == False:
            raise ValueError(f"'# Data end' doesn't appear in the file!")

        if line != '# SeqHeadStart' and line !='# SeqHeadEnd' and line != '# Data end':
            list_a.append(line)
            d = (num)


    for num, line in enumerate(data_as_string.split('\n'), start=0): # neue for-Schleife aufgemacht, da c in der alten als nicht definiert gilt
        if c < b:
            raise ValueError(f"'# Data end' stands in front of '# SeqHeadEnd'")


    print(list_a)
    searched = list_a[0:a]

    i=0
    for i in searched:
        if len(i) > 0:
            raise ValueError(f'There are non-empty lines in front of the head!')


    short_list = list_a[a:b+1:1]
    print(short_list)
    dic = {"# SeqHeadStart":a, "# SeqHeadEnd":b, "# Data end":c, "s":d}
    print(dic)

    matching = [s for s in short_list if "# ID" in s]
    if matching:
        pass
    else:
        raise ValueError(f"There is no string named '# ID:' in the list")

    matching_date = [t for t in short_list if "# Date:" in t]
    if matching_date:
        pass
    else:
        raise ValueError(f"There is no string named '# Date:' in the list")

    matching_columns = [u for u in short_list if "# Columns:" in u]
    if matching_columns:
        pass
    else:
        raise ValueError(f"There is no string named '# Columns:' in the list")
    last_list = []

    for element in short_list:
  #  while element < short_list[-1]:
        #element = short_list[i]

        #id = element.startswith('# ID:')

        if element.startswith('# ID:'):
            print(element)
            ID = element.split(' ')
            id = str(ID[2])
            id
            #element += element

        # cr = element.startswith('# Date: ')
        if element.startswith('# Date: '):
            print(element)
            Date = element.split(' ')
            # return int(Date[2])

            try:
                da = int(Date[2])
            except:
                print('critical text')
                raise TypeError (f"The date could not be transformed in an integer.")

        elif element.startswith('# Columns: '):
            t = element.startswith('# Columns: ')

            col = element.replace(' ',';')
            col_element = col.split(';')
            print(col_element[2])
            if col_element[2]:
                last_list.append(col_element[2])
            else:
                raise ValueError(f"'No heading for first column found")
            if col_element[3]:
                print(col_element[3])
                last_list.append(col_element[3])
            else:
                raise ValueError(f"'No heading for second column found")
            if col_element[4]:
                last_list.append(col_element[4])
            else:
                raise ValueError(f"'No heading for second column found")
        else:
            pass

    for element in short_list:
        if len(element) == 0:
            pass
        if element.startswith('#'):
            pass
        else:
            raise ValueError(f"'# Data end' stands in front of '# SeqHeadEnd'")
        element += element
    print(last_list)

    data_as_string = (id, da, last_list)
    print(data_as_string)
    return data_as_string



#parse_file_metadata(file_content) # bei unittest kein output, wenn diese Zeile aktiv,
