function out = Inpainting_TV(f, M, K, lambda)
u = {};
u{1} = f;
t = 1/(lambda+4);

% Iterations
for k = 1:K
    norm = sqrt(gradx(u{k}).^2 + grady(u{k}).^2);
    inp_grad_x = gradx(u{k}) ./ sqrt( norm.^2 + eps^2);
    inp_grad_y = grady(u{k}) ./ sqrt( norm.^2 + eps^2);

    u{k+1}= u{k} + t*(lambda.*(f - u{k}).*M + div(inp_grad_x, inp_grad_y));
end
out = u{K};
end

