% Iori = imread('bridge.bmp');
IwatI = imread('thewhimskorn3r_bridge.bmp');
Iori = 'bridge.bmp';
Iwat = 'thewhimskorn3r_bridge.bmp';
% subplot(1,2,1);
% imshow(Iori);title('original');
% subplot(1,2,2);
% imshow(Iwat);title('watermarked');

WPSNR(uint8(imread('thewhimskorn3r_bridge.bmp')),uint8(imread('bridge.bmp')))
% attackedImage = attackingFunction(watermarked);
% attackingFunction2(Iori,IwatI);


Iatt = test_awgn(IwatI, 0.84, 79);
filename_att = strcat(Iwat,'_attacked.bmp');
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('awgn  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_blur(IwatI, 0.52);
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('blur  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_resize(IwatI, 0.22);
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('resize  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_jpeg(IwatI, 5);
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('jpeg  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_median(IwatI,6,5);
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('median  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);

Iatt = test_sharpening(IwatI, 11, 0.9);
imwrite(uint8(Iatt),filename_att,'bmp'); 
[detected,wpsnr_result] = detection_thewhimskorn3r(Iori, Iwat, filename_att);
fprintf('sharpening  is it detected? = %d --- WPSNR = %4.4f \n',detected,wpsnr_result);



