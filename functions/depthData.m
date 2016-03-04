classdef depthData < handle
    %DEPTHDATA ??????????????
    %   ????????L?
    
    properties
        original;
        fft;
        absfft;
        xcorr;
        lagvector;
        fftvector;
        power;
        var;
        average;
        n;
        meandeleted;
        polyval;
        p;
        his;

    end
    
    methods
        function obj = depthData(Fs,x)
            if nargin == 0
                return
            end
            obj.original = x;
            obj.meandeleted = x - mean(x);
            obj.fft = fft(x);
            [obj.xcorr,obj.lagvector]= xcorr(x - mean(x),'unbiased');
            [obj.fftvector,obj.absfft] = fftfftfft(Fs,x);
            obj.power = obj.absfft .^2;
            obj.average = mean(x);
            obj.var = var(x,1);
            obj.n = 0:length(x)-1;
            obj.p = polyfit(obj.n,x,1);
            obj.polyval = polyval(obj.p,obj.n);
            
        end
        
        function plotabsfft(obj)
            stem(obj.fftvector,obj.absfft);
            xlabel('Frequency [Hz]')
            ylabel('|X(f)|')
            title('abs fft(x)')
        end
        
        function plotabsfftWithLine(obj)
            plot(obj.fftvector,obj.absfft);
            xlabel('Frequency [Hz]')
            ylabel('|X(f)|')
            title('abs fft(x)')
            
        end
        
        function plotpower(obj)
            stem(obj.fftvector,obj.power,'Marker','no');
            xlabel('Frequency f [Hz]')
            ylabel('|X(f)|^2')
            %title('abs fft(x)^2')
        end
        
        function plotxcorr(obj)
            stem(obj.lagvector,obj.xcorr,'Marker','no')
            xlim([min(obj.lagvector) max(obj.lagvector)])
            xlabel('lag')
            ylabel('Autocorrelation')
            %title('Autocorrelation of the signal')
        end
        
        function plotsignal(obj)
            
            plot(obj.n,obj.original)
            xlim([0 length(obj.n)]);
            xlabel('n');
            ylabel('depth [mm]');
            %title('depth data')

        end
        
        function plotpolyfit(obj)
            plot(obj.n,obj.polyval);
            xlabel('n');
            ylabel('x[n]');
        end
        
        function plothistogram(obj)
            obj.his = histogram(obj.original);
            obj.his.BinEdges = [min(obj.original):max(obj.original)];
            obj.his.NumBins = max(obj.original) - min(obj.original);
           
            xlabel('depth [mm]')
            ylabel('number of samples')
            %title('histogram plot of the depth data')
        end
    end

end

function [f,Y] = fftfftfft(Fs,x)
x = x - mean(x);
N = length(x);
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
Y_bftrim = fft(x)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);
Y = (abs(Y_bftrim(1:NFFT/2+1)));
end


