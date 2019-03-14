%% SETUP_MDNET
%
% Setup the environment for running MDNet.
%
% Hyeonseob Nam, 2015 
%

if(isempty(gcp('nocreate')))
    parpool;
end

run matconvnet/matlab/vl_setupnn ;

addpath('pretraining');
addpath('tracking');
addpath('utils');

% path to the folder with OTB sequences
base_path = '/media/cjh/datasets/tracking/OTB100/';
% choose name of the OTB sequence
sequence_name = choose_video(base_path);

test_seq=sequence_name;
conf = genConfig('otb',test_seq,base_path);

% conf = genConfig('otb','Diving');
% conf = genConfig('vot2015','ball1');

switch(conf.dataset)
    case 'otb'
        net = fullfile('/media/cjh/cvpaper/git/models/mdnet_models','mdnet_vot-otb.mat');
    case 'vot2014'
        net = fullfile('/media/cjh/cvpaper/git/models/mdnet_models','mdnet_otb-vot14.mat');
    case 'vot2015'
        net = fullfile('/media/cjh/cvpaper/git/models/mdnet_models','mdnet_otb-vot15.mat');
end

result = mdnet_run(conf.imgList, conf.gt(1,:), net);
