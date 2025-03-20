import numpy as np

# Constants
NUM_BINS = 1024

# Global Variables
probability_distribution = np.zeros(NUM_BINS)

# Pulsar parameters (example values)
period = 1.0  # in seconds
epoch = 0.0  # reference time

# Example pulse profile (random values normalized to 1.0)
pulse_profile = np.random.rand(NUM_BINS)
pulse_profile /= np.max(pulse_profile)  # Normalize to 1.0

def initialize():
    """ Initializes the probability distribution to zero. """
    global probability_distribution
    probability_distribution = np.zeros(NUM_BINS)

def process_pulse(time_stamp):
    """
    Processes a pulse received at a given time_stamp.
    Updates the global probability_distribution.
    """
    global probability_distribution

    # Compute phase and corresponding bin
    phase = (time_stamp - epoch) % period
    phase_bin = int((phase / period) * NUM_BINS)

    # Shift the pulse profile and accumulate into probability distribution
    shifted_profile = np.roll(pulse_profile, phase_bin)
    probability_distribution += shifted_profile

    # Find the bin with the peak probability
    peak_bin = np.argmax(probability_distribution)

    return peak_bin

def run_simulation(num_pulses=100, time_interval=0.1):
    """
    Simulates pulse reception at random time intervals.
    """
    np.random.seed(42)
    pulse_times = np.cumsum(np.random.exponential(scale=time_interval, size=num_pulses))

    for t in pulse_times:
        peak_bin = process_pulse(t)
        print(f"Pulse at {t:.3f}s -> Peak Bin: {peak_bin}")

# Run the simulation
initialize()
run_simulation()
