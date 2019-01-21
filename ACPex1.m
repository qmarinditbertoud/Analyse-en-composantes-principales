clear all; close all;
P1=[2,-1,1];
P2=[-1,1,-1];
P3=[3,1,0];
P4=[-2,-4,1];
P5=[-2,3,-1];
CoordX=[2 -1 3 -2 -2];
CoordY=[-1 1 1 -4 3];
CoordZ=[1 -1 0 1 -1];

figure(1);
hold on;
plot3(CoordX,CoordY,CoordZ,'*');
text(2,-1,1,'P1');
text(-1,1,1,'P2');
text(3,1,0,'P3');
text(-2,-4,1,'P4');
text(-2,3,-1,'P5');


% m=3 et n=5
Y=[(CoordX)',(CoordY)',(CoordZ)'];
[n,m]=size(Y);
Moyx1=mean(CoordX);
Moyx2=mean(CoordY);
Moyx3=mean(CoordZ);
X=[(CoordX)'-Moyx1,(CoordY)'-Moyx2,(CoordZ)'-Moyx3];

%La matrice n'a pas changé car les moyennes sont nulles

M=(1/n)*X'*X;
[p,lambda]=(eig(M)); % Valeurs et vecteurs propres
ValeursPropres=diag(lambda); % On prend juste les valeurs propres situées sur la diagonale
Lambda=(flipud(ValeursPropres))'; % On classe par ordre décroissant
P=fliplr(p); % On associe les bons vecteurs propres aux bonnes valeurs propres

figure(2);
plot(Lambda,'*-');


%Axes factoriels
e1=[P(:,1)];
e2=[P(:,2)];
e3=[P(:,3)];


%Taux d'inertie pour chaque axe factoriel
Taux1=Lambda(1)/sum(Lambda);
Taux2=Lambda(2)/sum(Lambda);
Taux3=Lambda(3)/sum(Lambda);

Xstar=X*P;
figure(3);
plot(Xstar(:,1),-Xstar(:,2),'*');

%d=0 car on a centré le nuage de point (pas de centre de gravité) / Moyenne
%des moyennes (moyenne de 0+0+0)

%A.u=V avec U=(b,c)'
% a=1 ==> x+by+cz=0

A=cross(e1,e2); %Produit vectoriel afin d'avoir les coefficients de notre équation du plan
a=A(1);
b=A(2);
c=A(3);

%a=-0.1595
%b=0.3169
%c=0.9350
% Equation = 0.1595x+0.3169y+0.9350c=0

figure(4);
[x,y]=meshgrid(-7:7);
z=(1/c)*(a*x+b*y);
surf(x,y,z);
hold on;
plot3(CoordX,CoordY,CoordZ,'*');
