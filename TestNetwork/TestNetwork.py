
#Packagaes that you may need to install:
#   -> tensorflow
#   -> shap
#   -> pyplot

import tensorflow as tf
tf.compat.v1.disable_v2_behavior()
    #shap does not want to work cleanly with recent tensorflow versions. Use above if tf version 2.4+
    # https://stackoverflow.com/questions/66814523/shap-deepexplainer-with-tensorflow-2-4-error

from tensorflow import keras
from tensorflow.keras import models, layers, utils
import os
import matplotlib.pyplot as plt
import numpy as np
import shap

#GRAPH VISUALISATION, NOT ORIGINAL --> DELETE OR CREDIT WHEN USING:
    # https://towardsdatascience.com/deep-learning-with-python-neural-networks-complete-tutorial-6b53c0b06af0
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
def visualize_nn(model, description=False, figsize=(10, 8)):
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
    p = 0.025

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
        shap.plots._waterfall.waterfall_legacy(explainer.expected_value[0], shap_values,
                                               features=X_instance,feature_names=X_names)

#custom activation function example, will most likely be needed for our model
def binaryStepActivtion(x):
    #return 1 of x > 0.5, else return 1
    return tf.keras.activations.relu(x, alpha=0.0, max_value=1.0, threshold=0.5)
        #https://www.tensorflow.org/api_docs/python/tf/keras/activations/relu


model = models.Sequential(name="Test_Model", layers=[
    layers.Dense(              #a fully connected layer
          name="test_1",
          input_dim=10,        #num of inputs as singular layer model
          units=1,             #num of outputs as singular layer model
          activation= 'sigmoid' #f(x)=x
          #https://www.tensorflow.org/api_docs/python/tf/keras/activations/sigmoid
    )
])


n_features = 10
model2 = models.Sequential(name="DeepNN", layers=[
    ### hidden layer 1
    layers.Dense(name="h1", input_dim=n_features,
                 units=int(round((n_features + 1) / 2)),
                 activation='relu'),
    layers.Dropout(name="drop1", rate=0.2),

    ### hidden layer 2
    layers.Dense(name="h2", units=int(round((n_features + 1) / 4)),
                 activation='relu'),
    layers.Dropout(name="drop2", rate=0.2),

    ### layer output
    layers.Dense(name="output", units=1, activation='sigmoid')
])

#uncomment to see a visual representation of the above models
#visualize_nn(model, description=True, figsize=(10,8))
#visualize_nn(model2, description=True, figsize=(10,8))

print("Training sets: ")

#change the 10000 value to increase/decrease the amount of training data (and also train time)
TRAIN_DATA = 10000

x = np.random.rand(TRAIN_DATA,10)
    #generates an array of size TRAIN_DATA, with each element an array of size 10 contiang values from 1 --> 0
y = []
for item in x:
    y = np.append(y, round(sum(item)/len(item)))
    #generates an array of size x with each element either a 1 or 0
    #combined, X and y make up the training data
    #NEEDS TO BE A NUMPY ARRAY TO WORK WITH TENSORFLOW

print(x,y)
z = np.random.rand(10,10)
    #sample test dataset

#CAN CHANGE EVERY INSTANCE OF 'MODEL2' TO 'MODEL' BELOW TO SEE DIFFERENCE BETWEEN BOTH MODELS

#Optimizer --> responsible for changing the weights mid-training, the 'adam' algorithm is considered efficient and generally effective
    # --> https://www.tensorflow.org/api_docs/python/tf/keras/optimizers/Adam
#Loss --> used to determine the deviation between predicted and expected values. the 'binary-crossentropy' is expected to be used for binary classifications
    # --> https://keras.io/api/losses/probabilistic_losses/#binarycrossentropy-class
#metrics --> values that are to be used to guide the training of the model, in this case the model will favour its accuracy to be trained
model2.compile(optimizer="adam", loss='binary_crossentropy', metrics=['accuracy'])

#uncomment/recomment to untrain/retrain the model
training = model2.fit(x=x, y=y, batch_size=32, epochs=10, shuffle=True, verbose=1, validation_split=0.1)
    #batches --> size that the training set should be split into to avoid processing it all at once (should be a power of 2 ideally)
    #epochs --> number of iterations over the ENTIRE training set (higher --> better trained --> more time --> increased risk of over-fitting)
    #shuffle --> shuffle the training set or not before training
    #verbose --> how the training will appear in the console (0 = nothing, 1 = progress bar, 2 = epoch cycle)
        # --> lower loss, better model training, same with higher accuracy
        # --> inputs are random each time, expect deviation between model performance without changing anything when using poorly chosen activation functions
    #validation_split --> amount of training data set aside to validate the machine on after each epoch (between 0 -> 1)
#https://www.tensorflow.org/api_docs/python/tf/keras/Model#fit

#Runs the model against a random selection of (potentially) untrained inputs
predictions = model2.predict(z)
for i in range(len(z)):
    print("Given: " + str(z[i]) + " Prediction: " + str(predictions[i]) + " Expected: " + str(round(sum(z[i])/len(z[i]))))

i = 1
explainer_shap(model2,
               X_names=["1st: " + str(round(x[i][0],2)),
                        "2nd: " + str(round(x[i][1],2)),
                        "3rd: " + str(round(x[i][2],2)),
                        "4th: " + str(round(x[i][3],2)),
                        "5th: " + str(round(x[i][4],2)),
                        "6th: " + str(round(x[i][5],2)),
                        "7th: " + str(round(x[i][6],2)),
                        "8th: " + str(round(x[i][7],2)),
                        "9th: " + str(round(x[i][8],2)),
                        "10th: " + str(round(x[i][9],2))],
               X_instance=x[i],
               X_train=x,

               #Choose 1 task or the other
               #    --> classification: works as expected
               #    --> regression: slight grey text formatting issues still but would look better once working

               #task="classification",
               task="regression",


               top=10)

#ORIGINAL CODE:

#none right now, :(
