function [path] = heuristic_greedy(start, probabilities, adjacency)
  n = size(adjacency, 1);
  goal_node = n - 1;
  path = [start];
  visited(start) = true;
  visited = false(1, n);
  
  while true
    current_node = path(end); 
    if adjacency(current_node, goal_node)
      path = [path; goal_node];
      return;
    end
       
    candidates = find(adjacency(current_node, 1:n-2) & ~visited(1:n-2));
    if isempty(candidates)
      error('No valid path found to the target node');
    end
    [~, idx] = max(probabilities(candidates));
    next_node = candidates(idx);
    path = [path; next_node];
    visited(next_node) = true;
  endwhile
endfunction