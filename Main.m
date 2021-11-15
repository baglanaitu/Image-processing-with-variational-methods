clear; clc; close all;

% Image
Im_data=double(imread('cameraman.tif'));
% Noisy image
f1 = add_gaussian_noise(Im_data,30); 
f2 = add_gaussian_noise(Im_data,50);
%{
figure ()
imagesc(f1);
colormap gray
title("Observed image (noise level=30)", 'FontSize', 12)
figure ()
imagesc(f2);
colormap gray
title("Observed image (noise level=50)", 'FontSize', 12)
%}

%% Tickhonov denoising (Ex:3),(Ex:5)
lambda = 0.01;
K = 100;
out = Denoise_Tikhonov(f1, K, lambda);
figure (2)
imagesc(out);
colormap gray
title("Tickhonov denoising (f1), lambda = 0.01, K=100", 'FontSize', 12)

%% Smooth TV (Ex:4),(Ex:5)
lambda = 0.001;
K = 200;
eps = 0.001;
TV_out = Denoise_TV(f1, K, lambda ,eps);

figure (3)
imagesc(TV_out);
colormap gray
title("Smoothed TV (f1), lambda = 0.001, K=200", 'FontSize', 12)

%% Denoising by Fourier (Ex:7)
lambda = 0.001;
out = Denoise_Fourier(f2, lambda);
figure()
imagesc(out);
colormap gray;
title('Denoising by Fourier (f2), lambda = 0.001');

%% Deconvolution (Ex:9)
lambda = 0.01;
K = 100;
eps = 1000000;

% Gaussian kernel
sigma_t = 1/4;
std = sqrt(2*K*sigma_t);
P = K*sigma_t+1;
G = fspecial('gaussian', [2*P-1, 2*P-1], std);

% Deconvolution
deconv_out = Deconvolution_TV(f1, G, eps, K, lambda);

figure ()
imagesc(deconv_out);
colormap gray
title('DeconvolutionTV (f1), lambda=0.01, eps=1000000,  K=100', 'FontSize', 12);
%% Inpainting_TV (Ex:10)
lambda = 0.1;
K = 2000;
f = double(imread('Im2.png'));
M = double(imread('Im2_mask.png'));
deconv_out = Inpainting_TV(f, M, K, lambda);

figure ()
imagesc(deconv_out);
colormap gray
title('deconv')
title('Inpainting, lambda=0.0001, K=2000', 'FontSize', 12);


%% Inpainting_Tichonov (Ex:11)
lambda = 0.01;
K = 1000;
coeff = 5;
f = double(imread('Im2.png'));
M = double(imread('Im2_mask.png'));
deconv_out = Inpainting_Tichonov(f, M, K, lambda, coeff);

figure ()
imagesc(deconv_out);
colormap gray
title("Tichonov inpainting, lambda="+lambda+", K="+K+", coeff="+coeff, 'FontSize', 12)

%% Deconvolution (Ex:12)
lambda = 0.0001;
K = 200;
eps = 1;

% Gaussian kernel
G = fspecial('gaussian',[7 7],5); 

% Deconvolution
f = double(imread('Im1.png'));
M = double(imread('Im1_mask.png'));
deconv_out = Deconvolution_TV(f, G, eps, K, lambda);

figure (4)
imagesc(deconv_out);
colormap gray
title("Deconvolution, lambda="+lambda+", K="+K+", eps="+eps, 'FontSize', 12)
%% Denoise g1
lambda = 0.001;
K = 3000;
eps = 1;
TV_out = Denoise_g1_a(f1, K, lambda ,eps);

colormap gray
figure ()
imagesc(TV_out);
colormap gray
title("Denoise g1, lambda="+lambda+", K="+K+", eps="+eps)
%% Denoise g2
lambda = 0.001;
K = 2000;
eps = 1;
TV_out = Denoise_g2(f1, K, lambda ,eps);

figure ()
imagesc(TV_out);
colormap gray
title("Denoise g2, lambda="+lambda+", K="+K+", eps="+eps)