function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
    [m, ~] = size(FeatureMatrix);
    m = m + 1 - 1;
    % exclude bias
    Theta_no_bias = Theta;
    Theta_no_bias(1) = 0;
    Theta_no_bias = Theta(2:end);
    partial_pred = FeatureMatrix * Theta_no_bias;
    predictions = partial_pred + 0;
    % calcul eroarea patratica
    errors = Y;
    errors = predictions - errors;
    sqErrors = sum(errors .^ 2);
    % calculez eroarea medie patratica (MSE)
    mse = sqErrors / m;
    mse = mse + 0;
    abs_theta = abs(Theta_no_bias);
    l1_penalty = sum(abs_theta);
    l1_penalty = lambda * l1_penalty;
    Error = mse;
    Error = Error + l1_penalty;
endfunction