import shap
import tensorflow as tf
from matplotlib import pyplot as plt
from tensorflow.keras import models, layers, utils
import numpy as np
def utils_nn_config(model):
    lst_layers = []
    if "Sequential" in str(model): #-> Sequential doesn't show the input layer
        layer = model.layers[0]
        lst_layers.append({"name":"input", "in":int(layer.input.shape[-1]), "neurons":0,
                           "out":int(layer.input.shape[-1]), "activation":None,
                           "params":0, "bias":0})
    for layer in model.layers:
        try:
            dic_layer = {"name":layer.name, "in":int(layer.input.shape[-1]), "neurons":layer.units,
                         "out":int(layer.output.shape[-1]), "activation":layer.get_config()["activation"],
                         "params":layer.get_weights()[0], "bias":layer.get_weights()[1]}
        except:
            dic_layer = {"name":layer.name, "in":int(layer.input.shape[-1]), "neurons":0,
                         "out":int(layer.output.shape[-1]), "activation":None,
                         "params":0, "bias":0}
        lst_layers.append(dic_layer)
    return lst_layers

#used to visually see the models. NOTE: only 1 window will be open at a time, need to close previous models before a new one will appear
def visualize_nn(model, description=False, figsize=(20, 16)):
    ## get layers info
    lst_layers = utils_nn_config(model)
    layer_sizes = [layer["out"] for layer in lst_layers]

    ## fig setup
    fig = plt.figure(figsize=figsize)
    ax = fig.gca()
    ax.set(title=model.name)
    ax.axis('off')
    left, right, bottom, top = 0.1, 0.9, 0.1, 0.9
    x_space = (right - left) / float(len(layer_sizes) - 1)
    y_space = (top - bottom) / float(max(layer_sizes))
    p = 0.00025

    ## nodes
    for i, n in enumerate(layer_sizes):
        top_on_layer = y_space * (n - 1) / 2.0 + (top + bottom) / 2.0
        layer = lst_layers[i]
        color = "green" if i in [0, len(layer_sizes) - 1] else "blue"
        color = "red" if (layer['neurons'] == 0) and (i > 0) else color

        ### add description
        if (description is True):
            d = i if i == 0 else i - 0.5
            if layer['activation'] is None:
                plt.text(x=left + d * x_space, y=top, fontsize=10, color=color, s=layer["name"].upper())
            else:
                plt.text(x=left + d * x_space, y=top, fontsize=10, color=color, s=layer["name"].upper())
                plt.text(x=left + d * x_space, y=top - p, fontsize=10, color=color, s=layer['activation'] + " (")
                plt.text(x=left + d * x_space, y=top - 2 * p, fontsize=10, color=color,
                         s="Σ" + str(layer['in']) + "[X*w]+b")
                out = " Y" if i == len(layer_sizes) - 1 else " out"
                plt.text(x=left + d * x_space, y=top - 3 * p, fontsize=10, color=color,
                         s=") = " + str(layer['neurons']) + out)

        ### circles
        for m in range(n):
            color = "limegreen" if color == "green" else color
            circle = plt.Circle(xy=(left + i * x_space, top_on_layer - m * y_space - 4 * p), radius=y_space / 4.0,
                                color=color, ec='k', zorder=4)
            ax.add_artist(circle)

            ### add text
            if i == 0:
                plt.text(x=left - 4 * p, y=top_on_layer - m * y_space - 4 * p, fontsize=10,
                         s=r'$X_{' + str(m + 1) + '}$')
            elif i == len(layer_sizes) - 1:
                plt.text(x=right + 4 * p, y=top_on_layer - m * y_space - 4 * p, fontsize=10,
                         s=r'$y_{' + str(m + 1) + '}$')
            else:
                plt.text(x=left + i * x_space + p,
                         y=top_on_layer - m * y_space + (y_space / 8. + 0.01 * y_space) - 4 * p, fontsize=10,
                         s=r'$H_{' + str(m + 1) + '}$')

    ## links
    for i, (n_a, n_b) in enumerate(zip(layer_sizes[:-1], layer_sizes[1:])):
        layer = lst_layers[i + 1]
        color = "green" if i == len(layer_sizes) - 2 else "blue"
        color = "red" if layer['neurons'] == 0 else color
        layer_top_a = y_space * (n_a - 1) / 2. + (top + bottom) / 2. - 4 * p
        layer_top_b = y_space * (n_b - 1) / 2. + (top + bottom) / 2. - 4 * p
        for m in range(n_a):
            for o in range(n_b):
                line = plt.Line2D([i * x_space + left, (i + 1) * x_space + left],
                                  [layer_top_a - m * y_space, layer_top_b - o * y_space],
                                  c=color, alpha=0.5)
                if layer['activation'] is None:
                    if o == m:
                        ax.add_artist(line)
                else:
                    ax.add_artist(line)
    plt.show()

#used to visually show the explanation of the model's thought process on a given prediction
def explainer_shap(model, X_names, X_instance, X_train=None, task="classification", top=10):
    ## create explainer
    ### machine learning
    if X_train is None:
        explainer = shap.TreeExplainer(model)
        shap_values = explainer.shap_values(X_instance)
    ### deep learning
    else:
        explainer = shap.DeepExplainer(model, data=X_train[:100])
        shap_values = explainer.shap_values(X_instance.reshape(1,-1))[0].reshape(-1)

    ## plot
    ### classification
    if task == "classification":
        shap.decision_plot(explainer.expected_value, shap_values, link='logit', feature_order='importance',
                           features=X_instance, feature_names=X_names, feature_display_range=slice(-1,-top-1,-1))

    ### regression
    else:
        #shap.waterfall_plot(shap_values) #features=X_instance
        #shap.waterfall_plot(shap_values, )
        #shap.plots._waterfall.waterfall_legacy(explainer.expected_value[0], shap_values, features=X_instance,feature_names=X_names, max_display=20)
        shap.bar_plot(shap_values,features=X_names, max_display=20)


my_model = tf.keras.models.load_model("./TestNetwork/Model/model2.h5")
my_model.load_weights("./TestNetwork/Weights/")

inputs = np.array([[54.0, 0.0, 88.07963179916318, 4.0, 76.51101250283111, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 10.5, 156.01112288135593, 0.75, 59.61266335699032, 0.5510762832767473, 14.923076923076923, 160.0, 27.0, 32.5, 70.8108108108108, 4.2, 2.379614163467666, 1.7, 81.03259439825668, 1.0, 136.5, 50.14705882352941, 71.55911764705883, 114.38235294117646, 40.370547141266655, 147.7101331793596, 7.449432591779825, 203.0, 17.428571428571427, 96.58760365657565, 119.03812218740782, 37.357142857142854, 7.6932419859595695, 1.0552813027612875, 171.05263157894737, 10.3], [76.0, 1.0, 175.3, 2.0, 80.6705882352941, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 18.333333333333332, 156.01112288135593, 1.0999999999999999, 58.89705882352941, 0.5599999999999999, 13.333333333333334, 125.5, 22.333333333333332, 28.65555555555555, 80.79411764705883, 3.9, 2.379614163467666, 2.3, 76.94029850746269, 1.0, 137.0, 56.714285714285715, 75.30857142857143, 112.5, 38.857142857142854, 210.14285714285714, 7.3950000000000005, 178.6, 19.631588561926726, 96.83333333333333, 113.41176470588235, 36.93913043478261, 7.6932419859595695, 1.0552813027612875, 151.5609756097561, 11.266666666666666], [44.0, 0.0, 88.07963179916318, 3.0, 56.699999999999974, 2.5, 116.0, 83.0, 199.5, 2.9, 4.666666666666667, 156.01112288135593, 0.3333333333333333, 67.125, 0.5000000000000001, 5.923076923076923, 134.33333333333334, 25.0, 28.46, 83.75925925925925, 4.26, 1.366666666666667, 1.72, 90.4375, 1.0, 138.33333333333334, 79.0, 96.7513157894737, 132.26315789473685, 35.5, 134.5, 7.494999999999999, 89.66666666666667, 19.631588561926726, 95.0, 125.6875, 37.800000000000004, 7.6932419859595695, 1.0552813027612875, 124.95121951219512, 4.7], [68.0, 1.0, 180.3, 3.0, 84.60000000000004, 4.4, 105.0, 12.0, 15.0, 0.2, 17.666666666666668, 156.01112288135593, 0.7666666666666666, 59.61266335699032, 0.5510762832767473, 14.944444444444445, 117.33333333333333, 27.666666666666668, 37.44285714285714, 70.98333333333333, 4.0, 2.379614163467666, 2.033333333333333, 81.03259439825668, 1.0, 139.33333333333334, 65.05172413793103, 83.88551724137932, 121.55172413793103, 40.370547141266655, 147.7101331793596, 7.449432591779825, 330.0, 15.457627118644067, 96.58760365657565, 119.03812218740782, 36.223076923076924, 7.6932419859595695, 1.0552813027612875, 545.8333333333334, 9.4], [88.0, 0.0, 88.07963179916318, 3.0, 76.51101250283111, 3.3, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 35.0, 156.01112288135593, 1.0, 59.61266335699032, 0.5510762832767473, 15.0, 102.5, 19.0, 29.55, 74.95833333333333, 4.32, 2.379614163467666, 1.55, 81.03259439825668, 1.0, 139.5, 45.72093023255814, 74.94651162790697, 133.3953488372093, 40.370547141266655, 147.7101331793596, 7.449432591779825, 103.0, 19.166666666666668, 96.58760365657565, 119.03812218740782, 36.88000000000001, 7.6932419859595695, 1.0552813027612875, 62.13157894736842, 4.3], [64.0, 1.0, 180.3, 1.0, 114.0, 2.9435978999483323, 101.0, 52.5, 104.5, 0.4, 16.75, 212.0, 0.9749999999999999, 73.62222222222222, 0.4666666666666668, 8.666666666666666, 204.66666666666666, 19.75, 37.225, 88.53191489361703, 4.1499999999999995, 2.379614163467666, 2.0, 88.68888888888888, 1.0, 137.75, 70.5, 81.985, 105.0, 35.142857142857146, 110.0, 7.405714285714287, 210.75, 19.631588561926726, 97.0, 115.68888888888888, 37.577777777777776, 1.3, 1.0552813027612875, 136.33333333333334, 16.099999999999998], [68.0, 0.0, 162.6, 3.0, 87.0, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 32.5, 156.01112288135593, 3.6, 79.0, 0.5510762832767473, 15.0, 105.0, 24.666666666666668, 31.599999999999998, 68.33898305084746, 3.775, 2.379614163467666, 1.9, 109.30188679245283, 1.0, 139.0, 72.0, 102.14714285714285, 162.42857142857142, 40.370547141266655, 147.7101331793596, 7.449432591779825, 329.6666666666667, 13.9, 96.58760365657565, 166.5, 36.63076923076923, 0.75, 1.0552813027612875, 62.970588235294116, 6.366666666666667], [78.0, 0.0, 162.6, 3.0, 48.4, 1.9, 47.0, 46.0, 82.0, 0.3, 64.6, 156.01112288135593, 0.68, 39.266666666666666, 0.5363636363636364, 11.846153846153847, 126.2, 13.6, 33.233333333333334, 70.94520547945206, 4.38, 1.6375, 2.6333333333333333, 64.76666666666667, 1.0, 139.6, 30.697674418604652, 55.177906976744175, 104.13953488372093, 30.533333333333335, 130.4, 7.274, 96.33333333333333, 19.631588561926726, 96.4, 125.55, 37.00555555555556, 3.3, 1.0552813027612875, 43.810810810810814, 20.0], [64.0, 0.0, 88.07963179916318, 3.0, 60.699999999999974, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 22.0, 156.01112288135593, 0.7, 59.61266335699032, 0.5510762832767473, 15.0, 112.5, 23.0, 28.3, 127.23913043478261, 4.2, 2.379614163467666, 1.65, 81.03259439825668, 1.0, 139.0, 64.47826086956522, 84.47739130434783, 124.47826086956522, 40.370547141266655, 147.7101331793596, 7.449432591779825, 696.0, 34.93478260869565, 96.58760365657565, 119.03812218740782, 36.9, 7.6932419859595695, 1.0552813027612875, 240.0, 15.2], [74.0, 1.0, 175.3, 2.0, 68.58275862068965, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 19.333333333333332, 156.01112288135593, 1.1333333333333335, 58.410714285714285, 0.6333333333333333, 14.083333333333334, 110.0, 24.666666666666668, 29.1, 85.1896551724138, 4.35, 2.379614163467666, 1.8, 79.51785714285714, 1.0, 140.0, 53.0, 75.67, 121.0, 44.875, 219.0, 7.35, 145.66666666666666, 19.631588561926726, 97.33333333333333, 124.89285714285714, 36.683333333333344, 7.6932419859595695, 1.0552813027612875, 108.08510638297872, 10.166666666666666]]).reshape(10,41)
#inputs = np.array([[54.0, 0.0, 88.07963179916318, 4.0, 76.51101250283111, 2.9435978999483323, 107.81957602518797, 164.0058370624472, 239.1381714715385, 1.9179911287689173, 10.5, 156.01112288135593, 0.75, 59.61266335699032, 0.5510762832767473, 14.923076923076923, 160.0, 27.0, 32.5, 70.8108108108108, 4.2, 2.379614163467666, 1.7, 81.03259439825668, 1.0, 136.5, 50.14705882352941, 71.55911764705883, 114.38235294117646, 40.370547141266655, 147.7101331793596, 7.449432591779825, 203.0, 17.428571428571427, 96.58760365657565, 119.03812218740782, 37.357142857142854, 7.6932419859595695, 1.0552813027612875, 171.05263157894737, 10.3]]).reshape(1,41)

outputs = [0, 0, 0, 0, 0, 0, 0, 1, 0, 0]
#outputs = [0]
predictions = my_model.predict(inputs)
for i in range(len(inputs)):
    print("Given: " + str(inputs[i]) + " Prediction: " + str(predictions[i]) + " Expected: " + str(outputs[i]))
x = inputs

parameters = "Age Gender Height ICUType Weight Albumin ALP ALT AST Bilirubin BUN Cholesterol Creatinine DiasABP FiO2 GCS Glucose HCO3 HCT HR K Lactate Mg MAP MechVent Na NIDiasABP NIMAP NISysABP PaCO2 PaO2 pH Platelets RespRate SaO2 SysABP Temp TroponinI TroponinT Urine WBC"
parameters = parameters.split(" ")
#print(parameters)

i = 1
explainer_shap(my_model,
               X_names=parameters,
               X_instance=x[1],
               X_train=x,

               #Choose 1 task or the other
               #    --> classification: works as expected
               #    --> regression: slight grey text formatting issues still but would look better once working

               #task="classification",
               task="regression",

               top=41)