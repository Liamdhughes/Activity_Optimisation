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

% Plotting the imagesc for each of the first 6 iterations
figure;
colormap(jet(256))
for uu = 1:6
    subplot(2,3,uu)
    imagesc(squeeze(criterion(:,:,uu)), [0 100])
    colorbar
end

figure;
sgtitle('8d. Overlapping Factor') 
% Plotting the mean Mean Criterion Values for each sensor
subplot(2,3,1)
plot(mean(squeeze(abs(criterion(:,1,:)))), 'DisplayName', 'Sacrum')
xlabel('Overlapping Value')
xlim([1 6])
xticks(1:6)
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34%'})
ylabel('Mean Criterion Value')
ylim([0 12500])
title('Criterion Sacrum')

subplot(2,3,2)
plot(mean(squeeze(abs(criterion(:,2,:)))), 'DisplayName', 'Left Thigh')
xlabel('Overlapping Value')
xlim([1 6])
xticks(1:6)
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34%'})
ylabel('Mean Criterion Value')
ylim([0 12500])
title('Criterion Left Thigh')

subplot(2,3,3)
plot(mean(squeeze(abs(criterion(:,3,:)))), 'DisplayName', 'Right Thigh')
xlabel('Overlapping Value')
xlim([1 6])
xticks(1:6)
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34%'})
ylabel('Mean Criterion Value')
ylim([0 12500])
title('Criterion Right Thigh')

subplot(2,3,4)
plot(mean(squeeze(abs(criterion(:,4,:)))), 'DisplayName', 'Left Shank')
xlabel('Overlapping Value')
xlim([1 6])
xticks(1:6)
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34%'})
ylabel('Mean Criterion Value')
ylim([0 12500])
title('Criterion Left Shank')

subplot(2,3,5)
plot(mean(squeeze(abs(criterion(:,5,:)))), 'DisplayName', 'Right Shank')
xlabel('Overlapping Value')
xlim([1 6])
xticks(1:6)
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34%'})
ylabel('Mean Criterion Value')
ylim([0 12500])
title('Criterion Right Shank')

% Correcting the averaging process
% Assuming 'criterion' is a 3D matrix where dimensions are [Features, Sensors, Overlaps]
average_criterion = squeeze(mean(mean(abs(criterion), 2), 1)); % Average across sensors, then across features

% Now plot this one-dimensional average criterion array
subplot(2,3,6);
plot(average_criterion, 'DisplayName', 'Average');
xlabel('Overlapping Value');
xlim([1 6]);
xticks(1:6);
xticklabels({'0%', '50%', '66.67%', '75%', '80%', '88.34'})
ylabel('Mean Criterion Value');
ylim([0 12500]);
title('Average Criterion Across Sensors');
