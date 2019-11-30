# Reinforcement-Learning

Self-Driving Cab


Problem:
The agent needs to pick up the passenger at R(blue) and drop off at G(purple) in a fast and safe way without triggering any penalties. 
There are five obstacles(|) in this environment which are fixed as well as the locations. However, in every single episode, the agent and the passenger would be in random location. Also, every single time the agent hits the obstacle, it remains in the same state instead of going back to the original point. 
Goal 
In this environment, the agent must pick up and drop off the passenger in a 5x5 grid with four (4) locations(R, G, Y, B).
State Space
We assume self-driving cab is the only vehicle in this parking lot. We can break up the parking lot into a 5x5 grid, which gives us 25 possible taxi locations.  There's four (4) destinations[R, G, Y, B] and five (4 + 1) passenger locations (we account for one (1) additional passenger state of being inside the taxi).

Thus, our taxi environment has 5×5×5×4=500 total possible states.
Action 
The taxi can take the following actions (numbering same as in the environment):
0: move south
1: move north
2: move east
3: move west
4: pick up passenger
5: drop off passenger
The taxi can move in four directions: north, south, east and west. And its mission is to pick up passengers from one of four locations and then must drop them off at their destination.
Reward : 
-1 : The agent receives a reward of -1 on every timestep.
+20 : additional reward of +20 for delivering the passenger to their destination.
-10 : if the agent pick up or drop off the passenger illegally.

In this project, we use OpenAI Gym (Taxi-v3) to build self-driving cab’s environment.

Methods
Random self-driving(Brute-Force)(learning without Reinforcement Learning)
We make our agent to solve the problem based on this reward table, it is time consuming and triggering lots of penalties (as the result shows in figure1).
In this case, the agent is always exploring and the action it takes is random. Since the agent is not learning from the past experience as well as not considering the reward and penalty behind the action, it would jump to random state and take more than 2000 timesteps to achieve the goal.
The Reward Table

  Figure1. Reward Table of state 322.

Q-learning
In our Taxi environment, we initialized the q_table zero and for every timestep, the state-action value is updated.
Q-table

Figure 2. Q_table
The Q-table is a 500*6 matrix that maps state to action, in which the row represents the state while the column means action. 
Q-learning(λ)
In the project, we used 2 different algorithms(Q-learning and Q-learning lambda) for the self-driving cab.


Q-learning
(episode=5001,alpha =0.1,gamma = 0.6)


Q-learning(λ)
(episode=5001, alpha =0.1,gamma = 0.6,λ= 0.5)

Sarsa
(episode=5001,
alpha =0.1, 
gamma = 0.6)

Final Timesteps
12
10
17
Table 1. Comparison of Three Algorithms
For the parameters we set for the algorithms, our epsilon is set as 0.1, since we do not want our agent to explore too much which would cause extra penalty and eventually takes more steps to reach the destination. The value of alpha (α, learning rate) is set to 0.1, which represents the extent to which our Q-values are being updated in every iteration. Instead of setting the value of Gamma (γ) too high(close to 1), we set γ as 0.6 to make sure that the agent also focus enough on the immediate reward, hence making it greedy to reach the destination faster. For the value of lambda (λ), we set it as 0.5 but not 0.9 because of our small size of state space(500). Since the value of λ will not make an obvious impact on performance in a small size of state space. 
As table 1 shows, Q-learning and Q-learning(λ) algorithms got a close results on self-driving cab problem. However, Q-learning(λ) converges faster than Q-learning in the beginning. Our initial guess is that the eligibility trace strengthens the last few steps and gives the bigger value to the Q-learning(λ) agent to reach its destination. 
In conclusion, the final timesteps are close. It means both of them are capable of learning from the penalties and choose the optimal path. In the future, if we increase the number of state space, we believe Q_learning(λ) would learn more efficiently. 
Sarsa algorithm, compared to Q-learning and Q_learning(λ), is not converged. Our guess is that Sarsa follows its policy and sample an action a’ from policy at state s’. Unlike Q-learning, it will take the action a’ that it thinks is the best action. This makes Sarsa converge unstably compared to Q-learning.
