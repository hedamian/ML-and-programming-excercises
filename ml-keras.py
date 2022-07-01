import os
os.environ["CUDA_VISIBLE_DEVICES"] = "-1"
 
import tensorflow as tf
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense, Input, Flatten, Conv2D, MaxPool2D 
 

 
model = Sequential([
          Input(shape=(32,32,3,)),
          Conv2D(filters=6, kernel_size=(5,5), padding="same", activation="relu"),
          MaxPool2D(pool_size=(2,2)),
          Conv2D(filters=16, kernel_size=(5,5), padding="same", activation="relu"),
          MaxPool2D(pool_size=(2, 2)),
          Conv2D(filters=120, kernel_size=(5,5), padding="same", activation="relu"),
          Flatten(),
          Dense(units=84, activation="relu"),
          Dense(units=10, activation="softmax"),
      ])
 
print (model.summary())
 

from tensorflow import keras 
 
(trainX, trainY), (testX, testY) = keras.datasets.cifar10.load_data()
model.compile(optimizer="adam", loss=tf.keras.losses.SparseCategoricalCrossentropy(), metrics="acc")
 
history = model.fit(x=trainX, y=trainY, batch_size=256, epochs=10, validation_data=(testX, testY))