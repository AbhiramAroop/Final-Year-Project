import numpy as np
import os
import Input_Output_file_processing as input_output_data

mean_vals = []
data_mean_input = []

# computes the mean of a list
def compute_mean(num_list):
    if (len(num_list) != 0):
        return np.mean(num_list)
    return None

#Initiallise the values for mean
def init_mean(data):
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

#Computes the mean for all parametes
def set_mean():
    data = input_output_data.input_files_to_input_matrix(2)[1]
    means = init_mean(data)
    for i in means:
        mean_vals.append(compute_mean(i))

    mean_vals[1] = round(mean_vals[1])

    for i in range(len(data)):
        data_mean_input.append([])

    for i in range(len(data)):
        values = data[i][1]
        for j in range(len(values)):
            mean = compute_mean(values[j])
            if (mean != None) and (mean != -1.0):
                data_mean_input[i].append(mean)
            else:
                data_mean_input[i].append(mean_vals[j])

def get_output_list():
    data = input_output_data.read_output_file()
    output = []
    #print(data)
    for i in range(len(data)):
        output.append(data[i][1])

    return output
#Get mean array
def get_mean_list():
    set_mean()
    return mean_vals

def get_mean_data():
    set_mean()
    return data_mean_input


#print(mean_vals)
#print(data_mean_input)
#print(get_mean_data())
#print(get_mean_list())
#print(mean_vals)
#print(get_output_list())