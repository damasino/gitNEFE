function TD_Trials(subID)

% Created on 6/11/2015
% By Dianna Amasino
% This script creates the trials for the temporal discounting portion of
% run_NEFE_final. It creates all combos of delays and monetary amounts.

% Input: subID
% Output: mat file subject(subID#)TD_trials

%Specify output path
trial_dir='~/Documents/NEFE/Stimuli/TD/Design/';
outfid = strcat('subject', num2str(subID),'TD_trials');
output = fullfile(trial_dir,outfid);

% Specify monetary amounts and delays
money1=[.50 .75 1.00 1.50 2.00 2.50 3.00 3.50 4.00 4.50 5.00 5.50 ...
    6.00 6.50 7.00 7.50 8.00 8.50 9.00 9.50];
money2=10;
delay1='Today';
delay2=[1 7 15 30 90 180 365];

% Create cell array with all possible combos for immediate money and delay
% times (delayed money is always $10 and shorter delay is always "today")
trials=length(money1)*length(delay2);
ones(1:trials+3)=1;
%practice trials
start(1:2,1:2)=[5.00,30;2.00,7];
%actual trials
start(3:trials+2,1:2)=combvec(money1,delay2)';
%catch trial
start(trials+3,1:2)=[10,1];
startCell=mat2cell(start,ones,[1,1]);

money2Cell=repmat({money2},trials+3,1);
money2nd=cell2mat(money2Cell);

delay1Cell=repmat({delay1},trials+3,1);

%Calculate the k-value for each choice (as if it were the indifference pt)
k=(money2nd(1:trials+3)./start(1:trials+3,1)-1)./start(1:trials+3,2);
k2=mat2cell(k,ones,1);

%Combine all parts of each trial
all=[startCell(1:trials+3,1) delay1Cell money2Cell startCell(1:trials+3,2) k2];

%randomize trial order
randomize=randperm(trials+3);
for i=1:trials+1
    TDtrials(i+2,1:5)=all(randomize(i+2),1:5);
end
TDtrials(1,1:5)=all(1,1:5);
TDtrials(2,1:5)=all(2,1:5);

save(output, 'TDtrials')