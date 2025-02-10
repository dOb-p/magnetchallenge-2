# MagNet Challenge 2 in 2025
## IEEE PELS MagNet Challenge (MagNet Challenge 2)
<img src="img/mclogo.jpg" width="800">

## This site provides the latest information about the MagNet Challenge 2. 
## Please contact [pelsmagnet@gmail.com](mailto:pelsmagnet@gmail.com) for all purposes.

## MagNet Challenge 2 Overview
<img src="img/overview.jpg" width="800">

Build upon the success of MagNet Challenge 1, the goal of the MagNet Challenge 2 is to develop intelligent software tools that can learn and predict magnetic characteristics in transient. For each magnetic material of interest, we are looking for a MATLAB or Python function that takes the following three inputs:

-	A pair of B(t) and H(t) waveforms documenting the excitation history from t_0 to t_1;
- A future flux density excitation wave B’(t) from t_1 to t_2;
- Temperature: T.

And produce the following one output:
- The corresponding field strength wave H’(t) from t_1 to t_2 paired with B’(t).

This function should be packaged as: H'(t)=function (B(t),H(t),B'(t),T). 

In order to capture the physical behaviors of the magnetic material in transient, the models should be frequency agnostic (no frequency information), time-step agnostic (short or long time-steps), and initial-state agnostic (always converging after a long time). We encourage using the latest stable version of commonly used MATLAB and Python packages. Analytical methods and machine learning methods are both encouraged.

There are intrinsic correlations between the materials behavior in steady-state and in transient. In fact, a model operates well for transient conditions must operate well in steady states. As a result, student teams are encouraged to reuse the data and models made available for the MagNet Challenge 1 in 2023 and leverage the physical and analytical understandings of the models developed for the MagNet Challenge 1 in 2023 for the MagNet Challenge 2 in 2025.

Please refer to the [Handbook](docs/Handbook-2025.pdf) and [Slides](docs/Slides-2025.pdf) for more details.

## MagNet Challenge 2 Timeline

- 02-14-2025 Initial Call for Participation Announcement [Handbook](docs/Handbook-2025.pdf) [Slides](docs/Slides-2025.pdf) [SignUp](docs/SignUpForm-2025.pdf) 
- 03-18-2025 APEC Official Annoucement
- 04-01-2025 Data for 10 Materials Available
- 05-01-2025 1-Page Letter of Intent Due with Signature 
- 06-01-2025 2-Page Concept Proposal Due [PDF](docs/template.pdf) [DOC](docs/template.doc) [Latex](docs/ieeetran.zip)
- 07-01-2025 Notification of Acceptance
- 08-01-2025 Expert Feedback on the Concept Proposal
- 11-01-2025 Preliminary Submission Due, Data for 5 New Materials Available
- 12-24-2025 Final Submission Due
- 03-01-2026 Winners Selected

## Evaluation Timeline

- 06-15-2025 Evaluate the concept proposals and ensure all teams understand the competition rules.
- 11-15-2025 Evaluate the 10 models the teams developed for the 10 materials and provide feedback for improvements.
- 12-31-2025 Evaluate the 3 new models the teams developed for the 3 new materials and announce the winners.

## Evaluation Criterias

The judging committee will evaluate the results of each team with the following criterias.
- Model accuracy: core loss and B-H trajectory prediction accuracy (lower error better)
- Model size: number of parameters the model needs to store for each material (smaller model better)
- Model explanability: explanability of the model based on existing physical insights (more explainable better)
- Model novelty: new concepts or insights presented by the model (newer insights better)
- Software quality: quality of the software engineering (more concise better)

## MagNet Challenge Discussions

- MagNet GitHub Discussion Forum [Link](https://github.com/minjiechen/magnetchallenge-2/discussions)

## MagNet Challenge Awards (pending)

- Model Performance Award, First Place        $10,000
- Model Performance Award, Second Place       $5,000
- Model Novelty Award, First Place            $10,000
- Model Novelty Award, Second Place           $5,000
- Outstanding Software Engineering Award      $10,000
- Honorable Mentions Award         multiple x $1,000

## **Useful Links for MagNet Challenge 2 in 2025
[MagNet Challenge 1 in 2023](https://github.com/minjiechen/magnetchallenge) - maintained by Princeton University

[MagNet Open Database](https://www.princeton.edu/~minjie/magnet.html) - maintained by Princeton University

[MagNet-AI Platform](https://mag-net.princeton.edu/) - maintained by Princeton University

[MagNet Toolkit](https://github.com/upb-lea/mag-net-hub) - maintained by Paderborn University

## Other Related Resources

- [MagNet Challenge Homepage](https://minjiechen.github.io/magnetchallenge/)
- [MagNet Challenge GitHub](https://github.com/minjiechen/magnetchallenge)
- [MagNet-AI Platform](https://mag-net.princeton.edu/)
- [MagNet-AI GitHub](https://github.com/PrincetonUniversity/Magnet)
- [Princeton Power Electronics Research Lab](https://www.princeton.edu/~minjie/magnet.html)
- [Dartmouth PMIC](https://pmic.engineering.dartmouth.edu/)
- [ETHz PES](https://pes.ee.ethz.ch/)

## MagNet Project Reference Papers

- S. Wang, H. Kwon, H. Li, et al. "MagNetX: Foundation Neural Network Models for Simulating Power Magnetics in Transient," TechRxiv. December 11, 2024. [Paper](https://www.techrxiv.org/doi/full/10.36227/techrxiv.173396153.34393547)
- H. Kwon, S. Wang, H. Li, et al. "MagNetX: Extending the MagNet Database for Modeling Power Magnetics in Transient," TechRxiv. December 11, 2024. [Paper](https://www.techrxiv.org/doi/full/10.36227/techrxiv.173396064.40994860)
- D. Serrano et al., "Why MagNet: Quantifying the Complexity of Modeling Power Magnetic Material Characteristics," in IEEE Transactions on Power Electronics, doi: 10.1109/TPEL.2023.3291084. [Paper](https://ieeexplore.ieee.org/document/10169101)
- H. Li et al., "How MagNet: Machine Learning Framework for Modeling Power Magnetic Material Characteristics," in IEEE Transactions on Power Electronics, doi: 10.1109/TPEL.2023.3309232. [Paper](https://ieeexplore.ieee.org/document/10232863)
- H. Li, D. Serrano, S. Wang and M. Chen, "MagNet-AI: Neural Network as Datasheet for Magnetics Modeling and Material Recommendation," in IEEE Transactions on Power Electronics, doi: 10.1109/TPEL.2023.3309233. [Paper](https://ieeexplore.ieee.org/document/10232911)

## Organizers
<img src="img/magnetteam.jpg" width="800">

