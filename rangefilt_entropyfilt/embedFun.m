function [watermarkedret,resWPSNR] = embedFun(original)
close all;

I = original;
%I    = imread(image2read,'bmp');
[dimx,dimy] = size(I);

%% The watermark to be embeded
load('putsa.mat');
[dimwx,dimwy] = size(w);
watermark_size = dimwx*dimwy;
w = reshape(w,1,watermark_size);

%% Method to use
J = rangefilt(I);
% J = entropyfilt(I);
%% selecting the spots
reshaped_alt = reshape(J,1,dimx*dimy);
[~,pos_v] = sort(abs(reshaped_alt),'descend'); %to get the N biggest
position=zeros(watermark_size,2); %to make it faster
for k=1:watermark_size %find the positions in pic
    x=floor(pos_v(k)/dimx)+1;%columns
    y=mod(pos_v(k),dimx)+1;%rows
    position(k,1)=y;
    position(k,2)=x;
end

%% Embedding
Orig = I;
alpha = 17;
for k=1:watermark_size
    I(position(k,1),position(k,2))=I(position(k,1),position(k,2))+alpha.*w(k); %additive
%     I(position(k,1),position(k,2))=I(position(k,1),position(k,2))+alpha*I(position(k,1),position(k,2)).*w(k);
end


%save watermarked image
% imwrite(uint8(I),'watermarked.bmp','bmp'); 
watermarkedret = I;

%disp(PSNR(uint8(I),uint8(Orig)));
resWPSNR = WPSNR(uint8(I),uint8(Orig));