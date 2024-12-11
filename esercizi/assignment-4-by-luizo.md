
# RCPSP

| Default search | Objective value | Time    |
| -------------- | --------------- | ------- |
| rcpspData1     | 60              | 293msec |
| rcpspData2     | 46              | 347msec |
| rcpspData3     | 68              | 1m 16s  |

| EST        | Objective value | Time        | Time initial solution |
| ---------- | --------------- | ----------- | --------------------- |
| rcpspData1 | 60              | 343msec     | 343msec               |
| rcpspData2 | 49              | 39s 858msec | 313msec               |
| rcpspData3 | 70              | 11s 243msec | 358msec               |



# JSP

| Default search | Objective value | Time    |
| -------------- | --------------- | ------- |
| jobshop1       | 663             | 141msec |
| jobshop2       | 826             | 3m 46s  |

| EST      | Objective value | Time | Time initial solution |
| -------- | --------------- | ---- | --------------------- |
| jobshop1 | 802             | -    | 186msec               |
| jobshop2 | 921             | -    | 295msec               |

1. Is searching on EST a good strategy to find an initial solution?
	The initial solutions of the EST methods are good approximations of the optimal solutions and they get compute very early in the search (in the msec range for all our tests). The initial solutions found are close enough to what the optimal solution is in the RCPSP exercise, while in the JSP exercise the initial solutions are way more far off the optimal solution found by the default search, which depending on the situation, might not be a good enough solution.
	EST appears to be a consistent strategy time-wise, where it could be considered a good strategy for a initial solution if the context of the problem admits initial solutions that may be relatively far from optimal.
	
2. Is searching on EST a good strategy to find an optimal solution? Justify your answer
	EST didn't manage to find solutions that matched the results found by the default search outside of rcpspData1, where it found the same solution with slightly more time.
	In any of our experiments, EST timed out or took considerably longer times to achieve a solution that was somewhat close but never better than what the default search was able to find, so it doesn't appear that EST can be considered a good strategy to find optimal solutions compared to the default search.
	EST is designed to easily find feasible solutions by focusing on scheduling jobs as early as possible, which may not always lead to the global optimal makespan due to the complexity of task-machine interactions or due to the resource constraints in the exercises we conducted.
	It is not an ideal strategy for finding the **optimal solution** due to its tendency to prioritize early task start times without considering the broader problem structure.