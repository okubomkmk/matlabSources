filename = 'cplus';

if(isunix ==1)
    file = sprintf('/home/mkuser/KinectIR/cplusplus/sizeofframe%sDepth.dat', filename);
    depth = fileReader(file);
    file2 = sprintf('/home/mkuser/KinectIR/cplusplus/sizeofframe%sInfrared.dat', filename);
    ir = fileReader(file2);
else
    file = sprintf('V:/KinectIR/cplusplus/sizeofframe%sDepth.dat', filename);
    depth = fileReader();
end

%% checkPicture
frame = 3;
figure(1)
showAsPictureVar(depth.tempMatrix(:,:,frame));
figure(2)
showAsPicture(ir.tempMatrix(:,:,frame),2);