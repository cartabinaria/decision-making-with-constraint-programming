% Alldifferent model

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end to use GAC, otherwise BC is used. 

constraint alldifferent(q)::domain_propagation;
%constraint forall(i, j in 1..n where i < j) (q[i] != q[j]);

constraint alldifferent([q[i] + i | i in 1..n])::domain_propagation; % replace with decomposition
%constraint forall(i, j in 1..n where i < j) (q[i] + i != q[j] + j);

constraint alldifferent([q[i] - i | i in 1..n])::domain_propagation;
% constraint forall(i, j in 1..n where i < j) (q[i] - i != q[j] - j);

% Search for all solutions, using N = 30, 35, 45, 50.

solve :: int_search(q, input_order, indomain_min) satisfy;
%solve :: int_search(q, input_order, indomain_random) satisfy;
%solve :: int_search(q, first_fail, indomain_min) satisfy;
%solve :: int_search(q, first_fail, indomain_random) satisfy;
%solve :: int_search(q, dom_w_deg, indomain_min) satisfy;
%solve :: int_search(q, dom_w_deg, indomain_random) satisfy;