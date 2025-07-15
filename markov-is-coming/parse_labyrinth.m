function Labyrinth = parse_labyrinth(file_path)
  Labyrinth = []; % nitializare
  file = fopen(file_path, 'r');
  if file == -1
    error('Could not open file: %s', file_path);
    return;
  endif

  try
    rows = fscanf(file, '%d', 1);
    if isempty(rows)
      error('No rows.');
      fclose(file);
      return;
    endif

    cols = fscanf(file, '%d', 1);
    if isempty(cols)
      error('No columns.');
      fclose(file);
      return;
    end

    labyrinth_data = zeros(rows, cols);
    row_index = 1;
    while row_index <= rows
      col_index = 1;
      while col_index <= cols
        value = fscanf(file, '%d', 1);
        if isempty(value)
          if row_index <= rows && col_index <= cols
            error('Error.');
          end
          break; % Break out of the inner while loop
        end
        labyrinth_data(row_index, col_index) = value;
        col_index = col_index + 1;
      end
      if col_index <= cols && row_index <= rows
        break; % Break out of the outer while loop if inner loop broke prematurely
      end
      row_index = row_index + 1;
    end
    Labyrinth = labyrinth_data;

  catch ME
    error('Error reading or parsing the labyrinth file: %s', ME.message);
  end

  fclose(file);
end