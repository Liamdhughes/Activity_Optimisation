% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024

clear
close all

load cropped_data
load start_timings

S_R = 100;

time_duration = (14*60+40)*(101.158/101.39);

time_axis = 0:(1/100):time_duration;

% Undertake the interpolation, assuming a perfect sampling rate of 100 Hz:
A_Thigh_L_interpolated = interp1(0:((time_duration)/(length(A_Thigh_L_cropped) - 1)):time_duration,A_Thigh_L_cropped,time_axis,'pchip');
A_Sacrum_interpolated = interp1(0:((time_duration)/(length(A_Sacrum_cropped) - 1)):time_duration,A_Sacrum_cropped,time_axis,'pchip');
A_Thigh_R_interpolated = interp1(0:((time_duration)/(length(A_Thigh_R_cropped) - 1)):time_duration,A_Thigh_R_cropped,time_axis,'pchip');
A_Shank_L_interpolated = interp1(0:((time_duration)/(length(A_Shank_L_cropped) - 1)):time_duration,A_Shank_L_cropped,time_axis,'pchip');
A_Shank_R_interpolated = interp1(0:((time_duration)/(length(A_Shank_R_cropped) - 1)):time_duration,A_Shank_R_cropped,time_axis,'pchip');


figure
subplot(5,1,1)
plot(time_axis,A_Sacrum_interpolated)
title(['new sampling rate estimate: ',num2str(100*size(A_Sacrum_interpolated,2)./size(A_Sacrum_cropped,1))])
axis tight
subplot(5,1,2)
plot(time_axis,A_Thigh_L_interpolated)
title(['new sampling rate estimate: ',num2str(100*size(A_Thigh_L_interpolated,2)./size(A_Thigh_L_cropped,1))])
axis tight
subplot(5,1,3)
plot(time_axis,A_Thigh_R_interpolated)
title(['new sampling rate estimate: ',num2str(100*size(A_Thigh_R_interpolated,2)./size(A_Thigh_R_cropped,1))])
axis tight
subplot(5,1,4)
plot(time_axis,A_Shank_L_interpolated)
title(['new sampling rate estimate: ',num2str(100*size(A_Shank_L_interpolated,2)./size(A_Shank_L_cropped,1))])
axis tight
subplot(5,1,5)
plot(time_axis,A_Shank_R_interpolated)
title(['new sampling rate estimate: ',num2str(100*size(A_Shank_R_interpolated,2)./size(A_Shank_R_cropped,1))])
axis tight

save('corrected_data.mat','A_Sacrum_interpolated','A_Thigh_L_interpolated','A_Thigh_R_interpolated','A_Shank_L_interpolated','A_Shank_R_interpolated')
