% The purpose of this file is to save the data for evaluation in accordance
% to the data format created for MagNet Challenge 2. In this file, the test
% data is saved in the format of known:unknown ratio for the H sequence. The 
% length of known and unknown can be adjusted

%% Clear previous varaibles and add the paths
clear % Clear variable in the workspace
clc % Clear command window
close all % Close all open figures
cd ../../../; % To go to the previous folder 


%%
%%%%%%%%%%%%%%%%%%%%% PLEASE SELECT THE MATERIAL, SHAPE, DATASET TO ANALYZE
Database = 'Transient_Database'; Material = '3C90'; Shape = 'TX-25-15-10'; Dataset = 1;
%Database = 'Transient_Database'; Material = 'N87'; Shape = 'R34.0X20.5X12.5'; Dataset = 1;
%Database = 'Transient_Database'; Material = '3E6'; Shape = 'TX-22-14-6.4'; Dataset = 1;
%Database = 'Transient_Database'; Material = '3C94'; Shape = 'TX-20-10-7'; Dataset = 1;
%Database = 'Transient_Database'; Material = '3F4'; Shape = 'E-32-6-20-R'; Dataset = 1;
%Database = 'Transient_Database'; Material = '77'; Shape = '0014'; Dataset = 1;
%Database = 'Transient_Database'; Material = '78'; Shape = '0076'; Dataset = 1;
%Database = 'Transient_Database'; Material = 'N27'; Shape = 'R20.0X10.0X7.0'; Dataset = 1;
%Database = 'Transient_Database'; Material = 'N30'; Shape = '22.1X13.7X6.35'; Dataset = 1;
%Database = 'Transient_Database'; Material = 'N49'; Shape = 'R16.0X9.6X6.3'; Dataset = 1;

path_root = [pwd, '\', Database, '\', Material, '\', Shape, '\Dataset', num2str(Dataset)]; % Path of this file
path_root_save = [pwd, '\MLTran\Challenge_Models\', Material]; 
name = [Material, ' - ', Shape, ' - Dataset ', num2str(Dataset)];
mat_name = [Material, '_', Shape, '_Data', num2str(Dataset)];

save_name = '_Testing_True';
test_name = '_Testing_Padded';

%% Set the style for the plots
addpath([pwd,'\','MagNet_Database','\_Tools\Scripts']) % Add the folder where the scripts are located
[Xinit,Yinit,Xsize,Ysize,Nfont] = PlotStyle; close;

%% Initialize Parameters
rng(1);               % Random seed initialization.
window = 80;          % Model memory window size.
Test_length = 1000;   % The total length of each test segment.
ttl_samp = 10;        % No. of sample segments selected for each sequence.
nTemp = 10;           % Number of sequences to select for each temperature.

array_length = [32016 20016 12816 8015 5008 3216 2016]; % Array length at each frequency.


B_test_all = [];
H_test_all = [];
T_test_all = [];
H_test_all_past = [];
Loss_test_all = [];
%% Set the fixed frequncy indicies and reuse them in the iterations below
freq_levels = 7;  % Assuming 7 frequency levels, may vary.
rand_indices_all = cell(1, freq_levels); % Random idx of all temperatures. 
start_points_all = cell(1, freq_levels); % Random starting idx per sequence.

for i = 1:freq_levels % Find idx for each fequency
    file_name = fullfile(path_root, [Material, '_', num2str(i), '.h5']);
    T_dataset = sprintf('/T_%d', i);
    num_row = size(h5read(file_name, T_dataset),1); 
    T_all_data = h5read(file_name, T_dataset, [1, 1], [num_row, 1]); % Reading the whole dataset.

    % Find all idx of each temperature.
    idx_25 = find(T_all_data == 25);
    idx_50 = find(T_all_data == 50);
    idx_70 = find(T_all_data == 70);

    no_of_temp(i) = min([nTemp, length(idx_25), length(idx_50), length(idx_70)]);

    rand_idx_25 = idx_25(randperm(length(idx_25), no_of_temp(i)));
    rand_idx_50 = idx_50(randperm(length(idx_50), no_of_temp(i)));
    rand_idx_70 = idx_70(randperm(length(idx_70), no_of_temp(i)));

    rand_indices_all{i} = [rand_idx_25, rand_idx_50, rand_idx_70];           % Randomly selected temp idx
    start_points_all{i} = randi(array_length(i) - Test_length, ttl_samp, 1); % Randomly selected idx for each sequence
end


%%  Save data based on known : unknown (prediction) ratios

for seq_ratio = 0.1 : 0.4 : 0.9    % The ratios of known:unknown information in a segment: 0.1 means 10% known predicting 90% unknown.
   
    past_end_idx = Test_length * seq_ratio;     
    
    B_test_freq = [];
    H_test_freq = [];
    T_test_freq = [];
    Loss_test_freq = [];

    for i = 1:freq_levels
    
        file_name = fullfile(path_root,[Material, '_', num2str(i), '.h5']);
        B_dataset = sprintf('/B_%d', i);
        H_dataset = sprintf('/H_%d', i);
        T_dataset = sprintf('/T_%d', i);
    
        num_row = size(h5read(file_name, B_dataset),1); % no. of rows of original dataset.
        B_all_data = h5read(file_name, B_dataset, [1, 1], [num_row, array_length(i) + window]);
        H_all_data = h5read(file_name, H_dataset, [1, 1], [num_row, array_length(i) + window]);
        T_all_data = h5read(file_name, T_dataset, [1, 1], [num_row, 1]);
        
        dB = diff(B_all_data, 1, 2);
        H_mid = (H_all_data(:, 1:end-1) + H_all_data(:, 2:end)) / 2;
        Loss_all_data = sum(H_mid .* dB, 2);

        rand_indices = rand_indices_all{i};                             % Read the all temperature sequence idx for each frequency.
        rand_indices = reshape(rand_indices,1, 3 * no_of_temp(i));      % 3* from 3 temperatures.
        start_points = start_points_all{i};                             % set the start points idx for each sequence.
        
        
        for j = 1:length(rand_indices)              % sweeping through all temperatures sequences.
            for k = 1: length(start_points)         % For each seq at each temp, select random starting points.
                B_test = B_all_data(rand_indices(j), start_points(k):start_points(k) + Test_length - 1);
                H_test = H_all_data(rand_indices(j), start_points(k):start_points(k) + Test_length - 1);
                T_test = T_all_data(rand_indices(j));
                Loss_test = Loss_all_data(rand_indices(j));

                B_test_freq = [B_test_freq; B_test];
                H_test_freq = [H_test_freq; H_test];
                T_test_freq = [T_test_freq; T_test];
                Loss_test_freq = [Loss_test_freq; Loss_test];
            end
        end
    end

    H_test_freq_past = H_test_freq;
    H_test_freq_past(:, past_end_idx+1:end) = NaN;       % Setting the predicted section of the tested segment to NaN 

    B_test_all = [B_test_all; B_test_freq];
    H_test_all = [H_test_all; H_test_freq];
    T_test_all = [T_test_all; T_test_freq];
    Loss_test_all = [Loss_test_all ; Loss_test_freq];
    H_test_all_past = [H_test_all_past; H_test_freq_past];
end

%% Save Evaluation Data
% Saving B, H, Temp and core loss in full measurement data.

% B, H, T, Loss
writematrix(B_test_all, fullfile(path_root_save, [Material, save_name, '_B_seq.csv']));
writematrix(H_test_all, fullfile(path_root_save, [Material, save_name, '_H_seq.csv']));
writematrix(T_test_all, fullfile(path_root_save, [Material, save_name, '_T.csv']));
writematrix(Loss_test_all, fullfile(path_root_save, [Material, save_name, '_Loss.csv']));

% partial H
writematrix(H_test_all_past, fullfile(path_root_save, [Material, test_name, '_H_seq.csv']));

disp('The script has been executed successfully');