# load_pkl.py

import pickle

def load_pkl(filepath):
    with open(filepath, 'rb') as f:
        return pickle.load(f)
