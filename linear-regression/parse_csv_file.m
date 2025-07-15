function [Y, InitialMatrix] = parse_csv_file(file_path)
  if ~exist(file_path, 'file')
    error('File doesnt exists');
  endif
  fid = fopen(file_path, 'rt');
  if fid < 0
    error('Cant open file');
  endif

  % citeste header si parseaza liniile
  header = fgetl(fid);
  headers = strsplit(header, ',');
  num_columns = length(headers);

  % citire
  raw_data = textscan(fid, '%s', 'Delimiter', ',');
  raw_data = raw_data{1};
    
  % calculeaza nr de randuri cu info
  total_elements = length(raw_data);
  num_rows = total_elements / num_columns;

  % verif daca data e completa
  if mod(total_elements, num_columns) ~= 0
    warning('Data incomplete');
  endif
  
  Y = zeros(num_rows, 1);
  InitialMatrix = cell(num_rows, num_columns - 1);

  % prelucrare linie cu linie si rand cu rand
  for row = 1:num_rows
    base_idx = (row - 1) * num_columns;
    Y(row) = str2double(raw_data{base_idx + 1});
    % coloanele ramase -> InitialMatrix
    for col = 2:num_columns
      InitialMatrix{row, col - 1} = raw_data{base_idx + col};
    endfor
  endfor
  fclose(fid);
endfunction