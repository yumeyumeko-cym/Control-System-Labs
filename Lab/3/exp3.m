tm = 0.15;
A = 27.25;
po = 10;
zeta = -(log(po/100))/sqrt(pi^2 + (log(po/100))^2);
kp = [5 6 7];
kv = (2*zeta*sqrt(kp.*A*tm)-1)/A;
disp(kv)