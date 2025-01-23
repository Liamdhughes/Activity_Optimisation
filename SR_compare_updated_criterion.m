close all
load two_criteria_updated_criterion_no_norm15.mat

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

% Update the criterion with the adjusted values
criterion = reshape(array_01, size(criterion,1), size(criterion,2), size(criterion,3));

% Plotting the original and updated Mean Criterion Values
figure;
colormap(jet(256))
for uu = 1:18
    subplot(3,6,uu)
    imagesc(squeeze(criterion(:,:,uu)),[0 100])
    colorbar
end

% Calculating the mean Mean Criterion Values for each sensor and sampling frequency
performance = zeros(5, 18); % Initialize the performance matrix
for sensor_No = 1:5    
    performance(sensor_No,:) = mean(squeeze(abs(criterion(:,sensor_No,:))), 1); % Calculate mean across the first dimension
end

% Plotting the Mean Criterion Values for each sensor with specific titles
figure(4);
sgtitle('8b. Sampling Frequency') 
sensor_titles = {'Criterion Sacrum', 'Criterion Left Thigh', 'Criterion Right Thigh', 'Criterion Left Shank', 'Criterion Right Shank'}; % Titles for each sensor plot
for sensor_No = 1:5
    subplot(2,3,sensor_No)
    plot(performance(sensor_No,:))
    xlim([1 18])
    xticks(1:18)
    xticklabels(15:5:100)
    xlabel('Sampling Frequency (Hz)')
    ylabel('Mean Criterion Value')
    ylim([0 7000])
    title(sensor_titles{sensor_No}) % Use the specific title from sensor_titles array
end

% Adding the sixth subplot with the average of the Mean Criterion Values across sensors
subplot(2,3,6)
average_performance = mean(performance, 1); % Calculate the average across sensors
plot(average_performance)
xlim([1 18])
xticks(1:18)
xticklabels(15:5:100)
xlabel('Sampling Frequency (Hz)')
ylabel('Mean Criterion Value')
ylim([0 7000])
title('Average Criterion Across Sensors') % Title for the sixth plot