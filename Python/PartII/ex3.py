"""ex3.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 3
"""

import glob
import os
from os.path import isfile
import numpy as np
from PIL import Image
import torch
import re
from tqdm import tqdm
import cv2 as cv
class ImageNormalizer:

	def __init__(self, input_dir):
		input_dir2 = os.path.relpath(input_dir)
		found_files = glob.glob(os.path.join(input_dir2, '**', '*.jpg'), recursive=True)
		found_files.sort()
		found_files0 = []
		for e in found_files:  # have a look at each file of the found files
			to_remove = input_dir2 + '/'
			e2 = re.sub(to_remove, '', e)
			found_files0.append(e2)
		self.file_names = found_files0
		self.input = to_remove

	def get_stats(self):

		image_list = []

		for index, file in enumerate(self.file_names):
			image_files = Image.open(self.input + self.file_names[index])  # This returns a PIL image
			image_ar = np.array(image_files)  
			image_list.append(image_ar)
			
		# get all mean values
		# die normalen mean werte sollen in einem array abgespeichert werden
		mean_list = []
		derivation_list = []
		for e in image_list:
			means = e.mean()
			mean_list.append(means)

			derivation = e.std()
			derivation_list.append(derivation)

		# get an array with the mean values in it:
		mean_ar = np.zeros(shape=(len(image_list),), dtype=np.float64) # with a shape like (number,) you can slice through array like in a list
		for index3, mean_val in enumerate(mean_list):
			mean_ar[index3] = mean_val 	


		# get an array with the standard derivations in it:
		derivation_ar = np.zeros(shape=(len(image_list),), dtype=np.float64)
		for index4, derivation_val in enumerate(derivation_list):
			derivation_ar[index4] = derivation_val

		# create a tuple with the arrays for means and standard deri. in it:
		mean_deri_tup = (mean_ar, derivation_ar)

		return mean_deri_tup


	def get_images(self):

		# safe images as float32 arrays: (same as above)
		image_list = []
		for index, file in enumerate(self.file_names):
			image_ar = np.array(Image.open(self.input + self.file_names[index]), dtype=np.float32)
			image_list.append(image_ar)


		for file in image_list:
			mean_val = np.mean(file)
			deri_val = np.std(file)
			normalization = (file - mean_val)/deri_val
			yield normalization






