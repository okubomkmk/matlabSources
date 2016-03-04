function filtered = getFilteredmatrix(tempMatrix, area)
sz = size(tempMatrix);
xCenter = floor(sz(2)/2);
yCenter = floor(sz(1)/2);

temp = zeros(1,sz(3));
    for n = 1:sz(3)
        for y = -area : area
            for x = -area : area
                temp(n) = temp(n) + tempMatrix(yCenter + 3 * area, xCenter + 3 * area, n);
            end
        end
    end
filtered = depthData(30,temp/((2*area+1) * (2*area+1)));
            