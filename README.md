# Underwater Object Tracking using SONAR and Unscented Kalman Filter
![image](https://github.com/rbga/Underwater-Object-Tracking-using-SONAR-and-Unscented-Kalman-Filter/assets/75168756/82aa547d-2ec3-446e-aef9-dd738333ad02)
<img src="[path/to/your/image.png](https://github.com/rbga/Underwater-Object-Tracking-using-SONAR-and-Unscented-Kalman-Filter/assets/75168756/82aa547d-2ec3-446e-aef9-dd738333ad02)" alt="Image Alt Text" width="300" height="200">

## Introduction
Underwater Object Tracking using SONAR and Unscented Kalman Filter is a simulation project aimed at modeling an underwater object tracking scenario using SONAR and the Unscented Kalman Filter (UKF). The project utilizes the Phased Array Toolbox in MATLAB to implement the SONAR equations and perform precise computations in real-time.

## Literature Survey
SONAR, an essential technology for underwater navigation and detection, traces its roots back to the 15th century. It has been widely used in various fields, including military applications, oceanography, and autonomous underwater robotics. The classic Kalman Filter, introduced in the 1950s, is a powerful algorithm employed in a range of modern technologies, from smartphones to rockets. However, for highly nonlinear systems, the Extended Kalman Filter (EKF) has certain limitations, leading to inaccuracies and divergence. To address this, the Unscented Kalman Filter was developed to handle highly nonlinear systems with improved accuracy.

## SONAR
In an Active Sonar system, a transducer emits sound waves into the ocean, which interact with the environment and potential targets. The SONAR equation considers factors such as Source Level (SL), Target Strength (TS), Transmission Loss (TL), and Background Noise (NL) to calculate the Echo Intensity. The Phased Array Toolbox in MATLAB facilitates the computation of SONAR equations in decibels and enables the creation of complex simulations.

## Unscented Kalman Filter (UKF)
The Unscented Kalman Filter is employed when a system process exhibits significant nonlinearity, rendering the standard Kalman Filter ineffective. The UKF approximates the probability distribution of the state variables using Sigma Points, offering a more robust estimation of uncertainty, propagation, and measurement equations. With a set of 2l+1 Sigma Points, the UKF continually estimates state variables and covariance for nonlinear dynamic systems.

## Simulation
The simulation involves an Active Monostatic SONAR system with two moving targets at varying locations. The system consists of an isotropic spherical projector array as the transmitter and a hydrophone as the receiver. Five paths are assumed at a depth of 100 meters with a constant sound speed of 1520 m/s. The simulation tracks two moving targets with distinct target strengths, and their positions and velocities are described in Cartesian coordinates. The UKF algorithm is applied to predict the movement of the targets. The results include plots of sonar paths and the integrated pulse of the received signals.
![image](https://github.com/rbga/Underwater-Object-Tracking-using-SONAR-and-Unscented-Kalman-Filter/assets/75168756/f8739125-bdcb-426b-ab5a-f95757c3b19f)


## Conclusion
The simulation demonstrates that Unscented Kalman Filters are ideal for underwater SONAR modeling due to their ability to handle nonlinear systems effectively. Although the UKF consumes considerable computation power and processing time, it proves to be a powerful estimator for highly nonlinear scenarios. The application of UKF has significant scope in military applications, autonomous underwater robotics, and underwater object tracking.

**Please note that this README provides an overview of the project. For detailed implementation and code descriptions, refer to the provided MATLAB script.**
