function [Error] = ridge_regression_cost_function (Theta, Y, FeatureMatrix, lambda)
  m = length(Y);
  num_features = size(FeatureMatrix, 2);
  if (length(Theta) - 1) ~= num_features
    error('Dimensiunea lui Theta nu corespunde');
    return;
  endif
  % calculeaza predictiile modelului Ridge Regression
  % presupun ca primul element din Theta este termenul bias
  predictions = FeatureMatrix * Theta(2:end) + Theta(1);
  % calculeaza eroarea pătratica medie (MSE) intre predictii si valorile reale
  squared_error = (predictions - Y) .^ 2;
  mse = sum(squared_error) / (2 * m);
  % calculeaza termenul de penalizare L2
  % exclud termenul de bias din penalizare
  l2_penalty = lambda * sum(Theta(2:end) .^ 2);
  % eroarea totala a funcției de cost Ridge Regression este suma dintre MSE si penalizarea L2.
  Error = mse + l2_penalty;
  % Verificare finală (opțională) dacă eroarea calculată este numeric validă.
  if ~isreal(Error)
    warning('Eroare de cost invalid');
  endif
endfunction