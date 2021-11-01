# Created by: Daniela Chanci Arrubla
# Date: 9/27/2021
# Description: BMI500 Homework 5 - Natural Language Processing

from nltk.probability import FreqDist

#### ------------------------------- PROBLEM 1 ------------------------------- #####

###------- PART B

"""
*Source: https://docs.python.org/3/library/collections.html

Yes, there are more sophisticated dictionaries than the general dict. These can be 
found in the module 'collections'. In this regard, we find:
 -ChainMap: Encloses multiple dictionaries into a single one. 
 -Counter: The keys are elements and the corresponding value is its count. If the
           key is missing, they return zero.
 -OrderedDict: Remembers the order of the key-value pairs.
 -defaultDict: It is a container datatype that works similar to a dictionary.
               However, it assigns a value to missing keys instead of raising a 
               KeyError. 

"""

#### ------------------------------- PROBLEM 2 ------------------------------- #####

print("\nPROBLEM 2")

"""
def isPalindrome(word):

Description: This function checks whether the string input is a palindrome or not.

Parameters: word        - a string 

Return: None
"""

def isPalindrome(word):

    if word == word[::-1]:
        print("The string '" + word + "' is a palindrome")
    else:
        print("The string '" + word + "' is NOT a palindrome")

# Provide examples

isPalindrome("stats")
# The string 'stats' is a palindrome

isPalindrome("palindrome")
# The string 'palindrome' is NOT a palindrome


#### ------------------------------- PROBLEM 3 ------------------------------- #####

print("\nPROBLEM 3")

s = ' The quick brown fox jumped over the lazy dog '  # Input


###------- PART A

print(s.find("the"))
# 33

print(s.rfind("the"))
# 33


###------- PART B

print(s.index("dog"))
# 42

print(s.rindex("dog"))
# 42

# print(s.index("cat"))
# ValueError: substring not found

# print(s.rindex("cat"))
# ValueError: substring not found


###------- PART C

print(s.split())
# ['The', 'quick', 'brown', 'fox', 'jumped', 'over', 'the', 'lazy', 'dog']

print("$$".join(s.split()))
# The$$quick$$brown$$fox$$jumped$$over$$the$$lazy$$dog


###------- PART D

print(s.lower())
#  the quick brown fox jumped over the lazy dog

print(s.upper())
#  THE QUICK BROWN FOX JUMPED OVER THE LAZY DOG

print(s.title())
#  The Quick Brown Fox Jumped Over The Lazy Dog


###------- PART E

print(s.strip())
# The quick brown fox jumped over the lazy dog

# The strip function removes the spaces at the beginning and the end of s.


###------- PART F

print(s.replace("jumped", "flew"))
#  The quick brown fox flew over the lazy dog


#### ------------------------------- PROBLEM 4 ------------------------------- #####

print("\nPROBLEM 4")

###------- PART A

preprocessed_s = s.lower().split()
print(preprocessed_s)
# ['the', 'quick', 'brown', 'fox', 'jumped', 'over', 'the', 'lazy', 'dog']

###------- PART B AND C

dist = FreqDist(preprocessed_s)
print(dist.items())
# dict_items([('the', 2), ('quick', 1), ('brown', 1), ('fox', 1), ('jumped', 1),
# ('over', 1), ('lazy', 1), ('dog', 1)])

###------- PART D

dist = FreqDist(s)
print(dist.items())
# dict_items([(' ', 10), ('T', 1), ('h', 2), ('e', 4), ('q', 1), ('u', 2), ('i', 1),
# ('c', 1), ('k', 1), ('b', 1), ('r', 2), ('o', 4), ('w', 1), ('n', 1), ('f', 1),
# ('x', 1), ('j', 1), ('m', 1), ('p', 1), ('d', 2), ('v', 1), ('t', 1), ('l', 1),
# ('a', 1), ('z', 1), ('y', 1), ('g', 1)])

"""
Before preprocessing, the string s is the iterable, thus FreqDist finds
the frequency for each character. After preprocessing, a list of the words contained
in s is the iterable. Therefore, FreqDist fins the frequency for each of these
words
"""

