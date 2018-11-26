clc;
Iori = imread('original','bmp'); %read the image
[Iwat,resWPSNR] = DCT_rangefilt_embfun(Iori); %embed the watermark
fprintf('embeded wpsnr = %3.4f \n',resWPSNR);
% Iatt1 = imread('original2.bmp');


% attackingFunction2(Iori, Iwat);
%% get an attack on the watermarked image
% 
Iatt = test_awgn(Iwat, 0.00000000005, 43);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('awgn  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_blur(Iwat, 0.4);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('blur  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_resize(Iatt, 0.71);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('resize  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_jpeg(Iwat, 0.99);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('jpeg  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_median(Iwat,3,4);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('median  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_sharpening(Iwat, 1.5, 0.9);
[detected,wpsnr_result] = DCT_rangefilt_detfun(Iori, Iwat, Iatt);
fprintf('sharpening  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);
