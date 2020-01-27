clear
clc
Vc = 12; % Canopy speed in mph
Vc = Vc * 5280 / 3600; % Canopy speed in ft/s
theta = 150 % Canopy heading

Vw = 3; % Wind speed in kts
Vw = Vw * 5280 / 3600; % Wind speed in ft/s
phi = 40; % Wind direction

psi = 60; % Wire Direction

delay = 7; % Delay in sec
Voy = 5; % Initial horizontal velocity mph
Voy = Voy * 5280 / 3600; % Initial horizontal velocity ft/s 

Vr = [Vc*sind(theta),Vc*cosd(theta)]+[Vw*sind(phi),Vw*cosd(phi)];
% Resultant canopy velocity with wind velocity

h = (0.5)*(-32.2)*(delay^2); % Height fallen
yic = Voy * delay; % Inital distance away from the tower
xic = 0; 
slopeWire = tand(90-psi);

%Vr_dir = Vr(2)/Vr(1);
n = 1;
for t = 0:0.05:100;
    xtc = xic + Vr(1)*t; % X position of canopy over time
    xMat(n) = xtc; % X matrix of canopy position
    wirexMat(n) = xtc; % X position of wire over time
    ytc = yic + Vr(2)*t; % Y position of canopy over time
    yMat(n) = ytc; % Y matrix of canopy position 
    wireyMat(n) = slopeWire*abs(wirexMat(n)); % Y postion over wire over time
    if yMat(n)-wireyMat(n) < 0.05; % If the Y postions of the wire and 
        % the canopy are equal, then there is a strike
        intersection = yMat;
        time_to_strike = t;
        flag = 1;
        break   
    end
    n=n+1;
end

plot(xMat,yMat,'g')
hold on
plot(wirexMat, wireyMat,'r')


time_to_strike
yic
