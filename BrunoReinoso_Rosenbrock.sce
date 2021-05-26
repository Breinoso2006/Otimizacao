clc;
clear;
clearglobal;

//Criação da função dada
function a = f(p)
        global d;
    a = (p(1)-2)^4 + (p(1) - 2*p(2))^2;
endfunction

//Função lambda
function z = fLambda(a, j)
    global d;
    z = f([p(1) + (a*d(j, 1)), p(2) + (a*d(j, 2))]);
endfunction

//Cálculo de Newton
function newton(j)
    global lambdas;
    global d;
    for (i = 1:10)                  //faz 10 iteracoes
        lambdas(j) = lambdas(j) - (derivada(j)/derivada2(j)); 
    end
endfunction

//Derivada Primeira
function y=derivada(j)
    global lambdas;
    global d;
    tolerancia=0.001;
    
    y=(fLambda(lambdas(j)+tolerancia, j)-fLambda(lambdas(j), j))/tolerancia;
endfunction

//Derivada Segunda
function y=derivada2(j)
    global d;
    global lambdas;
    tolerancia=0.001;
    
    y = (fLambda(lambdas(j)+tolerancia, j)-2*fLambda(lambdas(j), j)+fLambda(lambdas(j)-tolerancia, j))/tolerancia^2;
endfunction

//Rosenbrock
function resultado=rosenbrock()
    global p;
    global d;
    global lambdas;
    a = [0,0];
    b = [0,0];

    for(k = 1:iteracoes)
        //Método Gram Schimidt
        if(k>1) then 
            for (j=1:2)
                if(lambdas(j)== 0) then
                    a(1) = d(j,1);
                    a(2) = d(j,2);
                else
                    for (i=j:2)
                        a(1) = a(1) + lambdas(i)*d(i,1);
                        a(2) = a(2) + lambdas(i)*d(i,2);
                    end
                end
                //Encontrando b
                if(j==1) then
                    b = a;
                else
                    b(1) = a(1) - ( a(1)*d(1,1) )*d(1,1);
                    b(2) = a(2) - ( a(2)*d(1,2) )*d(1,2); 
                end
                
                //Calculando direção
                moduloB = (b(1)^2 + b(2)^2)^0.5;
                d(j,1) = (1/moduloB)*b(1);
                d(j,2) = (1/moduloB)*b(2);
                newton(j);
                p(1) = (p(1) + lambdas(j) * d(j,1));
                p(2) = (p(2) + lambdas(j) * d(j,2));
            end
        else
            for (j = 1:2)
                newton(j);
                p(1) = (p(1) + lambdas(j) * d(j,1));
                p(2) = (p(2) + lambdas(j) * d(j,2));
            end
        end       
    end
    
    resultado = p;
    
endfunction

//Variáveis "globais" utilizadas
global d;
d = [1, 0; 0, 1];

global p;
p = [0, 3];

global lambdas;
lambdas = [0,1];

global iteracoes;
iteracoes = 1000

//Display
disp('A resposta será ', rosenbrock());

