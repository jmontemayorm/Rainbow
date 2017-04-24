% This code calculates the angle of deflection for different wavelengths of
% the visible spectrum inside a sperical droplet of water to show why
% rainbows form

% Path for saving images
path = 'OpticsProject/';
if exist(path,'dir') == 0
    mkdir(path)
end

% Reads data for the index of refraction according to the wavelength
wl = csvread('nData.csv',9,0,[9 0 21 0]);
n = csvread('nData.csv',9,1,[9 1 21 1]);

% These are the colors in RGB for wl
rgb = [131,0,181;...
    84,0,255;...
    0,70,255;...
    0,192,255;...
    0,255,145;...
    74,255,0;...
    163,255,0;...
    240,255,0;...
    255,190,0;...
    255,99,0;...
    255,0,0;...
    255,0,0;...
    255,0,0];
rgb = rgb/255;


% Heights and angles of incidence phi
h = linspace(0,1,300); % h = sin(phi)
phi = asin(h);

% Grids
[H, N] = meshgrid(h,n);
[PHI,~] = meshgrid(phi,n);

% Calculates the angle of transmitance TH and the angle of deflection GAMMA
TH = asin(H./N);
GAMMA = 4*TH - 2*PHI;

% Transforms the angles into degrees
PHIdeg = PHI*180/pi;
THdeg = TH*180/pi;
GAMMAdeg = GAMMA*180/pi;

% Generates the plot of the angle of deflection
figure(1)
hold on
for ii = 1:13
    plot(PHIdeg(ii,:),GAMMAdeg(ii,:),'color',rgb(ii,:))
end
xlbl1 = xlabel('\phi (degrees)');
xlbl1.FontSize = 16;
ylbl1 = ylabel('\gamma (degrees)');
ylbl1.FontSize = 16;
ttl1 = title('Angle of deflection as function of angle of incidence');
ttl1.FontSize = 18;

% Saves the color eps and png images
saveas(figure(1),[path 'rainbow'],'epsc')
saveas(figure(1),[path 'rainbow.png'])

% Fresnel Equations
Rs = abs((cos(PHI)-N.*cos(TH))./(cos(PHI)+N.*cos(TH))).^2;
Rp = abs((cos(TH)-N.*cos(PHI))./(cos(TH)+N.*cos(PHI))).^2;
R = (1/2).*(Rp+Rs);
T1 = 1 - R;
Rs = abs((N.*cos(TH)-cos(PHI))./(N.*cos(TH)+cos(PHI))).^2;
Rp = abs((N.*cos(PHI)-cos(TH))./(N.*cos(PHI)+cos(TH))).^2;
R1 = (1/2).*(Rp+Rs);
T2 = 1 - R1;
P = T1.*R1.*T2;

% Generates the plot of the intensity
figure(2)
hold on
for ii = 1:13
    plot(GAMMAdeg(ii,1:285),P(ii,1:285),'color',rgb(ii,:))
end
xlbl1 = xlabel('\gamma (degrees)');
xlbl1.FontSize = 16;
ylbl1 = ylabel('Intensity (%)');
ylbl1.FontSize = 16;
ttl1 = title('Intensity as a function of the angle of deflection');
ttl1.FontSize = 18;

% Saves the color eps and png images
saveas(figure(2),[path 'intensity'],'epsc')
saveas(figure(2),[path 'intensity.png'])