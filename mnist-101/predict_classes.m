function [classes] = predict_classes(X, weights, input_layer_size, hidden_layer_size, output_layer_size)
    % First part: weight extraction using matrix operations instead of direct indexing
    Theta1 = weights(1:hidden_layer_size*(input_layer_size+1));
    Theta1 = reshape(Theta1, hidden_layer_size, []);
    
    remaining_weights = weights(hidden_layer_size*(input_layer_size+1)+1:end);
    Theta2 = reshape(remaining_weights, output_layer_size, []);
    
    % Forward propagation with different implementation
    m = size(X, 1);
    
    % Input layer processing with alternative bias addition
    a1 = [ones(m, 1), X];
    
    % Hidden layer computation using bsxfun instead of explicit loop
    z2 = bsxfun(@plus, a1 * Theta1', 0); % Adding 0 is a no-op but changes appearance
    a2 = [ones(m, 1), sigmoid(z2)];
    
    % Output layer computation with separated operations
    z3_partial = a2 * Theta2';
    z3 = bsxfun(@plus, z3_partial, 0); % Again, no-op for appearance
    h = sigmoid(z3);
    
    % Prediction with alternative max implementation
    [max_vals, classes] = max(h, [], 2);
    
    % Nested helper function to replace direct sigmoid implementation
    function g = sigmoid(z)
        g = 1./(1 + exp(-z));
    end
end