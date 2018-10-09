% conclusão do teste
% não convém paralelizar este laço para mzk_mobile

global ncontrol tcromossomo opoints alfa
w1= pop(1,:);

ncontrol= 16;
tcromossomo= 3*ncontrol;
opoints= 24;
alfa= 0.1;

run('D:\Sérgio\Pesquisas\PSO revista\alg\op\load_NENY.m')

%define as matrizes A, B e C, de acordo com os Alfas, Betas e Gamas
%Ac(i)= [ -alfa(i)                        0                       0 
%         gama(i)-alfaBeta(i)             -gama(i)                0
%         beta(i)Gama(i)-alfaBeta(i)^2    gama(i)-Beta(i)Gama(i)  -gama(i)]
%Bc(i)= [ 1; beta(i); beta(i)^2]
%Cc(i)= [0 0 K]


k=1; %reinicia controladores
j=1; %reinicia j

while j <= tcromossomo

    a(1,k).c= [ -alfa                                           0                         0;
                (w1(1,j+2)-alfa*w1(1,j+1))                    -w1(1,j+2)                  0;
                (w1(1,j+1)*w1(1,j+2)-alfa*(w1(1,j+1))^2)     (w1(1,j+2)*(1-w1(1,j+1)))    -w1(1,j+2)];

    b(1,k).c= [ 1; w1(1,j+1); w1(1,j+1)*w1(1,j+1)];

    cc(1,k).c= [ 0  0  w1(1,j)];
    k= k+1;
    j= j+3;
end    


% define as matrizes Ac, Bc e Cc
% Ac(1,1).c =[ a(1,1).c zeros    zeros zeros ...
%              zeros    a(1,2).c zeros zeros ...
%              ...        ...     ...   ...  ... ]   
Ac(1,1).c= [ a(1,1).c                zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   a(1,2).c                zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,3).c                zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,4).c               zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  a(1,5).c                zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   a(1,6).c                zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));       
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,7).c                zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,8).c               zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c)); 
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  a(1,9).c                zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   a(1,10).c               zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,11).c               zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,12).c              zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  a(1,13).c               zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c)); 
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   a(1,14).c               zeros(size(a(1,1).c))   zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,15).c               zeros(size(a(1,1).c));
             zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))  zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   zeros(size(a(1,1).c))   a(1,16).c];

Bc(1,1).c= [ b(1,1).c                zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   b(1,2).c                zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,3).c                zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,4).c               zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  b(1,5).c                zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   b(1,6).c                zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,7).c                zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,8).c               zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  b(1,9).c                zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   b(1,10).c               zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,11).c               zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,12).c              zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  b(1,13).c               zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   b(1,14).c               zeros(size(b(1,1).c))   zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,15).c               zeros(size(b(1,1).c));
             zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))  zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   zeros(size(b(1,1).c))   b(1,16).c];

Cc(1,1).c= [ cc(1,1).c               zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  cc(1,2).c               zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,3).c               zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,4).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) cc(1,5).c               zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  cc(1,6).c               zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,7).c               zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,8).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) cc(1,9).c               zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  cc(1,10).c             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) cc(1,11).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  cc(1,12).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,13).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,14).c              zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,15).c              zeros(size(cc(1,1).c));
             zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c)) zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  zeros(size(cc(1,1).c))  cc(1,16).c];                     


% define matriz x~' e salva na estrutura xtl.c (x-tiu-linha).c
% par 30x+
for j=1:opoints 
    xtl(1,j).c= [ A(1,j).po                               (B(1,j).po*Cc(1,1).c);
                 (Bc(1,1).c*C(1,j).po*A(1,j).po)          (Ac(1,1).c+Bc(1,1).c*C(1,j).po*B(1,j).po*Cc(1,1).c)];
end

clear Ac Bc Cc a b cc
x=0; w=0; z=0; %cria variáveis temporárias

% verifica amortecimentos da matriz x~' e salva na estrutura ax.c
% par um pouco mais rápido (as vezes) -> não compensa
for j=1:opoints
    [w,x,z]= damp(xtl(1,j).c);
    ax(1,j).c= x;
end
%%% fim da verificação
clear xtl.c;

x=0; w=0; z=0; %zera armazenadores temporários

[size_ax w]= size(ax(1,1).c);

%numera os amortecimentos
%este laço serve apenas para conferir o funcionamento do programa
%na etapa da programação
% par 200x+
for k=1:opoints 
    for j=1:size_ax
        ax(1,k).c(j,2)= j;
    end %j
end %k

% verifica o menor amortecimento entre os pontos de operação
% os menores amortecimentos são guardados na matriz amt
w=0;
% par 1000x+
for k=1:opoints
    w(k)= min(ax(1,k).c(:,1));        
    amt(1,k)= w(k);
end %k

md=0;
md= min(amt(1,:));

