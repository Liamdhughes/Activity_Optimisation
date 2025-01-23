% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024


clear
close all

load raw
load start_timings

S_R = 100;

ruler_drop_end = 19*60 + 10;

figure(1)
subplot(5,1,1)
time_A_Sacrum = (60/60)*(1/S_R)*(0:(length(A_Sacrum)-1));
[a LL] = min(abs(time_A_Sacrum - start_time_1));
time_A_Sacrum_cropped = time_A_Sacrum(LL:end) - time_A_Sacrum(LL);
ruler_drop_end1 = ruler_drop_end -  time_A_Sacrum(LL);
A_Sacrum_cropped = A_Sacrum(LL:end);
plot(time_A_Sacrum_cropped,A_Sacrum_cropped,'k')
xlim([ruler_drop_end1-40 ruler_drop_end1+40])

end_time = 863.37;
[a LL] = min(abs(time_A_Sacrum_cropped - end_time));
figure(2)
plot(A_Sacrum_cropped(LL-400:LL));
time_A_Sacrum_cropped = time_A_Sacrum_cropped(1:LL);
A_Sacrum_cropped = A_Sacrum_cropped(1:LL);


figure(1)
subplot(5,1,2)
time_A_Thigh_L = (60/60)*(1/S_R)*(0:(length(A_Thigh_L)-1));
[a LL] = min(abs(time_A_Thigh_L - start_time_2));
time_A_Thigh_L_cropped = time_A_Thigh_L(LL:end) - time_A_Thigh_L(LL);
ruler_drop_end2 = ruler_drop_end -  time_A_Thigh_L(LL);
A_Thigh_L_cropped = A_Thigh_L(LL:end);
plot(time_A_Thigh_L_cropped,A_Thigh_L_cropped,'k')
xlim([ruler_drop_end2-40 ruler_drop_end2+40])

end_time = 874.07;
[a LL] = min(abs(time_A_Thigh_L_cropped - end_time));
figure(2)
hold on
plot(A_Thigh_L_cropped(LL-400:LL)),'r';
time_A_Thigh_L_cropped = time_A_Thigh_L_cropped(1:LL);
A_Thigh_L_cropped = A_Thigh_L_cropped(1:LL);


figure(1)
subplot(5,1,3)
time_A_Thigh_R = (60/60)*(1/S_R)*(0:(length(A_Thigh_R)-1));
[a LL] = min(abs(time_A_Thigh_R - start_time_3));
time_A_Thigh_R_cropped = time_A_Thigh_R(LL:end) - time_A_Thigh_R(LL);
ruler_drop_end3 = ruler_drop_end -  time_A_Thigh_R(LL);
A_Thigh_R_cropped = A_Thigh_R(LL:end);
plot(time_A_Thigh_R_cropped,A_Thigh_R_cropped,'k')
xlim([ruler_drop_end3-40 ruler_drop_end3+40])

end_time = 872.24;
[a LL] = min(abs(time_A_Thigh_R_cropped - end_time));
figure(2)
hold on
plot(A_Thigh_R_cropped(LL-400:LL)),'k';
time_A_Thigh_R_cropped = time_A_Thigh_R_cropped(1:LL);
A_Thigh_R_cropped = A_Thigh_R_cropped(1:LL);


figure(1)
subplot(5,1,4)
time_A_Shank_L = (60/60)*(1/S_R)*(0:(length(A_Shank_L)-1));
[a LL] = min(abs(time_A_Shank_L - start_time_4));
time_A_Shank_L_cropped = time_A_Shank_L(LL:end) - time_A_Shank_L(LL);
ruler_drop_end4 = ruler_drop_end -  time_A_Shank_L(LL);
A_Shank_L_cropped = A_Shank_L(LL:end);
plot(time_A_Shank_L_cropped,A_Shank_L_cropped,'k')
xlim([ruler_drop_end4-40 ruler_drop_end4+40])

end_time = 872.5;
[a LL] = min(abs(time_A_Shank_L_cropped - end_time));
figure(2)
hold on
plot(A_Shank_L_cropped(LL-400:LL)),'c';
time_A_Shank_L_cropped = time_A_Shank_L_cropped(1:LL);
A_Shank_L_cropped = A_Shank_L_cropped(1:LL);


figure(1)
subplot(5,1,5)
time_A_Shank_R = (60/60)*(1/S_R)*(0:(length(A_Shank_R)-1));
[a LL] = min(abs(time_A_Shank_R - start_time_5));
time_A_Shank_R_cropped = time_A_Shank_R(LL:end) - time_A_Shank_R(LL);
ruler_drop_end5 = ruler_drop_end -  time_A_Shank_R(LL);
A_Shank_R_cropped = A_Shank_R(LL:end);
plot(time_A_Shank_R_cropped,A_Shank_R_cropped,'k')
xlim([ruler_drop_end5-40 ruler_drop_end5+40])

end_time = 867.95;
[a LL] = min(abs(time_A_Shank_R_cropped - end_time));
figure(2)
hold on
plot(A_Shank_R_cropped(LL-400:LL)),'g';
time_A_Shank_R_cropped = time_A_Shank_R_cropped(1:LL);
A_Shank_R_cropped = A_Shank_R_cropped(1:LL);

save('cropped_data.mat','A_Sacrum_cropped','A_Thigh_L_cropped','A_Thigh_R_cropped','A_Shank_L_cropped','A_Shank_R_cropped')
