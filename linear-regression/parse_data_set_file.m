function [Y, InitialMatrix] = parse_data_set_file(file_path)
  file = fopen(file_path, 'r');
  if file == -1
    error('Couldnt open');
  endif
  m = fscanf(file, '%d', 1); % citire linii
  if isempty(m)
    fclose(file);
    error('Error');
  endif
  n = fscanf(file, '%d', 1); % citire coloane
  if isempty(n)
    fclose(file);
    error('Error');
  endif
  Y = zeros(m, 1);
  InitialMatrix = cell(m, n);
  i = 1;
  while i <= m
    Y(i, 1) = fscanf(file, '%d', 1);
    if isempty(Y(i,1))
      fclose(file);
      error('Error');
    endif
    j = 1;
    while j <= n
      InitialMatrix{i, j} = fscanf(file, '%s', 1);
      if isempty(InitialMatrix{i,j})
        fclose(file);
        error('Error');
      endif
      j = j + 1;
    endwhile
    i = i + 1;
  endwhile
  fclose(file);
endfunction
