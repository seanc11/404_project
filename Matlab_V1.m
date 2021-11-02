%%% Title
% ASTE 404 Final Project
% V1
% 11/2/2021

clc; clear; close all;


%% Define Variables

% Dropplet Min Diameter [m]
dropMinD = .0001;

% Dropplet Max Diamater [m]
dropMaxD = .1;

% Number of Dropplets [n]
numDrops = 100;

% Initial Height [m]
h = 1;

% Density of dropplets [kg/m^3]
rhoD = 1000;

% Initial Velocity X [m/s]
v0x = 1000;

% Initial Velocity Y [m/s]
v0y = 0;

% Air Density [kg/m^3]
rhoA = 1.225;

% Drag Coefficient for streamlined body [-]
cD = .04;

% Time Step [s]
dt = .001;

% Itterations [n]
I = 10000;




%% Define Arrays

% Dropplet Sample Diamteters [m]
dropDs = zeros(1, numDrops);

% Dropplet Sample Areas [m^2]
dropAs = zeros(1, numDrops);

% Drag Forces on each dropplet [N]
forceDrag = zeros(I, numDrops);

% Dropplet mass [kg]
massD = zeros(1, numDrops);

% Velocity in Y [m/s]
vY = zeros(I,numDrops);

% Velocity in Y [m/s]
vX = zeros(I,numDrops);
vX(1,:) = v0x;

% Position in Y [m/s]
Y = zeros(I,numDrops);

% Position in Y [m/s]
X = zeros(I,numDrops);



%% Calculations

for i = 1:numDrops
    
    % Generate Dropplet Diameters within range
    D = 0;
    while D < dropMinD
        D = rand()*dropMaxD;
    end
    dropDs(i) = D;

    % Generate areas
    dropAs(i) = 0.25*pi()*dropDs(i)^2;

    % Generate masses of dropplets
    massD(i) = rhoD*(4/3)*pi()*(dropDs(i)/2)^3;
end


% Position Generator
t = 0;
for i = 1:I
    t = t+dt;
    for j = 1:numDrops
        % Generate Y positions as particle falls
        Y(i,j) = h-.5*9.81*t^2;
        
        forceDrag(i,j) = .5*rhoA*cD*dropAs(j)*vX(i,j)^2;
        a = forceDrag(i,j)/massD(j);
        vX(i+1,j) = vX(i,j)-a*dt;

        % Generate X positions without drag
        X(i+1,j) = X(i,j)+vX(i,j)*dt-.5*a*dt^2;
        
    end
end

for i = 1:numDrops
    hold on;
    plot(X(1:I,i),Y(:,i));
end


ylim([0,h]);



    







