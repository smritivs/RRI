import numpy as np

# Parameters
num_bins = 1024
mean_bin = 512  # Center of distribution
std_dev = 100   # Spread of distribution

# Generate Gaussian pulse profile
pulse_profile = np.exp(-((np.arange(num_bins) - mean_bin) ** 2) / (2 * std_dev ** 2))
pulse_profile = (pulse_profile / max(pulse_profile) * 0xFFFFFFFF).astype(np.uint32)  # Normalize to 32-bit values

# Save to memory file
with open("pulse_profile.mem", "w") as f:
    for value in pulse_profile:
        f.write(f"{value:08X}\n")  # Write as hex values
