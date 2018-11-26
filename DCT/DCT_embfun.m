function [watermarkedret,resWPSNR] = DCT_embfun(original)
close all;

I = original;
%I    = imread(image2read,'bmp');
[dimx,dimy] = size(I);
Id   = double(I);
id_dct = dct2(Id); % get the dct components
%% The watermark to be embeded
load('putsa.mat');
[dimwx,dimwy] = size(w);
watermark_size = dimwx*dimwy;
w = reshape(w,1,watermark_size);

%% selecting the spots
reshaped_alt = reshape(id_dct,1,dimx*dimy);
[~,pos_v] = sort(abs(reshaped_alt),'descend'); %to get the N biggest
pos_v2=pos_v(2:watermark_size+1); %to exclude the dc
position=zeros(watermark_size,2); %to make it faster
for k=1:watermark_size %find the positions in pic
    x=floor(pos_v2(k)/dimx)+1;%columns
    y=mod(pos_v2(k),dimx)+1;%rows
    position(k,1)=y;
    position(k,2)=x;
end

%% Embedding
alpha = 0.0105;
for k=1:watermark_size
%     id_dct(position(k,1),position(k,2))=id_dct(position(k,1),position(k,2))+alpha.*w(k); %additive
    id_dct(position(k,1),position(k,2))=id_dct(position(k,1),position(k,2))+alpha*id_dct(position(k,1),position(k,2)).*w(k);
end

I_inv=idct2(id_dct);

%save watermarked image
%imwrite(uint8(I_inv),'watermarked.bmp','bmp'); 
watermarkedret = I_inv;

%disp(PSNR(uint8(I),uint8(Orig)));
resWPSNR = WPSNR(uint8(I_inv),uint8(I));