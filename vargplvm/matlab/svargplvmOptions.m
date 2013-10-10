function options = svargplvmOptions(Ytr, globalOpt, labelsTrain)

% SVARGPLVMOPTIONS  Creates an options structure which is used for creating an svargplvm model.
% FORMAT
% DESC Takes a cell array of output modalities and a global options structure and (optionally) a training
% labels vector, and returns an options structure which is used for creating the svargplvm model
%
% ARG Ytr: the cell array with the output modalities
% ARG globalOpt: the structure which holds all global options for the demos
% ARG labelsTrain: the label vector
% RETURN options: the options structure
%
% SEEALSO : svargplvmCreate, svargplvmModelCreate, svargplvm_init
%
% COPYRIGHT : Andreas C. Damianou, 2011

% VARGPLVM


if nargin < 3
    labelsTrain = [];
end


%-- Options for the models
for i=1:length(Ytr)
    % Set up models
    options{i} = vargplvmOptions('dtcvar');
    if iscell(globalOpt.baseKern)
        options{i}.kern = globalOpt.baseKern{i}; %{'rbfard2', 'bias', 'white'};
    else
        options{i}.kern = globalOpt.baseKern;
    end
    options{i}.numActive = globalOpt.indPoints;
    options{i}.optimiser = globalOpt.optimiser;
    options{i}.enableDgtN = globalOpt.DgtN;
    options{i}.fixInducing = globalOpt.fixInd;
    
    % !!!!! Be careful to use the same type of scaling and bias for all
    % models!!!
    
    % scale = std(Ytr);
    % scale(find(scale==0)) = 1;
    %options.scaleVal = mean(std(Ytr));
    
    % options{i}.scaleVal = sqrt(var(Ytr{i}(:))); %%% ??
    options{i}.scale2var1 = globalOpt.scale2var1;
   
    %%%%%
    if ~isempty(labelsTrain)
        options{i}.labels = labelsTrain;
        %optionsDyn{i}.labels = Ytr{i}.labels;
     %%%%%
    end
    
    options{i}.KLweight = globalOpt.KLweight;

end
