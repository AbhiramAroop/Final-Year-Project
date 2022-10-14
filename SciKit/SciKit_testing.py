# All models are implemented as classifiers


import numpy as np

from sklearn.metrics import confusion_matrix, accuracy_score
import ast
import matplotlib.pyplot as plt

scoreFile = open("testResults","w")

#Each model is made from scratch each test to be entirely retrained on, and compared to, the test data sets
def testModels(inputFile, outputFile, descriptionTest):
    input_data_sets = []
    output_data_sets = []
    input_test_data_sets = []
    output_test_data_sets = []

    scoreFile.write("\n" + descriptionTest + "\n")


    with open(inputFile,"r") as IT:
        for line in IT:
            item = line.strip("\n")
            temp = item.split(" ")
            print(temp)
            input_data_sets.append(temp)

    with open(outputFile,"r") as OT:
        for item in OT.readlines():
            output_data_sets.append(int(item))

    with open("testInput.txt","r") as OT:
        for line in OT:
            item = line.strip("\n")
            temp = item.split(" ")
            input_test_data_sets.append(temp)

    with open("testOutput.txt","r") as OT:
        for item in OT.readlines():
            output_test_data_sets.append(int(item))

    for list in input_data_sets:
        for index in range(len(list)):
            list[index] = int(list[index])

    for list in input_test_data_sets:
        for index in range(len(list)):
            list[index] = int(list[index])

    for index in range(len(output_data_sets)):
        output_data_sets[index] = int(output_data_sets[index])

    for index in range(len(output_test_data_sets)):
        output_test_data_sets[index] = int(output_test_data_sets[index])



    print("AMOUNT OF INPUTS:",len(input_data_sets))
    print("AMOUNT OF OUTPUTS:",len(output_data_sets))

    print("AMOUNT OF testINPUTS:", len(input_test_data_sets))
    print("AMOUNT OF testOUTPUTS:", len(output_test_data_sets))


    #print("generating train test split...")
    #Auto-splits the given data into testing and training sets from the given test size
    # [:7955] works to just get the set a and set b data, [7955:11950] for the set c data
    inTrain = np.asarray(input_data_sets)
    outTrain = np.asarray(output_data_sets)
    inTest = np.asarray(input_test_data_sets)
    outTest = np.asarray(output_test_data_sets)

    #NEURAL NETWORK IMPLEMENTATION:
    from sklearn.neural_network import MLPClassifier


    #Assumes default values --> https://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPClassifier.html#sklearn.neural_network.MLPClassifier
    clfNN = MLPClassifier().fit(inTrain, outTrain)


    predictions = clfNN.predict(inTest)


    accuracy = accuracy_score(outTest,predictions)*100

    #True/False Positives/Negatives for binary cases
    tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

    scoreFile.write("NeuralNetwork accuracy = " + str(accuracy) +"\n")
    scoreFile.write("TN: " + str(tn) + " FP: " + str(fp) + " FN: " + str(fn) + " TP: " + str(tp) + "\n")




    #RANDOM FOREST IMPLEMENTATION:
    from sklearn.ensemble import RandomForestClassifier

    #Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html
    clfRF = RandomForestClassifier()
    clfRF.fit(inTrain, outTrain)

    predictions = clfRF.predict(inTest)
    accuracy = accuracy_score(outTest,predictions)*100

    #True/False Positives/Negatives for binary cases
    tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

    scoreFile.write("RandomForest accuracy = " + str(accuracy)+"\n")
    scoreFile.write("TN: " + str(tn) + " FP: " + str(fp) + " FN: " + str(fn) + " TP: " + str(tp) + "\n")

    #EXTRA FOREST IMPLEMENTATION:
    from sklearn.ensemble import ExtraTreesClassifier

    #Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.ExtraTreesClassifier.html#sklearn.ensemble.ExtraTreesClassifier
    clfET = ExtraTreesClassifier()
    clfET.fit(inTrain, outTrain)


    predictions = clfET.predict(inTest)
    accuracy = accuracy_score(outTest,predictions)*100

    #True/False Positives/Negatives for binary cases
    tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

    scoreFile.write("ExtraForest accuracy = " + str(accuracy)+"\n")
    scoreFile.write("TN: " + str(tn) + " FP: " + str(fp) + " FN: " + str(fn) + " TP: " + str(tp) + "\n")

    #ADABOOST IMPLEMENTATION
    from sklearn.ensemble import AdaBoostClassifier

    #Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.AdaBoostClassifier.html#sklearn.ensemble.AdaBoostClassifier
    clfAB = AdaBoostClassifier()
    clfAB.fit(inTrain, outTrain)


    predictions = clfAB.predict(inTest)
    accuracy = accuracy_score(outTest,predictions)*100

    #True/False Positives/Negatives for binary cases
    tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

    scoreFile.write("AdaBoost accuracy = " + str(accuracy)+"\n")
    scoreFile.write("TN: " + str(tn) + " FP: " + str(fp) + " FN: " + str(fn) + " TP: " + str(tp) + "\n")

    #VOTING CLASSIFIER IMPLEMENTATION:
    from sklearn.ensemble import VotingClassifier

    #Default values --> https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.VotingClassifier.html#sklearn.ensemble.VotingClassifier
    Vclf = VotingClassifier(estimators=[('NN',clfNN),('RF',clfRF),('AB',clfAB),('ET',clfET)])

    #As the models have already been fit with the data, this model may be somewhat inaccurate of true results
    Vclf.fit(inTrain, outTrain)

    predictions = Vclf.predict(inTest)
    accuracy = accuracy_score(outTest,predictions)*100

    #True/False Positives/Negatives for binary cases
    tn, fp, fn, tp = confusion_matrix(outTest, predictions).ravel()

    scoreFile.write("VotingClassifier accuracy = " + str(accuracy)+"\n")
    scoreFile.write("TN: " + str(tn) + " FP: " + str(fp) + " FN: " + str(fn) + " TP: " + str(tp) + "\n")



testModels("basicInput.txt", "basicOutput.txt","Testing For Basic Model Learning against Simple Inputs")
testModels("biasInput.txt", "biasOutput.txt","Testing For Model Learning against inputs which heavily favour a specific classification ")
testModels("limitedInput.txt", "limitedOutput.txt","Testing For Basic Model Learning against a low number of Inputs")
testModels("misleadingInput.txt", "misleadingOutput.txt","Testing For Basic Model Learning against Inputs which may not cover all relationships between variables and output")

scoreFile.close()

