include "globals.mzn";

int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks
int: p; % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations

int: t = sum(duration);
array[TASKS] of var 0..t: start;

% Precedence constraints for each ai → aj
constraint forall(i in PREC) (start[pre[i,1]] + duration[pre[i,1]] <= start[pre[i,2]]);

% Cumulative constraints for each resource
constraint forall(i in RESOURCES) (cumulative(start, duration, [req[i,j] | j in TASKS], L[i]));

solve minimize max([start[i] + duration [i] | i in TASKS]); 

%solve::int_search(start, smallest, indomain_min) minimize max([start[i] + duration [i] | i in TASKS]); 