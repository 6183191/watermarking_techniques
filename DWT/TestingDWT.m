clc;
Iori = imread('original','bmp'); %read the image
[Iwat,resWPSNR] = embeddingDWT(Iori); %embed the watermark
fprintf('embeded wpsnr = %3.4f \n',resWPSNR);

%% get an attack on the watermarked image

Iatt = test_awgn(Iwat, 0.003, 99);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('awgn  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_blur(Iwat, 1.1);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('blur  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_resize(Iatt, 0.71);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('resize  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_jpeg(Iwat, 30);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('jpeg  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_median(Iwat,3,4);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('median  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_sharpening(Iwat, 3.5, 0.9);
[detected,wpsnr_result] = detectionDWT(Iori, Iwat, Iatt);
fprintf('sharpening  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);











