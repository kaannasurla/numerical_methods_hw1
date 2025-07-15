function [x, err, steps] = perform_iterative (G, c, x0, tol, max_steps)
  n=size(G,1);
  x=x0;
  err=1;
  steps=0;
  for i = 1:max_steps %  incep iteratia cu un numar maxim de max_steps pasi
    old_x = x;
    x = G * x + c;
    err = norm(x - old_x);
    steps = i;
    if err < tol
      break;
    endif
  endfor
 endfunction