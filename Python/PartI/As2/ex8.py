
import sys

args = sys.argv # argv = argument values and is a list, values as strings, from aguments that pass the command prompt
input_folder = args[1]
output_file=args[2]
subsequence=args[3]


from ex6 import read_raw_files
from ex5 import count_bases_and_subsequence
from ex7 import parse_file_metadata



import numpy as np
first_array = np.zeros(shape=(200, 5), dtype=np.float64)

for file_content in read_raw_files(input_folder):
    #print(file_content)
    #print(count_bases_and_subsequence(file_content, subsequence))

    list_for_count = list(count_bases_and_subsequence(file_content, subsequence))
    #print(list_for_count)
    is_a_dict = list_for_count[0]
    a = is_a_dict['a']
    c = is_a_dict['c']
    g = is_a_dict['g']
    t = is_a_dict['t']
    seq = list_for_count[1] # searched subsequence
    list_for_date = list(parse_file_metadata(file_content))
    list_for_date[1]

    indi = (int(list_for_date[1]))
    first_array[indi]
    first_array[indi, 0] += a / 10
    first_array[indi, 1] += c / 10
    first_array[indi, 2] += g / 10
    first_array[indi, 3] += t / 10
    first_array[indi, 4] += seq / 10


with open(output_file, 'w+') as f: # w+ makes file when it does not exist
    f.write("a;c;g;t;subsequence\n")
    for line in first_array:
        f.write(f"{line[0]};{line[1]};{line[2]};{line[3]};{line[4]}\n")









