function [] = showAsPictureVar(tempMatrix)

    dim = size(tempMatrix);
    AvgMatrix = zeros(dim(1),dim(2));
    for i = 1:dim(1)
        for j = 1:dim(2)            
            AvgMatrix(i,j) = mean(tempMatrix(i,j,:));
        end
    end
    imshow(AvgMatrix,[min(AvgMatrix(:)), max(AvgMatrix(:))],'InitialMagnification','fit')
    
end