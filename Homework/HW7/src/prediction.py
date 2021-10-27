import pandas as pd
from matplotlib import pyplot as plt
from sklearn import svm
from sklearn import metrics
from sklearn.metrics import plot_confusion_matrix
from sklearn.model_selection import train_test_split

# Load the csv file
data = pd.read_csv("before_aki.csv")
X = data.drop(["subject_id", "aki_stage"], axis=1).to_numpy() # Discard the id and the class
y = data[["aki_stage"]].to_numpy()

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = svm.SVC(kernel="poly", degree=3, class_weight="balanced")
model.fit(X_train, y_train)

# Evaluate model
y_hat = model.predict(X_test)
acc = metrics.accuracy_score(y_test, y_hat)
plot_confusion_matrix(model, X_test, y_test)
print("Accuracy: {}".format(acc))
plt.show()