function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
  # Caclulez procentul
  m = size(X,1);
  partial = round(m * percent);
  # Amestec indicii
  indice_random = randperm(m);
  
  # Caclulez X si y train si test in functie de X si y amestecati
  y_amestecat = y(indice_random);
  X_amestecat = X(indice_random,:);
  y_train = y_amestecat(1 : partial);
  X_train = X_amestecat(1 : partial, :);
  y_test = y_amestecat(partial + 1:end);
  X_test = X_amestecat(partial + 1:end,:);
endfunction