function [J, grad] = cost_function(params, X, y, lambda, input_layer_size, hidden_layer_size, output_layer_size)
    % Extract Theta1 and Theta2 using alternative indexing
    Theta1 = reshape(params(1:hidden_layer_size*(input_layer_size + 1)), ...
                    hidden_layer_size, input_layer_size + 1);
    
    remaining_params = params(hidden_layer_size*(input_layer_size + 1)+1 : end);
    Theta2 = reshape(remaining_params, output_layer_size, hidden_layer_size + 1);
    
    m = size(X, 1);
    
    % Convert y to one-hot encoding
    Y = zeros(m, output_layer_size);
    for i = 1:m
        Y(i, y(i)) = 1;
    end
    
    % Forward propagation (reorganized)
    % Layer 1 (input)
    a1 = [ones(m, 1), X];
    
    % Layer 2 (hidden)
    z2 = a1 * Theta1';
    a2_sigmoid = 1 ./ (1 + exp(-z2)); 
    a2 = [ones(m, 1), a2_sigmoid];
    
    % Layer 3 (output)
    z3 = a2 * Theta2';
    h = 1 ./ (1 + exp(-z3));  % Output probabilities
    
    % Regularization terms
    Theta1_no_bias = Theta1(:, 2:end);
    Theta2_no_bias = Theta2(:, 2:end);
    reg_term = (lambda/(2*m)) * (sum(Theta1_no_bias(:).^2) + sum(Theta2_no_bias(:).^2));
    
    % Cost function
    log_h = log(h);
    log_1h = log(1 - h);
    J_unreg = (-1/m) * sum(sum(Y .* log_h + (1 - Y) .* log_1h));
    J = J_unreg + reg_term;
    
    % Backpropagation 
    % Output layer error
    delta3 = h - Y;
    
    % Hidden layer error 
    sigmoid_grad = a2_sigmoid .* (1 - a2_sigmoid);
    delta2 = (delta3 * Theta2(:, 2:end)) .* sigmoid_grad;
    
    % Gradients 
    Theta1_grad = (delta2' * a1) / m;
    Theta2_grad = (delta3' * a2) / m;
    
    % Add regularization 
    Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + (lambda/m) * Theta1_no_bias;
    Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + (lambda/m) * Theta2_no_bias;
    
    % Unroll gradients 
    grad = [Theta1_grad(:); Theta2_grad(:)];
end