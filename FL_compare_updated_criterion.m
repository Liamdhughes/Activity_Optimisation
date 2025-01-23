% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024

close all
load two_criteria_updated_criterion_no_norm.mat

colormap(jet(256))
% Stretch the matrices into arrays:
array_01 = criterion(:);
array_02 = criterion_x(:);

% Find the spikes in the original matrix:
[a, b] = find(array_01 < 100);
% Fill the spikes with the criterion calculated using the horizontal axis only:
for uu = 1:length(a)
    if array_01(a(uu)) < array_02(a(uu))
        array_01(a(uu)) = array_02(a(uu));
    end
end

criterion = reshape(array_01, size(criterion, 1), size(criterion, 2), size(criterion, 3));

figure
colormap(jet(256))
for uu = 1:16
    subplot(3,6,uu)
    imagesc(squeeze(criterion(:,:,uu)),[0 100])
    colorbar
end

figure
sgtitle('8c. Window Length') 
% Plotting the mean criterion values for each sensor
subplot(2,3,1)
plot(mean(squeeze(abs(criterion(:,1,:)))))
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Criterion Sacrum')

subplot(2,3,2)
plot(mean(squeeze(abs(criterion(:,2,:)))))
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Criterion Left Thigh')

subplot(2,3,3)
plot(mean(squeeze(abs(criterion(:,3,:)))))
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Criterion Right Thigh')

subplot(2,3,4)
plot(mean(squeeze(abs(criterion(:,4,:)))))
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Criterion Left Shank')

subplot(2,3,5)
plot(mean(squeeze(abs(criterion(:,5,:)))))
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Criterion Right Shank')

% Adding the sixth subplot for the average criterion across sensors
subplot(2,3,6)
average_criterion = mean(squeeze(mean(abs(criterion(:,:,:)),2)),1); % Calculate the average across sensors
plot(average_criterion)
xlabel('Window Length (s)')
xlim([1 18])
xticks(1:18)
xticklabels(0.9:0.3:0.9+0.3*17)
ylabel('Mean Criterion Value')
ylim([0 19000])
title('Average Criterion Across Sensors')

