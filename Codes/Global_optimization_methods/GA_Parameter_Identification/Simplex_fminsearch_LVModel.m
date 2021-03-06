clear all
% Select years 1908-1935
idx = 64:91;
mytime = (1:length(idx))';
load('HaresLynxData.mat')
mydata(:,1) = Lotka_Volterra_Data(idx,2);
mydata(:,2) = Lotka_Volterra_Data(idx,3);

% Guess te initial solution
% This is the best guess
k=[0.7 0.1 0.7 0.1];
% alpha = k(1): prey population growth rate
% beta = k(2): prey population decline rate
% gamma = k(3): predator population decline rate
% delta = k(4): predator population growth rate

% Test the unbounded fminsearch
% k=[0.7 0.3 0.7 0.3];
% k=[0.9 0.1 0.9 0.1];
% Now very slow
% k=[0.7 0.1 0.7 0.3];
%% Let's plot the initial guess
y0(1) = 21.5; y0(2) = 3.4;
[t,y] = ode45(@Lotka_Volterra_Model,mytime,y0,[],k);

subplot(2,1,1)
title('Number of hares')
hold on
plot(mydata(:,1),'O');
plot(y(:,1),':b')

subplot(2,1,2)
title('Number of lynx')
hold on
plot(mydata(:,2),'rO');
plot(y(:,2),':r')

% First try the MATLAB built-in unbounded version
objfun = @(x) least_squares(x,mydata, mytime);
[k lest_squares] = fminsearch(objfun, k)

%% with upper/lower bounds
%[k lest_squares] = fminsearchbnd3(objfun, k,  [0.4 0 0.4 0], [0.8 0.8 0.8 0.8])

%% Plot model with estimated parameters
y0(1) = 21.5; y0(2) = 3.4;
[t,y] = ode45(@Lotka_Volterra_Model,mytime,y0,[],k);
figure(2)

subplot(2,1,1)
hold on
title('Number of hares')
plot(mydata(:,1),'O');
plot(y(:,1),'--b')

subplot(2,1,2)
hold on
title('Number of lynx')
plot(mydata(:,2),'rO');
plot(y(:,2),'--r')

