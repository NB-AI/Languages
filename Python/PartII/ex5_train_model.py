"""ex5_train_model.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 5
"""
# TRAINING SET
# inputs are the grayscale pictures from ex1
# pictures has to be transformed into numpy arrays and the pixel number reduced

# first have a look at the lesson slides (data transformation)



# 1. Transform images into numpy arrays
# exercise 

from PIL import Image
import os
import glob
import numpy as np
from numpy import asarray
import random
np.random.seed(0)  # Set a known random seed for reproducibility
# use the code from exercise 4 to use its output
import torch

device = torch.device("cuda:0")

found_files = glob.glob(os.path.join('**', '*.jpg'), recursive=True) # get all jpg-files starting from the current folder
# we start here with the resized pictures


# now work with the DataLoader to get minibatches
import torch
from torch.utils.data import Dataset, DataLoader, Subset


class RandomSeqDataset(Dataset):
    def __init__(self, found_files):#(self):#(self, sequence_length: int = 15, n_features: int = 9):
        """Here we define our __init__ method. In this case, we will take two
        arguments, the sequence length `sequence_length` and the number of
        features per sequence position `n_features`.
        """
        self.n_samples = len(found_files) # length is okay
        self.found_files = found_files # all files but not from folder 0213 and 230

    def ex4(self, image_array, crop_size, crop_center):

        # Value error if
        # image array is no 2d numpy array:
        if isinstance(image_array, np.ndarray) == False:  # ??? also for 3d???
            raise ValueError('Image input isn\'t a suitable array.')
        if len(image_array.shape) != 2:
            return None, None, None
           # raise ValueError
        if len(crop_center) != 2:
            return None, None, None
            #raise ValueError
        if len(crop_size) != 2:
            return None, None, None
            #raise ValueError

        if crop_size[0] % 2 == 0:
            return None, None, None
           # raise ValueError
        if crop_size[1] % 2 == 0:
            return None, None, None
            #raise ValueError

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
            new_height = self.number_for_crop_center()
            new_crop_center = (new_height, crop_center[1])
            return self.ex4(image_array, crop_size, new_crop_center)

        if H + int((height_length_rec - 1) / 2) > image_array.shape[0]:
            new_height = self.number_for_crop_center()
            new_crop_center = (new_height, crop_center[1])
            return self.ex4(image_array, crop_size, new_crop_center)

        if W - int((width_length_rec - 1) / 2) < 0:
            new_width = self.number_for_crop_center()
            new_crop_center = (crop_center[0], new_width)
            return self.ex4(image_array, crop_size, new_crop_center)

        if W + int((width_length_rec - 1) / 2) > image_array.shape[1]:
            new_width = self.number_for_crop_center()
            new_crop_center = (crop_center[0], new_width)
            return self.ex4(image_array, crop_size, new_crop_center)


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
                        new_height = self.number_for_crop_center()
                        new_crop_center = (new_height, crop_center[1])
                        return self.ex4(image_array, crop_size, new_crop_center)

                    if index_elements + 1 <= 20:
                        new_height = self.number_for_crop_center()
                        new_crop_center = (new_height, crop_center[1])
                        return self.ex4(image_array, crop_size, new_crop_center)


                # right upper corner:
                if index_lines == H - int((height_length_rec - 1) / 2) and index_elements == (
                        W + int((width_length_rec - 1) / 2)):
                    if (index_lines + 1) <= 20:
                        new_height = self.number_for_crop_center()
                        new_crop_center = (new_height, crop_center[1])
                        return self.ex4(image_array, crop_size, new_crop_center)

                    if (image_array2.shape[1] - index_elements) <= 20:

                        # modify ex4 such that a new crop is used
                        new_width = self.number_for_crop_center()
                        new_crop_center = (crop_center[0], new_width)
                        return self.ex4(image_array, crop_size, new_crop_center)

                # left lower corner:
                if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (
                        W - int((width_length_rec - 1) / 2)):
                    if index_elements + 1 <= 20:
                        new_width = self.number_for_crop_center()
                        new_crop_center = (crop_center[0], new_width)
                        return self.ex4(image_array, crop_size, new_crop_center)

                    if (image_array2.shape[0] - index_lines) <= 20:

                        new_height = self.number_for_crop_center()
                        new_crop_center = (new_height, crop_center[1])
                        return self.ex4(image_array, crop_size, new_crop_center)

                # right lower corner:
                if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (
                        W + int((width_length_rec - 1) / 2)):

                    if (image_array2.shape[1] - index_elements) <= 20:
                        new_width = self.number_for_crop_center()
                        new_crop_center = (crop_center[0], new_width)
                        return self.ex4(image_array, crop_size, new_crop_center)

                    if (image_array2.shape[0] - index_lines) <= 20:
                        new_height = self.number_for_crop_center()
                        new_crop_center = (new_height, crop_center[1])
                        return self.ex4(image_array, crop_size, new_crop_center)

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

        coun = 0
        for i in crop_array:
            for j in i:
                if j == 1:
                    coun += 1
        size_target_array = target_array.shape[0] * target_array.shape[1]
        if coun != size_target_array:  # in ex4 the crop center was changed when the crop transgressed against the
            # distance rules. However, it also can be that the crop size was simply to large for the
            # image.
            # A image is at least 70x70. The smallest crop size of 5x5 fits in in any case.
            # --> We can change the crop size randomly, when the size is at least 5x5:
            num1 = self.num()
            num2 = self.num()
            my_random_crop_size2 = (num1, num2)

            return self.ex4(image_array, my_random_crop_size2, crop_center)
        # return self ex 4 but then None returned???
        else:
            return (image_array2, crop_array, target_array) # crop_array seems to be fine

    # question: how to generate crop_size and crop_center? I would say: randomly
    # generate random odd int values:
    def num(self):
        number = random.randint(5, 21)  # how many pixels can a picture for this task maximal have? given in task
        if number % 2 == 0:
            return self.num()
        else:
            return number

    def number_for_crop_center(self):
        number2 = random.randint(40, 60)  # picture is 70-100 pixels but there is also a limit of 20 pixel to the border
        return number2


    def __getitem__(self, index):

        """ Here we have to create a random sample and add the signal in
        positive-class samples. Positive-class samples will have a label "1",
        negative-class samples will have a label "0".
        """
        # While creating the samples randomly, we use the index as random seed
        # to get deterministic behavior (will return the same sample for the
        # same ID)


        # get current random picture:
        pictures = self.found_files[index] # row pictures without any changes

        image = Image.open(pictures)
        my_image_array_without_hole = asarray(image, dtype=np.float32)

        # use ex4 to work with training set:
        num1 = self.num()
        num2 = self.num()
        my_random_crop_size = (num1, num2)

        num3 = self.number_for_crop_center()
        num4 = self.number_for_crop_center()
        my_random_crop_center = (num3, num4)

        train_image_array, train_crop_array, train_target_array = self.ex4(my_image_array_without_hole,

                                                                      my_random_crop_size, my_random_crop_center)

        # normalize each input:
        mean_val = np.mean(train_target_array)
        # np.std(array) = inf --> It does not work, therefore:
        first = (train_image_array - mean_val)
        second = abs(first) ** 2
        third = np.mean(second)
        deri_val = third ** (1 / 2) # or: der = np.std(my_image_array_without_hole) or: derr = np.std(image)
        train_image_array_n = (train_image_array - mean_val) / deri_val

        train_input_concat = np.stack(
            (train_image_array_n, train_crop_array))  # nun befinden sich neben den einzelnen bild pixel values
        # die values vom crop array (1 im Loch, 0 anywhere)


        # Let's say that our `index` is the sample ID
        sample_id = index

        # Return the sample, this time with label, train_target_concat
        return train_input_concat, train_target_array, str(sample_id), mean_val, deri_val#, my_image_array_without_hole#, list_imagewithhole_vs_TargetImagewithouthole# array_without_hole == target
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

   # Get sequence entries, which are at index 0 in each sample tuple
   means = [sample[3] for sample in list_imagewithhole_vs_TargetImagewithouthole]
   derivatives = [sample[4] for sample in list_imagewithhole_vs_TargetImagewithouthole]


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

   stacked_sequences = torch.zeros([len(list_imagewithhole_vs_TargetImagewithouthole),
                                         2,
                                         max_x1,
                                         max_y1,
                                         ], dtype=torch.float32)#.to(device=device)#, dtype=np.uint8)
   for index, ele in enumerate(sequences):
       x = sequences[index]
       x = torch.from_numpy(x)#.to(device=device)
       x = x.float()
       # expand to what shape
       empty_numpy_array = stacked_sequences[index]

       empty_numpy_array[:x.shape[0], :x.shape[1],:x.shape[2]] = x

   stacked_sequences_tensor = stacked_sequences#.to(device=device)

   # Get label entries, which are at index 1 in each sample tuple
   labels = [sample[1] for sample in list_imagewithhole_vs_TargetImagewithouthole]

   torch_labels_list = []
   for ind, i in enumerate(labels):
       # make losses later comparable, the target arrays shall become float tensors
      # i_denormal = (i * derivatives[ind]) + means[index] # don't use denormalizataion because comparing normalized targets with outputs later (losses)
       torch_labels_sample = torch.from_numpy(i) # or i_denormal
       #torch_labels_sample = torch_labels_sample.to(dtype=torch.float16)
       #torch_labels_sample = torch_labels_sample.float()
       torch_labels_sample = torch_labels_sample.to(device=device)
       torch_labels_list.append(torch_labels_sample)


   return stacked_sequences_tensor, torch_labels_list, means, derivatives
   # !!! now we have one big tensor with all image inputs and target_arrays of a mini_batch as tuples in it


shuffled_indices = np.random.permutation(len(found_files)) # create random indices # shuffled means that you mix up the indeces/ ele of files
validationset_inds = shuffled_indices[:int(len(found_files)/(2**9))]
trainingset_inds = shuffled_indices[int(len(found_files)/(2**9)):]

# We create a dataset instance of our new NewRandomSeqDataset
modified_dataset = RandomSeqDataset(found_files) #(sequence_length=15, n_features=9)
validationset = Subset(modified_dataset, indices=validationset_inds)
trainingset = Subset(modified_dataset, indices=trainingset_inds)
# Create a validation set to get an idea of the performance of the model later:

# We create a dataset instance of our new NewRandomSeqDataset
#trainingset = RandomSeqDataset(found_files) #(sequence_length=15, n_features=9)

# len(trainingset) --> is okay, same as within class
# And load it via the PyTorch dataloader with our stack_if_possible_collate_fn
training_loader = DataLoader(trainingset, shuffle=False, batch_size=30,
                             num_workers=0, collate_fn=first_stacked_function)
                             # !!! collate means vereinigen of samples
                             #collate_fn=stack_if_possible_collate_fn)

validation_loader = DataLoader(validationset, shuffle=False, batch_size=30,
                             num_workers=0, collate_fn=first_stacked_function)

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
            hidden_layers.append(nn.ReLU())  # relu common in CNN   ReLU # try out softmax
            n_input_channels = n_hidden_kernels

        self.hidden_layers = nn.Sequential(*hidden_layers)  # sequential class

        self.output_layer = nn.Conv2d(in_channels=n_input_channels,
                                      out_channels=n_output_channels,
                                      kernel_size=kernel_size,
                                      bias=True, padding=int(kernel_size/2))  # image with this spacial dimensions (height, width)

    def forward(self, x, means, derivatives): # train_crop_array is a list of arrays
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
        for sample in x: #.to(device=device):
            crop_list.append(sample[1])
        # Apply hidden layers module
        hidden_features = self.hidden_layers(x)

        # Apply last layer (=output layer)
        output = self.output_layer(hidden_features) # a tensor with all output samples


      #  print(output[0], 'first out')

        stacked_denormal = torch.zeros(size=output.shape
                                      , dtype=torch.float32).to(device=device)  # , dtype=np.uint8)

        for index, e in enumerate(output):
            new_e = (output[index]* derivatives[index]) + means[index]
            final_tensor = stacked_denormal[index]
            final_tensor[:new_e.shape[0], :new_e.shape[1], :new_e.shape[2]] = new_e
            final_tensor = final_tensor.to(device=device)



        list_mask = []
        for ind,crop in enumerate(crop_list):
            #output_each_image = output[ind]
            crop_mask = crop.bool()

            crop_mask=crop_mask.view(1, crop_mask.shape[0], crop_mask.shape[1])
            list_mask.append(crop_mask)
        e_list = []
        for i in list_mask[0]:
            for j in i:
                for e in j:
                    if e == True:
                      e_list.append(e)

        list_predictions_per_batch = [stacked_denormal[i, list_mask[i]] for i in range(len(stacked_denormal))]

        return list_predictions_per_batch# stacked_target_array_tensor # list of onedimensional tensors --> are okay!!!!

cnn = CNN(n_input_channels=2, n_hidden_layers=4, n_hidden_kernels=32,
          n_output_channels=1, kernel_size=7).to(device=device)
mse = torch.nn.MSELoss(reduction='mean')

optimizer = torch.optim.Adam(cnn.parameters(), lr=1e-3)
# which have the same values and is also a tensor # changed parameters lead to the estimated target
# array, maybe
from torch.utils.tensorboard import SummaryWriter # is a class
import tqdm  # Progress bar

writer = SummaryWriter(log_dir="results/fourth_try...") # there should the tensorboard files placed in


print('feeding the CNN and training with trainingset starts...')
# I choose weight epoch to optimize my model:
jj = 0
save_best_gradients = None
for epoch in tqdm.tqdm(range(7), desc="training"):
    jj += 1
    print(f'{jj}. epoch starts...')

    in_batch = 0
    for batch in training_loader:
        # start with feeding the CNN

        in_batch += 1
        input_tensor, target_array_list, means, derivatives = batch


        target_array_list = target_array_list#.to(device=device)
        input_tensor = input_tensor.float()
        input_tensor = input_tensor.to(device=device)

        model_output_tensor =cnn(input_tensor, means, derivatives)#.to(device=device) # output shall have same size as input

        # you have to compare the output of your model (1d tensor) with target array (2d tensor),
        # therefore:

        losses = torch.stack([mse(prediction, target.reshape((-1,)))
                              for prediction, target in zip(model_output_tensor, target_array_list)])

        # Compare 1d with 1d
        # Here you get the MeanSquaredErrorLoss for each sample as list

        main_loss = losses.mean() # take the mean over all losses of one minibatch

        # l2 weight regularization:
        l2_term = torch.mean(torch.stack([(param ** 2).mean()
                                          for param in cnn.parameters()]))

        loss = main_loss + l2_term * 1e-2 # do I need l2 regularization with SGD optimizer????
        print(in_batch, loss)
        loss.backward()

        # Perform update:
        optimizer.step()

        if epoch % 10 == 0:
            m=model_output_tensor[0]
            m=m.mean()
            t= target_array_list[0]
            t=t.mean()
            # Add losses as scalars to tensorboard
            writer.add_scalar(tag="training/main_loss",
                              scalar_value=main_loss.cpu(),
                              global_step=update)
            writer.add_scalar(tag="training/l2_term",
                              scalar_value=l2_term.cpu(),
                              global_step=update)
            writer.add_scalar(tag="training/loss", scalar_value=loss.cpu(),
                              global_step=update)
            writer.add_scalars(main_tag="training/output_target",
                               tag_scalar_dict=dict(output=m.cpu(),
                                                    target=t.cpu()),
                               global_step=update)
            # Add weights as arrays to tensorboard
            for i, param in enumerate(cnn.parameters()):
                writer.add_histogram(tag=f'training/param_{i}', values=param.cpu(),
                                     global_step=update)
            # Add gradients as arrays to tensorboard
            for i, param in enumerate(cnn.parameters()):
                writer.add_histogram(tag=f'training/gradients_{i}',
                                     values=param.grad.cpu(),
                                     global_step=update)
        # Reset the accumulated gradients:         ...,

        optimizer.zero_grad()

        if epoch % 2:
            print('eva starts...')
            eva_ind = 0
            for eva_batch in validation_loader:
                eva_ind += 1
                eva_input_tensor, eva_target_array_list, means1, derivatives1 = eva_batch
                eva_input_tensor = eva_input_tensor.to(device=device)

                eva_input_tensor = eva_input_tensor.float()
                eva_model_output_tensor = cnn(eva_input_tensor, means1, derivatives1)  # cnn was optimized before, now
                # use the optimized cnn

                # now get its loss

                eva_losses = torch.stack([mse(prediction, target.reshape((-1,)))
                                          for prediction, target in
                                          zip(eva_model_output_tensor, eva_target_array_list)])
                eva_loss = eva_losses.mean()
                eva_loss_np = eva_loss.detach().cpu().numpy()  # now it is possible to compare the losses


                # eva_final_loss = eva_loss + eva_l2_term * 1e-5
                # Save the best gradients:
                print(eva_ind, 'compare losses:', save_best_gradients, 'vs.', eva_loss_np)
                if (save_best_gradients is None) or (eva_loss_np < save_best_gradients):
                    save_path = f'results_test8/epoch{epoch}.pt'
                    with open(save_path, 'wb') as f:
                        torch.save(cnn, f)
                    save_best_gradients = eva_loss_np  # save model when model is improving
                    print('saved_loss', save_best_gradients)
                    print('saved on path', save_path)


save_path = f'results_test8/trained_model1final.pt'
torch.save(cnn, save_path)
print('DONE')
