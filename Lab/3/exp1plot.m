close all;
clear;

t_m = 0.15;
A = 27.25;

figure(1);
G = tf(A, [t_m 1 0]); % transfer function
kp = [0.5 1 2 3 4 5];
plotoptions = pzoptions('cstprefs');
plotoptions.Grid = 'on'; % specify the grid to be visible
plotoptions.Xlim = [-4,0]; % choose the x-axis size

labels = {};

% Plot poles
for i = kp
    PID = pid(i); % create a continuous-time proportinal controller
    CL = feedback(G * PID, 1);
    pzplot(CL, plotoptions);
    labels(end+1) = {"$k\_p$ = " + num2str(i)}; % using Latex interpreter to label the legend
    hold on;
end

legend(labels,'interpreter','latex');
hold off;

