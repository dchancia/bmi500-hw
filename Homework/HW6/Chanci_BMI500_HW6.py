# Created by: Daniela Chanci Arrubla
# Date: 9/29/2021
# Description: BMI500 Homework 6 - Natural Language Processing

# Required libraries
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import nltk
from nltk.corpus import brown
from pickle import dump
from pickle import load

#### ----------------------- PROBLEM 1 ----------------------- #####

###------- PART A

# Open, read, and lowercase provided texts
f1 = open(r'.\text1').read().lower()
f2 = open(r'.\text2').read().lower()
print(f1)
print(f2)


###------- PART B

# Create corpus
corpus = [f1, f2]

# Vectorize corpus
vectorizer = CountVectorizer(ngram_range=(1,3))
vect_corpus = vectorizer.fit_transform(corpus)

# Vectorized texts
vect_f1 = vect_corpus[0]
vect_f2 = vect_corpus[1]


###------- PART C

# Cosine similarity
cosine_sim = cosine_similarity(vect_f1, vect_f2)
print("The cosine similarity is " + str(cosine_sim[0][0]))


###------- PART D

# Jaccard similarity
vect_f1 = vect_f1.toarray()[0]
vect_f2 = vect_f2.toarray()[0]
intersection = np.sum(vect_f1 == vect_f2)
jaccard_sim = intersection/len(vect_f1)
print("The Jaccard similarity is " + str(jaccard_sim))


#### ----------------------- PROBLEM 2 ----------------------- #####

# Load data
brown_tagged_sents = brown.tagged_sents(categories='news')
brown_sents = brown.sents(categories="news")

# Split data
size = int(len(brown_tagged_sents) * 0.9)
train_sents = brown_tagged_sents[:size]
test_sents = brown_tagged_sents[size:]

# Train unigram tagger
unigram_tagger = nltk.UnigramTagger(train_sents)

# Test unigram tagger
perf_unigram = unigram_tagger.evaluate(test_sents)
print("The performance of the unigram tagger is " + str(perf_unigram))

# Train bigram tagger
bigram_tagger = nltk.BigramTagger(train_sents)

# Test bigram tagger
perf_bigram = bigram_tagger.evaluate(test_sents)
print("The performance of the bigram tagger is " + str(perf_bigram))

# Train combined tagger
t0 = nltk.DefaultTagger('NN')
t1 = nltk.UnigramTagger(train_sents, backoff=t0)
t2 = nltk.BigramTagger(train_sents, backoff=t1)

# Test combined tagger
perf_combined = t2.evaluate(test_sents)
print("The performance of the combined tagger is " + str(perf_combined))

# Save combined tagger
output = open('combined.pkl', 'wb')
dump(t2, output, -1)
output.close()

# Load combined tagger
input = open('combined.pkl', 'rb')
tagger = load(input)
input.close()

# Tag text1 with combined tagger
tokens = f1.split()
tags = tagger.tag(tokens)
print(tags)

# Can lowercasing affect the performance of the POS tagger? (Put your
# answer as comment in python file)

""" Yes, lowercasing can affect the performance of the tagger. According 
to the slides from Lecture 5, lowercasing is not important for tasks 
such as comparison of content. However, in this task it results in the 
elimination of clues that cases can provide. For example, proper names 
are usually in uppercase. """