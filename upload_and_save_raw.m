% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024

participant_No = '12';

path_name = ['D:\Liam Passport\Study 1 Data\P012\'];


files_name = ['P0',participant_No,'_Axivity.xlsx'];

S_R = 100;

data = xlsread([path_name,files_name]);




ruler_drop = 4*60 + 30;

A_Sacrum = sqrt((data(:,2)).^2 + (data(:,3)).^2 + (data(:,4)).^2);
A_Thigh_L = sqrt((data(:,6)).^2 + (data(:,7)).^2 + (data(:,8)).^2);

A_Thigh_R = sqrt((data(:,10)).^2 + (data(:,11)).^2 + (data(:,12)).^2);

A_Shank_L = sqrt((data(:,14)).^2 + (data(:,15)).^2 + (data(:,16)).^2);
%
A_Shank_R = sqrt((data(:,18)).^2 + (data(:,19)).^2 + (data(:,20)).^2);
%

subplot(5,1,1)
time_A_Sacrum = (60/60)*(1/S_R)*(0:(length(A_Sacrum)-1));
plot(time_A_Sacrum,A_Sacrum)
xlim([ruler_drop-8 ruler_drop-1])


subplot(5,1,2)
time_A_Thigh_L = (60/60)*(1/S_R)*(0:(length(A_Thigh_L)-1));
plot(time_A_Thigh_L,A_Thigh_L)
xlim([ruler_drop-8 ruler_drop-1])

subplot(5,1,3)
time_A_Thigh_R = (60/60)*(1/S_R)*(0:(length(A_Thigh_R)-1));
plot(time_A_Thigh_R,A_Thigh_R)
xlim([ruler_drop-8 ruler_drop-1])

subplot(5,1,4)

time_A_Shank_L = (60/60)*(1/S_R)*(0:(length(A_Shank_L)-1));
plot(time_A_Shank_L,A_Shank_L)
xlim([ruler_drop-8 ruler_drop-1])

subplot(5,1,5)
time_A_Shank_R = (60/60)*(1/S_R)*(0:(length(A_Shank_R)-1));
plot(time_A_Shank_R,A_Shank_R)
xlim([ruler_drop-8 ruler_drop-1])

save('raw.mat','A_Sacrum','A_Thigh_L','A_Thigh_R','A_Shank_L','A_Shank_R','time_A_Sacrum','time_A_Thigh_L','time_A_Thigh_R','time_A_Shank_L','time_A_Shank_R')
