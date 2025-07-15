function [decoded_path] = decode_path(path, lines, cols)
  decoded_path = zeros(length(path) - 1, 2);
  i = 1;
  while i <= length(path) - 1 % calculul pentru linie si coloana
    decoded_path(i, 1) = (path(i) + cols - 1 - mod(path(i) + cols - 1, cols)) / cols;
    decoded_path(i, 2) = mod(path(i) - 1, cols) + 1;
    i = i + 1;
  endwhile
endfunction