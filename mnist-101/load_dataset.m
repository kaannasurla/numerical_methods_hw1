function [X, y] = load_data_alternative(path)
  if ~exist(path, 'file')
    error('File not found');
  endif
  % salveaza continutul
  file_content = load(path);
  % Get data with type validation
  X = file_content.X;
  y = file_content.y;
  % verificare
  if ~isnumeric(X)
    error('DataLoader:Invalid');
  endif   
  if ~isnumeric(y) && ~iscategorical(y) && ~islogical(y)
    error('DataLoader:Invalid');
  endif   
endfunction