# BMI500 Homework Week 4

### To Install

```pip install -i https://test.pypi.org/simple/ Chanci-BMI500-HW4-pkg-dchancia==0.0.1```

### Description:

Application of dimensionality reduction k-means clustering to the Epileptic Seizure Recognition Data Set. This dataset is available online on the website https://data.world/uci/epileptic-seizure-recognition.

### Directory Files:

- Chanci_BMI500_HW4.py: Main script that runs the dimensionality reduction and unsupervised clustering
- data.csv: Comma-separated values file that contains the patient brain activity. In total, there were 500 patients with 23.5 seconds of recorded EEG. This information was organized in 11500 rows with 178 corresponding data points to simplify the interpretation of the data. There are 5 classes: 1) Seizure activity, 2) EEG from the area of the located tumor, 3) tumor located but EEG from healthy area, 4) eyes closed, and 5) eyes open. Therefore, each row falls into one of these categories.

