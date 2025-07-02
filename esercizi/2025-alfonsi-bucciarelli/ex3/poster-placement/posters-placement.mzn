include "diffn.mzn";

int: n;
int: w;
int: h;
set of int: NRECTS = 1..n;

array [NRECTS] of int: ws;
array [NRECTS] of int: hs;
array [NRECTS] of var 0..w-1: xs;
array [NRECTS] of var 0..h-1: ys;
array [1..2*n] of var 0..max(w,h)-1: all_vars;

% constraints to make sure each rectangle fits inside
constraint forall( i in NRECTS ) ( xs[i] + ws[i] <= w );
constraint forall( i in NRECTS ) ( ys[i] + hs[i] <= h ); 

% no overlap naive
% proof this works: https://yetanothermathprogrammingconsultant.blogspot.com/2017/07/rectangles-no-overlap-constraints.html
% constraint forall(i in NRECTS, j in NRECTS where i != j) (
%  xs[i] + ws[i] <= xs[j] \/ xs[j] + ws[j] <= xs[i] \/
%  ys[i] + hs[i] <= ys[j] \/ ys[j] + hs[j] <= ys[i] );
  
% no overlap (global)
% reference: https://github.com/MiniZinc/libminizinc/blob/2.5.5/share/minizinc/std/diffn.mzn#L9-L19
constraint diffn( xs, ys, ws, hs );

constraint forall(i in NRECTS ) (all_vars[2*i-1] = xs[i]);
constraint forall(i in NRECTS ) (all_vars[2*i] = ys[i]);

%solve :: int_search(all_vars, input_  order, indomain_min) satisfy;
%solve :: int_search(all_vars, input_order, indomain_random) satisfy;
%solve :: int_search(all_vars, dom_w_deg, indomain_min) satisfy;
solve :: int_search(all_vars, dom_w_deg, indomain_random) satisfy;