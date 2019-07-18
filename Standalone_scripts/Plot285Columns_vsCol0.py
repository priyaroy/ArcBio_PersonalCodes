import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import matplotlib.pylab as pylab

#set global matplotlib parameters
params = {'legend.fontsize': '16',
         'axes.labelsize': '12',
         'axes.titlesize':'18',
         'xtick.labelsize':'13',
         'font.weight' : 'medium',
         'ytick.labelsize':'13',
         'legend.fontsize': '14'}
pylab.rcParams.update(params)

# Import the file

df = pd.read_csv('../data/data.csv', delimiter=',', )
print(df.shape)

df.set_index('bp').plot(legend=None)
plt.ylim(0,40)
plt.ylabel('Phred Score', fontweight = 'bold')
plt.xlabel('Bp', fontweight = 'bold')
#plt.show()
plt.savefig('../plots/PhredScores.png', bbox_inches='tight')

