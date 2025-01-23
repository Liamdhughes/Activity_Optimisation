% Copyright, M.Bencsik, M.Bisele L.D.Hughes, 2024

clear
close all
path(path,'D:\Liam Passport v2\Study 1 Data\Useful_Matlab_Functions');

% This code builds a training data base of 30 2DFT's per sensor, per
% individual, so as to train the algorithm sensor by sensor, for one
% specific individual:

% folder_names = ['01']
folder_names = ['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';'24';'25';'26';'27';'28';'29';'30';'31';'32';'33';'34';'35'];
for Individual_No = 1:size(folder_names,1)
    starting_times = csvread(['D:\Liam Passport\Study 1 Data\P0',folder_names(Individual_No,:),'\TDB_starting_times.csv']);
    No_points_TDB(1,Individual_No) = size(starting_times,2);
end

tr_counter = 1;
temporal_resolution = 0.3;
feature_length = 3;
multiplication_factor = 2
    
    for I_index = 1:size(folder_names,1)
        
        Individual_No = folder_names(I_index,:);
        
        for Sensor_No = 1:5
            
            load(['D:\Liam Passport\Study 1 Data\processing_code\training_data_bases\TDB_',Individual_No,'_explore_criterion_','.mat'])
            % Centre the data set:
            eval(['TDB_',num2str(Sensor_No),' = TDB_',num2str(Sensor_No),''';'])
         %   Normalise the training data base:
            % eval(['extent_for_loop = size(TDB_',num2str(Sensor_No),',1)'])
            % for ms_No = 1:extent_for_loop
            %     eval(['TDB_',num2str(Sensor_No),'(ms_No,:) = (1/mean(TDB_',num2str(Sensor_No),'(ms_No,:)))*TDB_',num2str(Sensor_No),'(ms_No,:);'])
            %  end
            
            eval(['temp2 = mean(TDB_',num2str(Sensor_No),');'])
            eval(['centred_data_set2 = (TDB_',num2str(Sensor_No),' - ones(size(TDB_',num2str(Sensor_No),',1),1)*temp2)'';'])
            
            % Calculate the PCA scores and eigenvectors:
            L = centred_data_set2*centred_data_set2'; % L is the covariance matrix C=A*A'.
            [V D] = eig(L); % Diagonal elements of D are the eigenvalues for both L=A'*A and C=A*A'.
            
            scores = flipud(V'*centred_data_set2);
            Eigenspectra = fliplr(V);
           
            % Undertake the DFA on PCA scores that describe a fraction of all deviations found in the measurements:
            fraction = 80;
            deviations_against_limit = (100/sum(mean(abs(scores),2)))*cumsum(mean(abs(scores),2));
            [a limit] = min(abs(deviations_against_limit -  fraction));
                         
            % undertake 2D DFA on the limited TDB
            [U,V, eigenval] = dfa([scores(1:limit,:)]',[zeros(1,No_points_TDB(I_index)) ones(1,No_points_TDB(I_index)) 2*ones(1,No_points_TDB(I_index))],2);
            % Calculate the DF scores on the entire collection of swarming and non
            % swarming spectra:
            DFA_spectrum_01 = sum(Eigenspectra(:,1:limit)'.*(V(:,1)*ones(1,size(Eigenspectra,2))));
            DFA_spectrum_02 = sum(Eigenspectra(:,1:limit)'.*(V(:,2)*ones(1,size(Eigenspectra,2))));
            
            load(['D:\Liam Passport\Study 1 Data\processing_code\training_data_bases\high_density\high_density_TDB_',Individual_No,'_explore_criterion_','.mat'])
            eval(['TDB_',num2str(Sensor_No),' = TDB_',num2str(Sensor_No),''';'])
             % Normalise the training data base:
            % eval(['extent_for_loop = size(TDB_',num2str(Sensor_No),',1)'])
            % eval(['extent_for_loop = size(TDB_',num2str(Sensor_No),',1)'])
            % for ms_No = 1:extent_for_loop
            %     eval(['TDB_',num2str(Sensor_No),'(ms_No,:) = (1/mean(TDB_',num2str(Sensor_No),'(ms_No,:)))*TDB_',num2str(Sensor_No),'(ms_No,:);'])
            %  end
            eval(['validation_data = TDB_',num2str(Sensor_No),';'])
            eval(['temp2 = mean(TDB_',num2str(Sensor_No),');'])
            eval(['centred_data_set2 = (TDB_',num2str(Sensor_No),' - ones(size(TDB_',num2str(Sensor_No),',1),1)*temp2)'';'])
            
            % Calculate the PCA scores and eigenvectors:
            L = centred_data_set2*centred_data_set2'; % L is the covariance matrix C=A*A'.
            [V D] = eig(L); % Diagonal elements of D are the eigenvalues for both L=A'*A and C=A*A'.
            
            scores = flipud(V'*centred_data_set2);
            A_x = sum((validation_data).*(ones(size(validation_data,1),1)*DFA_spectrum_01),2);
            A_y = sum((validation_data).*(ones(size(validation_data,1),1)*DFA_spectrum_02),2);
            
            
            centre_01(1) = mean(A_x(1:boundary(1)));
            centre_02(1) = mean(A_x(boundary(1)+1:boundary(2)));
            centre_03(1) = mean(A_x(boundary(2)+1:end));
            
            centre_01(2) = mean(A_y(1:boundary(1)));
            centre_02(2) = mean(A_y(boundary(1)+1:boundary(2)));
            centre_03(2) = mean(A_y(boundary(2)+1:end));            
            
            dist_1_2 = sqrt((centre_01(1)-centre_02(1)).^2+(centre_01(2)-centre_02(2)).^2);
            dist_1_3 = sqrt((centre_01(1)-centre_03(1)).^2+(centre_01(2)-centre_03(2)).^2);
            dist_2_3 = sqrt((centre_02(1)-centre_03(1)).^2+(centre_02(2)-centre_03(2)).^2);
            
            array_01 = sqrt((centre_01(1)- A_x(1:boundary(1))).^2+(centre_01(2)- A_y(1:boundary(1))).^2);
            array_02 = sqrt((centre_02(1)- A_x(boundary(1)+1:boundary(2))).^2+(centre_02(2)- A_y(boundary(1)+1:boundary(2))).^2);
            array_03 = sqrt((centre_03(1)- A_x(boundary(2)+1:end)).^2+(centre_03(2)- A_y(boundary(2)+1:end)).^2);
            
            scatter_01 = std(array_01);
            scatter_02 = std(array_02);
            scatter_03 = std(array_03);
          
%           criterion(str2num(Individual_No),Sensor_No,tr_counter) = (scatter_01*scatter_02/dist_1_2)*(scatter_01*scatter_03/dist_1_3)*(scatter_02*scatter_03/dist_2_3);
%             criterion(str2num(Individual_No),Sensor_No,tr_counter) = (scatter_01*scatter_02*scatter_03)/(dist_1_2*dist_1_3*dist_2_3);            
            criterion(str2num(Individual_No),Sensor_No,tr_counter) = (dist_1_2*dist_1_3*dist_2_3)/(scatter_01*scatter_02*scatter_03);       



            clf
            graph_DF_scores_circles_std(scores,[A_x A_y],Sensor_No,Individual_No,boundary)
            %title(['Sensor = ',num2str(Sensor_No)',' Individual = ', num2str(Individual_No) 'discrimination criterion = ',num2str(criterion(str2num(Individual_No),Sensor_No)),'Temp Res = ',num2str(temporal_resolution)])
            title([' Individual = ', num2str(Individual_No), ' Sensor = ', num2str(Sensor_No), ' Explore Criterion ', ' Criterion = ', num2str(round(criterion(str2num(Individual_No),Sensor_No,tr_counter)))])

            % title([' Explore Criterion ',' Criterion = ',num2str(criterion(str2num(Individual_No),Sensor_No,tr_counter))])   
            print(['D:\Liam Passport v2\Study 1 Data\processing_code\explore_criterion\Scatter plots circle\Individual_',num2str(Individual_No),'_Sensor_',num2str(Sensor_No),'_explore_criterion_','.tif'],'-dtiff','-r300')
            pause(0.01)

        end
    end
    tr_counter = tr_counter + 1;

% Line below is taken from the title, This needs updating to show correct criterion values for each scatter plot figure. 
%'discrimination criterion = ',num2str(criterion(str2num(Individual_No)
% save entire_environment_normalised_explore_criterion_updated_criterion.mat
