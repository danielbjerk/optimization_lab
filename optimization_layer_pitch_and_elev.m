%% Initialization and model definition
%init08; % Change this to the init file corresponding to your helicopter

% Discrete time system model. x = [lambda r p p_dot e e_dot]'
delta_t	= 0.25; % sampling time
A1 = A;
B1 = B;

% Number of states and inputs
mx = size(A1,2); % Number of states (number of columns in A)
mu = size(B1,2); % Number of inputs(number of columns in B)

% Initial values
x1_0 = pi;                               % Lambda
x2_0 = 0;                               % r
x3_0 = 0;                               % p
x4_0 = 0;                               % p_dot
x5_0 = 0;                               % e
x6_0 = 0;                               % e_dot
x0 = [x1_0 x2_0 x3_0 x4_0 x5_0 x6_0]';           % Initial values

% Time horizon and initialization
N  = 40;                                  % Time horizon for states
M  = N;                                 % Time horizon for inputs
z  = zeros(N*mx+M*mu,1);                % Initialize z for the whole horizon
z0 = z;                                 % Initial value for optimization

% Bounds
ul 	    = [-30*pi/180, -Inf]';                   % Lower bound on control
uu 	    = [30*pi/180, Inf]';                   % Upper bound on control

xl      = -Inf*ones(mx,1);              % Lower bound on states (no bound)
xu      = Inf*ones(mx,1);               % Upper bound on states (no bound)
xl(3)   = ul(1);                           % Lower bound on state x3
xu(3)   = uu(1);                           % Upper bound on state x3

% Generate constraints on measurements and inputs
[vlb,vub]       = gen_constraints(N,M,xl,xu,ul,uu); % hint: gen_constraints
vlb(N*mx+M*mu)  = 0;                    % We want the last input to be zero
vub(N*mx+M*mu)  = 0;                    % We want the last input to be zero

% Generate the matrix Q and the vector c (objecitve function weights in the QP problem) 
Q1 = zeros(mx,mx);
Q1(1,1) = 1;                            % Weight on state x1
Q1(2,2) = 0;                            % Weight on state x2
Q1(3,3) = 0;                            % Weight on state x3
Q1(4,4) = 0;                            % Weight on state x4
Q1(5,5) = 0;                            % Weight on state x5
Q1(6,6) = 0;                            % Weight on state x6

q1 = 0.01;
q2 = 10;
P1 = diag([q1, q2]);                                % Weight on input

Q = gen_q(Q1,P1,N,M);                                  % Generate Q, hint: gen_q
c = zeros(size(Q,1),1);                                  % Generate c, this is the linear constant term in the QP

%% Generate system matrixes for linear model
Aeq = gen_aeq(A1,B1,N,mx,mu);             %  Generate A, hint: gen_aeq
beq = [A1*x0; zeros(mx*(N-1),1)];             % enerate b

%% Solve nonlinear problem with linear model
tic
opts = optimoptions('fmincon','Algorithm','sqp');
nonlcon = @normal_hill_constraint;
z = fmincon(@(z)z'*Q*z, z0, [], [], Aeq, beq, vlb, vub, nonlcon, opts);
t1=toc;

% Calculate objective value
phi1 = 0.0;
PhiOut = zeros(N*mx+M*mu,1);
for i=1:N*mx+M*mu
  phi1=phi1+Q(i,i)*z(i)*z(i);
  PhiOut(i) = phi1;
end

%% Extract control inputs and states
u1  = [z(N*mx+1:2:N*mx+M*mu);z(N*mx+M*mu)]; % Control input from solution
u2  = [z(N*mx+2:2:N*mx+M*mu);z(N*mx+M*mu)];

x1 = [x0(1);z(1:mx:N*mx)];              % State x1 from solution
x2 = [x0(2);z(2:mx:N*mx)];              % State x2 from solution
x3 = [x0(3);z(3:mx:N*mx)];              % State x3 from solution
x4 = [x0(4);z(4:mx:N*mx)];              % State x4 from solution
x5 = [x0(5);z(5:mx:N*mx)];
x6 = [x0(6);z(6:mx:N*mx)];

num_variables = 5/delta_t;
zero_padding = zeros(num_variables,1);
unit_padding  = ones(num_variables,1);

u1  = [zero_padding; u1; zero_padding];
u2  = [zero_padding; u2; zero_padding];
x1  = [pi*unit_padding; x1; zero_padding];
x2  = [zero_padding; x2; zero_padding];
x3  = [zero_padding; x3; zero_padding];
x4  = [zero_padding; x4; zero_padding];
x5  = [zero_padding; x5; zero_padding];
x6  = [zero_padding; x6; zero_padding];

%% Plotting
t = 0:delta_t:delta_t*(length(u1)-1);

figure(2)
subplot(811)
stairs(t,u1),grid
ylabel('u1')
title('Optimal trajectory from x_0 to x_f with weights q_1 = 0d01, q_2 = 10')

subplot(812)
stairs(t,u2),grid
ylabel('u2')

subplot(813)
plot(t,x1,'m',t,x1,'mo'),grid
ylabel('lambda')

subplot(814)
plot(t,x2,'m',t,x2','mo'),grid
ylabel('r')

subplot(815)
plot(t,x3,'m',t,x3,'mo'),grid
ylabel('p')

subplot(816)
plot(t,x4,'m',t,x4','mo'),grid
xlabel('tid (s)'),ylabel('pdot')

subplot(817)
plot(t,x5,'m',t,x5','mo'),grid
xlabel('tid (s)'),ylabel('e')

subplot(818)
plot(t,x6,'m',t,x6','mo'),grid
xlabel('tid (s)'),ylabel('edot')


%% Plot measurement against calculations
sim_t = 0.002;
t_0 = 0;
t_f = 30;

input = load('p3t4_testing-Q-R_u-and-x.mat');
data = input.ans;
time = data(1,1:end);
u_m = data(2,1:end);
y1 = data(3,1:end);
y2 = data(4,1:end);
y3 = data(5,1:end);
y4 = data(6,1:end);

figure(2)
subplot(511)
stairs(time,u_m),grid
ylabel('u')
title('Optimal trajectory from x_0 to x_f with weight Q = [10, 5, 1, 1], R = 0.5')
xlim([t_0 t_f])

subplot(512)
plot(time,y1,t,x1,'m',t,x1,'mo'),grid
ylabel('lambda')
xlim([t_0 t_f])

subplot(513)
plot(time,y2,t,x2,'m',t,x2','mo'),grid
ylabel('r')
xlim([t_0 t_f])

subplot(514)
plot(time,y3,t,x3,'m',t,x3,'mo'),grid
ylabel('p')
xlim([t_0 t_f])

subplot(515)
plot(time,y4,t,x4,'m',t,x4','mo'),grid
xlabel('tid (s)'),ylabel('pdot')
xlim([t_0 t_f])

legend('Measured state', 'Theoretical state')

%% Save figure
print('prework4t3_compare-G-[0d01,10]','-depsc');
print('prework4t3_compare-G-[0d01,10]','-dpng');

%% LQ Problem
u1_opt = timeseries(u1,t);
u2_opt = timeseries(u2,t);
x1_opt = timeseries(x1,t);
x2_opt = timeseries(x2,t);
x3_opt = timeseries(x3,t);
x4_opt = timeseries(x4,t);
x5_opt = timeseries(x5,t);
x6_opt = timeseries(x6,t);
x_opt = [x1_opt; x2_opt; x3_opt; x4_opt; x5_opt; x6_opt];

Q_k = diag([10 5 1 1 1 1]);
R_k = diag([0.5, 1]);

[K,S,e] = dlqr(A,B,Q_k,R_k);