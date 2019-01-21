clear all; close all;
i=1;
%données

data=  [68	76	127	60	72	68	84	68	82;
        2	4	3	3	2	3	2	2	4;
        81	74	41	81	101	102	111	68	70;
        36	34	31	37	35	40	42	44	24;
        64	115	172	82	60	76	83	57	237;
        89	53	69	84	64	33	30	38	57;
        25	93	87	13	66	6	3	14	45;
        6	12	20	4	4	8	8	7	22;
        7	3	1	12	10	6	4	12	1;
        24	33	25	21	28	23	23	13	20;
        58	38	24	41	41	26	32	51	18;
        84	90	80	136	87	14	14	9	13;
        85	91	84	135	89	134	187	159	64;
        6	7	2	3	8	5	11	6	1;
        12	18	13	13	10	6	3	10	8;
        17	15	11	11	14	14	14	14	12];

tab_1={ 'RFA' 3;
        'France' 6;
        'Italie' 6;
        'Pays Bas' 8;
        'Belg. Lux.' 10;	
        'Russie' 6;
        'Irlande' 7;
        'Danemark' 8;	
        'Grece' 5};  

tab_2={ 'Cereales' 8;
        'Riz' 3;
        'Pommes de terre' 14;
        'Sucre blanc' 11;
        'Legumes' 7;
        'Fruits' 6;
        'Vin' 3;
        'Huiles vegetales' 16;
        'Margarine' 9;
        'Viande bov.' 11;
        'Viande porc.' 12;
        'Volailles' 9;
        'Lait et deriv.' 14;
        'Beurre' 6;
        'Fromages' 8;
        'Oeufs' 5 }; 
    
%-----------------------------------traitement------------------------------------

% m=3 et n=5
Y=[data(:,1),data(:,2),data(:,3),data(:,4),data(:,5),data(:,6),data(:,7),data(:,8),data(:,9)];
[n,m]=size(Y);
Moyx=[];
X=[];

for i = 1:m
    
    Moyx(:,i)=mean(data(:,i));
    X(:,i)=Y(:,i)-Moyx(i);
    
end

M=(1/n)*X'*X;

[p,lambda]=(eig(M)); % Valeurs et vecteurs propres
ValeursPropres=diag(lambda); % On prend juste les valeurs propres situées sur la diagonale
Lambda=(flipud(ValeursPropres))'; % On classe par ordre décroissant
P=fliplr(p); % On associe les bons vecteurs propres aux bonnes valeurs propres

figure(2);
plot(Lambda,'*-');


%Axes factoriels

e=[];

for i=1:m
    e(:,i)=P(:,i);
end

%Taux d'inertie pour chaque axe factoriel

Taux=Lambda/sum(Lambda);

% Taux=[];
% 
% for i=1:m
%     
%     Taux(:,i)=Lambda(:,i)/sum(Lambda);
%     
% end


Xstar=X*P;
figure(3);
plot(Xstar(:,1),-Xstar(:,2),'*');

%d=0 car on a centré le nuage de point (pas de centre de gravité) / Moyenne
%des moyennes (moyenne de 0+0+0)

%A.u=V avec U=(b,c)'
% a=1 ==> x+by+cz=0

A=cross(e(1:3,1),e(1:3,2)); %Produit vectoriel afin d'avoir les coefficients d'une équation du plan
                            %On prend les 3 premières coordonnées des 2
                            %axes factoriels principaux
                            
a=A(1);
b=A(2);
c=A(3);

%a=-0.0718
%b=0.1545
%c=-0.0750

figure(4);
% [x,y]=meshgrid(-7:7);
% z=(1/c)*(a*x+b*y);
% surf(x,y,z);
% hold on;

%Cercle des corrélations
Zcorr=[];
Ecarttype=[];
e1=1;
e2=2;

S=ones(n,1)*std(Y);
Z=X./S;


hold on;

for i=1:m
    %Ecarttype(:,i)=std(data(:,i));
    %Zcorr(:,i)=X(i)./Ecarttype(:,i);
    rho1=(((Z(:,i))')*(Xstar(:,1)))/(n*sqrt(Lambda(1)));
    rho2=(((Z(:,i))')*(Xstar(:,2)))/(n*sqrt(Lambda(2)));
    
    plot(rho1,rho2,'*');
end

t = 0:0.05:2*pi;
x = cos(t);
y = sin(t);
plot(x,y,'k-');

axis('equal');




