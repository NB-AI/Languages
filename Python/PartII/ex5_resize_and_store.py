"""ex5_resize_and_store.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 5
"""
from PIL import Image
import os
import glob
import numpy as np
from numpy import asarray
import random
np.random.seed(0)  # Set a known random seed for reproducibility
# use the code from exercise 4 to use its output
import torch

found_files = glob.glob(os.path.join('**', '*.jpg'), recursive=True)


def resize_pic():
    number3 = random.randint(70, 100)
    number4 = random.randint(70, 100)
    new_size = (number3, number4)
    return new_size

for index, ele in enumerate(found_files):
    pictures = found_files[index]  # row pictures without any changes


    splited_name = pictures.split('/')
    try:
        last_folder = splited_name[-2] # determine the folder name in which the pictures are saved
    except:
        last_folder = 'extra_folder'

    pictures_only_name = os.path.basename(pictures)


    image = Image.open(pictures)

    # resize the image to 70 - 100 pixels:
    new_size = resize_pic()

    image2 = image.copy()
    crop = image2.resize(new_size, Image.LANCZOS)
    # print('THERE:', 'name pic:', found_files[index])

    if not os.path.exists('pic/{}'.format(last_folder)):
        os.mkdir('pic/{}'.format(last_folder))
    crop.save(r'pic/{}/{}'.format(last_folder, pictures_only_name))  # PROBLEM


found_files2 = glob.glob(os.path.join('pic/**', '*.jpg'), recursive=True)
