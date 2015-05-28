function [tau_prime, a_0] = genTauPrime (Rjs, V)

%V = [-1 -1 1; -1 1 -1; 1 -2 0];
%Rjs = [0 0 0];
numReactions = 3;
numSpecies = 3;
epsilon = 0.03; % error tolerance (larger epsilon = larger tau) (0<epsilon<1) 

species1 = X0(1); % amount of x1
species2 = X0(2); % amount of x2
species3 = X0(3); % amount of y

syms x1; % symbolic variable for x1
syms x2; % symbolic variable for x2
syms y; % symbolic variable for y
c1 = 2; % reaction rate of reaction 1
c2 = 1; % reaction rate of reaction 2 
c3 = 2; % reaction ate of reaction 3 

nummat = zeros(numSpecies,numReactions); % blank matrix to hold f values
changes = [-1, -1, +1;-1,1,-2;1,-1,0]; % changes in species quantities from reactions
deriv={}; % blank cell to hold derivative symbolic function 

syms f(x1,x2,y); %a for reaction 1 (symbolic)
syms g(x1,x2,y); %a for reaction 2 (symbolic)
syms h(x1,x2,y); %a for reaction 3 (symbolic) 

f(x1,x2,y) = c1*x1*x2; % a for reaction 1
g(x1,x2,y) = c2*x1*y; % a for reaction 2
h(x1,x2,y) = (1/2)*c3*(x2*(x2-1)); % a for reaction 3

all_species = [x1,x2,y]; % vector of all species involved in reaction 
rxns = {f,g,h}; % 3 different function to represent 3 different a's
all_rxns = [f,g,h]; % 3 different functions to represent 3 different a's 
a_0 = single(sum(all_rxns(species1,species2,species3))); % a0 is sum of all aj's
aj = single(all_rxns(species1,species2,species3));


for i = 1:numReactions % loop to calculate and evaluate derivatives 
    % differentiate the function 
    derivs{i} = diff([rxns{1:end}],all_species(i));
    %derivs{i} = diff(rxns{i}, all_species(1:end));
end
% evaluate all daj/dxi 
all_derivs = [derivs{1:end}];
all_evaluations = single(all_derivs(species1,species2,species3));


non_z = find(not(Rjs));
non_crit =length(non_z);
num_fs = numReactions * non_crit; % the number of f values to be calculated 

fjjs = zeros(1, num_fs); % create a vector to store fjj values

for count = 1:non_crit
    index = non_z(count); % index's are the reactions which are not critical (jprime values)
    
    fstart = (3* count) - 2; % index to start storng in fjjs (one jprime)
    fstop = 3*count; % index to stop storing in fjjs (one jprime)
    
    start = index; % index to start counting V values
    stops = [7 8 9]; 
    stop = stops(index); % index to stop counting V values
    
    % all f's for one j prime value with 3 different j values
    fjjs(fstart:1:fstop) = [sum(all_evaluations(1:3:7) .* V(start:3:stop)), ...
    sum(all_evaluations(2:3:8) .* V(start:3:stop)),...
    sum(all_evaluations(3:3:9) .* V(start:3:stop))];  
end

% generate mean and variances for all non-crticial reactions

means = zeros(1, 3); % vector to store means for non-critical
vars = zeros (1, 3); % vector to store variances for non-critical
first_term = zeros(1,3);
second_term = zeros(1,3);

aj_non = aj(non_z); % store ajs for non-critical reactions
max = length(aj_non); % find the number of non-critical reactions


for bb = 1:3 % loop through all reactions to calculate means
    nstart = bb; 
    nstops = [((3*max)-2) ((3*max)-1) (3*max)]; % max number of non-critical rxns
    nstop = nstops(bb); % stopping point for one reaction

    means(bb) = sum(fjjs(nstart:3:nstop) .* aj_non(1:1:max)); % calculate mean for one reaction
    vars(bb) = sum((fjjs(nstart:3:nstop).^2) .* aj_non(1:1:max)); % calculate variances 
end

first_term(1:1:3) = (epsilon * a_0) ./ abs(means(1:1:3)); % list all first terms
second_term(1:1:3) = (epsilon*a_0*a_0) ./ vars(1:1:3); % list all second terms

poss_taus = ones(1, 2);
poss_taus(1) = min(first_term); % minimum of all first terms
poss_taus(2) = min(second_term); % minimum of all second terms

tau_prime = min(poss_taus); % tau prime is the minimum of all first and second terms 


