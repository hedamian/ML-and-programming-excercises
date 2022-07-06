#Using Keras’ Functional Interface
#The next method of constructing Keras models that we’ll be exploring is using Keras’ functional interface. 
#The functional interface uses the layers as functions instead, taking in a Tensor and outputting a Tensor 
#as well. The functional interface is a more flexible way of representing a Keras model as we are not 
#restricted only to sequential models that have layers stacked on top of one another. Instead,
#we can build models that branch into multiple paths, have multiple inputs, etc.

#Consider an Add layer that takes inputs from two or more paths and adds the tensors together.



#Since this cannot be represented as a linear stack of layers due to the multiple inputs,

 #we would be unable to define it using a Sequential object.
  #Here’s where Keras’ functional interface comes in.
  # We can define an Add layer with two input tensors as such:

#from tensorflow.keras.layers import Add
#add_layer = Add()([layer1, layer2])
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"

#Now that we’ve seen a quick example of the functional interface, let’s take a look at what the
#  LeNet5 model that we defined by instantiating a Sequential class would look like using
#  a functional interface.

import tensorflow as tf
from tensorflow import keras
from keras.layers import Input, Conv2D, BatchNormalization, Add, MaxPool2D, Flatten, Dense
from keras.activations import relu
from tensorflow.keras.models import Model
 
#We can see that a model defined using the Sequential class would be unable to construct 
#such a block due to the skip connection which prevents this block from being represented
#as a simple stack of layers. Using the functional interface, this is one way
#we can define a ResNet block:


def residual_block(x, filters):
  # store the input tensor to be added later as the identity
  identity = x
  # change the strides to do like pooling layer (need to see whether we connect before or after this layer though)
  x = Conv2D(filters = filters, kernel_size=(3, 3), strides = (1, 1), padding="same")(x)
  x = BatchNormalization()(x)
  x = relu(x)
  x = Conv2D(filters = filters, kernel_size=(3, 3), padding="same")(x)
  x = BatchNormalization()(x)
  x = Add()([identity, x])
  x = relu(x)
 
  return x
 
(trainX, trainY), (testX, testY) = keras.datasets.cifar10.load_data()
#Then, we can build a simple network using these residual blocks using the functional interface as well.
input_layer = Input(shape=(32,32,3,))
x = Conv2D(filters=32, kernel_size=(3, 3), padding="same", activation="relu")(input_layer)
x = residual_block(x, 32)
x = Conv2D(filters=64, kernel_size=(3, 3), strides=(2, 2), padding="same", activation="relu")(x)
x = residual_block(x, 64)
x = Conv2D(filters=128, kernel_size=(3, 3), strides=(2, 2), padding="same", activation="relu")(x)
x = residual_block(x, 128)
x = Flatten()(x)
x = Dense(units=84, activation="relu")(x)
x = Dense(units=10, activation="softmax")(x)
 
model = Model(inputs=input_layer, outputs = x)
print(model.summary())
 
model.compile(optimizer="adam", loss=tf.keras.losses.SparseCategoricalCrossentropy(), metrics="acc")
 
history = model.fit(x=trainX, y=trainY, batch_size=256, epochs=10, validation_data=(testX, testY))