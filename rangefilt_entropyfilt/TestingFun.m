clc;
Iori = imread('original','bmp'); %read the image
[Iwat,resWPSNR] = embedFun(Iori); %embed the watermark
fprintf('embeded wpsnr = %3.4f \n',resWPSNR);

% attackingFunction2(Iori, Iwat);
%% get an attack on the watermarked image

Iatt = test_awgn(Iwat, 0.006, 43);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('awgn  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_blur(Iwat, 0.6);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('blur  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_resize(Iatt, 0.71);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('resize  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_jpeg(Iwat, 99);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('jpeg  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_median(Iwat,1,2);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('median  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_sharpening(Iwat, 1.5, 0.9);
[detected,wpsnr_result] = detectionFun(Iori, Iwat, Iatt);
fprintf('sharpening  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

% Iatt = attackingFunction(Iwat);
%% try to detect the watermark on the attacked
% [detected,wpsnr_result] = DCT_detfun(Iori, Iwat, Iatt);
% 
% fprintf('is it detected? = %d \n',detected);
% fprintf('WPSNR of attacked and watermarked = %4.4f \n',wpsnr_result);










