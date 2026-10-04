# OMNeT++ Queueing System Simulation

A discrete-event simulation project that models and analyzes finite-capacity queueing systems using **OMNeT++** and the **INET Framework**.

The project implements **M/M/1/L** and **M/M/c/L** queueing models and compares simulation results with analytical queueing theory results under different arrival rates and server configurations.

## Overview

The main goal of this project is to study how arrival rate, queue capacity, and the number of servers affect queueing system performance.

Two queueing architectures were simulated:

- **M/M/1/L** — single-server finite-capacity queue
- **M/M/c/L** — multi-server finite-capacity queue

The simulations use:

- Poisson packet arrivals
- Exponentially distributed service times
- Finite system capacity
- Packet dropping when the system reaches capacity

## Simulation Models

### M/M/1/L

A single-server queue with finite capacity.

The following configurations were tested:

| Arrival Rate (λ) | Service Rate (μ) | Capacity (L) |
|---:|---:|---:|
| 2 | 5 | 5 |
| 3 | 5 | 5 |
| 4 | 5 | 5 |

### M/M/c/L

The model was extended to support multiple servers.

Experiments were performed using:

- `c = 2`
- `c = 4`

with different arrival rates including:

- `λ = 2`
- `λ = 3`
- `λ = 4`

The multi-server model uses a demultiplexer to distribute incoming packets across servers and a multiplexer to collect completed packets before forwarding them to the sink.

## Performance Metrics

The following metrics were analyzed:

- Blocking probability
- Effective arrival rate / throughput
- Server utilization
- Mean queue length
- Mean number of jobs in the system
- Average waiting time
- Average waiting time of packets that actually waited
- Average service time
- Response time

## Results

Simulation outputs were compared with analytical queueing theory calculations.

For most experiments, the difference between theoretical and simulated results remained below **5%**.

The experiments showed that:

- Increasing the arrival rate increases congestion.
- Higher arrival rates increase queue length and waiting time.
- Blocking probability increases as the system becomes more heavily loaded.
- Adding more servers reduces congestion.
- Multi-server configurations significantly reduce queueing delay and blocking probability.

For example, in the M/M/1/5 configuration with `λ = 3` and `μ = 5`, the simulation produced results very close to the analytical model for throughput, utilization, queue length, waiting time, and response time.

## Technologies

- OMNeT++
- INET Framework
- NED
- OMNeT++ `.ini` configuration files
- Queueing Theory
- Discrete Event Simulation

## Project Structure

```text
omnet-queueing-simulation/
│
├── src/
│   ├── Task1MM1LInet.ned
│   └── MMcL_Inet.ned
│
├── configs/
│   ├── mm1_lambda2.ini
│   ├── mm1_lambda3.ini
│   ├── mm1_lambda4.ini
│   └── mmcl.ini
│
├── report/
│   └── CNG436_Assignment2_Report.pdf
│
└── README.md
