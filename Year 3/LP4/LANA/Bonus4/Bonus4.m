%% Skapar de n�dv�ndiga matriserna, vektorerna och variablerna
%Skapar cell-arrayer med de f�rsta Hilbertmatriserna, x-vektorerna,
%b-vektorerna, xhat-vektorerna, fel-vektorerna och residual-vektorerna och
%l�gger i de f�rsta elementen
H = {hilb(1)};
x = {[1]};
b = {H{1}*x{1}};
xhat = {H{1}\b{1}};
fel = {xhat{1}-x{1}};
r = {b{1}-H{1}*xhat{1}};

%Skapar arrayer med normena av felen, normena av residualen och
%konditionstalen och l�gger i de f�rsta v�rdena
normfel = [norm(xhat{1}-x{1})];
normr = [norm(r{1})];

%Anger toleransen som beh�vs f�r att ber�kna det maximala n-v�rdet
tol = 1e-2;

%Skapar en array som kommer att inneh�lla alla n-v�rden (beh�vs f�r att
%plotta mot n)
N = [1];

%Skapar en array som ska inneh�lla konditionstalen till hilbertmatriserna
condtal = [cond(H{1})];


%B�rjar while-loopen fr�n i=2
i = 2;

%Skapar de n�dv�ndiga matriserna, vektorerna och talen f�r i = 2, ..., n
%till normfelet �r st�rre en sqrt(i)*tol. Termen sqrt(i) kommer fr�n att
%normen av vektorn x �r sqrt(k)  och vi �r intresserade av det relativa
%felet
while normfel(i-1)/sqrt(i)<tol
    %Fyller ut cell-arrayerna med Hilbertmatriserna, x-vektorerna,
    %b-vektorerna, xhat-vektorerna, fel-vektorerna och residual-vektorerna
    H{i} = hilb(i);
    %En for-loop skapar x-vektorn f�r varje i
    x{i} = [1];
    for k = 2:i
        x{i} = [x{i};1];
        k = +k;
    end
    
    b{i} = H{i}*x{i};
    xhat{i} = H{i}\b{i};
    fel{i} = xhat{i}-x{1};
    r{i} = b{i}-H{i}*xhat{i};
    
    %Fyller ut arrayerna med normerna av felen och normerna av residualerna
    normfel = [normfel,norm(xhat{i}-x{i})];
    normr = [normr,norm(r{i})];
    
    %Fyller ut arrayen med alla n-v�rden
    N = [N,i];
    
    %Fyller ut arrayen med alla konditionstal
    condtal = [condtal, cond(H{i})];

    i = i+1;
end
n = i-1; % 12
%Det maximala n f�r vilket approximationen �r anv�ndbar bed�ms allts� att 
%vara 12

%% Plottar normen av felen mot n, normen av residualerna mot n, konditionstalen mot n och normen av felen mot konditionstalen
%S�tter manuellt figurens storlek
f = figure(1);
FS = get(f,'Position');
set(f,'Position',[FS(1) FS(2) FS(3)*1.5 FS(4)*1.5])

%Plottar normen av felen mot n, semilogy
subplot(2,2,1)
semilogy(N,normfel, 'blue')
xlabel(['$n$'],'Interpreter','latex','fontsize',13)
title('$\textnormal{Normen av felen (semilogy)}$','fontsize',13, ...
    'Interpreter','latex')
ylabel('$||\hat{x}-x||_2$','Interpreter','latex','fontsize',13)

%Plottar normen av residualerna mot n, semilogy
subplot(2,2,2)
plot(N,normr, 'blue')
xlabel(['$n$'],'Interpreter','latex','fontsize',13)
title('$\textnormal{Normen av residualerna}$','fontsize',13, ...
    'Interpreter','latex')
ylabel('$||r||_2$','Interpreter','latex','fontsize',13)

%Plottar konditionstalen mot n, semilogy
subplot(2,2,3)
semilogy(N,condtal, 'blue')
xlabel(['$n$'],'Interpreter','latex','fontsize',13)
title('$\textnormal{Konditionstalen (semilogy)}$','fontsize',13, ...
    'Interpreter','latex')
ylabel('$\kappa(H)$','Interpreter','latex','fontsize',13)

%Plottar normen av felen mot konditionstalen, OBS: loglog
subplot(2,2,4)
loglog(condtal,normfel, 'blue')
xlabel('$\kappa(H)$','Interpreter','latex','fontsize',13)
title('$\textnormal{Normen av felen mot konditionstalen (loglog)}$', ...
    'Interpreter','latex','fontsize',13)
ylabel('$||\hat{x}-x||_2$','Interpreter','latex','fontsize',13)

%% Slutsatser fr�n graferna
% Residualen verkar inte vara ett bra m�tt p� felets storlek i allm�nhet.
% Om man dock plottar till t.ex. n=100 s� ser man att n�r felet blir
% ovanligt stort s� blir ocks� residualen ovanligt stor, residualens kurva
% f�ljer ungef�r felets kurva. Detta fenomen �r dock inte sant f�r n<13.
%
% En linj�ranpassning av de logaritmerade v�rdena av normalen av felet mot 
% de logaritmerade v�rdena av konditionstalet ger en linje med lutning
% ungef�r 1. Detta betyder att normalen av felet v�xer linj�rt med
% konditionstalet.
%
% Grafen som relaterar konditionstalet till n verkar vara en
% exponentialfunktion. L�t oss testa detta genom att ans�tta $\kappa =
% a*e^{b*n}$ och l�sa ut a och b genom fit-funktionen i MATLAB f�r olika n
% och ta medelv�rdet av koefficienterna.
k=[];
for i = 2:n
    f=fit(N(1:i)',condtal(1:i)','exp1');
    k=[k, coeffvalues(f)'];
end
k
a1=mean(k(1,:))
b2=mean(k(2,:))
%%
% Koefficienterna verkar allts� vara ungef�r a= 0.02, b= 3.4. Som vi ser �r
% det inte mycket varians mellan koefficienterna f�r de olika n-v�rdena.
% D�rmed kan vi med ganska stor sannolikhet s�ga att
% $\kappa \approx 0.02*e^{3.4*n}$.
%% Relation mellan $||\hat{x}-x||_2$ och $\kappa(H)$, j�mf�relse med teorin
% Vi f�rs�ker hitta det exakta sambandet mellan condtal och normfel. Vi 
% visade ovan att det sannolikt finns ett linj�r samband f�r n som bed�ms 
% vara rimliga, s� vi f�rs�ker hitta det sambandet genom polyfit. 
%
% Sedan j�mf�r vi med teorin. I boken Numerisk Analys finns sambandet:
%
% $\frac{||\delta x||}{||x||} \leq \kappa*\frac{||\delta b||}{||b||}$
%
% Om vi antar att det finns ett linj�rt samband p� formen:
%
% $a*\kappa=||\hat{x}-x||=||\delta x||$,
%
% s� kan vi s�tta in det i den teoriteska formeln och f� sambandet:
%
% $\frac{a}{||x||} \leq \frac{||\delta b||}{||b||}$,
%
% vilket leder till:
%
% $a \leq \frac{||\delta b||*||x||}{||b||}$.
%
% D� kan vi plotta a och $\frac{||\delta b||*||x||}{||b||}$ mot n och l�tt
% kolla om sambandet st�mmer.
%Vi b�rjar allts� genom att hitta a med polyfit.
warning('off');
c = polyfit(condtal,normfel,1);
%Vi f�r att a = 2.4698e-17. Nu m�ste vi ber�kna h�gerledet. Som vanligt
%b�rjar vi med att skapa arrayer och l�gga in de f�rsta v�rdena. Sedan
%anv�nder vi en for-loop f�r att ber�kna de resterande v�rdena.
K = norm(H{1}*(xhat{1}-x{1}))*norm(x{1})/norm(b{1});
a = 2.4698e-17;
for i = 2:n
    K = [K, norm(H{i}*(xhat{i}-x{i}))*norm(x{i})/norm(b{i})];
    a = [a,2.4698e-17];
end
%Nu plottar vi a mot N (svart) och K mot N (r�tt). Om v�rt samband st�mmer
%s� ska den svarta kurvan ligga 'under' den r�da.

figure(2)
hold on
plot(N,a, 'black')
plot(N,K, 'red')
%%
% Som vi ser ligger den r�da funktionen ovanf�r den svarta f�r alla $n\geq
% 2$. Resultatet st�mmer inte f�r n=1 f�r att felet d� �r exakt lika med 0.


