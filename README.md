# Activity_Optimisation

All code used to create the training database and machine learning algorithm for the discrimination of three locomotion activities, and for calculating their success in discriminating novel recordings.

Project is an extension of repository activity_discrimination_PCA_DFA. activity_discrimination_PCA_DFA should be executed first prior to any optimisation undertaken. 

For sampling frequency optimisation, the code interpolate_and_save_at_differing_SR should be executed on each and every dataset required for analysis. 

FL = Feature Lenght
SR = Sampling Rate
TR = Temporal Resolutaion
OF = Overlapping Factor

It is assumed raw accelerometer data is available, and that 10 starting times for each of the three activites are saved onto a .csv file. 
the path 'useful_matlab_functions' contains: spectrogram_revised_by_martin.m TW_gen.m dfa.m graph_DF_scores_circle.m two_D_FT_Gaussian.m
