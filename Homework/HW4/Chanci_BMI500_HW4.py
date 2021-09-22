# Created by: Daniela Chanci
# Description: Application of the unsupervised clustering algorithm k-means
# to the public dataset "Epileptic Seizure Recognition Data Set" downloaded
# from the website data.world

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA

# Load the Epileptic Seizure Recognition Data Set
data_original = pd.read_csv("data.csv")
data = data_original.drop(data_original.iloc[:,[0,-1]], axis = 1)  # Discard the id and the class

# Dimensionality reduction with Principal Component Analysis
data_reduced = PCA(n_components = 2).fit_transform(data)  # The output will have two dimensions

# Plot PCA=2 of the data
plt.scatter(data_reduced[:,0],data_reduced[:,1], c='black', s=10)
plt.title("PCA on Epilectic Seizure Data", fontsize=16)
plt.xlabel("Principal Component 1", fontsize=13)
plt.ylabel("Principal Component 2", fontsize=13)

# Apply k-means algorithm
k_means = KMeans(n_clusters = 5).fit(data_reduced)
y_kmeans = k_means.predict(data_reduced)
labels = np.transpose(k_means.labels_)
centers = k_means.cluster_centers_

# Plot clustered data 2D
fig1 = plt.figure()
plt.scatter(data_reduced[:, 0], data_reduced[:, 1], c=y_kmeans, s=10, cmap='viridis')
plt.scatter(centers[:, 0], centers[:, 1], c='black', s=5, alpha=0.8)
plt.title("Clustered Data", fontsize=16)
plt.xlabel("Principal Component 1", fontsize=13)
plt.ylabel("Principal Component 2", fontsize=13)
plt.show()

