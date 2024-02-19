---
sidebar_position: 10
---

# Neural Network Paradigm

### What is an Artificial Neural Network (ANN)?
ANNs are composed of node layers: input, hidden, and output. Each layer passes weighted data along to the next layer, as long as that data meets a specified threshold value.
Neural networks rely on training data to learn and improve their accuracy over time. Once fine-tuned, they are powerful tools allowing for classification and clustering of data at a high velocity.

### SmartWeights Neural Network (per Sensor)

![SmartWeights Neural Network Model](https://github.com/Capstone-Projects-2024-Spring/project-smartweights/assets/123014795/e0d8a758-7f6d-4b89-a726-f446f85544da)

**Figure 1.** This model represents the neural network used by SmartWeights to predict the proper position of a single sensor in 3-D space. The structure comprises an Input Layer, a Hidden Layer, and an Output Layer. The Input Layer consists of 3 neurons, each receiving the tracked X, Y, and Z coordinates of a sensor as input. Subsequently, the Hidden Layer applies nonlinear transformations to the input data to discern complex patterns. The output of these transformations is then subject to an activation function, determining whether the neuron’s output is passed to the next layer. Similar to the Input Layer, the Output Layer contains a node for each dimension. This layer is equipped with a loss function, which measures the variability between the output generated and the provided target data.
This network is trained via backpropagation, which involves iteratively adjusting the weights and biases of the network’s connections to minimize the loss function of the Output Layer. The weights and biases are initialized with random values. Input values are fed into the model and processed, and the resulting output is compared to target values from a given test dataset to calculate the loss. Then, through backpropagation, the gradients of the loss function with respect to the weights and biases of the network are updated using the chain rule of calculus. These gradients indicate the necessary adjustments to each parameter to decrease the loss. Periodically throughout the training, the test dataset is substituted with a validation set to ensure the generalization of the model and to prevent overfitting. 


