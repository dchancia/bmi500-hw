# AKI Prediction MIMICIII
SQL and Python code for identifying biomarkers of patients that met the conditions for AKI according to the KDIGO definition.

## Dataset
MIMICIII

## Files

* ```src/get_before_aki.sql``` - Retrieves data from the MIMICIII dataset which is located in Google Cloud, it is not contained in this repository.
* ```src/cluster.py``` - Python code that applies K-means clustering to the data, and uses t-SNE and UMAP for visualization.
* ```src/prediction.py``` - Python code for training and testing a SVM model for the prediction of AKI
* ```before_aki.csv``` - File obtained with get_before_aki.sql that contains the selected biomarkers for AKI.

# Installation
To install the packaged code, run:
```pip install -i https://test.pypi.org/simple/ Chanci-BMI500-HW7-pkg-dchancia==0.0.1```