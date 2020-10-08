function E2=PAS(E1,L,N,a,lambda_noll,n_medium)

% Varje sampelpunkt i k-planet motsvarar en plan v�g med en viss riktning (kx,ky,kz)
delta_k=...; % samplingsavst�nd i k-planet *** Ej klar
kxvekt=-N/2*delta_k:delta_k:(N/2-1)*delta_k; % vektor med sampelpositioner i kx-led
kyvekt=kxvekt; % och ky-led
[kxmat,kymat]=meshgrid(kxvekt,kyvekt); % k-vektorns x- resp y-komponent i varje sampelpunkt i k-planet

k=...; % k-vektorns l�ngd (skal�r) f�r en plan v�g i ett material med brytningsindex n_medium *** Ej klar
kzmat=sqrt(...); % k-vektorns z-komponent i varje sampelpunkt i k-planet *** Ej klar (Obs! Matlab till�ter att en skal�r direkt adderas/subtraheras med matris, man beh�ver allts� tex inte skriva "skal�r*ones(N,N)-matris")

fasfaktor_propagation=exp(1i* ...); % faktorn varje sampelpunkt i k-planet (som ju motsvarar plan v�g i viss riktning) multas med f�r att propagera str�ckan L i z-led *** Ej klar

A= ... *fft2c(...); % Planv�gsspektrum i Plan 1 *** Ej klar

B=A.*fasfaktor_propagation; % Planv�gsspektrum i Plan 2 (Planv�gsspektrum i Plan 1 multat med fasfaktorn f�r propagation f�r varje plan v�g)

E2= ... *ifft2c(...); % *** Ej klar
