clear;
intensity_range = 10; % Intensity range in nm  
% 方案1：16个LED，光谱范围10nm
%Parameters  
wavelength_min = 400; % Minimum wavelength in nm  
wavelength_max = 700; % Maximum wavelength in nm  
num_leds = 16; % Number of LEDs  
num_points = 300; % Number of spectral data points per LED  
  
% Central wavelengths for each LED  
central_wavelengths = linspace(400, 670, num_leds);  
  
% Generate LED spectra with narrower intensity distribution  
spectra = zeros(num_points, num_leds);  
wavelengths = linspace(wavelength_min, wavelength_max, num_points);  

  
for i = 1:num_leds  
    mean_wavelength = central_wavelengths(i);  
  
    % Generate Gaussian spectral data with narrower intensity range  
    std_deviation = intensity_range / (2 * sqrt(2 * log(2))); % Standard deviation  
    intensities = exp(-(wavelengths - mean_wavelength).^2 / (2 * std_deviation^2));  
  
    % Normalize intensities  
    %intensities = intensities / sum(intensities); % Normalize by the sum instead of the maximum  
  
    % Store spectrum  
    spectra(:, i) = intensities;  
end  
  
% Generate a random 300x1 matrix  
target_wavelength_min = 400; % Minimum wavelength in nm  
target_wavelength_max = 700; % Maximum wavelength in nm  
  
% Generate LED spectrum with Gaussian distribution  
num_points = 300; % Number of spectral data points  
target_wavelengths = linspace(target_wavelength_min, target_wavelength_max, num_points);  
target_mean_wavelength = (target_wavelength_min + target_wavelength_max) / 2; % Mean wavelength  
target_std_deviation = (target_wavelength_max - target_wavelength_min) / 6; % Standard deviation  
  
% Generate Gaussian spectral data  

target_intensities = exp(-(target_wavelengths - target_mean_wavelength).^2 / (2 * target_std_deviation^2));  
  
% Normalize intensities to ensure sum is 1  
%random_matrix = target_intensities / sum(target_intensities);  
random_matrix = target_intensities;
random_matrix = transpose(random_matrix)  ;
  
% Calculate the needed matrix based on the known 300x9 matrix  

needed_matrix = pinv(spectra) * random_matrix;  
normalized_needed_matrix = needed_matrix ./ sum(needed_matrix);  
  
% Print the needed matrix  
% disp('Needed Matrix:');  
% disp(needed_matrix);  

% 输出预测光谱
output_spectra = spectra * needed_matrix;  

% Plot the LED spectra, needed matrix spectra, and random spectra  
figure;  
  
% Subplot 1: LED spectra  
subplot(2, 2, 1);  
hold on;  
colors = lines(num_leds);  
plots_led = gobjects(num_leds); % Store plot objects  
  
for i = 1:num_leds  
    plots_led(i) = plot(wavelengths, spectra(:, i), 'Color', colors(i, :));  
end  
  
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
title('LED Spectra');  

% Subplot 2: Needed matrix spectra  
subplot(2, 2, 2);  
hold on;  
plot(wavelengths, output_spectra);
plot(wavelengths, random_matrix);    
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
title('Output Matrix Spectra');  
legend('模拟光谱','实际光谱');
  
% 计算差的平方  
squaredDiff = (output_spectra - random_matrix).^2;  
% 计算MSE  
mse_1 = mean(squaredDiff);  
fprintf('方案1均方误差（MSE）: %.8f\n', mse_1);  






% 方案2：25个LED，光谱范围10nm
%Parameters  
wavelength_min = 400; % Minimum wavelength in nm  
wavelength_max = 700; % Maximum wavelength in nm  
num_leds = 25; % Number of LEDs  
num_points = 300; % Number of spectral data points per LED  
  
% Central wavelengths for each LED  
central_wavelengths = linspace(400, 670, num_leds);  
  
% Generate LED spectra with narrower intensity distribution  
spectra = zeros(num_points, num_leds);  
wavelengths = linspace(wavelength_min, wavelength_max, num_points);  
  
for i = 1:num_leds  
    mean_wavelength = central_wavelengths(i);  
  
    % Generate Gaussian spectral data with narrower intensity range  
    std_deviation = intensity_range / (2 * sqrt(2 * log(2))); % Standard deviation  
    intensities = exp(-(wavelengths - mean_wavelength).^2 / (2 * std_deviation^2));  
  
    % Normalize intensities  
    %intensities = intensities / sum(intensities); % Normalize by the sum instead of the maximum  
  
    % Store spectrum  
    spectra(:, i) = intensities;  
end  
  
% Generate a random 300x1 matrix  
target_wavelength_min = 400; % Minimum wavelength in nm  
target_wavelength_max = 700; % Maximum wavelength in nm  
  
% Generate LED spectrum with Gaussian distribution  
num_points = 300; % Number of spectral data points  
target_wavelengths = linspace(target_wavelength_min, target_wavelength_max, num_points);  
target_mean_wavelength = (target_wavelength_min + target_wavelength_max) / 2; % Mean wavelength  
target_std_deviation = (target_wavelength_max - target_wavelength_min) / 6; % Standard deviation  
  
% Generate Gaussian spectral data  

target_intensities = exp(-(target_wavelengths - target_mean_wavelength).^2 / (2 * target_std_deviation^2));  
  
% Normalize intensities to ensure sum is 1  
%random_matrix = target_intensities / sum(target_intensities);  
random_matrix = target_intensities;
random_matrix = transpose(random_matrix)  ;
  
% Calculate the needed matrix based on the known 300x9 matrix  

needed_matrix = pinv(spectra) * random_matrix;  
normalized_needed_matrix = needed_matrix ./ sum(needed_matrix);  
  
% Print the needed matrix  
%disp('Needed Matrix:');  
%disp(needed_matrix);  

% 输出预测光谱
output_spectra = spectra * needed_matrix;  

% Plot the LED spectra, needed matrix spectra, and random spectra  
  
% Subplot 1: LED spectra  
subplot(2, 2, 3);  
hold on;  
colors = lines(num_leds);  
plots_led = gobjects(num_leds); % Store plot objects  
  
for i = 1:num_leds  
    plots_led(i) = plot(wavelengths, spectra(:, i), 'Color', colors(i, :));  
end  
  
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
title('LED Spectra');  

% Subplot 2: Needed matrix spectra  
subplot(2, 2, 4);  
hold on;  
plot(wavelengths, output_spectra);
plot(wavelengths, random_matrix);    
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
title('Output Matrix Spectra');  
legend('模拟光谱','实际光谱');
  
% 计算差的平方  
squaredDiff = (output_spectra - random_matrix).^2;  
% 计算MSE  
mse_2 = mean(squaredDiff);  
fprintf('方案2均方误差（MSE）: %.8f\n', mse_2);  

