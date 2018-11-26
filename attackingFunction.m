function [attackedImage] = attackingFunction(image)

Iwat = image;
wpsnrres = 66;
while wpsnrres > 35
c = randperm(6);
n = c(2);
switch n
    case 1
        Iatt = test_awgn(Iwat, 0.001, 79);
        disp('awgn');
    case 2
        Iatt = test_blur(Iwat, 1.2);
        disp('blur');
    case 3
        Iatt = test_resize(Iwat, 0.66);
        disp('resize');
    case 4
        Iatt = test_jpeg(Iwat, 0.79);
        disp('jpeg');
    case 5
        Iatt = test_median(Iwat,3,4);
        disp('median');
    case 6
        Iatt = test_sharpening(Iwat, 1.1, 0.7);
        disp('sharpening');
end
wpsnrres  = WPSNR(uint8(Iwat),uint8(Iatt));
if wpsnrres > 35
    Itmp = Iatt;
end
end

attackedImage = Itmp;
