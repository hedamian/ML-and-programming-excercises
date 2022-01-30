##example 1 neural network training
#In this tutorial, you will implement a small subsection of object recognition—digit recognition.
#Using TensorFlow (https://www.tensorflow.org/), an open-source Python library developed by the Google Brain labs for deep learning research,
#you will take hand-drawn images of the numbers 0-9 and build and train a neural network to recognize and predict the correct label for the digit displayed.

import tensorflow.compat.v1 as tf
tf.disable_v2_behavior()
#note, this command sets tensorflow 2 in compatibility mode  with version 1


#import mnist data from input_data.py
#When reading in the data, we are using one-hot-encoding to represent the labels 
import input_data
mnist = input_data.read_data_sets('MNIST_data', one_hot=True)


#training parameters
n_train = mnist.train.num_examples #number of examples  55,000
n_validation = mnist.validation.num_examples # number of examples for validation 5000
n_test = mnist.test.num_examples # number of examples for testing 10,000

#to store the number of units per layer in global variables. This allows us to alter the network architecture in one place,

# network architecture
#the term hidden layer is used for all of the layers in between the input and output layers
n_input = 784 	# input layer (28x28 pixels)
n_hidden1 = 512 # 1st hidden layer
n_hidden2 = 256 # 2nd hidden layer
n_hidden3 = 128 # 3rd hidden layer
n_output = 10 	# output layer (0-9 digits)

# network parameters
#The learning rate represents how much the parameters will adjust at each step of the learning process.
#These adjustments are a key component of training: after each pass through the network we tune the weights slightly to try and reduce the loss.
# Larger learning rates can converge faster, but also have the potential to overshoot the optimal values as they are updated.
# The number of iterations refers to how many times we go through the training step, and the batch size refers to how many training examples
#  we are using at each step. The dropout variable represents a threshold at which we eliminate some units at random.
 # We will be using dropout in our final hidden layer to give each unit a 50% chance of being eliminated at every training step.
 # This helps prevent overfitting.

learning_rate = 1e-4
n_iterations = 1000
batch_size = 128
dropout = 0.5

# tf placeholders which are tensors that we’ll feed values into later.
#The keep_prob tensor is used to control the dropout rate, and we initialize it as a placeholder
#rather than an immutable variable because we want to use the same tensor both for training (when dropout is set to 0.5) and testing (when dropout is set to 1.0).
X = tf.placeholder("float", [None, n_input])
Y = tf.placeholder("float", [None, n_output])
keep_prob = tf.placeholder(tf.float32) # dropout

# w & b parameters
#The parameters that the network will update in the training process are the weight and bias values,
#so for these we need to set an initial value rather than an empty placeholder.
#These values are essentially where the network does its learning, as they are used in the activation functions of the neurons,
#representing the strength of the connections between units.
#We’ll use random values from a truncated normal distribution for the weights.
# We want them to be close to zero, so they can adjust in either a positive or negative direction, and slightly different, so they generate different errors.
 #This will ensure that the model learns something useful.

weights = {
	'w1': tf.Variable(tf.truncated_normal([n_input, n_hidden1], stddev=0.1)),
	'w2': tf.Variable(tf.truncated_normal([n_hidden1, n_hidden2], stddev=0.1)),
	'w3': tf.Variable(tf.truncated_normal([n_hidden2, n_hidden3], stddev=0.1)),
	'out': tf.Variable(tf.truncated_normal([n_hidden3, n_output], stddev=0.1)),
}

 #For the bias, we use a small constant value to ensure that the tensors activate in the intial stages and therefore contribute to the propagation.
 #The weights and bias tensors are stored in dictionary objects for ease of access.

biases = {
	'b1': tf.Variable(tf.constant(0.1, shape=[n_hidden1])),
	'b2': tf.Variable(tf.constant(0.1, shape=[n_hidden2])),
	'b3': tf.Variable(tf.constant(0.1, shape=[n_hidden3])),
	'out': tf.Variable(tf.constant(0.1, shape=[n_output]))
}

# network layers
#Next, set up the layers of the network by defining the operations that will manipulate the tensors
#Each hidden layer will execute matrix multiplication on the previous layer’s outputs
#and the current layer’s weights, and add the bias to these values.

layer_1 = tf.add(tf.matmul(X, weights['w1']), biases['b1'])
layer_2 = tf.add(tf.matmul(layer_1, weights['w2']), biases['b2'])
layer_3 = tf.add(tf.matmul(layer_2, weights['w3']), biases['b3'])
layer_drop = tf.nn.dropout(layer_3, keep_prob)
output_layer = tf.matmul(layer_3, weights['out']) + biases['out']

# define loss and optimiser
#. A process named gradient descent optimization is a common method for finding the (local) minimum of a function by taking iterative steps
#along the gradient in a negative (descending) direction. There are several choices of gradient descent optimization algorithms already implemented in TensorFlow,
#and in this tutorial we will be using the Adam optimizer. This extends upon gradient descent optimization
#by using momentum to speed up the process through computing an exponentially weighted average of the gradients and using that in the adjustments.

cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=Y, logits=output_layer))
train_step = tf.train.AdamOptimizer(1e-4).minimize(cross_entropy)

# define evaluation
#In correct_pred, we use the arg_max function to compare which images are being predicted correctly
 #by looking at the output_layer (predictions) and Y (labels), and we use the equal function to return this as a list of Booleans.
 #We can then cast this list to floats and calculate the mean to get a total accuracy score.

correct_pred = tf.equal(tf.argmax(output_layer, 1), tf.argmax(Y, 1))
accuracy = tf.reduce_mean(tf.cast(correct_pred, tf.float32))

# initialise variables, start session
init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init)

# train on minibatches
for i in range(n_iterations):
	batch_x, batch_y = mnist.train.next_batch(batch_size)
	sess.run(train_step, feed_dict={X: batch_x, Y: batch_y, keep_prob:dropout})

	# print loss and accuracy (per minibatch)
	if i%100==0:
		minibatch_loss, minibatch_accuracy = sess.run([cross_entropy, accuracy], feed_dict={X: batch_x, Y: batch_y, keep_prob:1.0})
		print("Iteration", str(i), "\t| Loss =", str(minibatch_loss), "\t| Accuracy =", str(minibatch_accuracy))


# accuracy on test set
test_accuracy = sess.run(accuracy, feed_dict={X: mnist.test.images, Y: mnist.test.labels, keep_prob:1.0})
print("\nAccuracy on test set:", test_accuracy)
