clc;
Iori = imread('original3','bmp'); %read the image
[Iwat,resWPSNR] = DCT_embfun(Iori); %embed the watermark
fprintf('embeded wpsnr = %3.4f \n',resWPSNR);
Iatt1 = imread('original3','bmp');

%% get an attack on the watermarked image

% Iatt = test_awgn(Iwat, 0.003, 79);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('awgn  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
% 
% Iatt = test_blur(Iwat, 1.01);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('blur  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
% 
% Iatt = test_resize(Iatt, 0.99);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('resize  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
% 
% Iatt = test_jpeg(Iwat, 10);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('jpeg  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
% 
% Iatt = test_median(Iwat,3,4);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('median  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
% 
% Iatt = test_sharpening(Iwat, 1.5, 0.9);
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% fprintf('sharpening  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = attackingFunction(Iwat);
% try to detect the watermark on the attacked
[detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);

fprintf('is it detected? = %d \n',detected);
fprintf('WPSNR of attacked and watermarked = %4.4f \n',wpsnr_result);










