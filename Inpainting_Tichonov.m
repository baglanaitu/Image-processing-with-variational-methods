function out = Inpainting_Tichonov(f, M, K, lambda, coeff)
u = {};
u{1} = f;
t = 1/(lambda+coeff);

% Iterations
for k = 1:K
    u{k+1}= u{k} + t*(lambda*(f - u{k}).*M + div(gradx(u{k}), grady(u{k}) ) );
end
out = u{K+1};
end


