clear
clc

global d;
global x;
global lamb;
x = [0, 3];
lamb = 0;

//Função Analisada
function z = f(p)
    z = (p(1)-2)^4 + (p(1)-2*p(2))^2;
endfunction

//Derivada em X
function resp = derivadaPrimeiraEmX(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Derivada em Y
function resp = derivadaPrimeiraEmY(p)
    h = 0.00001;
    h2= [0, h];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Cálculo de Gradiente
function resp = Gradiente(p)
   resp = [derivadaPrimeiraEmX(p), derivadaPrimeiraEmY(p)];
endfunction

//Função em lamb
function z = fLamb(lamb)
    global x;
    global d;
    z = f(x + lamb*d);
endfunction

//Derivada primeira para lamb
function y1 = primeiraDerivada()
    global lamb;
    h = 0.00001;
    y1 = (fLamb(lamb+h)-fLamb(lamb))/h;
endfunction

//Derivada segunda para lamb
function y2 = segundaDerivada()
    global lamb;
    h = 0.00001;
    y2 = (fLamb(lamb+h)-2*fLamb(lamb)+fLamb(lamb-h))/h^2;
endfunction

//Newton com lamb
function newtonParalamb()
    global lamb;
    for (i = 1:2)
        lamb = lamb - (primeiraDerivada()/segundaDerivada());
    end
endfunction

//Norma quadrado
function res = normaquadrado(y)
    a = Gradiente(y);
    res = ((( a(1)^2 + a(2)^2 ))^0.5)^2;
endfunction              
     
//Método de Fletchreeves                    
function fletcherreeves()
    global x;
    global d;
    global lamb;
    disp(x)
    for(k = 1:10)
        for(j=1:2)
            if(j==1)
                d = -Gradiente(x);
                newtonParalamb();
                y = x + lamb*d;
            else
                alpha = normaquadrado(y)/normaquadrado(x);
                d = -Gradiente(x) + alpha*d;
                newtonParalamb();
                y = x + lamb*d;
            end
            disp(y)
        end
        x = y;
    end
    disp(x)
endfunction

//Chamada da função
fletcherreeves();
