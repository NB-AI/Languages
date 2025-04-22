
import sys
import os
import subprocess
from plot_csv import plot_csv

#sys.argv = ['ex9.py', 'output_folder']

args = sys.argv
output_folder = args[1]
print(output_folder)

path0 = ("/")

if not os.path.exists(output_folder):
    os.mkdir(output_folder)

for number in range(0, 10, 1):

    path2 = os.path.join(output_folder, "0{}".format(number))

    if not os.path.exists(path2):
        os.mkdir(path2)

    subprocess.call([sys.executable, "hamstergenegen.py", path2])

    inputfilename = os.path.join(path2, 'sequence_analysis.csv')
    subprocess.call([sys.executable, "ex8.py", path2, inputfilename, "actc"])

    outputfilename = os.path.join(path2, 'sequence_analysis.png')

    plot_csv(inputfilename, outputfilename)
