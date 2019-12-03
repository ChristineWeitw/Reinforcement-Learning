# Reinforcement-Learning of 3 games coded in Matlab.

# In the game of Coin-game, Prisoner-dilemma, and RockPaperScissor:
We have used 2 different update policy to each of the 3 games.

The 1st update policy (The update rules for each player are): 

𝑝3(𝑘 + 1) = 𝑝3(𝑘) + 𝛼𝑟3(𝑘)91 − 𝑝3(𝑘):, 𝑖𝑓 𝑎𝑐𝑡𝑖𝑜𝑛 𝑐 𝑖𝑠 𝑡𝑎𝑘𝑒𝑛 𝑎𝑡 𝑡𝑖𝑚𝑒 𝑡 

𝑝3(𝑘 + 1) = 𝑝3(𝑘) − 𝛼𝑟3(𝑘)𝑝3(𝑘), 𝑓𝑜𝑟 𝑎𝑙𝑙 𝑜𝑡h𝑒𝑟 𝑎𝑐𝑡𝑖𝑜𝑛𝑠 𝑜 ≠ 𝑐 


The 2nd update policy :

𝑝3(𝑘 + 1) = 𝑝3(𝑘) + 𝛼𝑟3(𝑘)91 − 𝑝3(𝑘): + 𝛼J𝔼9𝑝3(𝑘): − 𝑝3(𝑘)L, 𝑖𝑓 𝑎𝑐𝑡𝑖𝑜𝑛 𝑐 𝑖𝑠 𝑡𝑎𝑘𝑒𝑛 𝑎𝑡 𝑡𝑖𝑚𝑒 𝑡 

𝑝3(𝑘 + 1) = 𝑝3(𝑘) − 𝛼𝑟3(𝑘)𝑝3(𝑘) + 𝛼J𝔼9𝑝3(𝑘): − 𝑝3(𝑘)L, 𝑓𝑜𝑟 𝑎𝑙𝑙 𝑜𝑡h𝑒𝑟 𝑎𝑐𝑡𝑖𝑜𝑛𝑠 𝑜 ≠ 𝑐 


# For the explanation of functions' names we created in these 3 games:

list2.m and value2.m : calculate the value

Mean2 : iteratively calculate the mean

Non-zero-mean : sum(x)/length(x) x is the array

choose_a : choose next action based on probability

Rewardmatrix: game-1 game-2 game-3 with different rewards

Policy update1/2 : algorithm

prob_distribution : for game3 to initialize the probability
