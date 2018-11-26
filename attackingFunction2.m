function  attackingFunction2(orig,waterm)

watermarked = imread(waterm);
%% 1
m_awgn = 0.001;
for i = 1:1000
    Iatt = test_awgn(watermarked, m_awgn, 43);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    m_awgn = m_awgn + 0.001;
end
fprintf('Attack with Gaussian Noise with Power = %3.5f and WPSNR = %3.4f \n',m_awgn,wpsnr_result);


%% 2
m_blur = 0.01;
for i = 1:250
    Iatt = test_blur(waterm, m_blur);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    m_blur = m_blur + 0.01;
end
fprintf('Attack with Blur with Power = %3.5f and WPSNR = %3.4f\n',m_blur,wpsnr_result);


%% 3
m_res = 0.25;
for i = 1:250
    Iatt = test_resize(waterm, m_res);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    m_res = m_res + 0.01;
end
fprintf('Attack with Resize with Power = %3.5f and WPSNR = %3.4f\n',m_res,wpsnr_result);

%% 4
m_jpeg = 1;
for i = 1:100
    Iatt = test_jpeg(waterm, m_jpeg);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    m_jpeg = m_jpeg + 1;
end
fprintf('Attack with Jpeg with Power = %3.5f and WPSNR = %3.4f\n',m_jpeg,wpsnr_result);

%% 5
m_med1 = 1;
m_med2 = 1;
for i = 1:250
    Iatt = test_median(waterm,m_med1,m_med2);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    m_med1 = m_med1 + 1;
    if mod(m_med1,3) == 0
        m_med2 = m_med2 +1;
    end
end
fprintf('Attack with Median Matrix of  = %d x %d and WPSNR = %3.4f\n',m_med1,m_med2,wpsnr_result);


%% 6
fprintf('TESTING FOR THE SHARPENING ==================================\n');
% for radius = 0.2:0.2:4
power = 1;
radius =  2.2;
for i = 1:100
    Iatt = test_sharpening(waterm, radius, power);
    filename_att = strcat(waterm,'_attacked');
    imwrite(uint8(Iatt),filename_att,'bmp'); 
    %% THIS IS THE DETECTION FUNCTION TO BE USED
    [detected,wpsnr_result] = detection_slytherin(orig, waterm, filename_att);
    if detected == 0
        break;
    end
    power = power + 0.1;
end
fprintf('Attack with Sharpening with Power = %3.5f and radius = %3.4f and WPSNR = %3.4f\n',power,radius,wpsnr_result);
% end
