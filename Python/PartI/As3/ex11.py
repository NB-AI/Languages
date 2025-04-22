
import numpy as np

def __compute_next_state__(state):
    final_seed = np.copy(state)
    for a,b in enumerate(state):
        for r,d in enumerate(b):
            live_neighbors = 0


            # Current line, left
            if r-1 >= 0:
                if state[a, r-1] == True:
                    live_neighbors += 1
            # Current line, right
            if r+1 < len(b):
                if state[a, r+1] == True:
                    live_neighbors += 1


            # Above line, left
            if a - 1 >= 0 and r-1 >= 0:
                if state[a-1, r-1] == True:
                    live_neighbors += 1
            # Above line, current index
            if a-1 >= 0:
                if state[a-1, r] == True:
                    live_neighbors += 1
            # Above line, right
            if a-1 >= 0 and r+1 < len(b):
                if state[a-1, r+1] == True:
                    live_neighbors += 1


            # Under line, left
            if r-1 >= 0 and a+1 < len(state):
                if state[a+1, r-1] == True:
                    live_neighbors += 1
            # Under line, current index
            if a+1 < len(state):
                if state[a+1, r] == True:
                    live_neighbors += 1
            # Under line, right
            if a+1 <= len(state)-1 and r+1 < len(b):
                if state[a+1, r+1] == True:
                    live_neighbors += 1


            # Further tasks:
            if live_neighbors < 2:
                final_seed[a,r] = False

            if live_neighbors == 2 or live_neighbors == 3:
                if state[a,r] == True:
                    final_seed[a,r] = True

            if live_neighbors > 3 and state[a,r] == True:
                final_seed[a,r] = False

            if live_neighbors == 3 and state[a,r] == False:
                final_seed[a,r] = True

            print(live_neighbors)
    return final_seed
