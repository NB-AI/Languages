"""ex2.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 2
"""

def ex2(input_dir, output_dir, logfile):
    import glob
    import os
    from os.path import isfile
    import numpy as np
    from PIL import Image  # for criterion 3
    import hashlib  # for criterion 6
    from shutil import copyfile  # to copy valid files in output folder
    import re

    # for output folder:
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)

    # write in the logfile:
    def function_log(e, error, logfile):
        with open(logfile, 'a') as f:
            f.write(f'{e};{error}\n')

    hash_list = [] # for criterion 6
    valid_files = [] # for fulfilled criterion 6
    dirname = input_dir
    found_files0 = glob.glob(os.path.join(dirname, '**'), recursive=True) # find all files in the directory and subdirectories


    found_files0.sort()
    input_dir2 = os.path.relpath(input_dir) # for the part with 'error 1'

    for e in found_files0: # have a look at each file of the found files
        e = os.path.relpath(e)

        # validity criterion 1:
        if e.endswith('.jpg') or e.endswith('.JPG') or e.endswith('.JPEG') or e.endswith('.jpeg'):  # Validity fulfilled

            # validity criterion 2:
            size = os.path.getsize(e)
            if size > 10000:  # criterion 2 fulfilled

                # validity criterion 3:
                try:
                    image0 = Image.open(e)

                    # cirterion 4
                    image = np.array(image0)

                    stds = image.std()
                    var = stds ** 2
                    if var > 0:  # criterion 4 fulfilled

                        # criterion 5
                        try: # error 5 part 1
                            image.shape[2]
                            to_remove = input_dir2 + '/'
                            e2 = re.sub(to_remove, '', e)
                            error = '5'
                            function_log(e2, error, logfile)

                        except:
                            if image.shape[0] >= 100 and image.shape[1] >= 100:  # criterion 5 fulfilled

                                # criterion 6:
                                hashing_function = hashlib.sha256()
                                image_str = str(image)
                                hashing_function.update(bytes(image_str, encoding='utf'))
                                created_hash = hashing_function.digest()

                                if len(hash_list) == 0:  # you can't loop over empty list with success. Therefore, put one element in
                                    hash_list.append(created_hash)
                                    valid_files.append(e)

                                elif len(hash_list) > 0:
                                    if created_hash in hash_list: # error 6
                                        to_remove = input_dir2 + '/'
                                        e2 = re.sub(to_remove, '', e)
                                        error = '6'
                                        function_log(e2, error, logfile)


                                    else:  # all criteria fulfilled. It is a valid image.
                                        hash_list.append(created_hash)
                                        valid_files.append(e)

                            else:  # error 5
                                to_remove = input_dir2 + '/'
                                e2 = re.sub(to_remove, '', e)
                                error = '5'
                                function_log(e2, error, logfile)

                    else:  # error 4
                        to_remove = input_dir2 + '/'
                        e2 = re.sub(to_remove, '', e)
                        error = '4'
                        function_log(e2, error, logfile)



                except:  # error 3
                    to_remove = input_dir2 + '/'
                    e2 = re.sub(to_remove, '', e)
                    error = '3'
                    function_log(e2, error, logfile)


            else:  # error 2
                to_remove = input_dir2 + '/'
                e2 = re.sub(to_remove, '', e)
                error = '2'
                function_log(e2, error, logfile)


        else:  # error 1

            if isfile(e):
                to_remove = input_dir2 + '/'
                e2 = re.sub(to_remove, '', e)
                error = '1'
                function_log(e2, error, logfile)
            else:
                e = os.path.basename(e)
                if len(e) > 0 and e != input_dir2: # the name of the input_dir shall not stand in the log file
                    error = '1'
                    function_log(e, error, logfile)



    # for output folder:
    string = '000000'
    new_number = 1
    for v in valid_files:
        end_string = string[0:-len(str(new_number))] + str(new_number)

        out_rel = os.path.relpath(output_dir) # get the relative path of the input directory
        v_rel = os.path.relpath(v)
        copyfile(v_rel, f'{out_rel}/{end_string}.jpg')

        new_number += 1


    return len(hash_list)



