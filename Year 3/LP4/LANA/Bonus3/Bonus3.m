%% Skapar matriser och vektorer n�dv�ndiga f�r b�da metoderna
% Genererar fempunktsmatrisen med hj�lp av numgrid och delsq, ber�knar
% egenv�rdena till A och l�gger in de 6 st�rsta och de 6 minsta i separata
% vektorer
A=delsq(numgrid('S',13));
eigenA=eig(A);
eigStorsta=eigenA(116:121,1);
eigMinsta=eigenA(1:6,1);
%% Ortogonal iteration
%Skapar X_0, QR-faktoriserar den och ber�knar X_1, tar fram diagonalen av R
%genom funktionen getdiagonal
X=eye(121,6);
[Q,R]=qr(X,0);
X=A*Q;
p=getdiagonal(R);

%B�rjar r�kna iterationer och tid
i1=0;
tic

%K�r en while-loop till v�rdena av diagonalen av R ligger inom toleransen
while intolerance(getdiagonal(R),eigStorsta,1e-6)==false
    %QR-faktoriserar X_k, ber�knar X_(k+1) och l�gger till 1 till
    %iteration-r�knaren
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
%B�rjar r�kna iterationer och tid
i2=0; 
tic

%K�r en while-loop till v�rdena av diagonalen av R ligger inom toleransen
while intolerance(getInverseDiagonal(R),eigMinsta,1e-6)==false
    %Ber�knar n�sta X och R genom att QR-faktoresira Y
    [X,R]=qr(Y,0);
    %Ber�knar n�sta Z och Y genom algoritmen som beskrivs i Invers
    %iteration
    Z=U.'\X;
    Y=U\Z;
    %L�gger till 1 till iteration-r�knaren
    i2=i2+1;
end
%Skriver ut tiden och antalet interationer
toc % 0.016625
i2  % 204
%% Slutsatser
%Invers- iterationalgoritmen med ca. 0.15 s och 2971 iterationer �r ungef�r
%en faktor 10 l�ngsammare �n ortogonal- iterationalgoritmen med ca. 
%0.02 s och 204 iterationer
%% Funktioner
%Skapar en vektor som best�r av diagonalen i matrisen R bakifr�n
function f=getdiagonal(R)
    f=[];
    for i=1:6
        f=[R(i,i);f];
    end
end

%Kollar att varje element i vektorn R ligger inom toleransen j�mf�rt med
%vektorn facit
function f=intolerance(K, facit, tol)
    f=true;
    for i=1:6
        if(abs(K(i)-facit(i))>tol)
            f=false;
        end
    end
end

%Skapar en vektor som best�r av inversen av elementen av
%diagonalen i matrisen R
function f=getInverseDiagonal(R)
    f=[];
    for i=1:6
        f=[f;1./R(i,i)];
    end
end
    