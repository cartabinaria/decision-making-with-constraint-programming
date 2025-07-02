% Combined alldifferent & symmetry breaking model
include "alldifferent.mzn";

% alldiff model

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

constraint alldifferent(q)::domain_propagation;
constraint alldifferent([q[i] + i | i in 1..n]);
constraint alldifferent([q[i] - i | i in 1..n]);

% Integration of the Boolean model 
array [1..n, 1..n] of var 0..1: qb;

constraint forall(i, j in 1..n)(q[i]=j <-> qb[i, j]=1);
constraint lex_lesseq(array1d(qb), [ qb[j,i] | i,j in 1..n ]);
constraint lex_lesseq(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ]);
constraint lex_lesseq(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ]);
constraint lex_lesseq(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ]);
constraint lex_lesseq(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ]);
constraint lex_lesseq(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ]);
constraint lex_lesseq(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ]);

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;

