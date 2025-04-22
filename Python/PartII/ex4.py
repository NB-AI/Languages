"""ex4.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 4
"""

def ex4(image_array, crop_size, crop_center):
    import numpy as np
    # Value error if
    # image array is no 2d numpy array:
    if isinstance(image_array, np.ndarray) == False: #??? also for 3d???
        raise ValueError('Image input isn\'t a suitable array.')
    if len(image_array.shape) != 2:
        raise ValueError
    if len(crop_center) != 2:
        raise ValueError
    if len(crop_size) != 2:
        raise ValueError

    if crop_size[0]%2==0:
        raise ValueError
    if crop_size[1]%2==0:
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

    left_upper_corner = image_array2[H-int((height_length_rec-1)/2)][W-int((width_length_rec-1)/2)]
    right_upper_corner = image_array2[H-int((height_length_rec-1)/2)][W+int((width_length_rec-1)/2)]
    left_lower_corner = image_array2[H+int((height_length_rec-1)/2)][W-int((width_length_rec-1)/2)]
    right_lower_corner = image_array2[H+int((height_length_rec-1)/2)][W+int((width_length_rec-1)/2)]

    # look if the corners are within the image:
    if H-int((height_length_rec-1)/2) < 0:
        raise ValueError
    if H+int((height_length_rec-1)/2) > image_array.shape[0]:
        raise ValueError
    if W-int((width_length_rec-1)/2) < 0:
        raise ValueError
    if W+int((width_length_rec-1)/2) > image_array.shape[1]:
        raise ValueError

    # create the crop_array:
    crop_array = np.zeros(shape=image_array2.shape, dtype=image_array.dtype) # until now only filled with 0s

    # create target_array:
    target_array = np.zeros(shape=crop_size, dtype=image_array.dtype)

    # search the rectangle in image_array2 and make all the needed changes for image_array2, crop_array and target_array:
    target_list = []
    for index_lines, lines in enumerate(image_array2):
        for index_elements, elements in enumerate(lines):

            # have a look at the distance between rectangle and frame (ValueErrors risen when problems):

            # left upper corner:
            if index_lines == H-int((height_length_rec-1)/2) and index_elements == (W-int((width_length_rec-1)/2)):
                if (index_lines + 1) <= 20:
                    raise ValueError('Rectangle is too near to upper border of image.')
                if index_elements + 1 <= 20:
                    raise ValueError('Rectangle is too near to left border of image.')

            # right upper corner:
            if index_lines == H-int((height_length_rec-1)/2) and index_elements == (W+int((width_length_rec-1)/2)):
                if (index_lines + 1) <= 20:
                    raise ValueError('Rectangle is too near to upper border of image.')
                if (image_array2.shape[1] - index_elements) <= 20:
                    raise ValueError('Rectangle is too near to right border of image.')

            # left lower corner:
            if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (W - int((width_length_rec - 1) / 2)):
                if index_elements + 1 <= 20:
                    raise ValueError('Rectangle is too near to left border of image.')
                if (image_array2.shape[0] - index_lines) <= 20:
                    raise ValueError('Rectangle is too near to lower border of image.')

            # right lower corner:
            if index_lines == H + int((height_length_rec - 1) / 2) and index_elements == (W + int((width_length_rec - 1) / 2)):
                if (image_array2.shape[1] - index_elements) <= 20:
                    raise ValueError('Rectangle is too near to right border of image.')
                if (image_array2.shape[0] - index_lines) <= 20:
                    raise ValueError('Rectangle is too near to lower border of image.')

            # get the space of the cropped rectangle in the image_array copy:
            if index_lines >= (H-int((height_length_rec-1)/2)) and index_lines <= (H+int((height_length_rec-1)/2)):
                if index_elements >= (W-int((width_length_rec-1)/2)) and index_elements <= (W+int((width_length_rec-1)/2)):
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
            target_array[index][index_ele] = target_list[0]
            target_list = target_list[1:]


    return (image_array2, crop_array, target_array)
