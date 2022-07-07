#How to Tune the Number of Neurons in the Hidden Layer

# Use scikit-learn to grid search the number of neurons
import numpy as np
import tensorflow as tf
from sklearn.model_selection import GridSearchCV
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Dropout
from scikeras.wrappers import KerasClassifier
from tensorflow.keras.constraints import MaxNorm
# Function to create model, required for KerasClassifier
def create_model(neurons):
	# create model
	model = Sequential()
	model.add(Dense(neurons, input_shape=(8,), kernel_initializer='uniform', activation='linear', kernel_constraint=MaxNorm(4)))
	model.add(Dropout(0.2))
	model.add(Dense(1, kernel_initializer='uniform', activation='sigmoid'))
	# Compile model
	model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
	return model
# fix random seed for reproducibility
seed = 7
tf.random.set_seed(seed)
# load dataset
dataset = np.loadtxt("pima-indians-diabetes.csv", delimiter=",")
# split into input (X) and output (Y) variables
X = dataset[:,0:8]
Y = dataset[:,8]
# create model
model = KerasClassifier(model=create_model, epochs=100, batch_size=10, verbose=0)
# define the grid search parameters
neurons = [1, 5, 10, 15, 20, 25, 30]
param_grid = dict(model__neurons=neurons)
grid = GridSearchCV(estimator=model, param_grid=param_grid, n_jobs=-1, cv=3)
grid_result = grid.fit(X, Y)
# summarize results
print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
means = grid_result.cv_results_['mean_test_score']
stds = grid_result.cv_results_['std_test_score']
params = grid_result.cv_results_['params']
for mean, stdev, param in zip(means, stds, params):
    print("%f (%f) with: %r" % (mean, stdev, param))



#Tips for Hyperparameter Optimization

#This section lists some handy tips to consider when tuning hyperparameters of your neural network.

#k-fold Cross Validation. You can see that the results from the examples in this post show some variance.
#  A default cross-validation of 3 was used, but perhaps k=5 or k=10 would be more stable. 
# Carefully choose your cross validation configuration to ensure your results are stable.
#Review the Whole Grid. Do not just focus on the best result, review the whole grid of results
#  and look for trends to support configuration decisions.
#Parallelize. Use all your cores if you can, neural networks are slow to train and we often
#  want to try a lot of different parameters. Consider spinning up a lot of AWS instances.
#Use a Sample of Your Dataset. Because networks are slow to train, try training them on a smaller 
# sample of your training dataset, just to get an idea of general directions of parameters rather
#  than optimal configurations.
#Start with Coarse Grids. Start with coarse-grained grids and zoom into finer grained grids once you 
# can narrow the scope.
#Do not Transfer Results. Results are generally problem specific. Try to avoid favorite configurations
#  on each new problem that you see. It is unlikely that optimal results you discover on one problem 
# will transfer to your next project. Instead look for broader trends like number of layers or
#  relationships between parameters.
#Reproducibility is a Problem. Although we set the seed for the random number generator in NumPy, 
# the results are not 100% reproducible. There is more to reproducibility when grid searching wrapped 
# Keras models than is presented in this post.
