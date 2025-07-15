========================TASK 1 MARKOV-IS-COMING============================

1. function [Labyrinth] = parse_labyrinth(file_path)
Functia parse_labyrinth primeste ca intrare calea catre un fisier text.
Acest fisier ar trebui sa contina pe primele doua linii numarul de randuri
si respectiv numarul de coloane ale unui labirint. Restul fisierului contine
valorile numerice care reprezinta labirintul, citite pe randuri. Functia
citeste aceste informatii din fisier si returneaza o matrice Labyrinth.
Aceasta matrice reprezinta structura labirintului, unde fiecare element
corespunde unei celule din labirint si valoarea sa indica starea acelei
celule. Functia include si gestionare a erorilor, deoarece datele sunt
citite dintr-un fisier si pot aparea elemente invalide.
___________________________________________________________________________
2. function [Adj] = get_adjacency_matrix(Labyrinth)
Functia get_adjacency_matrix transforma un labirint reprezentat printr-o
matrice (Labyrinth) intr-o matrice de adiacenta (Adj). Fiecare celula din
labirint devine un nod in graf. Functia itereaza prin fiecare celula si
verifica posibilitatea de a se deplasa in cele patru directii (N,S,E,V)
pe baza valorii celulei. Dacă o miscare este permisa catre o celula vecina,
se seteaza o legătura <1> in matricea de adiacenta. Celulele de pe marginea
de sus duc la un nod "WIN", iar cele de pe marginea din dreapta duc la
un nod "LOSE".
___________________________________________________________________________
3. function [Link] = get_link_matrix(Labyrinth)
Functia get_link_matrix primeste un labirint (Labyrinth) si creeaza o matrice
de legaturi probabilistice (Adj). Fiecare celula devine un nod. Functia
itereaza prin labirint, iar pe baza valorilor, determina vecinii posibili
(N,S,E,V). Daca o deplasare este permisa, se stabileste o legatura in Adj.
Celulele de pe marginea de sus duc la nodul "WIN", iar cele de pe marginea
din dreapta duc la "LOSE". La final, fiecare rand din Adj este normalizat
prin numarul de legaturi ale nodului corespunzator, transformand matricea
de adiacenta intr-o matrice de probabilitati.
___________________________________________________________________________
4. function [G, c] = get_Jacobi_parameters(Link)
Functia get_Jacobi_parameters va primi matricea legaturilor si va returna
matricea de iteratie si vectorul de iteratie pentru metoda Jacobi. Verific
daca Link este matrice bidimensională. Extrage dimensiunea sistemului (n)
din Link. Separa G (primele n linii si coloane) si c (coloana n+1 din
primele n linii). Return eroare daca Link nu are dimensiuni suficiente.
___________________________________________________________________________
5. function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
Aceasta functie implementeaza metoda iterativa pentru rezolvarea sistemelor
de ecuatii liniare de forma x=Gx+c. Initializeaza x cu x0 si error cu 1. In
bucla, actualizeaza x folosind formula iterativa x=Gx+c. Calculeaza eroarea
ca norma diferentei dintre solutiile vechi si noi. Se opreste cand eroarea
scade sub toleranta sau se atinge max_steps.
___________________________________________________________________________
6. function [path] = heuristic_greedy(start_position, probabilities, Adj)
Functia heuristic_greedy gaseste un drum intr-un graf de la un nod de start
la un nod tinta (considerat n-1), folosind o strategie bazata pe
probabilitate. Porneste de la nodul start si il marcheaza ca vizitat. La
fiecare pas, verifics daca nodul curent are legătura directa cu tinta (n-1)
Daca da, break. Altfel, alege vecinul nevizitat cu cea mai mare probabilitate
(din primele n-2 noduri) si il adauga in drum. Returneaza drumul sub forma
de vector de noduri.
___________________________________________________________________________
7. function [decoded_path] = decode_path(path, lines, cols)
Functia transforma un vector path intr-o matrice 2D decoded_path, folosind
dimensiunile unei matrice(lines x cols). Pentru elementele lui path voi
folosi la calculul liniei: impartirea indicelui i la numarul de coloane, iar
pentru coloane folosind modulo.

========================TASK 2 LINEAR-REGRESSION===========================

1. function [Y, InitialMatrix] = parse_data_set_file(file_path)
Functia citeste dimensiunile matricei (numarul de randuri si de coloane).
Dupa aceea, aloca memorie pentru matricea Y si pentru matricea InitialMatrix.
Foloseste bucle while pentru a citi datele din fisier, element cu element,
si le salveaza in matricele alocate. Inchide fisierul si returnează matricele
Y si InitialMatrix. Functia include si erori de verificare.
___________________________________________________________________________
2. function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
Functia transforma o matrice de intrare InitialMatrix intr-o FeatureMatrix,
potrivita pentru analiza de regresie. Se parcurge fiecare coloana din Initial
Matrix, convertind sirurile de caractere in reprezentari numerice. 'yes' 
devine 1, 'no' devine 0. Orice sir de caractere este convertit in numar,
coloanele procesate sunt adaugate la FeatureMatrix. Daca o coloana are o
valoare, aceasta este adaugata direct.
___________________________________________________________________________
3. function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
Functia cost a regresiei liniare  calculeaza eroarea medie patratica dintre
predictii si valorile reale, atfel se proceseaza fiecare exemplu de antrenament
secvential, calculand predictiile prin bucle for. Pentru fiecare exemplu,
calculeaza produsul scalar dintre caracteristici și ponderi, gaseste diferenta
fata de valoarea cautata. In fine, normalizeaza prin impartire.
___________________________________________________________________________
4. function [Y, InitialMatrix] = parse_csv_file(file_path)
Aceasta functie analizează un fisier CSV, separand prima coloana in Y si
restul in InitialMatrix. Verifica fisierul, gestioneaza datele incomplete
si foloseste textscan pentru citirea datelor din fisierul CSV.
___________________________________________________________________________
5. function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
Gradient descent este un algoritm de optimizare iterativ folosit pentru a
gasi minimul unei functii. In context, este folosit pentru a minimiza
functia de cost, ajustand iterativ parametrii modelului (Theta) in directia
opusa gradientului functiei. La fiecare pas, se calculeaza gradientul
erorii modelului, iar parametrii sunt actualizati proportional cu rata de
invatare. Procesul se repeta pana la convergenta.
___________________________________________________________________________
6. function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
Functia normal_equation implementeaza o metoda iterativa (gradientul conjugat)
pentru a gasi parametrii Theta. Initializeaza Theta si adauga un termen de
bias implicit. Verifica daca matricea A este pozitiv definita. Apoi, printr-o
bucla estimeaza iterativ Theta ajustand directia si pasul pe baza reziduului
si produsului matriceal. Bucla continua până se atinge un numar maxim de
iteratii. In fine, adauga un zero ca prim element Theta pentru a reprezenta biasul.
___________________________________________________________________________
7. function [Error] = lasso_regression_cost_function(Theta, Y, FeMatrix, lambda)
Functia lasso_regression_cost_function calculeaza eroarea pentru regresia Lasso.
Primeste parametrii Theta, valorile Y, matricea de caracteristici FeatureMatrix
si parametrul de regularizare L1 lambda. Exclude termenul de bias din Theta
pentru penalizare. Calculeaza predictiile, eroarea patratică medie (MSE) si
penalizarea L1. Eroarea finala este suma dintre MSE și penalizarea L1.
___________________________________________________________________________
8. function [Error] = ridge_regression_cost_function(Theta, Y, FeMatrix, lambda)
Functia calculeaza costul pentru regresia Ridge. Verifica dimensiunile lui Theta
si FeatureMatrix pentru compatibilitate. Calculeaza predictiile adaugand termenul
de bias (Theta(1)) si calculez eroarea patratica medie (MSE). Adaug penalizarea L2
(regularizarea Ridge), excluzând biasul. In fine, returnez eroarea totala.

============================TASK 3 MNIST-101===============================

1. function [X, y] = load_dataset(path)
Aceasta functie incarca date dintr-un fisier si validează tipul acestuia.
Functia load citeste continutul fisierului, extragand variabilele X și y.
Functia returneaza datele X si y validate.
___________________________________________________________________________
2. function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)
Functia
Aceasta functie partitioneaza datele in seturi de antrenament si testare pe
baza unui raport. Calculeaza numarul de esantioane de antrenament si creeaza
o masca pentru a le selecta. Functia itereaza apoi prin setul de date,
atribuind esantioane fie setului de antrenament, fie setului de testare,
pe baza mastii. Seturile de antrenament si testare rezultate sunt returnate.
___________________________________________________________________________
3. function [matrix] = initialize_weights(L_prev, L_next)
Functia a fost initializata conform formulelor din breviarul teoretic.
___________________________________________________________________________
4. function [J, grad] = cost_function(params, X, y, lambda, input_layer_size,
hidden_layer_size, output_layer_size)
___________________________________________________________________________
5. function [classes] = predict_classes(X, weights, input_layer_size,
hidden_layer_size, output_layer_size)
___________________________________________________________________________
===========================================================================
===========================================================================

