include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)


constraint alldifferent(q)::domain_propagation;
constraint alldifferent([q[i] + i | i in 1..n])::domain_propagation;
constraint alldifferent([q[i] - i | i in 1..n])::domain_propagation;

var int: objective = sum([abs(q[i] - i) | i in 1..n ]);

% solve minimize objective;
% solve :: int_search(q, dom_w_deg, indomain_random) minimize objective;
% solve :: int_search(q, dom_w_deg, indomain_random) :: restart_luby(250) minimize objective;
solve :: int_search(q, dom_w_deg, indomain_random) :: restart_luby(250) :: relax_and_reconstruct(q, 85) minimize objective;