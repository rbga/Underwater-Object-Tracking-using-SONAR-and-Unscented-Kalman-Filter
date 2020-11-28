# Underwater-Object-Tracking

Underwater Object Tracking using SONAR and Unscented Kalman Filter
This was a Matlab tutorial hacked to include UKF tracking

Abstract – This course project is aimed at simulating an underwater object tracking scenario using SONAR, Unscented Kalman Filter and the Phased array toolbox from Matlab. Currently the Extended Kalman Filter which is widely in use has disadvantages compared to UKF, which will be demonstrated through the help of this Simulation.

I. INTRODUCTION
Underwater Object Tracking unlike the land based Object tracking, is more complex and is riddled with a lot of uncertainties, distortions and discrepancies. This is mainly because underwater is noisy and speed of sound is not constant underwater along with all the excess noise, false triggers like a school of fish or corals, refraction and reverberation. So to combat these problems and providing a result with accuracy and precision needs intense mathematical calculations and complex algorithms. Here we will be using the Unscented Kalman Filter to model the SONAR system which can track moving objects. UKF is specifically used for highly nonlinear systems where the Gaussians cannot converge properly. So UKF, will choose Sigma points across the Gaussian values which will be used to predict the future states. Though the accuracy of this is precise compared to the rest, it takes up a lot of computational power.

II. LITERATURE SURVEY
History dictates that the first person to use the idea of Sonar to listen to nearby vessels was Leonardo Da Vinci in 1490, when he dipped a tube into the water to listen for minute change in vibrations. Proper Sonar was not developed until World War I time period where countries were increasingly threatened by submarines. Some Notable technological achievements across time helped enable the continuous development of SONAR to aid nations in their various requirements. Throughout time, since the advent of Kalman Filter from the 50s, it’s a really strong algorithm that is still widely used on almost every latest technology we own. Ranging from your smartphones that can precisely locate you even when you’re indoors, to the Rocket that took Human to the moon. This is a really simple probabilistic algorithm that predicts the future behavior of a system based on approximation of an actual measurement which is too noisy to rely upon. Now the current generation technology and even future technology like Autonomous Cars are going to be employing modern iterations of this classic Algorithm. But in spite of all the rapid development that happened on land over time, we still haven’t tried to discover most of the ocean yet. Part of the reason might be due to lack of vision and light underwater. But we still have been able to use the ocean to help us in many ways. The advent of SONAR and RADAR greatly changed the way information was transferred across the planet and the way humans fought their wars. Using SONAR systems on Aircraft Careers and Submarines, armies have been able to assimilate the advancements of the opponent. Radars have greatly helped aircrafts avoid missile strikes. Now, considering oceans, warships have 2 options regarding SONAR, Active and Passive. An Active Sonar is where the ship has a transmitter that sends a pulse and receives it back to identify nearby targets. In passive sonar, the ship has a hydrophone (receiver) that actively listens for change in sound made by nearby targets. In this scenario, we will be looking on how Unscented Kalman Filter can be implemented on an Active Sonar system to detect moving targets.

III. SONAR
In an Active Sonar, a transducer (piezo electric) will act as the transmitter, emitting sounds waves into the ocean. If the transmitter is an isotropic spherical array that can transmit uniformly omnidirectional sound waves, it’s known as an isotropic projector- monostatic. If the transmitter and receiver are separated they’re called Bistatic. The SONAR equation must account for the Source Level (SL), sound spread, decrease of acoustic intensity (attenuation), transmission loss (TL), background noise, Target Strength (TS)

Echo Intensity (dB) = (SL – TL) + TS (1)

Let’s consider a sonar pulse emitted. The Intensity of the traveling waves can be described as sum of the target strength and the difference of source level and transmission loss. After hitting the target, it returns back, which experiences more attenuation in the form of another transmission loss. If the background noise is NL then the ratio of Sonar to noise is SNR

SNR (dB) = SL – 2TL + TS – NL (2)

Current generation sonars use an array type receivers to propagate in all direction and reduce noise. So let’s consider the Array Gain as AG. The Sonar to Noise Ratio becomes

SNR (dB) = SL + TS + AG – 2TL –NL (3)

This is known as the SONAR to NOISE RATIO or SNR or known as the Sonar Equation which is calculated in decibels. Under MATLAB R2016a version and onwards, the Phased Array Toolbox was introduced which incorporates this equation to enable precise and lengthy computations to be done faster in real time. This toolbox was primarily used to create this Simulation on Matlab.

IV. UNSCENTED KALMAN FILTER
When a system process is highly nonlinear to the point where the probabilistic density function (Gaussian) doesn’t converge properly, Kalman Filter cannot be used to predict the state transition and observation model as they were designed to work with a linear system with a defined mean and uniform variance. Instead we could use the later variants of the Kalman filter designed to handle nonlinear systems. We could use the Extended Kalman Filter to model the system. But there are a lot more disadvantages compared to other algorithms. This EKF was mainly designed for systems will low non-linearity. Employing this system on a highly nonlinear system is highly unadvisable as the results are always distorted. Suppose, if the initial estimate is wrong, or if the process modelling had errors in them, then it will quickly diverge due to linearization. And as estimated covariance underestimates true covariance, the results don’t even marginally align with the true values. So instead of it, a robust non liner filter like the unscented Kalman filter can be used.
The unscented Kalman Filter is based on the foundation that probability distribution is easier to approximate. It selects a set of points known as Sigma Points among the state distribution. It uses them to continually estimate the uncertainty, propagation and measurement equations.
Consider a nonlinear dynamic system

X(k+1) = f (X, k) + Wk (4)
Zk = h (X, k) + Vk (5)
Where W is Gaussian noise of state system ranging from zero to covariance Q
V is Gaussian noise of measurement system ranging from 0 to covariance R

For an UKF with l – dimensional probability density function it need 2l+1 sigma points.
Where lambda is a scaling parameter
So these sigma points are passed through the function equation
Y = h (xi) (6)
Then finally, the output mean and covariance is computed

V. SIMULATION
We will be simulating an Active monostatic sonar system with two moving targets at varying locations. The transmitter is an isotropic spherical projector array and the receiver is a hydrophone which receives back scatter signals which have both direct and multipath propagation. 5 paths are assumed at a depth of 100 meters and a constant sound speed of 1520 m/s is set.
There are two moving targets in this scenario. They are separated and are moving in a constant velocity. The target closer to the ship has a lesser target strength compared to the farther target’s strength. Target positon and their velocities are describes in the Cartesian coordinate system. Plotting the sonar paths for the two targets results in a z-depth plot.

Next the transmitter is defined and created with range as 5000, resolution 10. It is located 60 meters below the surface of water. The array is created and array geometry is seen.

The receiver frequency range is from 0 to 30 KHz and the hydrophone’s voltage sensitivity is -140dB.
The unscented Kalman filter algorithm is applied for both the targets to predict their movement.

Finally plotting the magnitudes of the no coherent signals return the integrated pulse of the received signals.

VI. CONCLUSION
Through this simulation clearly, it has been demonstrated that unscented Kalman filters are perfect for underwater sonar modelling. Underwater is filled with immense amounts noise and distortion which makes the system highly nonlinear. Unscented Kalman filter selects sigma points across the PDF and continuously iterates them with the current measurement, to predict next state and covariance. The only disadvantage of UKF is that it consumes a lot of computation power and takes considerable time for processing. The greatest advantage of UKF is that it’s a very powerful estimator for highly nonlinear systems. This has greater scope in the field of military, autonomous underwater robotics, underwater object tracking and many more.

VII. REFERENCES
[1] Brown, R.G. and P.Y.C. Wang. Introduction to Random Signal Analysis and Applied Kalman Filtering. 3rd Edition. New York: John Wiley & Sons, 1997.
[2] Wan, Eric A. and R. van der Merwe. “The Unscented Kalman Filter for Nonlinear Estimation”. Adaptive Systems for Signal Processing, Communications, and Control. AS-SPCC, IEEE, 2000, pp.153–158.
[3] Deng ZC, Yu X, Qin HD, Zhu ZB. Adaptive Kalman Filter-Based Single-Beacon Underwater Tracking with Unknown Effective Sound Velocity. Sensors (Basel). 2018;18(12):4339. Published 2018 Dec 8. doi:10.3390/s18124339
[4] Kumar.N, Ashok & Shaik, Riyaz & Swathi, G.. (2015). Application of Extended Kalman filter and Modified Gain Extended Kalman Filter in Underwater Active Target Tracking (Tracking from a stationary observer). International Journal of Advanced Research in Computer and Communication Engineering (IJARCCE). 4. 126-130. 10.17148/IJARCCE.2015.4628.
[5] Huo G, Wu Z, Li J, Li S. Underwater Target Detection and 3D Reconstruction System Based on Binocular Vision. Sensors (Basel). 2018;18(10):3570. Published 2018 Oct 21. doi:10.3390/s18103570
[6] Visual detection and feature recognition of underwater target using a novel model-based method Daxiong Ji , Haichao Li, Chen-Wei Chen, Wei Song and Shiqiang Zhu International Journal of Advanced Robotic Systems November-December 2018: 1–10 ª The Author(s) 2018 DOI: 10.1177/1729881418808991 journals.sagepub.com/home/arx
[7] https://www.mathworks.com/help/phased/ug/underwater-target-detection-with-an-active-sonar-system.html
