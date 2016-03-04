file = 'breathe';
%% filename

if (isunix == 0)
    filename1 = sprintf('V:\\Eng\\FrameData\\DepthMeasure%s.dat',file);
    filename2 = sprintf('V:\\Eng\\FrameData\\DepthCenter%s.dat',file);
    filename3 = sprintf('V:\\Eng\\FrameData\\InfraredMeasure%s.dat',file);
    filename4 = sprintf('V:\\Eng\\FrameData\\InfraredCenter%s.dat',file);
    
    filename5 = sprintf('V:\\Eng\\FrameData\\sizeofframe%s.dat',file);
elseif(isunix == 1)
    filename1 = sprintf('/home/mkuser/Eng/FrameData/DepthMeasure%s.dat',file);
    filename2 = sprintf('/home/mkuser/Eng/FrameData/DepthCenter%s.dat',file);
    filename3 = sprintf('/home/mkuser/Eng/FrameData/InfraredMeasure%s.dat',file);
    filename4 = sprintf('/home/mkuser/Eng/FrameData/InfraredCenter%s.dat',file);
    filename5 = sprintf('/home/mkuser/Eng/FrameData/sizeofframe%s.dat',file);
end
%% input data
aDepth = transpose(dlmread(filename1));
CenterCheckDepth = transpose(dlmread(filename2));

aIR = transpose(dlmread(filename3));
CenterCheckIR=  transpose(dlmread(filename4));

sizeOfFrame = dlmread(filename5);

maxX = sizeOfFrame(1);
maxY = sizeOfFrame(2);
N = sizeOfFrame(3);
WritedPixel = maxX*maxY;

b = zeros(WritedPixel,N);
c = zeros(1,N);
Fs = 30;   
centerIR = depthData(Fs,CenterCheckIR);
centerDepth = depthData(Fs, CenterCheckDepth);
PixelDataDepth(maxY,maxX) = depthData();
PixelDataIR(maxY,maxX)  = depthData();



%% contain into array
inverce = 2; % 1??????????????????B
if(inverce == 1)breathe
    IRtempMatrix = permute(reshape(aIR,maxX,maxY,N),[1 2 3]);
    DepthtempMatrix = permute(reshape(aDepth,maxX,maxY,N),[1 2 3]);
else
    IRtempMatrix = permute(reshape(aIR,maxX,maxY,N),[2 1 3]);
    DepthtempMatrix = permute(reshape(aDepth,maxX,maxY,N),[2 1 3]);
end

%% same frame destroyer
IRdestroyNumber = sameFrameDetection(IRtempMatrix);
DepthdestroyNumber = sameFrameDetection(IRtempMatrix);

destroyedCounter = 0;



N = N - destroyedCounter;
%% itsumonoyatsu
temp1 = zeros(1,N);
temp2 = zeros(1,N);
for i = 1:maxY
    for j = 1:maxX
        for n=1:N
            temp1(n) = IRtempMatrix(i,j,n);
            temp2(n) = DepthtempMatrix(i,j,n);
        end
        PixelDataIR(i,j) = depthData(Fs,temp1);
        PixelDataDepth(i,j) = depthData(Fs,temp2);
    end
end


% %% plotdepth
% h1 = figure(1)
% plotMatrix(PixelDataDepth)
% h1.Name = 'DepthMatrix'
% %% plotIR
% h2 = figure(2);
% plotMatrix(PixelDataIR);
% h2.Name = 'IRMatrix';



close all
%% showaspicture
frame = 12;

figure(1)
showAsPictureVar(DepthtempMatrix(:,:,frame))
figure(2)
showAsPictureVar(IRtempMatrix(:,:,frame))

%% average add breathe depth
centerX = floor(maxX / 2);
centerY = floor(maxY / 2);
addCounter = 0;
AddArea = 2;
temp = zeros(1,N);
for i = -AddArea : AddArea
   for j = -AddArea : AddArea
       for n = 1: N
            temp(n) =  temp(n) + PixelDataDepth(centerY + i * 3,centerX + j * 3).original(n);
       end
       addCounter = addCounter + 1;

   end
end

temp = temp/(addCounter);
addedData = depthData(30, temp);
addedData.var
figure(3)
addedData.plotsignal;
ylim([1030 1045])
figureadjust(50)
figure(4)
PixelDataDepth(centerY,centerX).plotsignal;
ylim([1030 1045])
figureadjust(50)


%% add average pulse
centerX = floor(maxX / 2);
centerY = floor(maxY / 2);

addCounter = 0;

AddArea = 3;
temp = zeros(1,N);
for i = -AddArea : AddArea
   for j = -AddArea : AddArea
       for n = 1: N
            temp(n) =  temp(n) + PixelDataIR(centerY + i,centerX + j).original(n);
       end
       addCounter = addCounter + 1;

   end
   
end

temp = temp/(addCounter);
addedData = depthData(30, temp);
figure(5)
addedData.plotsignal
ylim([3000 4500])
figureadjust(50)
%% ??????????????????????
figure(6)
PixelDataIR(13,10).plotsignal
ylim([3000 4500])
figureadjust(50)


