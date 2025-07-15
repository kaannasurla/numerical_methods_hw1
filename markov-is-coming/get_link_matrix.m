function [Adj] = get_link_matrix (Labyrinth)
  n = size(Labyrinth, 1);
  m = size(Labyrinth, 2);
  num_nodes = n * m + 2;
  WIN = num_nodes - 1;
  LOSE = num_nodes;

  Adj = sparse(num_nodes, num_nodes);
  Adj(WIN, WIN) = 1;
  Adj(LOSE, LOSE) = 1;

  num_edges = zeros(num_nodes, 1);

  for i = 1:n
    for j = 1:m
      idx = (i - 1) * m + j;
      cell_val = Labyrinth(i, j);
      for dir = 1:4
        switch dir
          case 1 % SUS
            if bitand(cell_val, 8) == 0
              if i == 1
                Adj(idx, WIN) = 1;
              else
                neighbor_idx = idx - m;
                Adj(idx, neighbor_idx) = 1;
              end
              num_edges(idx) = num_edges(idx) + 1;
            end

          case 2 % JOS
            if bitand(cell_val, 4) == 0
              if i == n
                Adj(idx, WIN) = 1;
              else
                neighbor_idx = idx + m;
                Adj(idx, neighbor_idx) = 1;
              end
              num_edges(idx) = num_edges(idx) + 1;
            end

          case 3 % DREAPTA
            if bitand(cell_val, 2) == 0
              if j == m
                Adj(idx, LOSE) = 1;
              else
                neighbor_idx = idx + 1;
                Adj(idx, neighbor_idx) = 1;
              end
              num_edges(idx) = num_edges(idx) + 1;
            end

          case 4 % STÂNGA
            if bitand(cell_val, 1) == 0
              if j == 1
                Adj(idx, LOSE) = 1;
              else
                neighbor_idx = idx - 1;
                Adj(idx, neighbor_idx) = 1;
              end
              num_edges(idx) = num_edges(idx) + 1;
            end
        end
      end
    end
  end

  % Normalizare pe linii
  for i = 1:num_nodes
    if num_edges(i) ~= 0
      Adj(i, :) = Adj(i, :) / num_edges(i);
    end
  end
endfunction
