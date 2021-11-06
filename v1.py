
import numpy as np
import matplotlib.pyplot as plt

dropMinD = 0.0001;

# Dropplet Max Diamater [m]
dropMaxD = 0.1;

# Number of Dropplets [n]
numDrops = 100;

# Initial Height [m]
h = 1;

# Density of dropplets [kg/m**3]
rhoD = 1000;

# Initial Velocity X [m/s]
v0x = 1000;

# Initial Velocity Y [m/s]
v0y = 0;

# Air Density [kg/m**3]
rhoA = 1.225;

# Drag Coefficient for streamlined body [-]
cD = .04;

# Time Step [s]
dt = .001;

# Itterations [n]
I = 10000;

# blah blah blah

dropDs = np.zeros(numDrops);
dropAs = np.zeros(numDrops);

massD = np.zeros(numDrops);
forceDrag = np.zeros((I, numDrops));
a = np.zeros((I, numDrops));

X = np.zeros((I, numDrops));
vX = np.zeros((I, numDrops));
vX[0,:] = v0x;

Y = np.zeros((I, numDrops));
vY = np.zeros((I, numDrops));

#sdifisdf

# Calculations
for i in range(numDrops) :
    # Generate Dropplet Diameters within range
    D = 0;
    
    while D < dropMinD :
        D = np.random.random()*dropMaxD;
    
    dropDs[i] = D;

    # Generate areas
    dropAs[i] = 0.25*np.pi*dropDs[i]**2;

    # Generate masses of dropplets
    massD[i] = rhoD*(4/3)*np.pi*(dropDs[i]/2)**3;

# Position Generator
t = 0;
for i in range(I) :
    t = t+dt;
    for j in range(numDrops) :
        # Generate Y positions as particle falls
        Y[i,j] = h-0.5*9.81*t**2;
        
        forceDrag[i,j] = 0.5*rhoA*cD*dropAs[j]*vX[i,j]**2;
        a = forceDrag[i,j]/massD[j];
        
        if i < I-1:
            vX[i+1,j] = vX[i,j]-a*dt;
        
            # Generate X positions without drag
            X[i+1,j] = X[i,j]+vX[i,j]*dt-0.5*a*dt**2;
        

for i in range(numDrops) :
    plt.plot(X,Y);