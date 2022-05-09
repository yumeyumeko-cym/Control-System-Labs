% According to the pre-lab Q6
tm = 0.15;
A = 27.25;
po = [50 55 60 65];
kp = ((-pi./log(po./100)).^2+1)./(4*A*tm);
disp(kp)