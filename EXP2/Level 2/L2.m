%% Experiment 1: Doppler Frequency Shift in VANET V2V Links
% Equation (1): f_d = (v_r / c) * f_c * cos(theta)
%
% Simulates the Doppler shift experienced on a V2V link as a function of
% (a) relative vehicle speed, and (b) the angle between the relative
% velocity vector and the line-of-sight direction, at the 802.11p DSRC
% carrier frequency (5.9 GHz).

clear; clc; close all;

%% Constants and parameters
c  = 3e8;                 % Speed of light, m/s
fc = 5.9e9;               % 802.11p DSRC carrier frequency, Hz

% Relative speed range: 0 to 240 km/h (covers two vehicles approaching
% each other at up to 120 km/h each, a realistic highway worst case)
v_kmh     = linspace(0, 240, 500);       % km/h
v_r       = v_kmh ./ 3.6;                % Convert to m/s
theta_deg = [0, 30, 60, 90];             % LOS angles to compare, degrees

%% Compute Doppler shift for each angle
figure('Name', 'Doppler Shift vs Relative Speed');
hold on; 
grid on;
colors = lines(numel(theta_deg));

for k = 1:numel(theta_deg)
    theta  = deg2rad(theta_deg(k));
    fd     = (v_r ./ c) .* fc .* cos(theta);   % Eq. (1), Hz
    fd_kHz = fd ./ 1e3;
    plot(v_kmh, fd_kHz, 'LineWidth', 1.8, 'Color', colors(k,:), ...
        'DisplayName', sprintf('\\theta = %d^\\circ', theta_deg(k)));
end

xlabel('Relative vehicle speed v_r (km/h)');
ylabel('Doppler shift f_d (kHz)');
title(sprintf('Doppler Shift at f_c = %.1f GHz (IEEE 802.11p)', fc/1e9));
legend('Location', 'northwest');
hold off;

%% Numerical example (single worked case)
v_example_kmh = 200;                     % Two vehicles approaching, 100 km/h each
theta_example = 0;                       % Head-on approach, worst case
v_r_example   = v_example_kmh / 3.6;
fd_example    = (v_r_example / c) * fc * cos(deg2rad(theta_example));

fprintf('--- Worked example ---\n');
fprintf('Relative speed      : %.1f km/h (%.2f m/s)\n', v_example_kmh, v_r_example);
fprintf('Carrier frequency   : %.2f GHz\n', fc/1e9);
fprintf('LOS angle theta     : %d deg\n', theta_example);
fprintf('Doppler shift f_d   : %.2f kHz\n', fd_example/1e3);

%% Relevance check: OFDM subcarrier spacing
% IEEE 802.11p uses 156.25 kHz subcarrier spacing (10 MHz channel, half
% of 802.11a's 20 MHz/312.5 kHz). Compare max Doppler to a fraction of
% subcarrier spacing to flag potential ICI risk.
subcarrier_spacing = 156.25e3;          % Hz
pct_of_spacing     = 100 * fd_example / subcarrier_spacing;

fprintf('Doppler as %% of 802.11p subcarrier spacing (156.25 kHz): %.2f %%\n', pct_of_spacing);

if pct_of_spacing > 1
    fprintf('=> Non-negligible: high-speed opposite-direction V2V links can erode\n');
    fprintf('   OFDM subcarrier orthogonality (inter-carrier interference).\n');
end