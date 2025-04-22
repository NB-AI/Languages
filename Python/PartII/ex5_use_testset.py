"""ex5_use_testset.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 5
"""
# TRAINING SET
# inputs are the grayscale pictures from ex1
# pictures has to be transformed into numpy arrays and the pixel number reduced

# first have a look at the lesson slides (data transformation)


# 1. Transform images into numpy arrays

from PIL import Image
import os
import glob
import numpy as np
from numpy import asarray
import random
import pickle
import torch
np.random.seed(0)  # Set a known random seed for reproducibility
# use the code from exercise 4 to use its output

device = torch.device("cuda:0")


with open('challenge_testset.pkl', 'rb') as f:
    # Pickle load the objects from the file into the dictionary 'data'
    data_test_set = pickle.load(f)


found_files = data_test_set['images']
found_crop_sizes = data_test_set['crop_sizes']
found_crop_centers = data_test_set['crop_centers']


# now work with the DataLoader to get minibatches

from torch.utils.data import Dataset, DataLoader, Subset


class RandomSeqDataset(Dataset):
    def __init__(self, found_files, found_crop_sizes, found_crop_centers):#(self):#(self, sequence_length: int = 15, n_features: int = 9):
        """Here we define our __init__ method. In this case, we will take two
        arguments, the sequence length `sequence_length` and the number of
        features per sequence position `n_features`.
        """

        self.n_samples = len(found_files) # length is okay

        self.found_files = found_files # all files but not from folder 0213 and 230
        self.found_crop_sizes = found_crop_sizes
        self.found_crop_centers = found_crop_centers
    def ex4(self, image_array, crop_size, crop_center):
        import numpy as np
        # Value error if
        # image array is no 2d numpy array:
        if isinstance(image_array, np.ndarray) == False:  # ??? also for 3d???
            raise ValueError('Image input isn\'t a suitable array.')
        if len(image_array.shape) != 2:
            raise ValueError
        if len(crop_center) != 2:
            raise ValueError
        if len(crop_size) != 2:
            raise ValueError

        if crop_size[0] % 2 == 0:
            raise ValueError
        if crop_size[1] % 2 == 0:
            raise ValueError

        # find crop_center in array:
        H = crop_center[0]
        W = crop_center[1]
        crop_center_position = image_array[H][W]

        # make a copy of array:
        image_array2 = np.copy(image_array)

        # find corners of cropped rectangle:
        height_length_rec = crop_size[0]
        width_length_rec = crop_size[1]


        # look if the corners are within the image:
        if H - int((height_length_rec - 1) / 2) < 0:
            raise ValueError
        if H + int((height_length_rec - 1) / 2) > image_array.shape[0]:
            raise ValueError
        if W - int((width_length_rec - 1) / 2) < 0:
            raise ValueError
        if W + int((width_length_rec - 1) / 2) > image_array.shape[1]:
            raise ValueError

        # create the crop_array:
        crop_array = np.zeros(shape=image_array2.shape, dtype=image_array.dtype)  # until now only filled with 0s

        # create target_array:
        target_array = np.zeros(shape=crop_size, dtype=image_array.dtype)

        # search the rectangle in image_array2 and make all the needed changes for image_array2, crop_array and target_array:
        target_list = []
        for index_lines, lines in enumerate(image_array2):
            for index_elements, elements in enumerate(lines):

                # have a look at the distance between rectangle and frame (ValueErrors risen when problems):

                # left upper corner:
                if index_lines == H - int((height_length_rec - 1) / 2) and index_elements == (
                        W - int((width_length_rec - 1) / 2)):
                    if (index_lines + 1) <= 20:
                        raise ValueError('Rectangle is too near to upper border of image.')
                    if index_elements + 1 <= 20:
                        raise ValueError('Rectangle is too near to left border of image.')

                # right upper corner:
                if index_lines == H - int((height_length_rec - 1) / 2) and index_elements == (
                        W + int((width_length_rec - 1) / 2)):
                    if (index_lines + 1) <= 20:
                        raise ValueError('Rectangle is too near to upper border of image.')

                    if (image_array2.shape[1] - index_elements) <= 20:
                        # modify ex4 such that a new crop is used
                        raise ValueError('Rectangle is too near to right border of image.')
                        #crop_center[1] is too large


                # left lower corner:
                if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (
                        W - int((width_length_rec - 1) / 2)):

                    if index_elements + 1 <= 20:
                        raise ValueError('Rectangle is too near to left border of image.')

                    if (image_array2.shape[0] - index_lines) <= 20:
                        raise ValueError('Rectangle is too near to lower border of image.')


                # right lower corner:
                if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (
                        W + int((width_length_rec - 1) / 2)):
                    if (image_array2.shape[1] - index_elements) <= 20:
                        raise ValueError('Rectangle is too near to right border of image.')

                    if (image_array2.shape[0] - index_lines) <= 20:
                        raise ValueError('Rectangle is too near to lower border of image.')


                # get the space of the cropped rectangle in the image_array copy:
                if index_lines >= (H - int((height_length_rec - 1) / 2)) and index_lines <= (
                        H + int((height_length_rec - 1) / 2)):
                    if index_elements >= (W - int((width_length_rec - 1) / 2)) and index_elements <= (
                            W + int((width_length_rec - 1) / 2)):
                        # target_array has only the values of image_array within the rectangle:
                        # save these values at first in a list:
                        target_list.append(image_array2[index_lines][index_elements])

                        # values for image_array2 become here 0 because within rectangle:
                        image_array2[index_lines][index_elements] = 0

                        # crop_array has within rectangle 1s:
                        crop_array[index_lines][index_elements] = 1

        # The values from the target_list are now transfered to the target_array

        for index, lines in enumerate(target_array):
            for index_ele, ele in enumerate(lines):
                # the try part is new: When target list is empty there should be no error message
                try:
                    target_array[index][index_ele] = target_list[0]
                    target_list = target_list[1:]
                except:
                    pass

        return (image_array2, crop_array, target_array) # crop_array seems to be fine

    # question: how to generate crop_size and crop_center? I would say: randomly
    # generate random odd int values:



    def __getitem__(self, index):
        """ Here we have to create a random sample and add the signal in
        positive-class samples. Positive-class samples will have a label "1",
        negative-class samples will have a label "0".
        """
        # While creating the samples randomly, we use the index as random seed
        # to get derministic behavior (will return the same sample for the
        # same ID)



        pictures = self.found_files[index] # row pictures without any changes
        crop_sizes = self.found_crop_sizes[index]
        crop_centers = self.found_crop_centers[index]

        # delete path and only use the picture name!:
        #print(pictures, 'PIC') # problem: here I can find the pictures of dataset 4 folder 0213 but outside the
        # class in the list of found files 0213 is missing


        test_image_array, test_crop_array, test_target_array = self.ex4(pictures,
                                                                      crop_sizes, crop_centers)

        # normalize each picture:
        mean_val = np.mean(test_image_array)
        deri_val = np.std(test_image_array)
        test_image_array_normal = (test_image_array - mean_val)/deri_val

        test_input_concat = np.stack(
            (test_image_array_normal, test_crop_array))

        # make a list to feed it to the minibatch generator
        #list_imagewithhole_vs_TargetImagewithouthole.append((train_input_concat, my_image_array_without_hole))


        # Let's say that our `index` is the sample ID
        sample_id = index
        # Return the sample, this time with label, train_target_concat

        return test_input_concat, test_target_array, str(sample_id), mean_val, deri_val, crop_sizes#, my_image_array_without_hole#, list_imagewithhole_vs_TargetImagewithouthole# array_without_hole == target
        #return my_image_array_without_hole(as target), train_image_array, train_crop_array, train_target_array, my_random_crop_center, my_random_crop_size
        #return sample_features, sample_class_label, str(sample_id)

    def __len__(self):
        """ Optional: Here we can define the number of samples in our dataset

        __len__() should take no arguments and return the number of samples in
        our dataset
        """
        return self.n_samples

random.seed(0)
def first_stacked_function(list_imagewithhole_vs_TargetImagewithouthole: list):
    # !!! The DataLoader puts the single values automatically in this here new defined list list_imagewithhole_...



  #  to_tensor_converted = torch.tensor(empty_numpy_for_tensor)
   # return to_tensor_converted
   means = [sample[3] for sample in list_imagewithhole_vs_TargetImagewithouthole]
   derivatives = [sample[4] for sample in list_imagewithhole_vs_TargetImagewithouthole]
   crop_sizes = [sample[5] for sample in list_imagewithhole_vs_TargetImagewithouthole]
    #
   # Get sequence entries, which are at index 0 in each sample tuple
   sequences = [sample[0] for sample in list_imagewithhole_vs_TargetImagewithouthole]

   # !!! the number of samples within the list_imagewithhole_... == batch_size
   # --> this function is called for each minibatch
   # Get the maximum sequence length in the current mini-batch
   max_seq_len = np.max([seq.shape[0] for seq in sequences])
   # Allocate a tensor that can fit all padded sequences
   #n_seq_features = sequences[0].shape[1]  # Could be hard-coded to 3
   max_x1 = 0
   max_y1 = 0

   for i in sequences:
       # get biggest X-value:
       if i.shape[1] > max_x1:
           max_x1 = i.shape[1]
        #get biggest y_value:
       if i.shape[2] > max_y1:
           max_y1 = i.shape[2]

   stacked_sequences = np.zeros(shape=[len(list_imagewithhole_vs_TargetImagewithouthole),
                                         #100,100,
                                         2,
                                         max_x1,
                                         max_y1,
                                     ], dtype=np.float32) # dtype has to be float to save the normalized values in it!
   """ second nice way to make tensors bigger by adding zeros
   for i, sequence in enumerate(sequences):
       # make sequence bigger:
       sequence = torch.from_numpy(sequence)
       filler = torch.nn.ConstantPad3d((0,(max_y1-sequence.shape[2]),0,(max_x1-sequence.shape[1])),0)
       stacked_sequences[i] = filler(sequence)
   """

   for index, ele in enumerate(sequences):
       x = sequences[index]

       # expand to what shape
       empty_numpy_array = stacked_sequences[index]

       #final_array = first_tensor.numpy()[:,  :, :]
       # do expand

       empty_numpy_array[:x.shape[0], :x.shape[1],:x.shape[2]] = x

   stacked_sequences_tensor = torch.from_numpy(stacked_sequences)

       # Handle targets
       #
       # Get label entries, which are at index 1 in each sample tuple
   labels = [sample[1] for sample in list_imagewithhole_vs_TargetImagewithouthole]
   # !!! labels are here the target_arrays from ex4!


   max_x = 0
   max_y = 0
   for i in labels:
       # get biggest X-value:
       if i.shape[0] > max_x:
           max_x = i.shape[0]
           #print(i, i.shape, 'there')
        #get biggest y_value:
       if i.shape[1] > max_y:
           max_y = i.shape[1]
           #print(i,i.shape,'therey')


   stacked_target = np.zeros(shape=[len(list_imagewithhole_vs_TargetImagewithouthole),
                                         # 100, 100,
                                           max_x,
                                           max_y,
                                          ], dtype=np.uint8)  # , dtype=np.uint8)
   for index, ele in enumerate(labels):
       y = labels[index]
       #print(index, ele)
       # expand to what shape
       to_fill_array = stacked_target[index]
       #to_fill_array[:y.shape[0], :y.shape[1], :y.shape[2]] = y
       #final_array = first_tensor.numpy()[:,  :, :]
       # do expand
       #right=to_fill_array[index]
       #stacked_full_image[index] = y
       to_fill_array[:y.shape[0], :y.shape[1]] = y
   stacked_target_array_tensor = torch.from_numpy(stacked_target)

  # print(sequences[0].shape, stacked_target_array_tensor[0], '1111111111111111111')
   return stacked_sequences_tensor, stacked_target_array_tensor, means, derivatives, crop_sizes
   # !!! now we have one big tensor with all image inputs and target_arrays of a mini_batch as tuples in it


# Create a validation set to get an idea of the performance of the model later:


# We create a dataset instance of our new NewRandomSeqDataset
test_dataset = RandomSeqDataset(found_files, found_crop_sizes, found_crop_centers) #(sequence_length=15, n_features=9)

# And load it via the PyTorch dataloader with our stack_if_possible_collate_fn
test_loader = DataLoader(test_dataset, shuffle=False, batch_size=30, # shuffle=True would be that getitem is fed with different indeces of files
                             num_workers=0, collate_fn=first_stacked_function)
                             # !!! collate means vereinigen of samples
                             #collate_fn=stack_if_possible_collate_fn)



print("Our mini-batch is now a stacked tensors where possible and a list"
      " otherwise!")


# NEW CHAPTER: NN with mini-batch learning
torch.random.manual_seed(0)
import torch.nn as nn

class CNN(nn.Module):
    def __init__(self, n_input_channels: int, n_hidden_layers: int,
                 n_hidden_kernels: int, n_output_channels: int, kernel_size: int):
        """CNN, consisting of `n_hidden_layers` linear layers, using relu
        activation function in the hidden CNN layers.

        Parameters
        ----------
        n_input_channels: int
            Number of features channels in input tensor
        n_hidden_layers: int
            Number of hidden layers
        n_hidden_kernels: int
            Number of kernels in each hidden layer
        n_output_channels: int
            Number of features in output tensor
        """
        super(CNN, self).__init__()

        hidden_layers = []
        for _ in range(n_hidden_layers):
            # Add a CNN layer

            layer = nn.Conv2d(in_channels=n_input_channels,
                              out_channels=n_hidden_kernels,
                              kernel_size=kernel_size, bias=True, padding=int(kernel_size/2))  # convolutional layer

            # also here number of inputs channels has to be the first thing in the input tensor
            # max pooling reducing spacial dimensions so you need no large kernel size anymore
            hidden_layers.append(layer)
            # Add relu activation module to list of modules
            hidden_layers.append(nn.SELU())  # relu common in CNN   ReLU
            n_input_channels = n_hidden_kernels

        self.hidden_layers = nn.Sequential(*hidden_layers)  # sequential class

        self.output_layer = nn.Conv2d(in_channels=n_input_channels,
                                      out_channels=n_output_channels,
                                      kernel_size=kernel_size,
                                      bias=True, padding=int(kernel_size/2))  # image with this spacial dimensions (height, width)

    def forward(self, x, means, derivatives, crop_sizes): # train_crop_array is a list of arrays
        """Apply CNN to `x`

        Parameters
        ----------
        x: torch.tensor
            Input tensor of shape (n_samples, n_input_channels, x, y)
            my input tensor shape (n_samples,x,y,n_input_channels)
        Returns
        ----------
        torch.tensor
            Output tensor of shape (n_samples, n_output_channels, u, v) # spacial dimensions smaller than input
            dimensions bc we loose pixels
            my output tensor shape (n_samples, u,v, n_output_channel=1)!!!
            # ???are u and v of the same size as x and y? have to be, bc laying mask on output pictures
        """
        crop_list = []
        for sample in x:
            crop_list.append(sample[1])
        # Apply hidden layers module
        hidden_features = self.hidden_layers(x)

        # Apply last layer (=output layer)
        output = self.output_layer(hidden_features) # a tensor with all output samples


        list_predictions_per_batch = []
        list_mask = []

       # list_crop_sizes = []
        for ind,crop in enumerate(crop_list):
            #output_each_image = output[ind]
            crop_mask0 = crop.bool()
            crop_mask=crop_mask0.view(1, crop_mask0.shape[0], crop_mask0.shape[1])
            list_mask.append(crop_mask)
            count_h = 0
            count_w = 0

            # get the crop size out of the crop array by searching the True-values:
            for line in crop_mask0:
                if True in line:
                    count_h += 1
                    if count_w == 0:
                        for ele in line:
                            if ele == True:
                                count_w += 1

          #  list_crop_sizes.append((count_h,count_w))

        list_predictions_per_batch = [output[i, list_mask[i]] for i in range(len(output))]

       # print(list_predictions_per_batch[0], '222222222222222222222222')
        list_numpy_outputs = []
        # reshape the output tensor of shape [s,] to shape [h,w] and convert it to numpy array
        for ind, sample in enumerate(list_predictions_per_batch):
            single_crop_size = crop_sizes[ind] # list_crop_sizes
            sample_helper = sample.reshape(single_crop_size)

            # convert tensor to numpy array:
            output_numpy = sample_helper.detach().cpu().numpy() # is a single sample

            # After normalizing the input, the output has to be denormalized:
            output_numpy= (output_numpy * derivatives[ind]) + means[ind]

            # Change dtype of array:
            output_numpy = output_numpy.astype('uint8')

            list_numpy_outputs.append(output_numpy)

        return list_numpy_outputs # list of onedimensional tensors --> are okay!!!!


# load the model with the saved parameters
save_path = 'other_hyper/trained_model1final2.pt'
cnn = torch.load(save_path)


huge_list = []
for batch in test_loader:
   input_tensor, full_image_tensor, means, derivatives, crop_sizes = batch
   input_tensor = input_tensor.float()
   input_tensor = input_tensor.to(device=device)
   model_output_np =cnn(input_tensor, means, derivatives, crop_sizes) # output shall have same size as input
   huge_list.extend(model_output_np)


# save the huge list in a pickle file:
pickle.dump(huge_list, open("save0109.pkl", "wb"))


