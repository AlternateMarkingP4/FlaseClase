# P4 Alternate Marking Algorithm
In this repository you may find an implementation of the algorithems Double Marking and Multiple Marking with p4-switches and a C program.
It is base on time_stamping_simulation_P4 Project: https://github.com/MichaelBun/time_stamping_simulation_P4

## Some Background First
This project ...
In addition we created a MiniNet simulation network model that demonstrates the benefits of the mentioned features. <br /> 
Specifically, this repository includes a demo that uses the time-of-day metadata to exhibit a round-robin like routing, that helps us load balance the system, in order to increase packet throughput.

#### Before Getting Started
This simulation was run on Ubuntu 14.04 and on Mininet 2.2.2. It should work on later versions as well. <br /> 
For the simulation it is required to have about 400MB of free disk space.

## Topology
The topology we use in our simulation network is as follows : ![Topology](https://github.com/MichaelBun/time_stamping_simulation_P4/blob/master/topology-resized.jpg)

## Installation

1.  Run: `sudo apt-get install python-pip` and `sudo apt-get install git`
2.  Select or create a directory for the project and change current directory to it using the terminal
3.  Run: 
	- `git clone https://github.com/MichaelBun/behavioral-model bmv2`
	- `git clone https://github.com/p4lang/p4c-bm p4c-bmv2` <br />
    We are cloning the P4 required files and its behavioral model. Please notice, the `bmv2`, `p4c-bmv2` directories must be in the same parent directory.
4.  Enter the `p4c-bmv2` directory, and run: `sudo pip install -r requirements.txt`
5.  Return to the parent directory and move to the `bmv2` directory. <br /> 
    Run the following scripts by order (add execution permission if needed):
	 - `install_deps.sh`
	 - `autogen.sh`
	 - `configure`
	 -  Use `make` to build the code
6.	From the parent directory containing `bmv2` and `p4c-bmv2`. <br /> 
	Run: ```git clone https://github.com/AlternateMarkingP4/FlaseClase.git```
   - In directory FlaseClase/simulation_double run `chmod 777 re*`
   - In directory FlaseClase/simulation_multiplexed run `chmod 777 re*`
7.  Install Mininet (skip this part if you already have the newest Mininet version installed). <br />
	From the desired location, run by order:
	 - `git clone git://github.com/mininet/mininet`
	 - `mininet/util/install.sh`
8.  Install the `scapy`, `thrift`, and `networkx` python packeges, running: `sudo pip install scapy thrift networkx`
9.  Install `iperf` using: `sudo apt-get install iperf`

## Running the Double Marking algorithm
1. Move back to the `FlaseClase/simulation_double` directory, and run the script `run_demo.sh` (add execution permission if needed).
2. Check if the system topology is connected using `h1 ping h2`. <br /> 
If you see that packets are transmitted between the hosts you can move on to the next step
3. Inside the mininet command prompt open a terminal for hosts 1 and 2 using : `xterm h1 h2`
4. Run on host 2: `iperf -su -i -1`.Run on host 1: `iperf -c 10.0.0.2 -u -b 2m -t 60`. <br /> 
5. On a different terminal run from FlaseClase directory `run_double_marking.sh`. <br />
6. Run on host 1: `iperf -c 10.0.0.2 -u -b 2m -t 60`. <br />
7. When you are done, you must exit the Mininet environment using `exit` in the mininet promt (**See note**)

### Changing Time Periods

#### Note
If Mininet was closed improperly, please use `sudo mn -c` before doing anything else to clean up any residue left by the Mininet software.

## Credits
This project was built by Yonnie Kirzon and Alon Riesenberg (undergrad students in the Technion - Israel Institute of Technology) for their BSc degree with the supervision of Tal Mizrahi, PhD, in association with Marvell Israel.

Our system is based in the source routing example from the SIGCOMM 2015 P4 tutorial, and our switch code is based on the P4 simple router example.
