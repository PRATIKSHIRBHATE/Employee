#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 10 19:19:57 2018

@author: pratikshirbhate
"""

# Set the working directory
import os
os.chdir("/Users/pratikshirbhate/Documents/Data Science/Projects/Employee_Dataset")

input_file =  "employee.csv"

# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing a dataset
dataset = pd.read_csv(input_file)

dataset.sort_values('Salary', ascending=False).groupby('dept_id').head(2)

dataset.groupby('dept_id', as_index=False).apply(lambda x: x.nlargest(2, 'Salary'))
