function [aj, a0] = AGeneration(X0, c)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculates the aj of each reaction, and returns all aj
% values in a vector. It also calculated a0 which is the sum of the ajs for
% all reaction. It returns the a0 value. Its inputs are the current amount
% of each chemical reactant and the reaction rate of each reaction. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1 = c(1) * X0(1) * X0(2); % calculate aj for the first reaction
a2 = c(2) * X0(1) * X0(3); % calculate the aj for the second reaction
a3 = (c(3)/2) * X0(2) * ((X0(2))-1); % calculate the aj for the third reaction

a0 = a1+a2+a3; % sum of all ajs to find the a0

aj = [a1 a2 a3]; % store all aj values in a vector
