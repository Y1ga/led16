%Matlab function that generates a spectrum from frequency, ocillator strength data output from 
%quantum calculations adding Gaussian or 
%Lorentzian functions. The input should be in the form
% spectrum = generate_spec(data,full_width_half_max,method)
%The two available methods are 'gaussian' or 'lorentzian'.


function [spec,y] = generate_spec(x,FWHM,method)

if size(x,1)==2
    x = x';
end

numpoints = max(size(x));
% y = 0:0.5:1.2*max(x(:,1));
y = linspace(min(x(:, 1)), max(x(:, 1)), 300);  
sigma = (1/2.35)*FWHM;
spec = 0;

if strcmp('gaussian',method)
     for n=1:numpoints
        spec = spec + x(n,2).*exp(-((y-x(n,1)).^2)/(2*sigma).^2);
     end
else if strcmp('lorentzian',method)
        for n=1:numpoints
            spec = spec + x(n,2).*(1/pi).*(FWHM./((((y-x(n,1)).^2)+FWHM.^2)));
        end
end
end

spec = spec./max(spec);

%plot(y,spec)
