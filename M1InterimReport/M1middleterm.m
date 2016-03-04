if(isunix ==1)
    depth = fileReader('/home/mkuser/KinectIR/newversion/sizeofframeslideDepth.dat');
else
    depth = fileReader('V:/KinectIR/newversion/sizeofframeslideDepth.dat');
end

label = [0 500 2000 4000 6000 8000];

lowDepth = 500;
maxDepth = 2000;



labelValue = [0 0.25/4 0.25 0.5 0.75 1];
       
            
imshow(depth.tempMatrix, [lowDepth maxDepth]);
c = colorbar('Ticks',label,'TickLabels',label);
c.Limits = [0 8000];
c.FontSize = 30;
%% process
for y = 1:depth.FramesizeY
    for x = 1:depth.FramesizeX
        for n = 1:depth.FrameNum
            if(depth.tempMatrix(y,x,n) < lowDepth)
                depth.tempMatrix(y,x,n) = 0;
            elseif(depth.tempMatrix(y,x,n) > maxDepth)
                depth.tempMatrix(y,x,n) = 1;
            else
                depth.tempMatrix(y,x,n) = (depth.tempMatrix(y,x,n))/maxDepth;
            end
        end
    end
end
