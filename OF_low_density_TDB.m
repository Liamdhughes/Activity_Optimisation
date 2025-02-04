% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024

clear
close all

Disk_Letter_Name = 'D';

path(path,[Disk_Letter_Name,':\Liam Passport\Study 1 Data\Useful_Matlab_Functions']);

% This code builds a training data base of 30 2DFT's per sensor, per
% individual, so as to train the algorithm sensor by sensor, for one
% specific individual:

Individual_No_array = ['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';'25';'26';'27';'28';'29';;'30';'31';'32';'33';'34';'35'];

temporal_resolution = 0.3; 
S_R = 100;
feature_length = 3;

for multiplication_factor = 1:6
    
    for index = 1:size(Individual_No_array,1)
        Individual_No = Individual_No_array(index,:);      
        
        % Upload the corresponding data set:
        load([Disk_Letter_Name,':\Liam Passport\Study 1 Data\P0',Individual_No,'\corrected_data.mat'])
        % Upload the starting times for the TDB:
        starting_times = csvread([Disk_Letter_Name,':\Liam Passport\Study 1 Data\P0',Individual_No,'\TDB_starting_times.csv']);
        
        time_axis = 0.01*(0:(length(A_Sacrum_interpolated)-1));
        
        %** process the Sacrum **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                % compute the 2DFT of the relevant section of accelerometer:
                temp = two_D_FT_Gaussian(A_Sacrum_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                dim1=size(temp,1);
                dim2=size(temp,2);
                TDB_1(:,counter) = temp(:);
                counter = counter + 1;
            end
        end
        
        
        %** process the Thigh L **
        
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                % compute the 2DFT of the relevant section of accelerometer:
                temp = two_D_FT_Gaussian(A_Thigh_L_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                TDB_2(:,counter) = temp(:);
                counter = counter + 1;
            end
        end
        
        %** process the Thigh R **
        
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                % compute the 2DFT of the relevant section of accelerometer:
                temp = two_D_FT_Gaussian(A_Thigh_R_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                TDB_3(:,counter) = temp(:);
                counter = counter + 1;
            end
        end
        
        %** process the Shank L **
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                % compute the 2DFT of the relevant section of accelerometer:
                temp = two_D_FT_Gaussian(A_Shank_L_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                TDB_4(:,counter) = temp(:);
                counter = counter + 1;
            end
        end
        
        %** process the Shank R **
        counter = 1;
        for uu = 1:size(starting_times,1)
            for vv = 1:size(starting_times,2)
                %find the index of the data according to the starting time:
                [a b] = min(abs(time_axis - starting_times(uu,vv)));
                % compute the 2DFT of the relevant section of accelerometer:
                temp = two_D_FT_Gaussian(A_Shank_R_interpolated(b:round(b+feature_length*S_R)),multiplication_factor,temporal_resolution,S_R,0.5*feature_length);
                TDB_5(:,counter) = temp(:);
                counter = counter + 1;
            end
        end
        
        
            % monitor the outcome of the training data bases:
            for fig_No = 1:5
                subplot(2,3,fig_No)
                eval(['imagesc(log10(TDB_',num2str(fig_No),'))'])
                title(['Multiplication Factor = ',num2str(multiplication_factor)])
                colormap(jet(256))
            end
        
        save([Disk_Letter_Name,':\Liam Passport\Study 1 Data\processing_code\training_data_bases\TDB_',Individual_No,'_multiplication_factor_',num2str(multiplication_factor),'.mat'],'TDB_1','TDB_2','TDB_3','TDB_4','TDB_5','dim1','dim2')
        clear TDB_1 TDB_2 TDB_3 TDB_4 TDB_5
        
        saveas(gcf,'Barchart.png')
    end
end
