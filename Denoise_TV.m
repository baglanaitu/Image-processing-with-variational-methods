function out = Denoise_TV(f, K, lambda,eps)
u = {};
u{1} = f;
t = 1/(lambda+4);

for k = 1:K
    inp_grad_x = gradx(u{k}) ./ sqrt( (gradx(u{k}).^2 + grady(u{k}).^2) + eps);
    inp_grad_y = grady(u{k}) ./ sqrt( (gradx(u{k}).^2 + grady(u{k}).^2) + eps);
    
    u{k+1}= u{k} + t*(lambda * (f - u{k}) + div(inp_grad_x, inp_grad_y));
    
end
out = u{K};

end

