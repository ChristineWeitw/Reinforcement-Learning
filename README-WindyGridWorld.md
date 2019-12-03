# Reinforcement-Learning in WindyGridWorld game using 4 algorithms to solve.

In this game, we create 2 different cases by the actions of agent, one with standard action and another with king's move.
In this Windy Grid, the agent has to figure optimal policy to get to destination(G) from starting point(S) with stochastic winds' effect.

We implement several algorithms to solve this problem:
1. Sarsa
2. Q-learning 
3. Sarsa(𝜆)
4. Q(𝜆)

###results
##### The comparison of timesteps taken by 4 different algorithms.
When we run our code using Alpha: 0.4 gamma: 0.3 epsilon: 0.2 lambda: 0.4(minimum) episodes: 500.
                Standard Move               King’s Move
Sarsa               22                          28
Q-learning          25                          15
Sarsa(𝜆)            23                          27
Q(𝜆)                19 ​                        14​

When we run our code using Alpha: 0.4 gamma: 0.3 epsilon: 0.2 lambda: 0.4(minimum) episodes: 500.
Standard moves: Q(𝜆) > Sarsa> Sarsa(𝜆) > Q-learning (How fast they reach the goal state.) 
Kings moves: Q(𝜆) > Q-learning > Sarsa(𝜆) > Sarsa

Also, we found out the 𝜆 value will effect the performance of the agent.
 
##### The comparison of timesteps taken by 4 algorithms using different 𝜆 values in fixed wind, standard actions.
 𝜆                   Sarsa(𝜆)      Q-learning(𝜆)       Sarsa        Q-learning 
0.4                     24            ​ 19               22              22
0.6                     29              24               26            ​ 19
0.8                   ​ 17              26               22              32

