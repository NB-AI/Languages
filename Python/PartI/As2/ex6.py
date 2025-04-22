
def read_raw_files(foldername: str):
    import os
    old_list = []
    for file in os.listdir("00"):
        if file.endswith(".seq.raw"):
            new_element = [os.path.join("00", file)]
            old_list = old_list + new_element
    sorted_list = sorted(old_list)

    print(old_list)
    print(sorted_list)


    with open(old_list[0], 'r') as fh:
        file_content = fh.read()
        print(file_content)

    i = 0
    old_list[i]
    while i < len(old_list):
        with open(old_list[i], 'r') as fh:
            file_content = fh.read()
            i = i + 1
            yield file_content

#print(read_raw_files("00"))

if __name__ == '__main__':
    foldername = "00"
    file_reader = read_raw_files(foldername=foldername)
    for file_content in file_reader:
        print(file_content)
