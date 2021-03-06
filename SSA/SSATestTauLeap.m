close all
clear all
clc
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Programmed by: Ella Thomson
% Tracks the changes in amounts of three chemical reactants involved in
% three chemical reactions. The reactions occur at randomly distributed
% times. The program plots the quantities of all three substances vs time.
% It produces two plots; one figure with each substance on its own plot,
% and one figure with all three substances on the same plot.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Notes: The whole program takes approcimately 45-55 seconds to run 4
% simulations up to 0.05 seconds each

prompt = 'How many simulations would you like to run?';
num_sims = input(prompt);

prompt = 'What is the maximum time? (less than 0.07 seconds)';
max_rx = input(prompt) ;

for n = 1:num_sims
    % asks the user how many reactions they want to track
    
    go_ahead = 1; % will be tested to determine whether to plot
    count = 0;
    
    % call intialize parameters to define ititial time and concentrations
    [time, times, X0, X, num_rx, c, V, num_species] = InitializeParameters ();
    
    
    while count <max_rx;
        %[aj, a0] = AGeneration(X0, c); % calculate the current aj's and a0
        
%         calc_L(X0);
        
        [tau] = TauLeapVectorized (num_species,num_rx,V, X0); % calculate tau
        
        time = time + tau; % find new time by adding tau to previous time
        times = [times time]; % add new time to list of times
        
        [aj, a0] = AGeneration(X0, c); % generate new aj and a0 values
        
        [X0] = XGeneration(X0, aj, V, num_species, tau); % generate new amounts of substances for all species
        
        X = [X; X0]; % store all X values in a matrix
        
        count = time; % increment number of reactions
        

        
        %if ((X0(1)==0) || (X0(2)==0) || (X0(3)==0)) % check if any substances are depleted
        %   count = max_rx + 1; % will stop the while loop from running again
        %  go_ahead = 0; % will stop plotting
        % disp('Ran Out of A Reactant') % lets user know a substance has run out
        % end
        
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The below code is for plotting, which only occurs is no substances have
    % run out during the preset number of reactions.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    symbols = {'*-','o-','h-','p-','.-','x-','s-','d-','>-','^-','<-','+-'};
%     colours = ['y','m','r','b','g','c','k'];
    
    if go_ahead ==1 % check if plotting will occur
        figure(1)
        
        % first plot displays x1 amount vs time
        subplot(3,1,1)
        plot(times, X(:,1), symbols{ceil(length(symbols)*rand)},'color',...
            'b','markersize',12)
        title('X1 Amount vs Time')
        xlabel('Time')
        ylabel('X1 Amount')
        hold on
        
        % second plot displays x2 amount vs time
        subplot(3,1,2)
        plot(times, X(:,2),symbols{ceil(length(symbols)*rand)},'color',...
            'r','markersize',12)
        title('X2 Amount vs Time')
        xlabel ('Time')
        ylabel('X2 Amount')
        hold on
        
        % third plot displays y amount vs time
        subplot(3,1,3)
        plot(times,X(:,3), symbols{ceil(length(symbols)*rand)},'color',...
            'g','markersize',12)
        title('Y Amount vs Time')
        xlabel('Time')
        ylabel('Y Amount')
        hold on

    end
end
toc
