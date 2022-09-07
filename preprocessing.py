import numpy as np
import os
import Input_Output_file_processing as input_output_data

mean_vals = []

#computes the mean of a list
def compute_mean(num_list):
    if (len(num_list) != 0):
        return np.mean(num_list)
    return None

def init_mean():
    data = input_output_data.input_files_to_input_matrix(2)[1]
    means = []
    mean_length = len(data[0][0])
    for i in range(mean_length):
        means.append([])

    for i in range(len(data)):
        values = data[i][1]
        for j in range(len(values)):
            mean = compute_mean(values[j])
            if mean != None:
                means[j].append(mean)

    return means

def set_mean():
    means = init_mean()
    for i in means:
        mean_vals.append(compute_mean(i))

    mean_vals[1] = round(mean_vals[1])



set_mean()
print(mean_vals)