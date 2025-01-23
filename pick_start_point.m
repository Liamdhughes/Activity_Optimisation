clear
close all

load raw

S_R = 100;

ruler_drop = 4*60 + 30;

figure(1)
subplot(5,1,1)
time_A_Sacrum = (60/60)*(1/S_R)*(0:(length(A_Sacrum)-1));
plot(time_A_Sacrum,A_Sacrum)
xlim([0 ruler_drop+20])


subplot(5,1,2)
time_A_Thigh_L = (60/60)*(1/S_R)*(0:(length(A_Thigh_L)-1));
plot(time_A_Thigh_L,A_Thigh_L)
xlim([0 ruler_drop+20])

subplot(5,1,3)
time_A_Thigh_R = (60/60)*(1/S_R)*(0:(length(A_Thigh_R)-1));
plot(time_A_Thigh_R,A_Thigh_R)
xlim([0 ruler_drop+20])

subplot(5,1,4)

time_A_Shank_L = (60/60)*(1/S_R)*(0:(length(A_Shank_L)-1));
plot(time_A_Shank_L,A_Shank_L)
xlim([0 ruler_drop+20])

subplot(5,1,5)
time_A_Shank_R = (60/60)*(1/S_R)*(0:(length(A_Shank_R)-1));
plot(time_A_Shank_R,A_Shank_R)
xlim([0 ruler_drop+20])


% Choose a reference channel and crop the signal to the section of the
% trace that seems to be repeatable across all channels:
% 
start_time_1 = 262.01;
figure(2)
[a LL] = min(abs(time_A_Sacrum - start_time_1));
plot(A_Sacrum(LL-100:LL+600))
 
hold on
start_time_2 = 260.75;
[a LL] = min(abs(time_A_Thigh_L - start_time_2));
plot(A_Thigh_L(LL-100:LL+600),'r')

start_time_3 = 262.32;
[a LL] = min(abs(time_A_Thigh_R - start_time_3));
plot(A_Thigh_R(LL-100:LL+600),'k')

start_time_4 = 265.45;
[a LL] = min(abs(time_A_Shank_L - start_time_4));
plot(A_Shank_L(LL-100:LL+600),'c')

start_time_5 = 261.51;
[a LL] = min(abs(time_A_Shank_R - start_time_5));
plot(A_Shank_R(LL-100:LL+600),'g')

save('start_timings.mat','start_time_1','start_time_2','start_time_3','start_time_4','start_time_5')