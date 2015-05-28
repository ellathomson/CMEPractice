function [Rjs] = genRj (X0, V)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generates Ls values for each reaction in order to determine whether the
% reaction is critical. If there are critical reactions, the function
% outputs a variable that tells the main program to call the tau generation
% function for critical reactions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% setup values
% the minimum value of lj for rj to be considered a critical reaction. This
% can be a whole number between 2-20. It's usually equal to 10
nc = 10; 

X0 = [40 40 20]; % amounts of each species (will eventaully be an input) 

V = [-1 -1 1; -1 1 -1; 1 -2 0]; % v values for each reaction 

species1 = X0(1); % amount of x1
species2 = X0(2); % amount of x2
species3 = X0(3); % amount of y

syms x1; % symbolic variable for x1
syms x2; % symbolic variable for x2
syms y; % symbolic variable for y
c1 = 2; % reaction rate of reaction 1
c2 = 1; % reaction rate of reaction 2 
c3 = 2; % reaction ate of reaction 3 

syms f(x1,x2,y); %a for reaction 1 (symbolic)
syms g(x1,x2,y); %a for reaction 2 (symbolic)
syms h(x1,x2,y); %a for reaction 3 (symbolic) 

f(x1,x2,y) = c1*x1*x2; % a for reaction 1
g(x1,x2,y) = c2*x1*y; % a for reaction 2
h(x1,x2,y) = (1/2)*c3*(x2*(x2-1)); % a for reaction 3


all_rxns = [f,g,h]; % 3 different functions to represent 3 different a's 

% find ajs for each reaction and store in a vector
aj = single(all_rxns(species1,species2,species3));

<<<<<<< HEAD
%% Check elements
=======
disp(all_rxns)
disp(aj)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
>>>>>>> a6d36d7efb5791b51f1e1a794f8c436d3456ca5d
% check_elements is used to keep track of which elements in the matrix v
% will need to be checked to determine whether they are critical. If an aj is
% negative the entire row for that reaction will be zeroed. If Vij is
% positive, then the one element will be zeroed. 

% Find which reactions have negative aj's, zero their whole row
first_row = aj>0;
first_col= transpose(first_row);

check_elements = double(repmat(first_col,1,3));

% find indexes of non-zero reactions (the elements in these rows will be
% tested later
indexes = find(first_row);

% find negative Vij's for reactions which are not zeroed out
% negative Vij's will have a 1 in check_element, positive Vij's will have a
% 0 in check_element
check_elements([indexes], :) = V([indexes], :)<0;

%% Determine the critical reactions
% ones in Rjs indicate that these reactions are critical reactions
Rjs = zeros(1,3);

% Stores the Lj value for all reactions
Ljs = zeros(1,3);

for x = 1:3 % generates an lj value for each reaction

    Vs = V(x,:); % chooses row of Vij values for a reaction
    
    check = check_elements(x,:); % finds non zero elements 
    ind = find(check); % finds indexes of non zero elements
    x_to_check = X0(ind); % finds x's of indexes determined above
    V_to_check = Vs(ind); % finds vs of indexes determined above
    
    Ls = ceil(x_to_check ./ abs(V_to_check)); % find lj for all elements
    Ljs(x) = min(Ls); % find lj for one reaction and store it (minimum Lj value)
end

Rjs = single(Ljs < nc); % vector of critical reactions
