# Created by: Daniela Chanci
# Description: Application of the unsupervised clustering algorithm k-means
# to a subset of MIMICIII for AKI patients for visualization

import pandas as pd
from matplotlib import pyplot as plt
from sklearn.cluster import KMeans
import umap
from sklearn.manifold import TSNE

# Load the csv file
data_original = pd.read_csv("before_aki.csv")
data = data_original.drop(["subject_id", "aki_stage"], axis=1)  # Discard the id and the class

# Apply k-means algorithm
k_means = KMeans(n_clusters=3).fit(data)
y_kmeans = k_means.predict(data)

# Visualize clusters with TSNE
tsne = TSNE(n_components=2, learning_rate='auto').fit_transform(data)
fig1 = plt.figure()
plt.scatter(tsne[:, 0], tsne[:, 1], c=y_kmeans, s=10, cmap='cividis')
plt.title("AKI Clustered Data", fontsize=16)
plt.xlabel("tsne_1", fontsize=13)
plt.ylabel("tsne_2", fontsize=13)

# # Visualize clusters with UMAP
# fig1 = plt.figure()
# standard_embedding = umap.UMAP(random_state=42, n_neighbors=30, n_components=2).fit_transform(data)
# plt.scatter(standard_embedding[:, 0], standard_embedding[:, 1], c=y_kmeans, s=10, cmap='cividis')
# plt.title("AKI Clustered Data", fontsize=16)
# plt.xlabel("umap_1", fontsize=13)
# plt.ylabel("umap_2", fontsize=13)

plt.show()