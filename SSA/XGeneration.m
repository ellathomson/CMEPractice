function X_new = XGeneration(Old_X, aj, V, num_rx, tau)
    X_new=Old_X; % make a blank vector to store the new amounts of all three substances
    for n=1 :num_rx % loop through changes in all species from all reactions
        arx = aj(n); % current a value of a substance
        vrx = V(n,:); % changes in amounts of substances from each reaction
        poi_ran = poissrnd(tau*arx); % generate a poisson random number
        change_amount = poi_ran * vrx; % the change in the substance is the # of reactions * the amount used in each reactin
        X_new = X_new + change_amount; % add change to previous amount to get new amount
    end
    
   