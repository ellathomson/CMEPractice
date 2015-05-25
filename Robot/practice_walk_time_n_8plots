function practice_walk_time_n_8plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% By: Chris Cadonic and Ella Thomson
% N number of robots moving in a confined area according to random time
% distribution. Plot the current location of all robots in a fixed time
% range. Using a random distrubtion. Program can be used with several
% random number distributions, updated in the movement_time function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sets the number of robots and the number of time points to be evaluated
% (minimum=1, maximum = 8). The maximum value can be changed by extending
% plot_types and titles
num_robots = 8;

% define the maximum time constraint of the problem
max_time = 30;

% generate random times for all robots
[times_cell] = generate_random_times_n (num_robots);

%parameters = setup; % create parameters structure
save parameters % save parameters for viewing

% define symbols to plot robots on graph 
plot_types = {'ro', 'bh', 'k^', 'yx', 'm+', 'cd', 'g*', 'yp'};

% define titles for all subplots 
titles = {'Robot 1 Movement', 'Robot 2 Movement', 'Robot 3 Movement', ...
    'Robot 4 Movement', 'Robot 5 Movement', 'Robot 6 Movement', ...
    'Robot 7 Movement', 'Robot 8 Movement' };

% defines the number of rows of subplots. There will be two subplots per
% row, so the required number of rows is half the number of robots
numrows= round(num_robots/2); 

% vector to store current x values of all robots
store_xs = ones(1, num_robots);

% vector to store current y values of all robots
store_ys = ones(1, num_robots); 

% vector to store average x values at all time points
overall_average_x = ones(1, 60);

% vector to store average y values at all time points 
overall_average_y = ones(1, 60); 

% Find all x and y values at each time point for all robots
x_positions = {}; % will store all x positions for all robots
y_positions = {}; % will store all y positions for all robots 
for n = 1:num_robots % loop through all robots
    xs_int = [50]; % starting x value for all robots. Minimum = 0, Maximum = 100
    ys_int = [50]; % starting y value for all robots. Minimum = 0, Maximum = 100
    times = times_cell{n}; % retrieve the time values for one robot
    size = length(times); % find the number of time points
    for l = 2:size  % loop through all time points for a robot
        temp_paramx = xs_int(l-1); % retrieve previous x coordinate
        temp_paramy = ys_int(l-1); % retrieve previous y coordinate
        
        % get new x and y coordinate
        [path_x,path_y] = movement_time_n(temp_paramx, temp_paramy, n);
        
        xs_int = [xs_int path_x]; % add x coordinate to temporary vector
        ys_int = [ys_int path_y]; % add y coordinate to temporary vector
    end
    x_positions{n} = xs_int; % add all x values (as a vector) for one robot to x position cell
    y_positions{n} = ys_int; % add all y values (as a vector) for one robot to y position cell 
end

av_xs = {};
av_ys = {};

for r = 1:num_robots % loop to calculate first 4 moving x and y averages
    rob_av_x = []; % blank vector to store average x values of one robot
    rob_av_y = []; % blank vector to store average y values of one robot
    all_xs = x_positions{r}; % Retrieve the x positions of one robot
    all_ys = y_positions{r}; % retrieve the y positions of one robot
    % for the first four n values, use all the known values
    for j = 1:4 
        b=j;
        xvals_to_av = [];% start a blank vector to store all known x/ y values
        yvals_to_av = [];
        while b >=1 % loop throuh and store all known x and y values
            newx = all_xs(b);
            newy = all_ys(b);
            xvals_to_av = [xvals_to_av newx]; 
            yvals_to_av = [yvals_to_av newy];
            b=b-1;
        end
        x_mean = mean(xvals_to_av); % take average of all known x values
        y_mean = mean(yvals_to_av); % take average of all known y values
        rob_av_x = [rob_av_x x_mean];
        rob_av_y = [rob_av_y y_mean];
    end
    av_xs{r} = rob_av_x; % store current vectors of average x values
    av_ys{r} = rob_av_y; % store current vectors of average y values 
end
    
for s = 1:num_robots % loop to calculate 5 to final moving averages 
    rob_av_x = av_xs{s}; % retrieve the known average x values
    rob_av_y = av_ys{s}; % retrieve theknown average y values
    all_xs = x_positions{s}; % retrieve all x positions
    all_ys = y_positions{s}; % retrieve all y positions
    max_xy = length(all_xs); % find the number of x/ y positions
    for u = 5:max_xy % moving averages for fifth to last x/y positions
        xs_included = [all_xs(u) all_xs(u-1) all_xs(u-2) all_xs(u-3)...
            all_xs(u-4)]; % store 5 previous x values in a vector
        ys_included = [all_ys(u) all_ys(u-1) all_ys(u-2) all_ys(u-3) ...
            all_ys(u-4)]; % store 5 previous y values in a vector
        x_mean = mean(xs_included); % find mean of 5 previous x values
        y_mean = mean(ys_included); % find mean of 5 previous y values
        rob_av_x = [rob_av_x x_mean]; % append new moving x average
        rob_av_y = [rob_av_y y_mean]; % append new moving y average 
    end
    av_xs{s} = rob_av_x; % store vector of moving x averages for one robot
    av_ys{s} = rob_av_y; % sotre vector of moving y averages for one robot 
end

matrixes_to_combine = {}; % make a blank cell to store the t, y and x values for all robots
for q = 1:num_robots % makes a matrix of x, y and t for each robot and stores them in a cell
    temp_matrix = [times_cell{q}]; % start with a row of all times
    temp_matrix = [temp_matrix; x_positions{q}]; % add a row of all x positions
    temp_matrix = [temp_matrix; y_positions{q}]; % add a row of all y positions
    matrixes_to_combine{q} = temp_matrix; % store matrix for one robot in a cell
end

all_t_x_y = matrixes_to_combine{1};% start a matrix with t x and y for one robot

for a = 2:num_robots % combines matrixes for each robot into one matrix
    new_mat = matrixes_to_combine{a};
    all_t_x_y = horzcat(all_t_x_y, new_mat);
end 

[~,b] = sort(all_t_x_y(1,:));
sorted = all_t_x_y(:,b);

ints_to_delete = find(diff(sorted(1,:))==0);


num_delete = length(ints_to_delete);


for b = num_delete:-1:1
    index_del = ints_to_delete(b);
    sorted (:,index_del) = [];
end
 
    
%disp(sorted) 

figure(1) % set up a figure to plot the paths of both robots over time
% plot x and y values for all robots at all time points 
for i=0.5:0.5:max_time % loop through the time range at set intervals
  
    for j = 1: num_robots % loop through all robots at a time point
        
        % retrieve all times for one robot
        times_row = times_cell{j};
    
        % find the maximum time value still within constraint
        update_t1 = max(times_row(times_row <= i));
    
        % get the index of the maximum time
        c1 = find(times_row==update_t1);
        
        % retrieve the x and y coordinates for one robot
        x_row = x_positions{j};
        y_row = y_positions{j};
        
        % find the x and y vales with the same index as the 'max time' 
        x_to_plot = x_row(c1);
        y_to_plot = y_row(c1);
        
        % store the x value of one robot 
        store_xs(j) = x_to_plot;
        
        % store the y value of one robot 
        store_ys(j) = y_to_plot; 
        
        grid on
        
        % fixed range of x and y values for the x axis
        axis([0 100 0 100])
        
        % formatting of axes and axes labels
        set(gca, 'FontSize', 10) 
        xlabel('X Position') % x label is the same for all plots
        ylabel('Y Position') % y label is the same for all plots 
        
        % plot the current x and y coordinates of each robot at one
        
        % selects the correct subplot for each robot (subplot n) 
        subplot(numrows,2,j) 
        
        % plot the updated x and y coordinates of one robot
        plot(x_to_plot, y_to_plot, plot_types{j}, 'MarkerSize', 14, 'LineWidth', 4)
        
        % formatting the title of the graph. Chooses the nth title from the
        % titles cell
        title (titles{j}, 'FontSize', 16)
        grid on
        
        % fixed range of x and y values for the x axis
        axis([0 100 0 100])
        
        
    end
    hold off % clear graph after each time point 
    
    % find the average x value of all robots at one time point 
    average_x = mean(store_xs);
    
    % find the averag y value of all robots at one time point 
    average_y = mean(store_ys);
    
    
    % store the average x value at one time point
    overall_average_x(2*i) = average_x;
    
    % store the average y value at one time point 
    overall_average_y(2*i) = average_y; 
   
     
    % The pause time needs to be updated if the criteria for changing the x
    % and y positions is changed. They need to be the same so that the plot
    % updating time matches the time points for the successive x and y values 
    pause(0.5)   
end

x_titles = {'Robot 1 X vs T', 'Robot 2 X vs T', 'Robot 3 X vs T',...
    'Robot 4 X vs T', 'Robot 5 X vs T', 'Robot 6 X vs T',...
    'Robot 7 X vs T', 'Robot 8 X vs T'};
figure (2)
for n = 1:num_robots % loop to make plots of x position vs t for each robot
     axis([0 30 0 100])   
     % formatting of axes and axes labels
     set(gca, 'FontSize', 10) 
     xlabel('Time') % x label is the same for all plots
     ylabel('X Position') % y label is the same for all plots 
        
        
     % selects the correct subplot for each robot (subplot n) 
     subplot(numrows,2,n) 
        
     % plot the updated x and y coordinates of one robot
     plot(times_cell{n}, x_positions{n})
     hold on
     
     avs_x = av_xs{n};
     plot(times_cell{n}, avs_x, 'r') 
        
     % formatting the title of the graph. Chooses the nth title from the
     % titles cell
     title (x_titles{n}, 'FontSize', 16)
     %grid on 
     axis([0 30 0 100])
     %legend ('Actual X Value', 'Moving Average X Value') 
    
end
 
y_titles = {'Robot 1 Y vs T', 'Robot 2 Y vs T', 'Robot 3 Y vs T',...
    'Robot 4 Y vs T', 'Robot 5 Y vs T', 'Robot 6 Y vs T',...
    'Robot 7 Y vs T', 'Robot 8 Y vs T'};

figure (3)
for m = 1:num_robots % loop to make plots of y position vs t for each robot
     axis([0 30 0 100])   
     % formatting of axes and axes labels
     set(gca, 'FontSize', 10) 
     xlabel('Time') % x label is the same for all plots
     ylabel('Y Position') % y label is the same for all plots 
        
        
     % selects the correct subplot for each robot (subplot n) 
     subplot(numrows,2,m) 
        
     % plot the updated x and y coordinates of one robot
     plot(times_cell{m}, y_positions{m})
     
     hold on
     
     avs_y = av_ys{m};
     plot(times_cell{m}, avs_y, 'r')
     % formatting the title of the graph. Chooses the nth title from the
     % titles cell
     title (y_titles{m}, 'FontSize', 16)
     %grid on 
     axis([0 30 0 100]) 
    
end

figure (4) 
all_times = sorted(1,:);
all_x = sorted(2,:);
plot(all_times,all_x)
title('X Values vs Time')
xlabel('Time')
ylabel('X Location')

figure(5)
all_times = sorted(1,:);
all_y = sorted(3,:);
plot(all_times,all_y)
title('Y Values vs Time')
xlabel('Time')
ylabel('Y Location')


%function parameters=setup
% define the number of robots 
%

%create the grid on which robot(s) can move
%parameters.exactgrid = zeros(100);
%parameters.displaygrid = zeros(10);



