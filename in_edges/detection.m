
function [detected, wpsnr] = detection_putsa(filename_I, filename_WI, filename_AI)

    %% Define some constants
    k = 1024;
    alpha = 12;
    tk= 1;
    
    %% Load images
    I    = filename_I; % original image
    WI   = filename_WI; % watermarked image
    IA = filename_AI; % attacked image

    %% Reshape the image in 1 vector (columnwise reshape)
    [dimy,dimx] = size(I);
    I_res = reshape(I, 1, dimx*dimy);
    WI_res = reshape(WI,1,dimx*dimy);
    IA_res = reshape(IA,1,dimx*dimy);

 %% Find best edges/textures pixels
    RFI = rangefilt(I);
    RFI_res = reshape(RFI, 1, dimx*dimy);
    sorted_RFI = sort(RFI_res,'descend');
    edge_threshold = sorted_RFI(k*tk);

    %% Extract the watermark from WI
    ALL_W = [];
    count = 0;
    for i = 1:dimx*dimy       
        if count >= k*tk
            break;
        end
        
        if RFI_res(i) >= edge_threshold
            ALL_W(ceil(count/k + 0.00000001), mod(count,k)+1) = (WI_res(i) - I_res(i))/alpha;        
            count = count + 1;
        end
    end

    % Combine them 
    W = [];
    for i=1:k
        W(i) = round(sum(ALL_W(:,i))/tk);
    end
    
        
    %% Extract from WA
    ALL_WA = [];
    count = 0;
    for i = 1:dimx*dimy       
        if count >= k*tk
            break;
        end
        
        if RFI_res(i) >= edge_threshold
            ALL_WA(ceil(count/k + 0.00000001), mod(count,k)+1) = (IA_res(i) - I_res(i))/alpha;        
            count = count + 1;
        end
    end
    
    %% Check similarity
    T = 13.2;
    detected = 0;
    for i=1:tk
        if SIM(W,ALL_WA(i,:)) > T
            detected = 1;
        end
    end
    
    wpsnr = WPSNR(I,IA);
    
end


function out = SIM(A,B)
	out = (A*B')/sqrt(B*B');
end