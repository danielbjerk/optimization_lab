function [c, ceq] = normal_hill_constraint(x)
    N = 40;
    mx = 6;
    mu = 2;
    
    alpha = 0.2;
    beta = 20;
    lambda_t = 2*pi/3;
    
    c = zeros(N,1);
    
    for i = 1:N
        lambda_k = x(1 + (i-1)*mx);
        e_k = x(5 + (i-1)*mx);
        c(i) = (alpha * exp(-beta*((lambda_k - lambda_t)^2))) - e_k;
    end
    
    ceq = [];
end