function PixelData  = matrixReshaper(tempMatrix)
sz = size(tempMatrix);

y = sz(1);
x = sz(2);
N = sz(3);
Fs = 30;

PixelData(y,x) = depthData();
temp1 = zeros(1,N);
for i = 1:y
    for j = 1:x
        for n=1:N
              temp1(n) = tempMatrix(i,j,n);

        end
        PixelData(i,j) = depthData(Fs,temp1);
    end
end




