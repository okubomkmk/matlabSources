classdef fileReader < handle

    properties
        FilePassWin;
        FilePassUnix;
        tempMatrix;
        FramesizeX;
        FramesizeY;
        FrameNum;
        file;
        type;
        miss;
        a;
        
    end
    
    methods
        function obj = fileReader(Filename)
            if nargin == 0
                return
            end
            obj.file = fopen(Filename);
            obj.FramesizeX = fscanf(obj.file, '%d/n');
            obj.FramesizeY = fscanf(obj.file, '%d/n');
            obj.FrameNum = fscanf(obj.file, '%d/n');
            obj.type = fscanf(obj.file,'%s/n');
            obj.FilePassWin = fscanf(obj.file,'%s/n');
            obj.miss = fscanf(obj.file,'%s/n');
            obj.FilePassUnix = fscanf(obj.file,'%s/n');
            
            if(isunix == 0)
                obj.a = dlmread(obj.FilePassWin);
            else
                obj.a = dlmread(obj.FilePassUnix);
            end

            obj.tempMatrix = permute(reshape(obj.a,obj.FramesizeX,obj.FramesizeY,obj.FrameNum),[2 1 3]);
        end
        
    end
end

        
            
