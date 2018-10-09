clear all
clc

%% informa��es do programa
global npop ncontrol tcromossomo opoints alfa
npop= 30; % define tamanho da popula��o
counter= 0; % inicia contador
stp= 0; % inicia vari�vel de parada

% informa��es do problema
psskmin= 0;   psskmax= 20;  %limitantes - K
pssbmin= 0;   pssbmax= 32;  %limitantes - beta
pssgmin= 9;   pssgmax= 45;  %limitantes - gama

% informa��es do m�todo de otimiza��o
dmin= 0.10; % define condi��o de parada
c1= 0.7; % define fator de individualidade
c2= 1.25; % define fator de sociabilidade
w= 0.5;  % define in�rcia
vmax= 0.7; % limitante de velocidade

%% busca os 25 pontos de opera��o
run('D:\S�rgio\Pesquisas\PSO revista\alg\op\load_NENY.m'); 

%% busca popula��o inicial
load('D:\S�rgio\Pesquisas\PSO revista\pops\ini\pop30.mat');
pop= popini;
pso.pini= pop; % salva popula��o inicial n�o organizada

%% inicia contador de tempo
t1= tic;
tic
%% verifica fitness da popula��o
mdamp= zeros(npop,3);
for i=1:npop
    x1= pop(i,:);
    x2= v_damp(x1);
    mdamp(i,1)= x2;
    mdamp(i,2)= i;
end %i

pso.dini= mdamp; % salva amortecimento inicial n�o organizado

%% organiza fitness e pop
[x(:,1),x(:,2)]= sort(mdamp(:,1),'descend');
mdamp= x;
popt= zeros(size(pop));
% organiza popula��o em popt
for i=1:npop
    popt(i,:)= pop(mdamp(i,2),:);
    mdamp(i,3)=i;
end %i
% devolve popula��o organizada para pop
for i=1:npop
    pop(i,:)= popt(i,:);
end %i

%% prepara velocidade, pbest, gbest e fitness completo
v= vmax*rand(npop,tcromossomo);

pbest= pop; 
gbest= pop(1,:);

mdamp(:,4)= mdamp(:,3); % troca coluna de endere�os
mdamp(:,2)= mdamp(:,1); % define fitnes pbest
mdamp(:,3)= mdamp(1,1); % define fitnes gbest

stp= mdamp(1,1);

%% salva popula��o e fitness inicial organizado
pso(1,1).pop= pop;
pso(1,1).damp= mdamp;
toc

disp(mdamp);
%% inicia PSO
v= ones(size(pop));

while stp < dmin   
    tic
    %% define velocidades
    for i=1:npop
        r1= rand(1,tcromossomo); % define valores aleat�rios
        r2= rand(1,tcromossomo); % define valores aleat�rios
%         r1= ones(1,tcromossomo);
%         r2= ones(1,tcromossomo);
        
        for j=1:tcromossomo
            % define velocidades
            v(i,j)= w*v(i,j) + c1*r1(j)*(pbest(i,j)-pop(i,j)) + c2*r2(j)*(gbest(j)-pop(i,j));
            
            % verifica limites de velocidade
            if v(i,j) > vmax
                v(i,j)= vmax;
            end %if
            
            if v(i,j) < (-vmax)
                v(i,j)= (-vmax);
            end %if
        end %j
    end %i
    
    %% movimenta part�culas
    for i=1:npop
        for j=1:tcromossomo
            pop(i,j)= pop(i,j) + v(i,j);
        end %j
    end %i
    
    % verifica limites das part�culas
    for i=1:npop
        j=1;
        while j < tcromossomo
            if pop(i,j) < psskmin
                pop(i,j)= psskmin;
            end %if
            if pop(i,j) > psskmax
                pop(i,j)= psskmax;
            end %if

            if pop(i,j+1) < pssbmin
                pop(i,j+1)= pssbmin;
            end %if
            if pop(i,j+1) > pssbmax
                pop(i,j+1)= pssbmax;                
            end %if

            if pop(i,j+2) < pssgmin
                pop(i,j+2)= pssgmin;
            end %if
            if pop(i,j+2) > pssgmax
                pop(i,j+2)= pssgmax;
            end %if
            
            j= j+3; %incrementa j
        end %j
    end %i
    
    %% verifica fitness das part�culas modificadas e atualiza pbest/gbest
    for i=1:npop
        x1= pop(i,:);
        x2= v_damp(x1);
        mdamp(i,1)= x2;
    end %i
   
    % atualiza pbest
    for i=1:npop
        if mdamp(i,1) > mdamp(i,2)
            mdamp(i,2)= mdamp(i,1);
            pbest(i,:)= pop(i,:);
        end %if
    end %i
    
    % atualiza gbest
    [x(:,1),x(:,2)]= sort(mdamp(:,1),'descend');
    if x(1,1) > mdamp(1,3)
        mdamp(:,3)= x(1,1);
        gbest(1,:)= pop(x(1,2),:);
    end %if
        
    %% atualiza contadores
    stp= mdamp(1,3);
    counter= counter + 1;
    
    pso(1,counter).pop= pop;
    pso(1,counter).damp= mdamp;
    
%     disp(pop);
%     disp(gbest);
    disp(mdamp);
    disp(counter);
    
    
    toc
    %reinicia la�o
    end % while
    
    %% organiza resultados finais
    t2= toc(t1);
    disp(t2);