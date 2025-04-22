"""ex6.py
Author: Nina Braunmiller
Matr.Nr.: k11923286
Exercise 6
"""

def ex6(logits, activation_function, threshold, targets):
    import tensorflow as tf
    import torch
    import numpy as np

    TP = 0 # true positive
    TN = 0 # true negative
    FP = 0 # false positive
    FN = 0 # false negative


    # raise TypeError when
    if torch.is_floating_point(logits) == False:
        raise TypeError('logits is no torch of floating datatype!')

    if torch.is_tensor(threshold) == False:
        raise TypeError('threshold is no tensor!')

    if targets.dtype != torch.bool:
        raise TypeError('targets is no boolean tensor!')


    # raise ValueError when

    lo = logits.numpy()
    if lo.ndim != 1:
        raise ValueError

    ta = targets.numpy()
    if ta.ndim != 1:
        raise ValueError

    if len(logits) == 0:
        raise ValueError

    if len(targets) == 0:
        raise ValueError

    if len(logits) != len(targets):
        raise ValueError('logits and targets have a different number of samples!')

    true = 0
    false = 0
    for ele in targets:
        if ele == True:
            true += 1
        elif ele == False:
            false += 1
     #   else:
      #      raise ValueError

    if true == 0:
        raise ValueError('No True in targets!')
    elif false == 0:
        raise ValueError('No False in targets!')

    # get the single values out of the input logits and targets at the same time by looping:
    for index, samples in enumerate(logits):
        curr_sample_logit = logits[index]
        curr_sample_targets = targets[index]

        curr_model_prediction = activation_function(curr_sample_logit)

        # if the modified sample score is higher than a border/threshold then the sample shall be marked as 'True'
        if curr_model_prediction >= threshold:
            curr_marked_sample = True
        else: # sample shall be marked as False
            curr_marked_sample = False

        # when the marked sample is the same as the target then the model prediction was right:
        if curr_marked_sample == True and curr_sample_targets == True:
            TP += 1
        elif curr_marked_sample == False and curr_sample_targets == False:
            TN += 1
        elif curr_marked_sample == True and curr_sample_targets == False:
            FP += 1
        elif curr_marked_sample == False and curr_sample_targets == True:
            FN += 1

    # calculate the searched output values:
    # True positive rate:
    TPR = TP / (TP + FN)

    # True negative rate:
    TNR = TN / (TN + FP)

    # False positive rate:
    FPR = 1 - TNR

    # Fale negative rate:
    FNR = 1 - TPR

    # accuracy:
    accuracy = (TP + TN) / (TP + TN + FP + FN)

    # balanced accuracy:
    bal_accuracy = (TPR + TNR) / 2


    return (TPR, TNR, FPR, FNR, accuracy, bal_accuracy)



