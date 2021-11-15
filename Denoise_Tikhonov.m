function out = Denoise_Tikhonov(f, K, lambda)
u = {};
u{1} = f;
t = 1/(lambda+4);
for k = 1:K
    u{k+1}= u{k} + t*(lambda * (f - u{k}) + div(gradx(u{k}),grady(u{k})) );
end
out = u{K};
end

