import math

def generate_pairs(C, V):
    # Define the possible values for Tc
    Tc_values = [1, 2, 4, 8, 10, 16, 32, 64]

    # Initialize an empty list to store the valid pairs
    valid_pairs = []

    # Iterate over each possible value of Tc
    for Tc in Tc_values:
        # Calculate the maximum possible NZc based on V and Tc
        max_NZc = C // Tc

        # Iterate over possible values of NZc from 1 to max_NZc
        for NZc in range(math.ceil(max_NZc/2), max_NZc + 1):
            if Tc == 1 and (NZc % 16 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 2 and (NZc % 8 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 4 and (NZc % 4 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 8 and (NZc % 2 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc in [10, 16, 32, 64]:
                valid_pairs.append((Tc, NZc))


    # Return the list of valid pairs
    return valid_pairs

def generate_pairs2(R):
    # Define the possible values for Tc
    Tc_values = [1, 2, 8, 16, 32, 64, 192]

    # Initialize an empty list to store the valid pairs
    valid_pairs = []

    # Iterate over each possible value of Tc
    for Tc in Tc_values:
        # Calculate the maximum possible NZc based on V and Tc
        max_NZc = R // Tc

        # Iterate over possible values of NZc from 1 to max_NZc
        for NZc in range(math.ceil(max_NZc/2), max_NZc + 1):
            if Tc == 1 and (NZc % 16 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 2 and (NZc % 8 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 4 and (NZc % 4 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc == 8 and (NZc % 2 == 0):
                valid_pairs.append((Tc, NZc))
            elif Tc in [10, 16, 32, 64]:
                valid_pairs.append((Tc, NZc))

    # Return the list of valid pairs
    return valid_pairs
