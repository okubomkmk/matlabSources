file = '/home/mkuser/EnglishPaperPresentation/Mapper/Mappercplus.dat';
dim = [424 512]
%% set as depth resolution
a = dlmread(file);
b = zeros(1,424*512);
DeciRatio = 4;
colorFrameMask = zeros(1280,1920,3);
colorFrameMaskDecimated = zeros(1280/DeciRatio, 1920/DeciRatio, 3);
sDeci = size(colorFrameMaskDecimated);
usedCounter = zeros(1280,1920);
for i = 1:dim(1) *dim(2)
    if(a(i,1) > 0 && a(i,1)< 1920)
        if(a(i,2) > 0 && a(i,2) < 1080)
            usedCounter(a(i,2),a(i,1)) = usedCounter(a(i,2),a(i,1)) + 1;
            b(i) = 1;
        end
    end
end

for i  = 1:1280
    for j = 1: 1920
        if(usedCounter(i,j) == 1)
            colorFrameMask(i,j,:) = [255 0 0];
        elseif(usedCounter(i,j)==2)
            colorFrameMask(i,j,:) = [0 255 0];
        elseif(usedCounter(i,j)==3)
            colorFrameMask(i,j,:) = [0 0 255];
        elseif(usedCounter(i,j)>3)
            colorFrameMask(i,j,:)=[255 255 255];
        end
    end
end
temp = 0;
for i = 1:sDeci(1)
    for j = 1:sDeci(2)
        for y = 1:DeciRatio
            for x = 1:DeciRatio
                colorFrameMaskDecimated(i,j) = usedCounter((i-1)*DeciRatio + y, (j-1)*DeciRatio + x) + colorFrameMaskDecimated(i,j);
            end
        end
    end
end

    

c = permute(reshape(b,dim(2),dim(1)),[2 1]);
figure(1);
imshow(c)

%% set as color resolution
figure(2)
imshow(colorFrameMask)
figure(3)
showAsPictureVar(colorFrameMaskDecimated)
colorbar

figureadjust(50)

