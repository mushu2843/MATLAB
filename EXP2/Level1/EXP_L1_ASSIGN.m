%% Practical: BER Performance of BPSK over AWGN and Rayleigh Fading Channels
clc; clear; close all;

%% ---- Simulation Parameters ----
N = 2e6;                         % Number of transmitted bits (increased for low BER resolution)
EbN0_dB = 0:2:30;               % Extended Eb/N0 range in dB
EbN0_lin = 10.^(EbN0_dB / 10);   % Linear Eb/N0

% Preallocate Bit Error Rate arrays
BER_awgn_sim = zeros(size(EbN0_dB));
BER_rayleigh_sim = zeros(size(EbN0_dB));

%% ---- Bit Generation and BPSK Modulation ----
bits = randi([0 1], 1, N);       % Random binary sequence
s = 2*bits - 1;                  % BPSK mapping: 0 -> -1, 1 -> +1 (Symbol Energy Es = 1)

%% ---- Monte Carlo Simulation Loop ----
for i = 1:length(EbN0_dB)
    ebno = EbN0_lin(i);

    % Noise standard deviation per dimension for Es/N0 = Eb/N0
    sigma = sqrt(1 / (2 * ebno));

    % Complex Additive White Gaussian Noise (AWGN)
    noise = sigma * (randn(1, N) + 1j * randn(1, N));

    % 1. AWGN Channel (Real transmission)
    r_awgn = s + real(noise);
    bits_hat_awgn = real(r_awgn) > 0;
    BER_awgn_sim(i) = sum(bits ~= bits_hat_awgn) / N;

    % 2. Rayleigh Fading Channel (Multipath V2V Scenario)
    % Complex Gaussian channel gain: E[|h|^2] = 1
    h = (randn(1, N) + 1j * randn(1, N)) / sqrt(2);

    % Received signal: r = h*s + w
    r_rayleigh = h .* s + noise;

    % Coherent Equalization / Detection: r_eq = (h* / |h|^2) * r
    % Equivalent decision variable: Re{r .* conj(h)}
    r_eq = real(r_rayleigh .* conj(h));

    bits_hat_rayleigh = r_eq > 0;
    BER_rayleigh_sim(i) = sum(bits ~= bits_hat_rayleigh) / N;
end

%% ---- Theoretical BER Calculations ----
% AWGN Theoretical: Pb = Q(sqrt(2*Eb/N0)) = 0.5 * erfc(sqrt(Eb/N0))
BER_awgn_theory = 0.5 * erfc(sqrt(EbN0_lin));

% Rayleigh Theoretical: Pb = 0.5 * (1 - sqrt(gamma / (1 + gamma)))
BER_rayleigh_theory = 0.5 * (1 - sqrt(EbN0_lin ./ (1 + EbN0_lin)));

%% ---- Plotting BER Curves ----
figure;
semilogy(EbN0_dB, BER_awgn_theory, 'k--', 'LineWidth', 1.5); hold on;
semilogy(EbN0_dB, BER_awgn_sim, 'bo', 'MarkerSize', 6, 'LineWidth', 1.2);
semilogy(EbN0_dB, BER_rayleigh_theory, 'm--', 'LineWidth', 1.5);
semilogy(EbN0_dB, BER_rayleigh_sim, 'rs', 'MarkerSize', 6, 'LineWidth', 1.2);
hold off;

grid on;
axis([0 30 1e-6 1]);
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');
title('BER Comparison: AWGN vs. Rayleigh Flat Fading (BPSK)');
legend('Theoretical AWGN', 'Simulated AWGN', ...
    'Theoretical Rayleigh', 'Simulated Rayleigh', ...
    'Location', 'southwest');