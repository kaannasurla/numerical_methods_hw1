function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
    Error = 0;
    if size(Y, 1) ~= size(FeatureMatrix, 1)
        error('Dimension error');
    endif
    m = size(Y, 1);
    n = size(FeatureMatrix, 2);
    if m == 0 || n == 0
        error('Empty inputs');
    endif
    Weights = Theta(2:end);
    for i = 1:m
        features_row = FeatureMatrix(i, :);
        prediction = 0;
        for j = 1:n
            prediction = prediction + features_row(j) * Weights(j);
        end
        difference = prediction - Y(i); % calcularea erorii patratice
        squared_error = difference * difference;
        Error = Error + squared_error;
    end
    Error = Error / (2 * m);
    if isnan(Error) || isinf(Error)
        warning('Check your input data for extreme values.');
    end
end