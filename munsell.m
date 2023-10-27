
img_path = "C:\Users\yiga\Documents\MATLAB\resources\pictures\MetaCow\tiffs\"
image_name = "MetaCow410nm.tif";
image = imread('C:\Users\yiga\Documents\MATLAB\resources\pictures\0801.png');  
% Example usage  
% Example data input  
data = [  
    500, 0.8;  
    550, 0.6;  
    600, 0.9;  
    650, 0.4;  
    700, 0.7;  
];   % Replace with your actual data  
full_width_half_max = 40;  % Replace with your desired FWHM  
method = 'gaussian';  % Replace with 'gaussian' or 'lorentzian'  
  
[spectrum, y_values] = generate_spec(data, full_width_half_max, method);  
n = size(spectrum, 2);
x = linspace(400, 700, n);
figure;
hold on;
plot(x, spectrum, 'r');
hold off;
