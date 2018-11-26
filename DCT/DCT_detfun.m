function [detected,wpsnr_result] = DCT_detfun(original, watermarked, attacked)
start_time = cputime;
%% read the original and watermarked images 
I = original;
Wat = watermarked;
att = attacked;

I_dct = dct2(double(I));
I_wat_dct = dct2(double(Wat));
I_att_dct = dct2(double(att));

%% some misc values
[dimx,dimy] = size(I);
alpha = 0.0105;
watermark_size = 1024;
%T = 13.47;
%% selecting the spots
reshaped_alt = reshape(I_dct,1,dimx*dimy);
[~,pos_v] = sort(abs(reshaped_alt),'descend'); %to get the N biggest
pos_v2 = pos_v(2:watermark_size+1);
position=zeros(watermark_size,2); %to make it faster
for k=1:watermark_size %find the positions in pic
    x=floor(pos_v2(k)/dimx)+1;%columns
    y=mod(pos_v2(k),dimx)+1;%rows
    position(k,1)=y;
    position(k,2)=x;
end

%% extracting
w_rec_w = zeros(1,1024); %for speed
for k=1:watermark_size
%     w_rec_w(k) = ((I_wat_dct(position(k,1),position(k,2))-I_dct(position(k,1),position(k,2))))/alpha; %additive
    w_rec_w(k) = ((I_wat_dct(position(k,1),position(k,2))/I_dct(position(k,1),position(k,2)))-1)/alpha; %multiplicative
end
T = findThreshold(w_rec_w);
fprintf('T = %3.4f\n',T);

w_rec_att = zeros(1,1024); %for speed
for k=1:watermark_size
%     w_rec_att(k) = ((I_att_dct(position(k,1),position(k,2))-I_dct(position(k,1),position(k,2))))/alpha; %additive
      w_rec_att(k) = ((I_att_dct(position(k,1),position(k,2))/I_dct(position(k,1),position(k,2)))-1)/alpha; %multiplicative

end

%% similarity of w-extracted and w-extracted-attacked
SIM = w_rec_w * w_rec_att' / sqrt(w_rec_att * w_rec_att');

%% return values
detected = 0;
fprintf('SIM = %3.4f\n',SIM);
if SIM > T
    detected =1;
end
wpsnr_result  = WPSNR(uint8(Wat),uint8(att));
%% Time evaluation
stop_time = cputime;
fprintf('Execution time = %0.5f sec\n',abs( start_time - stop_time));

