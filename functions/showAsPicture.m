function AvgMatrix = showAsPicture(tempMatrix,type)
    
    dim = size(tempMatrix);
    AvgMatrix = zeros(dim(1),dim(2));
    for i = 1:dim(1)
        for j = 1:dim(2)            
            AvgMatrix(i,j) = mean(tempMatrix(i,j,:));
        end
    end
    if(type == 1)
        imshow(AvgMatrix,[min(AvgMatrix(:)) max(AvgMatrix(:))],'InitialMagnification','fit')
    elseif(type == 2)
        imshow(AvgMatrix,[0 4000],'InitialMagnification','fit')
    end
end
   

