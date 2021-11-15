function out = Denoise_Fourier(f, lambda)
[m,n] = size(f);
F = fft2(f);
for p=1:m
    for q=1:n
        F(p,q) = lambda*F(p,q) / (lambda+4*(sin(pi*p/m).^2 + sin(pi*q/n).^2));
    end
end
out = abs(ifft2(F));
end

