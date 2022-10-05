import numpy as np


mean_lst = [64.51907949790795, 1, 88.07963179916318, 2.778410041841004, 76.51101250283111, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 25.43866573829181, 156.01112288135593, 1.356137324014913, 59.61266335699032, 0.5510762832767473, 11.64202015665703, 137.28933985266397, 23.676099932986638, 31.397114116374343, 87.05126944377999, 4.131746136066895, 2.379614163467666, 2.015791260418448, 81.03259439825668, 1.0, 138.88556988717397, 57.277354246564535, 76.44662386278048, 117.2374079998596, 40.370547141266655, 147.7101331793596, 7.449432591779825, 203.9575736782518, 19.631588561926726, 96.58760365657565, 119.03812218740782, 36.95715348264941, 7.6932419859595695, 1.0552813027612875, 134.31089468974935, 12.81182300303993]


def parser(string):
    input_lines = string.split("\n")
    recordID = float(input_lines[1].split(',')[2])
    input_lines = input_lines[2:]

    input_lists = []
    for i in range(len(input_lines)):
        input_lists.append(input_lines[i].split(",")[1:])
        input_lists[i][1] = float(input_lists[i][1])

    unproc_input_list = []
    parameters = "Age Gender Height ICUType Weight Albumin ALP ALT AST Bilirubin BUN Cholesterol Creatinine DiasABP FiO2 GCS Glucose HCO3 HCT HR K Lactate Mg MAP MechVent Na NIDiasABP NIMAP NISysABP PaCO2 PaO2 pH Platelets RespRate SaO2 SysABP Temp TroponinI TroponinT Urine WBC"
    parameters = parameters.split(" ")

    for i in range(len(parameters)):
        unproc_input_list.append([])
        for j in range(len(input_lists)):
            if input_lists[j][0] == parameters[i]:
                unproc_input_list[i].append(input_lists[j][1])

    proc_input = []
    for i in unproc_input_list:
        if len(i) == 0:
            proc_input.append(mean_lst[i])
        else:
            proc_input.append(np.mean(unproc_input_list))

    return recordID, proc_input
