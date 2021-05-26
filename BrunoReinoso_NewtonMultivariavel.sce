clear
clc

global x;
x = [0 3];

//Função analisada
function z = f(p)
    z = (p(1)-2)^4 + (p(1)-2*p(2))^2;
endfunction

//Derivada Primeira em X
function resp = derivadaPrimeiraEmX(p)
    h = 0.0000001;
    h2= [h, 0];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Derivada Segunda em X
function resp = derivadaSegundaEmX(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (derivadaPrimeiraEmX(p+h2)-derivadaPrimeiraEmX(p))/h;
endfunction


//Derivada Primeira em Y
function resp = derivadaPrimeiraEmY(p)
    h = 0.0000001;
    h2= [0, h];
    resp = (f(p+h2)-f(p))/h;
endfunction

//Derivada Segunda em Y
function resp = derivadaSegundaEmY(p)
    h = 0.00001;
    h2= [0, h];
    resp = (derivadaPrimeiraEmY(p+h2)-derivadaPrimeiraEmY(p))/h;
endfunction

//Derivada segunda em x e y
function resp = derivadaEmXY(p)
    h = 0.00001;
    h2= [h, 0];
    resp = (derivadaPrimeiraEmY(p+h2)-derivadaPrimeiraEmY(p))/h;
endfunction

//Derivada segunda em y e x
function resp = derivadaEmYX(p)
    h = 0.00001;
    h2= [0, h];
    resp = (derivadaPrimeiraEmX(p+h2)-derivadaPrimeiraEmX(p))/h;
endfunction

//gradiente
function resp = gradiente(p)
   resp = [derivadaPrimeiraEmX(p), derivadaPrimeiraEmY(p)];
endfunction

//Hessiana
function resp = hessiana(p)
    resp = [derivadaSegundaEmX(p), derivadaEmXY(p); derivadaEmYX(p), derivadaSegundaEmY(p)];
endfunction

//Método Newton Multivariável
function newtonMultivariavel()
    global x;
    
    for(k = 1:10)
        disp(x)
        x = (x' -inv(hessiana(x))*gradiente(x)')';
    end
    
    disp(x)
endfunction

//Chamada da função
newtonMultivariavel()
