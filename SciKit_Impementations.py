#FILE GOAL:
#   - implement multiple sci-kit machine learning models
#   - get SHAP working with the models
import copy

# All models are implemented as classifiers


import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, accuracy_score
import ast
import matplotlib.pyplot as plt


#Set C has been included in the data returned to 'input_data_sets' BUT NOT FOR 'output_data_sets'
#   - need to rectify before the below can work again, as 'train_test_split' requires same num of inputs in both

#write the input/output lists to new txt files for easier access as opposed to calling the pre-process functions each time

scoreFile = open("Scores.txt","w")

input_data_sets = []
output_data_sets = []

#Write to file both lists

#Sets a + b is 11950 in size, write set c to different file

with open("Input_Train","r") as IT:
    for item in IT.readlines():
        temp = ast.literal_eval(item)
        input_data_sets.append(temp[:len(temp)//2])

with open("Output_Train","r") as OT:
    for item in OT.readlines():
        output_data_sets.append(int(item))

print(input_data_sets[0])
#print(input_data_sets[11951])
print(output_data_sets[0])

print("AMOUNT OF INPUTS:",len(input_data_sets))
print("AMOUNT OF OUTPUTS:",len(output_data_sets))




print("generating train test split...")
#Auto-splits the given data into testing and training sets from the given test size
# [:7955] works to just get the set a and set b data, [7955:11950] for the set c data
inTrain = input_data_sets[:1000]
outTrain = output_data_sets[:1000]
inTest = input_data_sets[7955:11950]
outTest = output_data_sets[7955:11950]

#NEURAL NETWORK IMPLEMENTATION:
from sklearn.neural_network import MLPClassifier

print("fitting to classifier...")
#Assumes default values --> https://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPClassifier.html#sklearn.neural_network.MLPClassifier
clfNN = MLPClassifier().fit(inTrain, outTrain)

print("predicting on test data...")
predictions = clfNN.predict(inTest)



accuracy = accuracy_score(outTest,predictions)*100
confusion_mat = confusion_matrix(outTest,predictions)

#True/False Positives/Negatives for binary cases
tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

print("Accuracy for Neural Network is:",accuracy)
print("Confusion Matrix")
print(confusion_mat)
print(tn, fp, fn, tp)

scoreFile.write("Neural Network: \n")
first = tp/(tp+fn)
second = tp/(tp+fp)

scoreFile.write(str(first) + " " + str(second))
scoreFile.write("\n")

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

#RANDOM FOREST IMPLEMENTATION:
from sklearn.ensemble import RandomForestClassifier

#Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html
clfRF = RandomForestClassifier()
clfRF.fit(inTrain, outTrain)

predictions = clfRF.predict(inTest)
accuracy = accuracy_score(outTest,predictions)*100

confusion_mat = confusion_matrix(outTest,predictions)

#True/False Positives/Negatives for binary cases
tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

print("Accuracy for Random Forest is:",accuracy)
print("Confusion Matrix")
print(confusion_mat)
print(tn, fp, fn, tp)

scoreFile.write("Random Forest: \n")
first = tp/(tp+fn)
second = tp/(tp+fp)

scoreFile.write(str(first) + " " + str(second))
scoreFile.write("\n")

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

#EXTRA FOREST IMPLEMENTATION:
from sklearn.ensemble import ExtraTreesClassifier

#Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.ExtraTreesClassifier.html#sklearn.ensemble.ExtraTreesClassifier
clfET = ExtraTreesClassifier()
clfET.fit(inTrain, outTrain)


predictions = clfET.predict(inTest)
accuracy = accuracy_score(outTest,predictions)*100

confusion_mat = confusion_matrix(outTest,predictions)

#True/False Positives/Negatives for binary cases
tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

print("Accuracy for Extra forest is:",accuracy)
print("Confusion Matrix")
print(confusion_mat)
print(tn, fp, fn, tp)

scoreFile.write("Extra Forest: \n")
first = tp/(tp+fn)
second = tp/(tp+fp)

scoreFile.write(str(first) + " " + str(second))
scoreFile.write("\n")

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

#ADABOOST IMPLEMENTATION
from sklearn.ensemble import AdaBoostClassifier

#Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.AdaBoostClassifier.html#sklearn.ensemble.AdaBoostClassifier
clfAB = AdaBoostClassifier()
clfAB.fit(inTrain, outTrain)


predictions = clfAB.predict(inTest)
accuracy = accuracy_score(outTest,predictions)*100

confusion_mat = confusion_matrix(outTest,predictions)

#True/False Positives/Negatives for binary cases
tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

print("Accuracy for AdaBoost is:",accuracy)
print("Confusion Matrix")
print(confusion_mat)
print(tn, fp, fn, tp)

scoreFile.write("AdaBoost: \n")
first = tp/(tp+fn)
second = tp/(tp+fp)

scoreFile.write(str(first) + " " + str(second))
scoreFile.write("\n")

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

#VOTING CLASSIFIER IMPLEMENTATION:
from sklearn.ensemble import VotingClassifier

#Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.VotingClassifier.html#sklearn.ensemble.VotingClassifier
Vclf = VotingClassifier(estimators=[('NN',clfNN),('RF',clfRF),('AB',clfAB),('ET',clfET)])

#As the models have already been fit with the data, this model may be somewhat inaccurate of true results
Vclf.fit(inTrain, outTrain)

predictions = Vclf.predict(inTest)
accuracy = accuracy_score(outTest,predictions)*100

confusion_mat = confusion_matrix(outTest,predictions)

#True/False Positives/Negatives for binary cases
tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

print("Accuracy for Voting_Classifier is:",accuracy)
print("Confusion Matrix")
print(confusion_mat)
print(tn, fp, fn, tp)

scoreFile.write("Ensemble: \n")
first = tp/(tp+fn)
second = tp/(tp+fp)

scoreFile.write(str(first) + " " + str(second))
scoreFile.write("\n")

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

scoreFile.close()

#SHAP TESTING/OUTPUT:

# See following for further explanation--> https://stackoverflow.com/questions/65549588/shap-treeexplainer-for-randomforest-multiclass-what-is-shap-valuesi

#RANDOM FOREST OUTPUT
import shap
from shap import TreeExplainer, summary_plot
parameters = "Age Gender Height ICUType Weight Albumin ALP ALT AST Bilirubin BUN Cholesterol Creatinine DiasABP FiO2 GCS Glucose HCO3 HCT HR K Lactate Mg MAP MechVent Na NIDiasABP NIMAP NISysABP PaCO2 PaO2 pH Platelets RespRate SaO2 SysABP Temp TroponinI TroponinT Urine WBC"
parameters = parameters.split(" ")

explainer = TreeExplainer(clfRF,feature_names=parameters)
print("Getting SHAP values (may take a while)...")
shap_values = explainer.shap_values(np.asarray(inTrain[:100]))
#print(len(shap_values[0][0]), shap_values[0][0])

#https://shap-lrjball.readthedocs.io/en/latest/generated/shap.summary_plot.html


prediction = clfRF.predict_proba([inTrain[34]])
print(prediction,34)

prediction = clfRF.predict_proba([inTrain[35]])
print(prediction,35)

prediction = clfRF.predict_proba([inTrain[36]])
print(prediction,36)

prediction = clfRF.predict_proba([inTrain[37]])
print(prediction,37)

prediction = clfRF.predict_proba([inTrain[38]])
print(prediction,38)

prediction = clfRF.predict_proba([inTrain[39]])
print(prediction,39)


testValues = explainer(np.asarray(inTrain[:100]))

#shap.summary_plot(shap_values[0],inTrain, feature_names=parameters)
#shap.summary_plot(shap_values[1],inTrain, feature_names=parameters)
#not tested:


shap_values2 = copy.deepcopy(testValues)
shap_values2.values = shap_values2.values[:,:,1]
shap_values2.base_values = shap_values2.base_values[:,1]

shap.plots.beeswarm(shap_values2,max_display=20)
#low shap = 'died'
#high shap = 'survived'



shap.summary_plot(shap_values, inTrain, feature_names=parameters, class_names=["Survived", "Died"])



#summary plots as a bar graph, somewhat confusing
#shap.summary_plot(shap_values,np.asarray(inTrain[8]), feature_names=parameters)
#plot_type = "bar"
#,feature_names=parameters

#https://github.com/slundberg/shap/issues/764
