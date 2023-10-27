clear;

% step 1:Generate 9 LED spectrum: 300x9 matrix  
%Parameters  
wavelength_min = 400; % Minimum wavelength in nm  
wavelength_max = 700; % Maximum wavelength in nm  
num_leds = 9; % Number of LEDs  
num_points = 300; % Number of spectral data points per LED  
  
% Central wavelengths for each LED  
central_wavelengths = linspace(400, 670, num_leds);  
  
% Generate LED spectra with narrower intensity distribution  
spectra = zeros(num_points, num_leds);  
wavelengths = linspace(wavelength_min, wavelength_max, num_points);  
intensity_range = 10; % Intensity range in nm  
  
for i = 1:num_leds  
    mean_wavelength = central_wavelengths(i);  
  
    % Generate Gaussian spectral data with narrower intensity range  
    std_deviation = intensity_range / (2 * sqrt(2 * log(2))); % Standard deviation  
    intensities = exp(-(wavelengths - mean_wavelength).^2 / (2 * std_deviation^2));  
  
    % Normalize intensities  
    intensities = intensities / sum(intensities); % Normalize by the sum instead of the maximum 
    % Store spectrum  
    spectra(:, i) = intensities;  
end  
% step 2:Generate a random 300x1 matrix  
mu = 0;  % mean  
sigma = 1;  % standard deviation  
data = normrnd(mu, sigma, [1000, 1]);  
% Overlay the Gaussian distribution curve  
hold on;  
x = linspace(min(data), max(data), 300);  
y = normpdf(x, mu, sigma);  
random_matrix = y;  
random_matrix = transpose(random_matrix)  ;
random_matrix = random_matrix / sum(random_matrix); 
% Calculate the needed matrix based on the known 300x9 matrix  
needed_matrix = pinv(spectra) * random_matrix;  
normalized_needed_matrix = needed_matrix / sum(needed_matrix);  
  
% Print the needed matrix  
disp('Needed Matrix:');  
disp(needed_matrix);  

% 输出预测光谱
output_spectra = spectra * normalized_needed_matrix;  



% Plot the LED spectra, needed matrix spectra, and random spectra  
figure;  
  
% Subplot 1: LED spectra  
subplot(1, 2, 1);  
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
subplot(1, 2, 2);  
hold on;  
plot(wavelengths, output_spectra);
plot(wavelengths, random_matrix);    
hold off;  
xlabel('Wavelength (nm)');  
ylabel('Intensity');  
legend('simulate', 'real');
hold on;  

hold off;  
title('Output Matrix Spectra');  


  
% Legend with checkboxes for display control  
legend_strings = cell(num_leds, 1);  
for i = 1:num_leds  
    legend_strings{i} = ['LED ' num2str(i)];  
end  
  
checkbox_group = uibuttongroup('Position', [0.01 0.01 0.1 0.2]);  
checkboxes = gobjects(num_leds);  
  
for i = 1:num_leds  
    checkboxes(i) = uicontrol(checkbox_group, 'Style', 'checkbox', ...  
        'String', legend_strings{i}, 'Value', 1, ...  
        'Position', [10 180 - 20*i 100 20]);  
end  
  
set(checkbox_group, 'SelectionChangeFcn', @(~, event) update_plot_visibility(event.NewValue));  
  
% Function to update plot visibility based on checkbox selection  
function update_plot_visibility(selected_checkbox)  
    selected_led = find(checkboxes == selected_checkbox);  
  
    for i = 1:num_leds  
        if i == selected_led  
            set(plots_led(i), 'Visible', 'on');  
            set(plots_needed(i), 'Visible', 'on');  
        else  
            set(plots_led(i), 'Visible', 'off');  
            set(plots_needed(i), 'Visible', 'off');  
        end  
    end  
end  
