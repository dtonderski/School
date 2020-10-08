%% Skapar matriser och vektorer nödvändiga för båda metoderna
% Genererar fempunktsmatrisen med hjälp av numgrid och delsq, beräknar
% egenvärdena till A och lägger in de 6 största och de 6 minsta i separata
% vektorer
A=delsq(numgrid('S',13));
eigenA=eig(A);
eigStorsta=eigenA(116:121,1);
eigMinsta=eigenA(1:6,1);
%% Ortogonal iteration
%Skapar X_0, QR-faktoriserar den och beräknar X_1, tar fram diagonalen av R
%genom funktionen getdiagonal
X=eye(121,6);
[Q,R]=qr(X,0);
X=A*Q;
p=getdiagonal(R);

%Börjar räkna iterationer och tid
i1=0;
tic

%Kör en while-loop till värdena av diagonalen av R ligger inom toleransen
while intolerance(getdiagonal(R),eigStorsta,1e-6)==false
    %QR-faktoriserar X_k, beräknar X_(k+1) och lägger till 1 till
    %iteration-räknaren
    [Q,R]=qr(X,0);
    X=A*Q;
    i1=i1+1;
end
%Skriver ut tiden och antalet interationer
toc % 0.249541
i1  % 2971

%%
%Cholesky-faktoriserar A och skapar Y0
U=chol(A);
Y=eye(121,6);
%Skapar X och R genom at QR-faktoresira Y
[X,R]=qr(Y,0);
%Skapar Z och Y genom algoritmen som beskrivs i Invers iteration
Z=U.'\X;
Y=U\Z;
%Börjar räkna iterationer och tid
i2=0; 
tic

%Kör en while-loop till värdena av diagonalen av R ligger inom toleransen
while intolerance(getInverseDiagonal(R),eigMinsta,1e-6)==false
    %Beräknar nästa X och R genom att QR-faktoresira Y
    [X,R]=qr(Y,0);
    %Beräknar nästa Z och Y genom algoritmen som beskrivs i Invers
    %iteration
    Z=U.'\X;
    Y=U\Z;
    %Lägger till 1 till iteration-räknaren
    i2=i2+1;
end
%Skriver ut tiden och antalet interationer
toc % 0.016625
i2  % 204
%% Slutsatser
%Invers- iterationalgoritmen med ca. 0.15 s och 2971 iterationer är ungefär
%en faktor 10 långsammare än ortogonal- iterationalgoritmen med ca. 
%0.02 s och 204 iterationer
%% Funktioner
%Skapar en vektor som består av diagonalen i matrisen R bakifrån
function f=getdiagonal(R)
    f=[];
    for i=1:6
        f=[R(i,i);f];
    end
end

%Kollar att varje element i vektorn R ligger inom toleransen jämfört med
%vektorn facit
function f=intolerance(K, facit, tol)
    f=true;
    for i=1:6
        if(abs(K(i)-facit(i))>tol)
            f=false;
        end
    end
end

%Skapar en vektor som består av inversen av elementen av
%diagonalen i matrisen R
function f=getInverseDiagonal(R)
    f=[];
    for i=1:6
        f=[f;1./R(i,i)];
    end
end
    