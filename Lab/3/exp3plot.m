close all;
clear;

t_m = 0.15;
A = 27.25;

figure();
kp = [5 6 7];
kv = [0.1594 0.1782 0.1954]; % calculated by exp3.m
plotoptions = pzoptions('cstprefs');
plotoptions.Grid = 'on'; % specify the grid to be visible

labels = {};

for i = 1:3
    T = tf((kp(i) * A / t_m), [1.0 (1.0 / t_m) (kp(i) * A / t_m)]); 
    h = pzplot(T, plotoptions);
    labels(end+1) = {"$k\_p$ = " + num2str(kp(i)) + ", $k\_v$ = 0"};
    hold on;
end

for i = 1:3
    T = tf((kp(i) * A / t_m), [1.0 ((1.0 + kv(i) * A) / t_m) (kp(i) * A / t_m)]);
    h = pzplot(T, plotoptions);
    labels(end+1) = {"$k\_p$ = " + num2str(kp(i)) + ", $k\_v$ = " + num2str(kv(i))};
    hold on;       
end    

legend(labels,'interpreter','latex');
hold off;