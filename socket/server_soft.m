
i = 1;
N = 512;
temp = zeros(1,N);
figure(1)
plot(temp);



%% tcp ip section
t = tcpip('172.16.13.23', 22222, 'NetworkRole', 'server');
fopen(t);
warning no;

while(1)
    temp = circshift(temp,[0,1]);
    temp(1) = str2double(fscanf(t));
    
    if (temp(1) == 99999)
        sprintf('end')
        break;
    end
    
    i = i + 1;
    if(mod(i,N/128) ==0)
        [a,b] = max(abs(fft(temp - mean(temp))));
        i = 1;
        plot(temp)
        axis([1 N 0 8000])

        drawnow
    end
end
close all

fclose(t);