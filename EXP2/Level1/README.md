# Aim
To simulate, using MATLAB, the Doppler frequency shift experienced on a Vehicle-to-Vehicle (V2V) DSRC link at the IEEE 802.11p carrier frequency of 5.9 GHz, as a function of relative vehicle speed and the angle between the relative velocity vector and the line-of-sight (LOS) direction, and to evaluate its significance for OFDM subcarrier orthogonality. 


# Result / Observation 
The Doppler shift is observed to increase linearly with relative vehicle speed and to fall off as cos(θ), being maximum for θ = 0° (direct approach/recede) and zero for θ = 90° (perpendicular motion). For a realistic highway worst case of two vehicles approaching head-on at 100 km/h each (v_r = 200 km/h), the Doppler shift at 5.9 GHz is only about 1.09 kHz — under 1% of the 156.25 kHz OFDM subcarrier spacing used by IEEE 802.11p. This confirms that, for the speed ranges typical of vehicular traffic, the resulting Doppler shift is a small fraction of the subcarrier spacing, so inter-carrier interference remains limited under normal highway conditions, although it should still be accounted for in receiver design (e.g., pilot-aided channel tracking) for the highest-speed scenarios. 
