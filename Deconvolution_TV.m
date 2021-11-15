function out = Deconvolution_TV(f, G, eps, K, lambda)

u = {};
u{1} = f;
t = 1/(lambda+4);

% Iterations
for k = 1:K
    inp_grad_x = gradx(u{k}) ./ sqrt( (gradx(u{k}).^2 + grady(u{k}).^2) + eps^2);
    inp_grad_y = grady(u{k}) ./ sqrt( (gradx(u{k}).^2 + grady(u{k}).^2) + eps^2);
    
    % Convolution
    conv_lambda_G = imfilter(lambda, G, 'replicate');
    conv_u_G = imfilter(u{k}, G, 'replicate');
    
    % Main eq.
    u{k+1}= u{k} + t*(conv_lambda_G*(f- conv_u_G) + div(inp_grad_x, inp_grad_y));
end
out = u{K};
end

