 # Aim 
 To simulate, using MATLAB, (a) the log-distance path loss variation and (b) the Doppler frequency shift experienced in a Vehicle-to-Vehicle (V2V) DSRC link operating at 5.9 GHz, and to plot both characteristics. 

Path Loss (Log-Distance Model) 
The average path loss at a distance d from the transmitter, referenced to a close-in distance d0, is modeled as: PL(d) [dB] = PL(d0) + 10 n log10(d / d0) where n is the path-loss exponent (n ≈ 2.7–3.5 for suburban/urban V2V links, compared to n = 2 for free space), and PL(d0) is the free-space path loss at the reference distance, computed from 
# the Friis equation: PL(d0) [dB] = 20 log10(4π d0 fc / c) 

# Doppler Shift
Because both transmitting and receiving vehicles may be moving, the relative motion introduces a frequency shift in the received carrier, given by: 
# fd = (v fc / c) cos(θ) 
where v is the relative velocity between the two vehicles, fc is the carrier frequency, c is the speed of light, and θ is the angle between the vehicle's direction of motion and the line-of-sight to the other vehicle (θ = 0 for direct approach/recede, giving maximum Doppler shift). High relative speeds at 5.9 GHz can produce Doppler shifts of several kHz, which directly affects the coherence time of the channel and the design of the DSRC physical layer (e.g., pilot spacing in OFDM). 

# Result
Path loss is seen to increase logarithmically with distance, consistent with the log-distance model. The Doppler shift increases linearly with relative vehicle speed, reaching a few kHz at highway speeds (e.g., ~200 km/h closing speed) at 
 
