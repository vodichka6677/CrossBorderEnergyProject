% CrossBorderEnergy_KZ_China.m
% Simulation of renewable energy exchange between Kazakhstan and China
% Author: Timur Turinov
% Date: 15 March 2024

clc; clear; close all;

%% PARAMETERS
days = 30; % simulate for 30 days
regions = {'Kazakhstan','China'};
energy_types = {'Solar','Wind'};

% Average daily production (kWh) for each region
avg_solar = [800 1000]; % Kazakhstan, China
avg_wind  = [600 900];  % Kazakhstan, China

% Random fluctuations (±10%) to simulate daily variation
rng(42); % ensures reproducible results
solar_data = zeros(days,2);
wind_data  = zeros(days,2);
for i=1:2
    solar_data(:,i) = avg_solar(i) * (0.9 + 0.2*rand(days,1));
    wind_data(:,i)  = avg_wind(i)  * (0.9 + 0.2*rand(days,1));
end

%% TRANSMISSION PARAMETERS
line_efficiency = 0.85; % 15% energy loss during transmission

% Simulate energy flow from Kazakhstan to China
total_energy_KZ = solar_data(:,1) + wind_data(:,1);
transmitted_energy = total_energy_KZ * line_efficiency;

% Total energy in China including local production
total_energy_China = solar_data(:,2) + wind_data(:,2) + transmitted_energy;

%% VISUALIZATION

% 1. Solar energy production plot
figure('Color','w');
subplot(3,1,1)
plot(1:days, solar_data(:,1), '-o', 1:days, solar_data(:,2), '-s', 'LineWidth',1.5)
xlabel('Day'); ylabel('Solar Energy (kWh)')
title('Solar Energy Production')
legend('Kazakhstan','China'); grid on

% 2. Wind energy production plot
subplot(3,1,2)
plot(1:days, wind_data(:,1), '-o', 1:days, wind_data(:,2), '-s', 'LineWidth',1.5)
xlabel('Day'); ylabel('Wind Energy (kWh)')
title('Wind Energy Production')
legend('Kazakhstan','China'); grid on

% 3. Total energy in China plot
subplot(3,1,3)
plot(1:days, total_energy_China, '-d','LineWidth',1.5)
xlabel('Day'); ylabel('Total Energy in China (kWh)')
title('China Total Energy including Transmission from Kazakhstan')
grid on

%% HEATMAP OF TRANSMISSION
figure('Color','w')
imagesc(1:days,1,transmitted_energy') % 1-row heatmap
colormap('hot'); colorbar
xlabel('Day'); ylabel('Energy Flow')
title('Energy Transmitted from Kazakhstan to China (kWh)')

