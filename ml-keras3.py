#Subclassing keras.Model

#Keras also provides an object-oriented approach to creating models, which would help 
#with reusability and allows us to represent the models that we want to create as classes.
#This representation might be more intuitive, since we can think about models as a 
#set of layers strung together to form our network.

#To begin subclassing keras.Model, we first need to import it.
#from tensorflow.keras.models import Model

import tensorflow as tf
from tensorflow.keras.layers import Dense, Input, Flatten, Conv2D, MaxPool2D
from tensorflow.keras.models import Model
 #Then, we can start subclassing Model. First, we need to build the layers that we want to use 
#in our method calls since we only want to instantiate these layers once instead of each time 
#we call our model. To keep in line with previous examples, let’s build a LeNet5 model here as well.
class LeNet5(tf.keras.Model):
  def __init__(self):
    super(LeNet5, self).__init__()
    #creating layers in initializer
    self.conv1 = Conv2D(filters=6, kernel_size=(5,5), padding="same", activation="relu")
    self.max_pool2x2 = MaxPool2D(pool_size=(2,2))
    self.conv2 = Conv2D(filters=16, kernel_size=(5,5), padding="same", activation="relu")
    self.conv3 = Conv2D(filters=120, kernel_size=(5,5), padding="same", activation="relu")
    self.flatten = Flatten()
    self.fc2 = Dense(units=84, activation="relu")
    self.fc3=Dense(units=10, activation="softmax")
#Then, we override the call method to define what happens when the model is called.
#We override it with our model which uses the layers that we have built in the initializer.
  def call(self, input_tensor):
    #don't add layers here, need to create the layers in initializer, otherwise you will get the tf.
    # Variable can only be created once error
    x = self.conv1(input_tensor)
    x = self.max_pool2x2(x)
    x = self.conv2(x)
    x = self.max_pool2x2(x)
    x = self.conv3(x)
    x = self.flatten(x)
    x = self.fc2(x)
    x = self.fc3(x)
    return x  
   # It is important to have all the layers created at the class constructor, not inside the call() method.
   #  It is because the call() method will be invoked multiple times with different input tensor. 
   # But we want to use the same layer objects in each call so we can optimize their weight.
   #  We can then instantiate our new LeNet5 class and use it as part of a model:
input_layer = Input(shape=(32,32,3,))
x = LeNet5()(input_layer)
model = Model(inputs=input_layer, outputs=x)
print(model.summary(expand_nested=True))