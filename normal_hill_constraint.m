function [c, ceq] = normal_hill_constraint(x)
    alpha = 0.2;
    beta = 20;
    lambda_t = 2*pi/3;
    
    lambda_k = x(1);
    e_k = x(5);
    
    c = (alpha * exp(-beta*((lambda_k - lambda_t)^2))) - e_k;
    ceq = [];
end