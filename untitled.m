% Parameters  
wavelength_min = 400; % Minimum wavelength in nm  
wavelength_max = 700; % Maximum wavelength in nm  
num_leds = 10; % Number of LEDs  
num_points = 100; % Number of spectral data points per LED  
  
% Generate random LED spectra  
spectra = zeros(num_points, num_leds);  
for i = 1:num_leds  
    % Generate random spectral data  
    wavelengths = linspace(wavelength_min, wavelength_max, num_points);  
    intensities = rand(1, num_points);  
    % wavelengths: 100个离散坐标（400-700nm均分）
    % intensities: 100个强度对应坐标
    % Normalize intensities  
    intensities = intensities / max(intensities);  
    % 使用一个二维数组spectra(100×10)收集起来强度值
    % Store spectrum  
    spectra(:, i) = intensities;  
end  
  
% Plot the LED spectra  
figure;  
hold on;  
colors = lines(num_leds);  
for i = 1:num_leds  
    plot(wavelengths, spectra(:, i), 'Color', colors(i, :));  
end  
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
title('Stochastic LED Spectral Data');  
legend('LED 1', 'LED 2', 'LED 3', 'LED 4', 'LED 5', 'LED 6', 'LED 7', 'LED 8', 'LED 9', 'LED 10');  