function [Adj] = get_adjacency_matrix (Labyrinth)
    [n, m] = size(Labyrinth);
    num_nodes = n * m + 2;
    WIN = num_nodes - 1;
    LOSE = num_nodes;
    Adj = sparse(num_nodes, num_nodes); % initializez matricea de adiacenta
    % parcurg fiecare celula a labirintului
    for row = 1:n
        for col = 1:m
            i = (row - 1) * m + col;
            cell_value = Labyrinth(row, col);
            for dir = 1:4 % verific directia
                switch dir
                    case 1  % directia SUS
                        if mod(cell_value, 16) < 8
                            new_row = row - 1;
                            new_col = col;
                            if new_row >= 1
                                neighbor_idx = (new_row - 1) * m + new_col;
                                Adj(i, neighbor_idx) = 1;
                            else
                                Adj(i, WIN) = 1;
                            end
                        end
                    case 2  % directia JOS
                        if mod(cell_value, 8) < 4
                            new_row = row + 1;
                            new_col = col;
                            if new_row <= n
                                neighbor_idx = (new_row - 1) * m + new_col;
                                Adj(i, neighbor_idx) = 1;
                            else
                                Adj(i, WIN) = 1;
                            end
                        end
                    case 3  % directia DREAPTA
                        if mod(cell_value, 4) < 2
                            new_row = row;
                            new_col = col + 1;
                            if new_col <= m
                                neighbor_idx = (new_row - 1) * m + new_col;
                                Adj(i, neighbor_idx) = 1;
                            else
                                Adj(i, LOSE) = 1;
                            end
                        end
                    case 4  % directia STANGA
                        if mod(cell_value, 2) == 0
                            new_row = row;
                            new_col = col - 1;
                            if new_col >= 1
                                neighbor_idx = (new_row - 1) * m + new_col;
                                Adj(i, neighbor_idx) = 1;
                            else
                                Adj(i, LOSE) = 1;
                            end
                        end
                end
            end
        end
    end
    Adj(WIN, WIN) = 1;
    Adj(LOSE, LOSE) = 1;
endfunction