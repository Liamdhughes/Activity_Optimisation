clear
close all


path(path,'D:\Liam Passport\Study 1 Data\Useful_Matlab_Functions');

% This code builds a training data base of 30 2DFT's per sensor, per
% individual, so as to train the algorithm sensor by sensor, for one
% specific individual:
Individual_No_array = ['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';'25';'26';'27';'28';'29';'30';'31';'32';'33';'34';'35'];

time_increment = 0.1;

feature_length = 3;
S_R = 100;
multiplication_factor = 2;

for temporal_resolution = 0.01:0.01:0.3
    
    for index = 1:size(Individual_No_array,1)
        
        Individual_No = Individual_No_array(index,:);
                
        % Upload the corresponding data set:
        load(['D:\Liam Passport\Study 1 Data\P0',Individual_No,'\corrected_data.mat'])
        % Upload the starting times for the TDB:
        starting_times = csvread(['D:\Liam Passport\Study 1 Data\P0',Individual_No,'\TDB_starting_times.csv']);
        
        time_axis = 0.01*(0:(length(A_Sacrum_interpolated)-1));
        
        %** process the Sacrum **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                [a bmax] = min(abs(time_axis - (starting_times(uu,vv) + 4 - feature_length)));
                while (b < bmax)
                    % compute the 2DFT of the relevant section of accelerometer:
                    temp = two_D_FT_Gaussian(A_Sacrum_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                    TDB_1(:,counter) = temp(:);
                    counter = counter + 1;
                    %increase time by 'time_increment'
                    b = round(b + time_increment*S_R);
                end
            end
            boundary(uu) = counter -1;
        end
        
        
        
        %** process the Thigh L **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                [a bmax] = min(abs(time_axis - (starting_times(uu,vv) + 4 - feature_length)));
                while (b < bmax)
                    % compute the 2DFT of the relevant section of accelerometer:
                    temp = two_D_FT_Gaussian(A_Thigh_L_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                    TDB_2(:,counter) = temp(:);
                    counter = counter + 1;
                    %increase time by 'time_increment'
                    b = round(b + time_increment*S_R);
                end
            end
        end
        
        
        %** process the Thigh R **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                [a bmax] = min(abs(time_axis - (starting_times(uu,vv) + 4 - feature_length)));
                while (b < bmax)
                    % compute the 2DFT of the relevant section of accelerometer:
                    temp = two_D_FT_Gaussian(A_Thigh_R_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                    TDB_3(:,counter) = temp(:);
                    counter = counter + 1;
                    %increase time by 'time_increment'
                    b = round(b + time_increment*S_R);
                end
            end
        end
        
        
        %** process the Shank L **
        
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                [a bmax] = min(abs(time_axis - (starting_times(uu,vv) + 4 - feature_length)));
                while (b < bmax)
                    % compute the 2DFT of the relevant section of accelerometer:
                    temp = two_D_FT_Gaussian(A_Shank_L_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                    TDB_4(:,counter) = temp(:);
                    counter = counter + 1;
                    %increase time by 'time_increment'
                    b = round(b + time_increment*S_R);
                end
            end
        end
        
        %** process the Shank R **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                [a bmax] = min(abs(time_axis - (starting_times(uu,vv) + 4 - feature_length)));
                while (b < bmax)
                    % compute the 2DFT of the relevant section of accelerometer:
                    temp = two_D_FT_Gaussian(A_Shank_R_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                    TDB_5(:,counter) = temp(:);
                    counter = counter + 1;
                    %increase time by 'time_increment'
                    b = round(b + time_increment*S_R);
                end
            end
        end
        
%         % monitor the outcome of the training data bases:
%         for fig_No = 1:5
%             figure
%             eval(['imagesc(log10(TDB_',num2str(fig_No),'))'])
%             colormap(jet(256))
%         end
        
        save(['D:\Liam Passport\Study 1 Data\processing_code\training_data_bases\high_density\high_density_TDB_',Individual_No,'_TR_',num2str(round(1000*temporal_resolution)),'.mat'],'TDB_1','TDB_2','TDB_3','TDB_4','TDB_5','boundary')
        clear TDB_1 TDB_2 TDB_3 TDB_4 TDB_5 boundary
    end
    
end