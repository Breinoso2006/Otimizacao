clear
clc

global d;
global x;
global lamb;
x = [2, 1];
lamb = 0;

//Função analisada
function z = f(p)
    z = (p(1)-p(2)^3)^2 + 3*(p(1)-p(2))^4;
endfunction

//Derivada Primeira Em X
function resp = derivadaPrimeiraEmX(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Derivada Primeira Em Y
function resp = derivadaPrimeiraEmY(p)
    h = 0.00001;
    h2= [0, h];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Gradiente
function resp = Gradiente(p)
   resp = [derivadaPrimeiraEmX(p), derivadaPrimeiraEmY(p)];
endfunction

//Função em lambda
function z = fLamb(lamb)
    global x;
    global d;
    z = f(x + lamb*d);
endfunction

//Primeira derivada com lambda
function y1 = primeiraDerivada()
    global lamb;
    h = 0.00001;
    y1 = (fLamb(lamb+h)-fLamb(lamb))/h;
endfunction

//Segunda derivada com lambda
function y2 = segundaDerivada()
    global lamb;
    h = 0.00001;
    y2 = (fLamb(lamb+h)-2*fLamb(lamb)+fLamb(lamb-h))/h^2;
endfunction

//Método Newton com lambda
function newtonParalamb()
    global lamb;
    for (i = 1:100)
        lamb = lamb - (primeiraDerivada()/segundaDerivada());
    end
endfunction

//Método Gradiente Descendente
function gradienteDescendente()
    global x;
    global d;
    global lamb;
    
    for(k = 1:200)
        d = -Gradiente(x);
        disp(x)
        newtonParalamb();
        x = x + lamb*d;
    end
    disp(x)
endfunction

//Chamada Função
gradienteDescendente();
