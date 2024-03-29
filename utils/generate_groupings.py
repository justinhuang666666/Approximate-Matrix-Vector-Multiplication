def generate_groupings(arr):
    def helper(remaining, current_grouping):
        if not remaining:
            # No more elements to group, add current grouping to results if it's not a duplicate
            if current_grouping not in results:
                results.append(current_grouping)
            return
        
        # Option 1: Start a new group with the next element
        helper(remaining[1:], current_grouping + [[remaining[0]]])

        # Option 2: Add the next element to each of the existing groups
        for i in range(len(current_grouping)):
            new_grouping = [group[:] for group in current_grouping]  # Create a deep copy of the current grouping
            new_grouping[i].append(remaining[0])
            helper(remaining[1:], new_grouping)

    results = []
    helper(arr, [])
    return results

