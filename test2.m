% Load Munsell Renotation Data  
load('C_1_1_1.mat'); % Replace with the actual file name/path  
  
% Define wavelength range  
wavelengths = 400:700; % Adjust the range as needed  
  
% Select a Munsell color  
munsell_hue = 5; % Adjust the hue value (0-100)  
munsell_value = 5; % Adjust the value value (0-10)  
munsell_chroma = 5; % Adjust the chroma value (0-14)  
  
% Find the closest matching Munsell color in the data  
[~, hue_index] = min(abs(C_1_1_1.hues - munsell_hue));  
[~, value_index] = min(abs(C_1_1_1.values - munsell_value));  
[~, chroma_index] = min(abs(C_1_1_1.chromas - munsell_chroma));  
  
% Get the spectral reflectance for the selected Munsell color  
spectral_reflectance = C_1_1_1.spectra(hue_index, value_index, chroma_index, :);  
  
% Plot the Munsell spectrum  
plot(wavelengths, spectral_reflectance);  
xlabel('Wavelength (nm)');  
ylabel('Reflectance');  
title('Munsell Spectrum');  