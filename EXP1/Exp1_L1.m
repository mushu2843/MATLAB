%% Practical 1: Analog (AM, FM) and Digital (ASK, FSK, PSK) Modulation 
clc; clear; close all; %% ---- Parameters ---- 
fs = 100000;              % Sampling frequency (Hz) 

t  = 0:1/fs:0.01;         % Time vector for analog signals 
fm = 200;                 % Message frequency (Hz) 
fc = 2000;                % Carrier frequency (Hz) 
Am = 1; Ac = 1;           % Amplitudes 
ka = 0.8;                 % Amplitude sensitivity (AM) 
kf = 50;                  % Frequency sensitivity (FM) 

m = Am*sin(2*pi*fm*t); 
c = Ac*cos(2*pi*fc*t); 

s_am = Ac*(1 + ka*m).*cos(2*pi*fc*t);

s_fm = Ac*cos(2*pi*fc*t + 2*pi*kf*cumsum(m)/fs); 

bits = [1 0 1 1 0]; Tb = 0.002;                        % Bit duration (s) 
tb = 0:1/fs:Tb-1/fs; bit_signal = []; 
for i = 1:length(bits)     
    if bits(i) == 1         
        bit_signal = [bit_signal, ones(1,length(tb))];     
    else         bit_signal = [bit_signal, zeros(1,length(tb))];     
    end 
end 
td = 0:1/fs:(Tb*length(bits))-1/fs; 

s_ask = Ac*bit_signal.*cos(2*pi*fc*td); 

f1 = 1000; f2 = 3000; s_fsk = zeros(1,length(td)); 
for i = 1:length(td)     
    if bit_signal(i) == 1         
        s_fsk(i) = Ac*cos(2*pi*f1*td(i));     
    else         
        s_fsk(i) = Ac*cos(2*pi*f2*td(i));     
    end 
end 

s_psk = Ac*cos(2*pi*fc*td + pi*(1-bit_signal)); 

figure(1); 
subplot(3,1,1); plot(t,m,'b','LineWidth',1.2); title('Message Signal'); 
xlabel('Time(s)'); ylabel('Amplitude'); grid on; 
subplot(3,1,2); plot(t,c,'k'); title('Carrier Signal'); 
xlabel('Time(s)'); ylabel('Amplitude'); grid on; 
subplot(3,1,3); plot(t,s_am,'r'); title('Amplitude Modulated Signal (AM)'); 
xlabel('Time(s)'); ylabel('Amplitude'); grid on; 


figure(2); 
plot(t,s_fm,'m'); title('Frequency Modulated Signal (FM)');
xlabel('Time(s)'); ylabel('Amplitude'); grid on; 

figure(3); 
subplot(4,1,1); plot(td,bit_signal,'g','LineWidth',1.5); 
title('Binary Data: [1 0 1 1 0]'); axis([0 max(td) -0.5 1.5]); grid on; 
subplot(4,1,2); plot(td,s_ask,'b'); title('ASK Signal'); grid on; 
subplot(4,1,3); plot(td,s_fsk,'r'); title('FSK Signal'); grid on; 
subplot(4,1,4); plot(td,s_psk,'m'); title('BPSK Signal'); grid on; 
xlabel('Time(s)'); 