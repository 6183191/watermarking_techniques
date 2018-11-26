function [T] = findThreshold(w_rec)


load('putsa.mat');
wreshaped = reshape(w,1,1024);
randwatermarks = round(rand(999,size(w_rec,2)));
x = zeros(1,1000);
x(1) = (w_rec*wreshaped')/sqrt((w_rec*w_rec'));
for i = 1:999
    w_rand = randwatermarks(i,:);
    x(i+1) = (w_rand * wreshaped')/sqrt((w_rand * w_rand'));
%     x(i+1) = (w_rand * w_rec')/sqrt((w_rec * w_rec'));
end

x = abs(x);
x = sort(x, 'descend');
t = x(2);
T = t + 0.1*t;