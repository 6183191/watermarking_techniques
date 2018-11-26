function [watermarkedret,resWPSNR] = embeddingDWT(onepic)



%% We load the original image 
% I = imread('lena.bmp','bmp');
I = onepic;
%imshow(I); return

[dimx,dimy] = size(I);
Id   = double(I);
%imshow(Id); return

%% Load watermark 
load('putsa.mat', 'w');
[dimxw, dimyw] = size(w);
watermark = reshape(w, 1, dimxw*dimyw); 

%% Define watermark strenght
alpha = 2;
alpha2 = 0.6;

%% DWT tranform
[LL1,LH1,HL1,HH1] = dwt2(Id,'haar','d');

[LL2,LH2,HL2,HH2] = dwt2(HH1,'haar','d');
[LL2_,LH2_,HL2_,HH2_] = dwt2(HL1,'haar','d');

%% DCT transform

% dct for HH2
It_h2 = dct2(HH2);
[dimx_h2,dimy_h2] = size(It_h2);
It_h2_re = reshape(It_h2,1,dimx_h2*dimy_h2);


%dct for HL2
It_l2= dct2(HL2_);
[dimx_l2,dimy_l2] = size(It_l2);
It_l2_re = reshape(It_l2,1,dimx_l2*dimy_l2);


%% Modulo and sign
It_sgn_h2 = sign(It_h2_re);
It_mod_h2 = abs(It_h2_re);


It_sgn_l2 = sign(It_l2_re);
It_mod_l2 = abs(It_l2_re);

%% Modulo sorting
[~,Ix_h2] = sort(It_mod_h2,'descend');

[~,Ix_l2] = sort(It_mod_l2,'descend');

%% Embedding
Itw_mod_h2 = It_mod_h2; 
Itw_mod_l2 = It_mod_l2;

k = 2;

for j = 1:1024
    m = Ix_h2(k);
%    Itw_mod_h2(m) = It_mod_h2(m) + alpha*watermark(j);
    Itw_mod_h2(m) = It_mod_h2(m)*(1+alpha*watermark(j));
%    Itw_mod_h2(m) = It_mod_h2(m)*exp(alpha*w(j));
    k = k+1;
end

k = 2;

for j = 1:1024
    m = Ix_l2(k);
%    Itw_mod_l2(m) = It_mod_l2(m) + alpha*watermark(j);
    Itw_mod_l2(m) = It_mod_l2(m)*(1+alpha2*watermark(j));
    %Itw_mod_l2(m) = It_mod_l2(m)*exp(alpha*w(j));
    k = k+1;
end

% recover sign
It_new_h2 = Itw_mod_h2 .* It_sgn_h2;
It_new_l2 = Itw_mod_l2 .* It_sgn_l2;

%from vector to matrix
It_new_h2=reshape(It_new_h2,dimx_h2,dimy_h2);
It_new_l2=reshape(It_new_l2,dimx_l2,dimy_l2);

%% inverse dct
I_inv_h2 = idct2(It_new_h2);
I_inv_l2 = idct2(It_new_l2);


%% inverse DWT

im_L1_h2 = idwt2(LL2,LH2, HL2 ,I_inv_h2, 'haar');
im_L1_l2 = idwt2(LL2_,LH2_, I_inv_l2 ,HH2_, 'haar');


Iw = idwt2(LL1, LH1, im_L1_l2, im_L1_h2, 'haar');

%% results
% subplot(1,2,1);imshow(Iw,[]);
% subplot(1,2,2);imshow(I);
 
%save watermarked image
watermarkedret = Iw;
% imwrite(uint8(Iw),'watermarked.bmp','bmp'); 


%% output of the noise
resWPSNR = WPSNR(uint8(Iw),uint8(Id));

