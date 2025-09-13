# Reinforcement Learning and Regression Enhanced ADRC for Mobile Robot Control

This repository contains MATLAB/Simulink models and scripts for trajectory tracking control of a **Differential Drive Mobile Robot (DDMR)**.  
The project integrates **Active Disturbance Rejection Control (ADRC)** with **Time Series Regression (TSR)** and **Deep Reinforcement Learning (DDPG)** to enable adaptive, automated tuning of ADRC parameters.

The work is based on the paper *“Enhancing Mobile Robot Trajectory Tracking with Time Series Regression and Reinforcement Learning”*.

---

## 🚀 Key Features
- **Mobile Robot Kinematics & Dynamics**: Forward and inverse kinematics, dynamic modeling with motor torque inputs.  
- **ADRC Controller**: Extended State Observer (ESO) + Nonlinear State Error Feedback (NLSEF) for robust disturbance rejection.  
- **Time Series Regression (TSR)**: LSTM model predicts future states (x, y, θ) to enhance control performance.  
- **Reinforcement Learning (RL)**: Deep Deterministic Policy Gradient (DDPG) agent tunes ADRC parameters (Kp, Kd, ωo) online.  
- **Trajectory Tracking**: Circular path tracking under various disturbances (step, pulse, sinusoidal).  
- **Performance Evaluation**: Comparison between manually tuned ADRC and RL+Regression-enhanced ADRC.  

---

## 📂 Repository Structure
- `simulink_models/` → Multiple `.slx` Simulink models (Kinematics, ADRC, RL-DDPG integration).  
- `scripts/` → MATLAB scripts for training, testing, and plotting results.  
- `data/` → Training datasets for TSR (collected from simulation).  
- `docs/` → Project report and additional documentation.  
- `README.md` → Project overview (this file).  

---

## ⚙️ Requirements
- MATLAB R2021a or later  
- Simulink  
- Deep Learning Toolbox (for LSTM & DDPG)  
- Reinforcement Learning Toolbox  
- Control System Toolbox (optional, for ADRC analysis)  

---

## ▶️ How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/Reinforcement-Learning-and-Regression-Enhanced-ADRC.git
   cd Reinforcement-Learning-and-Regression-Enhanced-ADRC
   
2. Open MATLAB and navigate to the repository folder.

3. Open the required Simulink file.

4. Run the simulation to test different scenarios.
