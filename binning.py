import numpy as np
import matplotlib.pyplot as plt

# Define pulsar parameters
PULSE_PERIOD = 1.0  # In seconds (example)
EPOCH = 0.0  # Reference epoch (for now, assuming zero)
NUM_BINS = 1024  # Number of bins

# Simulate a synthetic pulsar signal over one period
time_samples = np.linspace(0, PULSE_PERIOD, 10000)  # 10,000 time samples
pulse_signal = np.exp(-((time_samples - PULSE_PERIOD / 2) ** 2) / (2 * (PULSE_PERIOD / 10) ** 2))  # Gaussian pulse

# Assign samples to bins
bin_edges = np.linspace(0, PULSE_PERIOD, NUM_BINS + 1)
binned_profile, _ = np.histogram(time_samples, bins=bin_edges, weights=pulse_signal)

# Normalize the pulse profile (optional)
binned_profile /= np.max(binned_profile)

# Plot the binned pulse profile
plt.figure(figsize=(10, 4))
plt.plot(binned_profile, label="Pulse Profile (1024 bins)")
plt.xlabel("Phase Bin")
plt.ylabel("Normalized Amplitude")
plt.title("Pulsar Pulse Profile (Binned)")
plt.legend()
plt.grid()
plt.show()
