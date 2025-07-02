% Alldifferent model

include "alldifferent.mzn";

int: N; % Number of rows and columns
array [1..N, 1..N] of int: start; % The initial placement
array [1..N, 1..N] of var 1..N: cells; % Variables for queens on the rows (or columns)

% start constraint  
constraint forall(i in 1..N, j in 1..N) (if start[i,j] > 0 then cells[i,j] = start[i,j] endif);

% alldifferent rows 
constraint forall(i in 1..N) (alldifferent([cells[i, j] | j in 1..N])::domain_propagation);

% alldifferent columns
constraint forall(j in 1..N) (alldifferent([cells[i, j] | i in 1..N])::domain_propagation);

%solve satisfy;
%solve :: int_search(cells, dom_w_deg, indomain_random) satisfy;
solve :: int_search(cells, dom_w_deg, indomain_random):: restart_luby(250)  satisfy;