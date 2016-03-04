file1 = 'withoutLight';
file2 = 'withLight';

if(isunix ==1)
    fileName = sprintf('/home/mkuser/KinectIR/newversion/sizeofframe%sDepth.dat', file1);
    depthWithoutLight = fileReader(fileName);
    
    fileName2 = sprintf('/home/mkuser/KinectIR/newversion/sizeofframe%sDepth.dat', file2);
    depthWithLight = fileReader(fileName2);
else
    depth = fileReader('V:/KinectIR/newversion/sizeofframeslideDepth.dat');
end

%% make depth data

depthLight = matrixReshaper(depthWithLight.tempMatrix);
depthDark = matrixReshaper(depthWithoutLight.tempMatrix);

%% plot fft result
figure(1)
depthLight(floor(depthWithLight.FramesizeY/2), floor(depthWithLight.FramesizeX/2)).plotabsfft;
title('with light')
ylim([0 1])

figure(2)
depthDark(floor(depthWithoutLight.FramesizeY/2), floor(depthWithoutLight.FramesizeX/2)).plotabsfft;
title('dark')
ylim([0 1])

%% plot fft filtered
figure(6)
filteredLight = getFilteredmatrix(depthWithLight.tempMatrix, 3);
filteredDark = getFilteredmatrix(depthWithoutLight.tempMatrix, 3);

filteredLight.plotabsfft
hold on
filteredDark.plotabsfft;
hold off
legend('WITH light', 'NOT light')
axis([0 1 0 1 ])

%% plot in same figure
maxFreq = 15;
figure(5)
depthLight(floor(depthWithLight.FramesizeY/2), floor(depthWithLight.FramesizeX/2)).plotabsfftWithLine;
hold on
depthDark(floor(depthWithoutLight.FramesizeY/2), floor(depthWithoutLight.FramesizeX/2)).plotabsfftWithLine;
hold off
legend('WITH light', 'NOT light')

