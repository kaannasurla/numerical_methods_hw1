function [matrix] = initialize_weights(L_prev, L_next)
  epsilon = sqrt(6) / sqrt(L_prev + L_next);
  random_values = rand(L_next, L_prev + 1); % genereaza valori aleatoare intre 0 si 1
  simetric_values = random_values - 0.5; # transforma valorile in intervalul [-0.5, 0.5]
  matrix = 2 * epsilon * simetric_values; % scaleaza valorile in intervalul [-epsilon, epsilon]
endfunction