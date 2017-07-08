#!/usr/bin/env python
# coding: utf-8

import numpy as np
import pickle


def init_network():
    with open("sample_weight.pkl", 'rb') as f:
        network = pickle.load(f)
    
    return network


network = init_network()
# network['W1'].shape

np.save('W1.npy', network['W1'], allow_pickle=False)
np.save('b1.npy', network['b1'], allow_pickle=False)
np.save('W2.npy', network['W2'], allow_pickle=False)
np.save('b2.npy', network['b2'], allow_pickle=False)
np.save('W3.npy', network['W3'], allow_pickle=False)
np.save('b3.npy', network['b3'], allow_pickle=False)
np.savez('sample_weight', **network)