function framenum = sameFrameDetection(tempMatrix)
    
    framenum = [];
    dim = size(tempMatrix);
        
    for n = 1:dim(3) -1
        if(tempMatrix(:,:,n) - tempMatrix(:,:,n+1) == zeros(dim(1), dim(2)))
            framenum = [framenum n+1];
        end
    end
end

