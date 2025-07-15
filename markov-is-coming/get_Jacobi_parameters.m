function [G, c] = get_Jacobi_parameters(Link)
  if ~ismatrix(Link)
    error('Link isnt matrix');
  endif

  n = size(Link, 1) - 2;
  if size(Link, 2) < n + 2
    error('Input Link must have at least %d columns', n + 1);
  endif
    
  % Extrage G si c cu submatrix indexing
  G = Link(1:n, 1:n);
  c = Link(1:n, n+1);
endfunction