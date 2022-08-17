import os
import numpy as np
import timeit

#read data from input file
def read_input_file(input_file):
    #print(input_file)
    my_data = np.genfromtxt(input_file, delimiter=',',
                            dtype=[('Time', 'U64'), ('parameter', 'U64'), ('value', 'float')])

    my_data = my_data[1:]
    input_data = [["Time", "Parameter", "value"]]

    # convert time into int format
    for i in range(len(my_data)):
        (m, s) = my_data[i][0].split(':')
        time_int = int(m) * 60 + int(s)
        input_data.append([time_int, my_data[i][1], my_data[i][2]])

    input_data = np.array(input_data)
    return input_data

#Read data from an output file
def read_output_file(output_file):
    my_data = np.genfromtxt(output_file, delimiter=',',
                            dtype='U64')
    # print(my_data)
    output_data = []
    for i in my_data:
        output_data.append([i[0], i[5]])
    output_data = np.array(output_data)
    return output_data

#convert data into two numpy arrays
#first with parameters second with values
def input_format_1(input_data):
    input_parameter = []
    input_value = []

    for i in range(len(input_data)):
        if input_data[i][1] not in input_parameter:
            input_parameter.append(input_data[i][1])
            input_value.append([input_data[i][2]])
        else:
            index = input_parameter.index(input_data[i][1])
            input_value[index].append(input_data[i][2])

    input_parameter = np.array(input_parameter)
    input_value = np.array(input_value,
                           dtype=object)
    return input_parameter,input_value

#takes parameters and values from format 1
#arranged them in a list of list format (2 list outputs)
def input_format_2(input_parameter,input_value):
    input_matrix = []
    for i in range(len(input_parameter)):
        input_matrix.append([input_parameter[i], input_value[i]])

    input_matrix = np.array(input_matrix,
                            dtype=object)
    # Input with array values in chronological order
    # print(input_matrix, len(input_matrix))

    # Lets have all parameters for each patient

    parameters = "Age Gender Height ICUType Weight Albumin ALP ALT AST Bilirubin BUN Cholesterol Creatinine DiasABP FiO2 GCS Glucose HCO3 HCT HR K Lactate Mg MAP MechVent Na NIDiasABP NIMAP NISysABP PaCO2 PaO2 pH Platelets RespRate SaO2 SysABP Temp TroponinI TroponinT Urine WBC"
    parameters = parameters.split(" ")
    # print(parameters)
    values = []
    for i in range(len(parameters)):
        values.append([])

    record_id = input_matrix[1][1][0]

    for i in input_matrix[2:]:
        # print(i[0])
        index = parameters.index(i[0])
        values[index] = i[1]

    # change values to float
    for i in range(len(values)):
        for j in range(len(values[i])):
            values[i][j] = float(values[i][j])

    return parameters,values

#creates a N x M matrix, with -1 or 0.5 values for empty values
def input_format_3(values):
    matrix_length = 0
    for i in values:
        if len(i) > matrix_length:
            matrix_length = len(i)

    for i in range(len(values)):
        for j in range(matrix_length-len(values[i])):
            values[i].append(-1)

    values = np.array(values)
    return values

#Puts all input filenames into a list
def input_files_to_list():
    input_file_loc = os.listdir("physionet.org/files/challenge-2012/1.0.0/set-a")
    input_files = []
    for i in input_file_loc:
        input_files.append("physionet.org/files/challenge-2012/1.0.0/set-a/" + i)

    return input_files

#converts all of the inputs into a matrix format (format 3)
#only SET A for now
def input_files_to_input_matrix(format):
    input_files = input_files_to_list()[:-1]
    input_values_matrix = []

    for i in input_files:
        input_data = read_input_file(i)
        input_parameter, input_value = input_format_1(input_data)
        parameters, values = input_format_2(input_parameter, input_value)
        if format == 1:
            input_format = input_format_1(input_data)
        elif format == 2:
            input_format = input_format_2(input_parameter,input_value)
        else:
            input_format = input_format_3(values)
        input_values_matrix.append(input_format)
        #print(input_format)

    return input_values_matrix


start = timeit.timeit()
data = input_files_to_input_matrix(3)
print("done",timeit.timeit()-start)