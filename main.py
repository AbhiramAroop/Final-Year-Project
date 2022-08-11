import os

import numpy as np

input_files = os.listdir("physionet.org/files/challenge-2012/1.0.0/set-a")
# print(input_files)

# input learning data from one file
my_data = np.genfromtxt("physionet.org/files/challenge-2012/1.0.0/set-a/132539.txt", delimiter=',',
                        dtype=[('Time', 'U64'), ('parameter', 'U64'), ('value', 'float')])
my_data = my_data[1:]  # Get rid of first line, since column headings are strings
input_data = [["Time", "Parameter", "value"]]

# convert time into int format
for i in range(len(my_data)):
    (m, s) = my_data[i][0].split(':')
    time_int = int(m) * 60 + int(s)
    input_data.append([time_int, my_data[i][1], my_data[i][2]])

input_data = np.array(input_data)
print("SINGLE INPUT FILE", input_data)
# output data
my_data = np.genfromtxt("physionet.org/files/challenge-2012/1.0.0/Outcomes-a.txt", delimiter=',',
                        dtype='U64')
# print(my_data)
output_data = []
for i in my_data:
    output_data.append([i[0], i[5]])
output_data = np.array(output_data)
# print("OUTPUT", output_data)

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

# print(input_parameter)
# print(input_value)

input_matrix = []
for i in range(len(input_parameter)):
    input_matrix.append([input_parameter[i], input_value[i]])

input_matrix = np.array(input_matrix,
                        dtype=object)
# Input with array values in chronological order
print(input_matrix,len(input_matrix))

# Lets have all parameters for each patient

parameters = "Age Gender Height ICUType Weight Albumin ALP ALT AST Bilirubin BUN Cholesterol Creatinine DiasABP FiO2 GCS Glucose HCO3 HCT HR K Lactate Mg MAP MechVent Na NIDiasABP NIMAP NISysABP PaCO2 PaO2 pH Platelets RespRate SaO2 SysABP Temp TropI TropT Urine WBC"
parameters = parameters.split(" ")
print(parameters)
values = []
for i in range(len(parameters)):
    values.append([])

for i in input_matrix[2:]:
    #print(i[0])
    index = parameters.index(i[0])
    values[index] = i[1]

#values of corresponding index parameters
#in a fixed order, as input for ML
print(values)