%% Exp 1.1
tau_m = 0.154;
A = 31.42;

% Transfer function
sys = tf(1, [1 1/tau_m 0]);
polesSys = pole(sys); % poles of the system

% Constraint
po = 20;
settle_time = 0.5;

% real part of the root locus
sigma = 4 / settle_time;

% calculate the damping ratio
zeta = -log(po/100)/sqrt(pi^2 + log(po/100)^2);

phi = acos(zeta); % angle phi
%disp(phi)
% caculate the imag part of the root locus
omega = sigma * tan(phi); 

poles_rlocus = [(-sigma + omega*1j) (-sigma - omega*1j)]; % two poles at +ve and -ve

s0 = poles_rlocus(1); % s0 is the upper plane root

% set zero just under the root at x-axis
z = sigma;
display(z)
% Prelab q3
% Four-quadrant inverse tangent
% turn rad into degrees
phase0 = rad2deg(atan2(imag(s0) - imag(polesSys(1)), real(s0) - real(polesSys(1))));
phase1 = rad2deg(atan2(imag(s0) - imag(polesSys(2)), real(s0) - real(polesSys(2))));
angle_G = -phase0 - phase1;



% required angle contribution for the controller
angle_Gc = 180 - angle_G - 0.7455*360; 
%display(angle_G)
angle_Gc_pole = 90 - angle_Gc;
%display(angle_Gc_pole)
%display(sigma)
%display(omega)
p = sigma - omega*tan(deg2rad(angle_Gc_pole));
display(p)


% set the controller's zero and pole
Gc_zero = -z;
Gc_pole = -p;


% prelab 6 distance contribution of zeros and poles to s0
mag_poles = norm(s0 - polesSys(1)) * norm(s0 - polesSys(2)) * norm(s0 - Gc_pole);
mag_zeros = abs(omega);

kG = A/tau_m; % plant gain
kc = (1/kG) * (mag_poles/mag_zeros); 
display(kc)
%% Exp 1.2 
kv = (kG * kc * z) / (p*(1/tau_m));
display(kv)


%% Exp 1.3 compute the closed-loop transfer function
sysGc = tf([1 -Gc_zero],[1 -Gc_pole]); % controller system
G_s = series(sys, kG); % connect to kG
Gc_s = series(sysGc, kc); % connect to kc
system = series(G_s, Gc_s); 
T_s = feedback(system, 1); % transfer function
cl_poles = pole(T_s); % poles
cl_zeros = zero(T_s); % zeros
display(cl_poles)
display(cl_zeros)

%% Exp 1.4 step response
figure(1);
step(T_s);


%% Exp 1.5 unit ramp input response
figure(2);
t = 0:0.001:2; % UNIT RAMP
lsim(T_s, t, t);
display(1/kv)