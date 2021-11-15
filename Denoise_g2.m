function [U_k] = Denoise_g2(f,K,lambda,eps)
    
    U_k = f;
    ts = 1/(4+lambda);

    for k=1:K
        
       x_term = (2*(gradx(U_k)))./(((gradx(U_k).^2 + grady(U_k).^2) + eps));
       y_term = (2*(grady(U_k)))./(((gradx(U_k).^2 + grady(U_k).^2) + eps));
        
       % gradient decent update three
       U_k =  U_k + ts*(lambda*(f - U_k) + div(x_term, y_term));
      
    end

end
