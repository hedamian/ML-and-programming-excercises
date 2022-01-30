# first neural network with keras tutorial
from numpy import loadtxt
from keras.models import Sequential
from keras.layers import Dense


# load the dataset
dataset = loadtxt('pima-indians-diabetes.csv', delimiter=',')
# split into input (X) and output (y) variables
X = dataset[:,0:8]
y = dataset[:,8]

#Models in Keras are defined as a sequence of layers.
#We create a Sequential model and add layers one at a time until we are happy with our network architecture.
#The first thing to get right is to ensure the input layer has the right number of input features.
#This can be specified when creating the first layer with the input_dim argument and setting it to 8 for the 8 input variables.
#How do we know the number of layers and their types?
#This is a very hard question. There are heuristics that we can use and often
#the best network structure is found through a process of trial and error experimentation
#Generally, you need a network large enough to capture the structure of the problem.


#Fully connected layers are defined using the Dense class.
#We can specify the number of neurons or nodes in the layer as the first argument,
#and specify the activation function using the activation argument.

#We will use the rectified linear unit activation function referred to as ReLU
#on the first two layers and the Sigmoid function in the output layer.


# define the keras model
model = Sequential()
model.add(Dense(12, input_dim=8, activation='relu'))
model.add(Dense(8, activation='relu'))
model.add(Dense(1, activation='sigmoid'))





# compile the keras model
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

#We can train or fit our model on our loaded data by calling the fit() function on the model.
#raining occurs over epochs and each epoch is split into batches.

#Epoch: One pass through all of the rows in the training dataset.
#Batch: One or more samples considered by the model within an epoch before weights are updated.


# fit the keras model on the dataset
model.fit(X, y, epochs=150, batch_size=10)


#The evaluate() function will return a list with two values.
#The first will be the loss of the model on the dataset and the second will be the accuracy of the model on the dataset.
# We are only interested in reporting the accuracy, so we will ignore the loss value.


# evaluate the keras model
_, accuracy = model.evaluate(X, y)
print('Accuracy: %.2f' % (accuracy*100))

# make class predictions with the model
predictions = (model.predict(X) > 0.5).astype(int)
# summarize the first 5 cases
for i in range(768):
	print('%s => %d (expected %d)' % (X[i].tolist(), predictions[i], y[i]))
