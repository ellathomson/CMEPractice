function [times_cell] = generate_random_times_n (num_robots)

times_cell = {}; % set up an empty cell to store vectors of times for all robots
n1 = 0; % initial time for all robots
times_vector = zeros(1,1); % set up a vector to store times for one robot

for k = 1: num_robots % loop through times for all robots 
    while n1 <=30 % ensure time is less than maximum time
        ran_num = rand; % random number to represent change in time
        n1 = n1+ran_num; % add random number to previous time to retrieve new time
        times_vector = [times_vector n1]; % add new time value to vector of time values
    end
    times_cell{k} = times_vector; % add vector of time values for one robot as a new element to the cell
    n1 = 0; % clear the initial time point for a new robot
    times_vector = zeros(1,1); % clear the vector of times for a new robot 
end
