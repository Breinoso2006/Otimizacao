clear 
clc

//Criação função
function func = f(x)
    func = (x^3) - (3*x) - 3  
endfunction

//Método 
function SecAurea = Aurea(esquerda,direita,Erro)
    mi = esquerda + razaoAurea*(direita-esquerda);
    lambda = direita - razaoAurea*(direita-esquerda);
    
    while (abs(mi-lambda)>Erro)
        mi = esquerda + razaoAurea*(direita-esquerda);
        lambda = direita - razaoAurea*(direita-esquerda);
        
        printf('\nIteração Atual: %i\nValor Lambda: %f\nValor Mi: %f\nF(Lambda): %f\nF(Mi): %f\n',it,lambda,mi,f(lambda),f(mi))
        
        printf('\nComparando valores de f:\n')
        
        if(f(mi)>f(lambda))
            direita = mi ;
            it = it + 1
            
            printf('\nf(mi)>f(lambda), portanto direita = %f\n',mi)
            
        else
            
            esquerda = lambda ;
            it = it + 1
            printf('\nf(mi)<=f(lambda), portanto esquerda = %f\n',lambda)
            
        end  
    end
    //Média
    SecAurea = (mi+lambda)/2
endfunction

//Variáveis "globais" utilizadas
razaoAurea=0.618 ;
it = 1;

//Chamada da função com o range (0,3) 
result = Aurea(0,3,0.00001)

printf('\nResultado final: %f',result)
