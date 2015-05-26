function [new_x1,new_y1] = movement_time_n(temp_paramx, temp_paramy, robot_num)
% Governs the movement of the robot by calculating the amount that a robot
% will move in the x and y directions

% fill in formulas for desired random distribution 

% I tested the random number distribution in rand_distribution_test and the
% spread of the numbers are different than the simple random distribtuion.
% However iI don't know how to test for the difference in the "practice
% walk" program, since the average values are staying the same. 

switch robot_num
    case 1
        ranx = (-1/10) * log(rand);
    case 2
        ranx = (-1/10)*log(rand);
    case 3
        ranx = (-1/10) * log(rand);
    case 4
        ranx = (-1/10)*log(rand);
    case 5
        ranx = (-1/10) * log(rand);
    case 6
        ranx = (-1/10) * log(rand);
    case 7
        ranx = (-1/10) * log(rand);
    case 8
        ranx = (-1/10) * log(rand);
end

 switch robot_num
    case 1
        rany = (-1/10) * log(rand);
    case 2
        rany = (-1/10) * log(rand);
    case 3
        rany = (-1/10) * log(rand);
    case 4
        rany = (-1/10) * log(rand);
    case 5
        rany = (-1/10) * log(rand);
    case 6
        rany = (-1/10) * log(rand);
    case 7
        rany = (-1/10) * log(rand);
    case 8
        rany = (-1/10) * log(rand); 
 end
% convert the random numbers for the movement to whole numbers between -50 and 50 
move_x1 = round((100* ranx)-50);
move_y1 = round((100*rany)-50);

% if the movement is more than 50 units, it will be changed to 50 units 
move_x1(move_x1<-50) = -50;
move_x1(move_x1>50) = 50;
move_y1(move_y1<-50) = -50;
move_y1 (move_y1 >50) = 50;


%change the location of the robot1 to incorporate change in location
new_x1 = temp_paramx + move_x1;
new_y1= temp_paramy + move_y1;


%check if the robots will go outside the boudaries. If a robot is out of
%boudaires by x units, it will be moved inside the boundaries by a distance
%of x units. 
if new_x1<0
        new_x1 = -new_x1;
end
if new_y1<0
        new_y1 = -new_y1;
end
if new_x1>100
        new_x1 = 100-(new_x1-100);
end
if new_y1>100
        new_y1 = 100-(new_y1-100);
end

