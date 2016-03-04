% void = plotMatrix(DepthData())

function t = plotMatrix(PixelData)

[maxY, maxX] = size(PixelData);

%% plotIR
AxisEdge = [99999 0];
for i = 1:maxY
    for j = 1:maxX
        AxisEdge = [min(AxisEdge(1), min(PixelData(i,j).original(:))) max(AxisEdge(2), max(PixelData(i,j).original(:))) ];
    end
end
t = 0;

for i = 1:maxY    
    for j = 1:maxX
        subplot(maxX,maxY,j+(i-1)*maxX)
        PixelData(i,j).plotsignal
        ylim(AxisEdge)
        
    end
end
