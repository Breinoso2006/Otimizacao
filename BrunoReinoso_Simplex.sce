clear
clc

global v;
v = [5,7;2,1;1,3];
n = 2;
numVertices = n + 1;

//Função Analisada
function z = f(x)
    z = (x(1)-2)^4 + (x(1) - 2*x(2))^2;
endfunction

//Ordena os vértices do melhor para o pior
function ordenaV()                              
    global v;
    for(i = 1:n)
        for(j = i+1:numVertices)
            if f(v(j,:)) < f(v(i,:)) then
                temp = v(i,:);
                v(i,:) = v(j,:);
                v(j,:) = temp;
            end
        end
    end
endfunction

//Calcula Centroide
function c = centroide()
    c = [0, 0];
    for(i = 1:n)
        c = c + v(i,:);
    end
    c = c/n;
endfunction

//Reflexão
function vr = reflexao(c, vn)
    vr = c + 1*(c-vn);
endfunction

function ve = expansao(c, vr)
    ve = c + 2*(vr-c);
endfunction

//Expansão
function vc = contracao(c, vn)
    vc = vn + 0.5*(vn-c);
endfunction

//Contração
function contracaoEncolhida(vl)
    global v;
    for(i = 2:numVertices)
        v(i,:) = vl + 0.5*(v(i,:) - vl);
    end
endfunction

//Método Simplex
function menor = simplex()
    global v;
    for (k = 1:100)
        ordenaV()
        
        vl = v(1,:)
        vs = v(2,:)
        vn = v(3,:)
        c = centroide()
        
        vr = reflexao(c, vn)
        if f(vl) <= f(vr) & f(vr) < f(vs) then
            v(numVertices,:) = vr;
        else
            if f(vr) < f(vl) then
                ve = expansao(c, vr)
                if(f(ve) < f(vr)) then
                    v(numVertices,:) = ve;
                else 
                    v(numVertices,:) = vr;
                end
            else
                if f(vs) < f(vr) then
                    vc = contracao(c, vn);
                    if f(vc) < f(vn) then
                        v(numVertices,:) = vc;
                    else
                        contracaoEncolhida(vl);
                    end
                end
            end
        end
    end
    ordenaV()
    menor = v(1,:)
endfunction

//Chamada e display da função
disp (simplex())
