function M = householder(X)
    %Householder-reflects matrix X
    a1=X(:,1);
    v1=a1;
    v1(1)=v1(1)-norm(v1);
    v1=v1/norm(v1);
    M1=2*v1*v1';
    H=eye(size(M1))-M1;
    M=H*X;