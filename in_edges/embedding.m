clear all; close all; clc;


%% Define some parameters
k = 1024;
% trade off between robustness and image quality
alpha = 12;
original = 'pillars';
filename_I = strcat(original,'.bmp'); % Original image
filename_WI = strcat(original,'_putsa','.bmp'); % Watermarked 
filename_watermark = 'putsa.mat';
% trade off between robustness and image quality
tk = 1;

%% Load image
I = imread(filename_I);
[dimy,dimx] = size(I);
I_res = reshape(I, 1, dimx*dimy);

%% Load watermark
W = load(filename_watermark);
W = reshape(W.w,1,k);

%% Find best edges/textures pixels
RFI = rangefilt(I);
RFI_res = reshape(RFI, 1, dimx*dimy);
sorted_RFI = sort(RFI_res,'descend');
edge_threshold = sorted_RFI(k*tk);



%% Insert the watermark
WI_res = I_res;

count = 0;
for i = 1:dimx*dimy
    if RFI_res(i) >= edge_threshold
        wbit = W(mod(count,k)+1);
        WI_res(i) = I_res(i) + wbit*alpha;
        count = count + 1;
        
        if count >= k*tk
            break;
        end
    end
end


%% Create the image
WI = reshape(WI_res, dimy, dimx);
imwrite(WI, filename_WI, 'bmp');
WPSNR(uint8(I),uint8(WI))