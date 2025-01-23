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
for uu = 1:29
    subplot(5, 6, uu)
    imagesc(squeeze(criterion(:,:,uu)), [0 100])
    colorbar
end

figure
sgtitle('8a. Temporal Resolution') 
% Plotting the mean Mean Criterion Values for each sensor with titles
titles = {'Criterion Sacrum', 'Criterion Left Thigh', 'Criterion Right Thigh', 'Criterion Left Shank', 'Criterion Right Shank'};
for i = 1:5
    subplot(2, 3, i)
    plot(mean(squeeze(abs(criterion(:,i,:)))), 'Linewidth', 1)
    xlim([1 29])
    xticks(1:2:29)
    xticklabels(0.02:0.02:0.58)
    xlabel('Temporal Resolution (s)')
    ylabel('Mean Criterion Value')
   ylim([3000 26000])
yticks(3000:3000:26000)  % Set y-axis tick values as needed
yticklabels(string(yticks))  % Display the values without scientific notation
    title(titles{i}); % Setting the title for each subplot
end

% Adding the sixth subplot for the average criterion across sensors
subplot(2,3,6)
average_criterion = mean(squeeze(mean(abs(criterion),2)),1); % Calculate the average across sensors
plot(average_criterion, 'Linewidth', 1)
xlim([1 29])
xticks(1:2:29)
xticklabels(0.02:0.02:0.58)
xlabel('Temporal Resolution (s)')
ylabel('Mean Criterion Value')
  ylim([3000 26000])
yticks(3000:3000:26000)  % Set y-axis tick values as needed
yticklabels(string(yticks))  % Display the values without scientific notation
title('Average Criterion Across Sensors')




