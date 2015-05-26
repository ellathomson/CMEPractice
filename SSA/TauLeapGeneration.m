function [tau] = TauLeapGeneration(numSpecies, numReactions, V, X0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluates tau for a given number of species and reactions, with a set
% error tolerance. Calculates f, mu and delta, and a final value for tau.
% Error tolerance, number of species and number of reactions can change. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%numSpecies = 3; % the number of components in all reactions
%numReactions = 3; % the number of different reactions that can occur

epsilon = 0.5; % error tolerance (larger epsilon = larger tau) (0<epsilon<1) 

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


for i = 1:numSpecies % loop to calculate and evaluate derivatives 
    %first calculated the  derivative , then evaluate it

    % differentiate the function 
    derivs{i} = diff([rxns{1:end}],all_species(i)); 

end

all_derivs = [derivs{1:end}];
all_evaluations = single(all_derivs(species1,species2,species3));

%
% ADD CODE
%


for j=1:numReactions %calculate mean and sigma
    % calculate mu for each reaction
    all_means(j) = sum(all_f(j,:).*single(all_rxns(species1,species2,species3)));
    all_variances(j) = sum((all_f(j,:).^2).*single(all_rxns(species1,species2,species3)));
    
    % calculate delta for each rection
    first_term(j) = (epsilon*a_0)/(abs(all_means(j)));
    second_term(j) = ((epsilon*a_0)^2)/all_variances(j);
    
    minima(j) = min(first_term(j),second_term(j)); % find minimum between delta nad mu for each reaction
end


tau = min(minima); % tau is the minimum 
