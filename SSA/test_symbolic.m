clear all

numSpecies = 3;
numReactions = 3;

epsilon = 0.5;

species1 = 1000; %x1
species2 = 1000; %x2
species3 = 100; %y

syms x1;
syms x2;
syms y;
c1 = 2;
c2 = 1;
c3 = 2;
nummat = zeros(numSpecies,numReactions);
changes = [-1, -1, +1;-1,1,-2;1,-1,0];
deriv={};

syms f(x1,x2,y); %a for reaction 1
syms g(x1,x2,y); %a for reaction 2
syms h(x1,x2,y); %a for reaction 3

f(x1,x2,y) = c1*x1*x2;
g(x1,x2,y) = c2*x1*y;
h(x1,x2,y) = (1/2)*c3*(x2*(x2-1));

all_species = [x1,x2,y];
rxn = {f,g,h};
all_rxns = [f,g,h];
a_0 = single(sum(all_rxns(species1,species2,species3)));

for j_prime = 1:numReactions %calculate f
    rxn_prime_func = rxn{j_prime};
    for j = 1:numReactions
        rxn_func = rxn{j}; % pick the j-th reaction
        
        for i = 1:numSpecies
            %first calc deriv, then evaluate
            func(x1,x2,y) = diff(rxn_func,all_species(i));
            nummat(i,j) = func(species1,species2,species3)*changes(i,j_prime);
            
            %just store the calculated deriv
            deriv{i,j} = diff(rxn_func,all_species(i));
            
        end
        all_f(j,j_prime) = sum(nummat(:,j));
    end
end

for j=1:numReactions %calculate mean and sigma
    all_means(j) = sum(all_f(j,:).*single(all_rxns(species1,species2,species3)));
    all_variances(j) = sum((all_f(j,:).^2).*single(all_rxns(species1,species2,species3)));
    
    first_term(j) = (epsilon*a_0)/(abs(all_means(j)));
    second_term(j) = ((epsilon*a_0)^2)/all_variances(j);
    
    minima(j) = min(first_term(j),second_term(j));
end

tau = min(minima)