model = sbiomodel('Validation Model')

%add reactions to model
r1 = addreaction(model, 'x1 + x2 -> y')
r2 = addreaction(model, 'x1 + y -> x2')
r3 = addreaction(model, 'x2 + x2 -> x1')

%denote the kinetic law for each reaction
kl1 = addkineticlaw(r1, 'MassAction');
kl2 = addkineticlaw(r2, 'MassAction');
kl3 = addkineticlaw(r3, 'MassAction');

%add rate constants for each reaction
p1  = addparameter(kl1, 'c1',  'Value', 2);
p2 = addparameter(kl2, 'c2', 'Value', 1);
p3 = addparameter(kl3, 'c3', 'Value', 2);

%name the parameters
kl1.ParameterVariableNames = {'c1'};
kl2.ParameterVariableNames = {'c2'};
kl3.ParameterVariableNames = {'c3'};

%set the initial amount of each species
model.species(1).InitialAmount = 40;    % x1
model.species(2).InitialAmount = 40;         % x2
model.species(3).InitialAmount = 20;         % y

%% Plot using SSA

%get the active configuration set for the model
cs = getconfigset(model,'active');

%extract model from cs and set stop time
cs.SolverType = 'ssa';
cs.StopTime = 0.1;
solver = cs.SolverOptions;
solver.LogDecimation = 10;
cs.CompileOptions.DimensionalAnalysis = false;
[t_ssa, x_ssa] = sbiosimulate(model);

%begin plotting the reactions for the SSA
figure(1)
h1 = subplot(2,1,1);
plot(h1, t_ssa, x_ssa(:,1),'.');
h2 = subplot(2,1,2);
plot(h2, t_ssa, x_ssa(:,2:3),'.');
grid(h1,'on');
grid(h2,'on');
title(h1,'Validation Model');
ylabel(h1,'Amount of x1');
ylabel(h2,'Amount of x2 & y');
xlabel(h2,'Time');
legend(h2, 'x2', 'y');
%% Plot using Tau-Leaping

cs.StopTime = 0.1;
cs.SolverType = 'explTau';
solver = cs.SolverOptions;
solver.LogDecimation = 10;
[t_etl, x_etl] = sbiosimulate(model);

hold(h1,'on');
hold(h2,'on');
plot(h1, t_etl, x_etl(:,1),'o','LineWidth',4);
plot(h2, t_etl, x_etl(:,2:3),'o','LineWidth',4);
legend(h2, 'x2 (SSA)', 'y (SSA)', 'x2 (Exp. Tau)', 'y (Exp. Tau)');
hold(h1,'off');
hold(h2,'off');