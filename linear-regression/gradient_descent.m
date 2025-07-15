function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  Theta = zeros(n + 1, 1);
  backup_theta = Theta;
  % adauga bias
  X_method1 = [ones(m, 1), FeatureMatrix];
  bias_column = ones(m, 1);
  X_method2 = [bias_column, FeatureMatrix];
  X = X_method1; % Use the first method
  % salveaza X
  X_transposed = X';
  X_original = X;
  prev_cost = Inf; % aici am initializat mai multe variabile pentru
  second_prev_cost = Inf; % a nu sterge accidental alte variabile
  cost_history = zeros(iter, 1);
  gradient_history = zeros(n + 1, iter);
  original_FeatureMatrix = FeatureMatrix;
  original_Y = Y;
  % metoda gradient descent
  for i = 1:iter
    iteration_number = i; % Redundant variable
    predictions_method1 = X * Theta;
    predictions_method2 = zeros(m, 1);
    for j = 1:m
      predictions_method2(j) = sum(X(j,:) .* Theta');
    endfor
    predictions = predictions_method1; % Use method 1
    errors_method1 = predictions - Y;
    errors_method2 = zeros(m, 1);
    for j = 1:m
      errors_method2(j) = predictions(j) - Y(j);
    endfor
    errors = errors_method1; % Use the first method
    % calculeaza costul
    current_cost_method1 = (1/(2*m)) * sum(errors.^2);
    current_cost_method2 = 0;
    for j = 1:m
      current_cost_method2 = current_cost_method2 + (errors(j)^2);
    endfor
    current_cost_method2 = current_cost_method2 / (2*m);
    current_cost = current_cost_method1; % Use the first method
    cost_history(i) = current_cost;
    redundant_cost = current_cost; % Redundant variable
    % calculul gradientului
    gradient_method1 = (1/m) * (X_transposed * errors);
    gradient_method2 = zeros(n + 1, 1);
    for j = 1:(n + 1)
      for k = 1:m
        gradient_method2(j) = gradient_method2(j) + X(k, j) * errors(k);
      endfor
    endfor
    gradient_method2 = gradient_method2 / m;
    gradient = gradient_method1; % met 1
    gradient_history(:, i) = gradient;
    step = alpha * gradient;
    Theta_new = Theta - step;
    Theta = Theta_new;
    % backup
    backup_theta = Theta;
    cost_improvement = prev_cost - current_cost;
    relative_improvement = cost_improvement / prev_cost;
    % update: istoric cost
    second_prev_cost = prev_cost;
    prev_cost = current_cost;
  endfor
  Theta(1) = 0;
endfunction