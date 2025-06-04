clc;

A = [5 -4; 12 -9]
% Ainv = inv(A)

[V T] = eig(A);
V(:,1) = V(:,1)/V(1);
V(:,2) = V(:,2)/V(3)
T
Vinv = inv(V)

syms t

eAt = [4*exp(-t)-3*exp(-3*t), -2*exp(-t)+2*exp(-3*t);
    6*exp(-t)-6*exp(-3*t), -3*exp(-t)+4*exp(-3*t)]

Ainv = [-3.0000 4/3; -4.0000 5/3]

As = eAt*Ainv
%%

As4 = As * [0;1]

ys4 = [1 -3] * As4
%%
clc; clear all

k = 3.2e6;
b = 4.6e3;
m1 = 2000;
m2 = 1000;

A = [0 1 0 0;
    -k/m1 -b/m1 k/m1 b/m1;
    0 0 0 1;
    k/m2 b/m2 -k/m2 -b/m2]

[V T] = eig(A)
% V(:,1) = V(:,1)/V(1);
% V(:,2) = V(:,2)/V(3)
% T
% Vinv = inv(V)

B1 = [0;.5;0;0]
B2 = [0;0;0;1]
C = [1 0 0 0]
K = [-110 2 113 1]

Acl = A - B2*K

eig(Acl)

gain_dy = -C*inv(Acl)*B1













