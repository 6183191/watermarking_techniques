function [detected,wpsnr_result] = detectionFun(original, watermarked, attacked)
% start_time = cputime;
%% read the original and watermarked images 
I = original;
Wat = watermarked;
att = attacked;

%% some misc values
[dimx,dimy] = size(I);
alpha = 17;
watermark_size = 1024;
% T = 13.47;

%% method
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

%% extracting
w_rec = zeros(1,1024); %for speed
for k=1:watermark_size
    w_rec(k) = ((Wat(position(k,1),position(k,2))-I(position(k,1),position(k,2))))/alpha; %additive
%     w_rec(k) = ((Wat(position(k,1),position(k,2))/I(position(k,1),position(k,2)))-1)/alpha;%     %multiplicative
end
T = findThreshold(w_rec);
% fprintf('T = %3.4f\n',T);
w_rec_att = zeros(1,1024); %for speed
for k=1:watermark_size
    w_rec_att(k) = ((att(position(k,1),position(k,2))-I(position(k,1),position(k,2))))/alpha; %additive
%     w_rec_att(k) = ((att(position(k,1),position(k,2))/I(position(k,1),position(k,2)))-1)/alpha;%     %multiplicative
end

%% similarity of w-extracted and w-extracted-attacked
SIM = w_rec * w_rec_att' / sqrt(w_rec_att * w_rec_att');

%% return values
detected = 0;
% fprintf('SIM = %3.4f\n',SIM);
if SIM > T
    detected =1;
end
wpsnr_result  = WPSNR(uint8(Wat),uint8(att));
%% Time evaluation
% stop_time = cputime;
% fprintf('Execution time = %0.5f sec\n',abs( start_time - stop_time));

