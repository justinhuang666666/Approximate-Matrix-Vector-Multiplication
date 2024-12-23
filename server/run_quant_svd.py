import subprocess

# List of weight word lengths to test
weight_word_lengths = [3, 4, 5, 6, 7, 8]

# Python script to run
script_name = "opus-mt-en-de-quant-svd.py"

# Loop through the weight word lengths and run the script
for weight_wl in weight_word_lengths:
    print(f"Running {script_name} with weight_wl={weight_wl}...")
    try:
        # Execute the script with the current weight_wl
        subprocess.run(["python", script_name, "--weight_wl", str(weight_wl)], check=True)
        print(f"Completed run with weight_wl={weight_wl}\n")
    except subprocess.CalledProcessError as e:
        print(f"Error occurred while running the script with weight_wl={weight_wl}: {e}\n")
