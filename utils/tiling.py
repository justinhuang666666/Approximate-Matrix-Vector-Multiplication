def tiling(vector, unroll_factor):
    tile_array = [vector[i:i + unroll_factor] for i in range(0, len(vector), unroll_factor)]
    return tile_array
