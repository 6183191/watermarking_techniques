function [detected,wpsnr_result] = detectionDWT(original, watermarked, attacked)



%% We load the original image 
I = original;


[dimx,dimy] = size(I);
Id   = double(I);


%% We load the watermarked image 
Iw = watermarked;


[dimx,dimy] = size(Iw);
Idw   = double(Iw);


%% We load the attacked image
%[attackedImage] = attackingFunction(Iw);
%Ia = attackedImage;
%imwrite(Ia,'attacked.bmp');
Ia = attacked;

[dimx,dimy] = size(Ia);
Ida   = double(Ia);

%% Define watermark strenght
alpha = 2;
alpha2 = 0.6;

%% Original image DWT tranform
[~,~,HL1,HH1] = dwt2(Id,'haar','d');

[LL2,LH2,HL2,HH2] = dwt2(HH1,'haar','d');
[LL2_,LH2_,HL2_,HH2_] = dwt2(HL1,'haar','d');

%% watermarked image DWT tranform
[LL1_1,LH1_1,HL1_1,HH1_1] = dwt2(Idw,'haar','d');

[LL2_1,LH2_1,HL2_1,HH2_1] = dwt2(HH1_1,'haar','d');
[LL2_1_,LH2_1_,HL2_1_,HH2_1_] = dwt2(HL1_1,'haar','d');

%% attacked image DWT tranform
[LL1_2,LH1_2,HL1_2,HH1_2] = dwt2(Ida,'haar','d');

[LL2_2,LH2_2,HL2_2,HH2_2] = dwt2(HH1_2,'haar','d');
[LL2_2_,LH2_2_,HL2_2_,HH2_2_] = dwt2(HL1_2,'haar','d');

%% original image DCT transform

% dct for HH2
It_h2 = dct2(HH2);
[dimx_h2,dimy_h2] = size(It_h2);
It_h2_re = reshape(It_h2,1,dimx_h2*dimy_h2);


%dct for HL2
It_l2= dct2(HL2_);
[dimx_l2,dimy_l2] = size(It_l2);
It_l2_re = reshape(It_l2,1,dimx_l2*dimy_l2);

%% watermarked image DCT transform

% dct for HH2
Itw_h2 = dct2(HH2_1);
[dimxw_h2,dimyw_h2] = size(Itw_h2);
Itw_h2_re = reshape(Itw_h2,1,dimxw_h2*dimyw_h2);


%dct for HL2
Itw_l2= dct2(HL2_1_);
[dimxw_l2,dimyw_l2] = size(Itw_l2);
Itw_l2_re = reshape(Itw_l2,1,dimxw_l2*dimyw_l2);

%% attacked image DCT transform

% dct for HH2
Ita_h2 = dct2(HH2_2);
[dimxa_h2,dimya_h2] = size(Ita_h2);
Ita_h2_re = reshape(Ita_h2,1,dimxa_h2*dimya_h2);


%dct for HL2
Ita_l2= dct2(HL2_2_);
[dimxa_l2,dimya_l2] = size(Ita_l2);
Ita_l2_re = reshape(Ita_l2,1,dimxa_l2*dimya_l2);

%% original image Modulo and sign
It_mod_h2 = abs(It_h2_re);
It_mod_l2 = abs(It_l2_re);
%% watermarked image Modulo and sign
Itw_mod_h2 = abs(Itw_h2_re);
Itw_mod_l2 = abs(Itw_l2_re);
%% attacked image Modulo and sign
Ita_mod_h2 = abs(Ita_h2_re);
Ita_mod_l2 = abs(Ita_l2_re);



%% original image Modulo sorting
[~,Ix_h2] = sort(It_mod_h2,'descend');
[~,Ix_l2] = sort(It_mod_l2,'descend');

k = 2;
for j=1:1024
    m= Ix_h2(k);
    %recover watermark in the watermarked image, using original image in h2
    %w_rec_h2(j)= ((Itw_mod_h2(m) - It_mod_h2(m)))/alpha;
    w_rec_h2(j)=((Itw_mod_h2(m) / It_mod_h2(m))-1)/alpha;
    
    %recover watermark in the attacked image, using original image in h2
    %a_rec_h2(j)= ((Ita_mod_h2(m) - It_mod_h2(m)))/alpha;
    a_rec_h2(j)= ((Ita_mod_h2(m) / It_mod_h2(m))-1)/alpha;
    k=k+1;    
end


k=2;
for j=1:1024
    m= Ix_l2(k);
    %recover watermark in the watermarked image, using original image in l2
    %w_rec_l2(j)= ((Itw_mod_l2(m) - It_mod_l2(m)))/alpha2;
    w_rec_l2(j)= ((Itw_mod_l2(m) / It_mod_l2(m))-1)/alpha2;
    
    %recover watermark in the attacked image, using original image in l2
    %a_rec_l2(j)= ((Ita_mod_l2(m) - It_mod_l2(m)))/alpha2;
    a_rec_l2(j)= ((Ita_mod_l2(m) / It_mod_l2(m))-1)/alpha2;
    k=k+1;    
end

% detection in h2
SIM_h2= abs((a_rec_h2 * w_rec_h2') / sqrt(w_rec_h2 * w_rec_h2'));

% detection in l2
SIM_l2= abs((a_rec_l2 * w_rec_l2') / sqrt(w_rec_l2 * w_rec_l2'));

%T=findthreshold(w_rec_h2)
%T1=findthreshold(w_rec_l2)
T=13.6367;
% T1=13.4713;
detected = 0;
if SIM_h2 > T | SIM_l2 > T
%     fprintf('Mark has been found. \nSIM_h2 = %f\n SIM_l2= %f', SIM_h2, SIM_l2);
        detected = 1;
end
fprintf('SIM_h2 = %f\n SIM_l2= %f\n', SIM_h2, SIM_l2);
wpsnr_result  = WPSNR(uint8(watermarked),uint8(attacked));
