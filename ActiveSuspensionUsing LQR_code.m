ms  = 300;% Sprung Mass (kg) 
mus = 50;% Unsprung Mass (kg)
ks  = 17000;% Suspension Stiffness (N/m) 
kus = 180000;% Wheel stiffness (N/m)
bs  = 500;% Suspension Inherent Damping coefficient (sec/m)
bus = 1050;% Wheel Inhenrent Damping coefficient (sec/m)

A = [ 0 1 0 -1 ;
    -ks/ms -bs/ms 0 bs/ms;
    0 0 0 1;
    ks/mus bs/mus -kus/mus -(bs+bus)/mus];
B = [0  0 ; 
    0 1/ms ; 
    -1  0 ;
    bus/mus -1/mus ];
C = [ 1 0 0 0 ; 
    -ks/ms -bs/ms 0 bs/ms ];
D = [0 0;
     0 0;
     0 0;
     0 0;
     0 0;
     0 1/ms];

Cr = ctrb(A,B); %Controlability
rank_Cr = rank(Cr);

Ob = obsv(A,C); %Observability
rank_Ob = rank(Ob);

Q = diag([1760*10^6, 11.6*10^6, 1, 1]);
R = 0.01;
K = lqr( A, B(:,2), Q, R ) %LQR

Sim_Time= 10;