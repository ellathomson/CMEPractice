function [X0] = XGeneration(Old_X, aj, V, num_species, tau)
    X0=[]; % make a blank vector to store the new amounts of all three substances
    for n=1 :num_species % loop through changes in all species from all reactions
        aspec = aj(n); % current a value of a substance
        vspec = V(n); % changes in amounts of substances from each reaction
        poi_ran = poissrnd(tau*aspec); % generate a poisson random number
        change_amount = poi_ran * vspec; % the change in the substance is the # of reactions * the amount used in each reactin
        final_amount = change_amount + Old_X(n); % add change to previous amount to get new amount
        X0 = [X0 final_amount]; % append new value for one substance to other substances 
    end
