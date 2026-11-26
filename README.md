# Moore Sequence Detector 1010 using Verilog HDL

<p align="center">
  <b>RTL Design | Moore Finite State Machine | Functional Verification</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Simulation-Synopsys%20VCS-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Debugging-Synopsys%20Verdi-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Waveform-FSDB-purple?style=for-the-badge" />
</p>

---

## 1. Project Overview

This project presents the RTL design and functional verification of a **1010 Sequence Detector** using Verilog Hardware Description Language (HDL).

The sequence detector is implemented using a **Moore Finite State Machine (FSM)** architecture to detect the occurrence of the binary sequence `1010` in a serial input stream.

The design accepts a single-bit serial input and generates an output HIGH whenever the specified sequence is detected.

The FSM consists of five states representing the progress of sequence detection.

- **S0:** Initial state, waiting for the first bit.
- **S1:** First bit `1` detected.
- **S2:** Sequence `10` detected.
- **S3:** Sequence `101` detected.
- **S4:** Complete sequence `1010` detected.

When the complete sequence is detected, the output `y` becomes HIGH.

The RTL implementation is simulated using **Synopsys VCS**, while waveform visualization and signal-level debugging are performed using **Synopsys Verdi**.

---

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Design Name | Sequence Detector 1010 |
| Design Type | Sequential Logic |
| Architecture | Moore Finite State Machine |
| Detection Sequence | 1010 |
| Input | Single-bit serial input (x) |
| Output | Sequence detection output (y) |
| Number of States | 5 |
| State Encoding | Binary Encoding |
| Reset | Active-high asynchronous reset |
| Clock | Positive-edge triggered |
| HDL | Verilog |
| RTL Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | FSDB and VCD |

---

## 3. Design Methodology

The sequence detector is implemented using a Finite State Machine (FSM).

The FSM continuously monitors the serial input and tracks the previously received bits to identify the sequence `1010`.

The output depends only on the current FSM state.

### 3.1 State Definition

Five states are used to represent the progress of sequence detection.

| State | Binary Encoding | Description |
|---|:---:|---|
| S0 (a) | 000 | Initial state |
| S1 (b) | 001 | First bit `1` detected |
| S2 (c) | 010 | Sequence `10` detected |
| S3 (d) | 011 | Sequence `101` detected |
| S4 (e) | 100 | Complete sequence `1010` detected |

The initial state of the sequence detector is S0.

### 3.2 State Transition Logic

The state transitions are controlled by the serial input `x`.

| Current State | Input x = 0 | Input x = 1 |
|---|---|---|
| S0 | S0 | S1 |
| S1 | S2 | S1 |
| S2 | S0 | S3 |
| S3 | S4 | S1 |
| S4 | S0 | S3 |

The following conditions are implemented:

- When input `1` is received in S0, the FSM moves to S1.
- When input `0` is received in S1, the FSM moves to S2.
- When input `1` is received in S2, the FSM moves to S3.
- When input `0` is received in S3, the FSM moves to S4.
- When the FSM reaches S4, the complete sequence `1010` is detected.
- The output `y` becomes HIGH in S4.
- The FSM returns to the appropriate state depending on the next input bit.

**Note:** The state transition logic supports overlapping sequence detection. After detecting `1010`, if the next input is `1`, the FSM moves to S3 to preserve the matching suffix `101`.

### 3.3 Moore FSM State Diagram and Transition Table

The following diagram represents the Moore FSM architecture and state transitions used for detecting the binary sequence `1010`.

![Moore FSM State Diagram](screenshots/moore_fsm_state_diagram.png)

**Output Conditions:**

| Current State | Output y |
|---|:---:|
| S0 | 0 |
| S1 | 0 |
| S2 | 0 |
| S3 | 0 |
| S4 | 1 |

- **S4:** Indicates successful detection of the binary sequence `1010`.
- All other states maintain the output LOW.

### 3.4 Output Generation

The sequence detector uses Moore FSM output logic.

The output depends only on the current FSM state.

**Boolean Condition:**

- `y = 1` when the current state is S4.
- `y = 0` for all other states.

Therefore, the output becomes HIGH when the complete binary sequence `1010` is detected.

Since this is a Moore FSM, the output changes after the active clock edge updates the state register.

---

## 4. RTL Module Architecture

The project consists of the following Verilog modules:

| Module | Functionality |
|---|---|
| `seq_det_1010` | Implements the Moore FSM sequence detector |
| `seq_det_1010_tb` | Testbench for functional verification |

### 4.1 Sequence Detector Controller

The main RTL module implements the following operations:

**1. State Register**

- Stores the current FSM state.
- Updates on every positive edge of the clock.
- Uses an active-high asynchronous reset.
- Initializes the FSM to state S0.

**2. Next State Logic**

- Determines the next state based on the current state and serial input.
- Implements the sequence detection functionality.
- Uses combinational logic with a `case` statement.
- Tracks the incoming bit pattern to detect `1010`.

**3. Output Logic**

- Generates the sequence detection output `y`.
- Uses the current FSM state to determine the output.
- Implements Moore FSM output behavior.
- Activates the output when the FSM reaches S4.

---

## 5. Repository Structure

```text
sequence-detector-1010/
│
├── seq_det_1010_moore.v
│   └── RTL source code (Moore FSM implementation)
│
├── seq_det_1010_tb.v
│   └── Functional verification testbench
│
├── screenshots/
│   ├── moore_fsm_state_diagram.png
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

Generated simulation files such as FSDB databases, VCD files, compiled executables, and intermediate simulation directories can be maintained locally rather than committed to GitHub.

---

## 6. Functional Verification

A Verilog testbench is developed to verify the functional behavior of the sequence detector.

The testbench generates a clock signal with a 10 ns period and applies different serial input patterns to verify the detection of the binary sequence `1010`.

The simulation uses `$monitor` to display the input, output, reset, clock, and FSM state values during execution.

### 6.1 Test Scenarios

| Test Case | Input Sequence | Expected Detection |
|:---:|---|:---:|
| TC1 | 1010 | 1 |
| TC2 | 1011 | 1 (first four bits) |
| TC3 | 1000 | 0 |
| TC4 | 101010 | 1 (multiple overlapping detections) |

### 6.2 Test Case Description

**TC1: Successful Sequence Detection**

- Apply input sequence `1010`.
- The FSM transitions through S1, S2, S3, and S4.
- Complete sequence is detected.
- Expected output: `y = 1`.

**TC2: Sequence Detection with Additional Input**

- Apply input sequence `1011`.
- The first four bits form the required sequence `1010`.
- The FSM reaches S4 before processing the final bit.
- Expected detection: `y = 1` for the detection state.

**TC3: Sequence Not Detected**

- Apply input sequence `1000`.
- The required sequence `1010` is not present.
- Expected output: `y = 0`.

**TC4: Overlapping Sequence Detection**

- Apply input sequence `101010`.
- The sequence detector identifies repeated occurrences of `1010`.
- The FSM preserves matching bits for subsequent detection.
- Expected detection: `y = 1` whenever the FSM reaches S4.

### 6.3 Testbench Input Sequence

The supplied testbench applies the following input sequence after reset:

```verilog
rst=1;
x=0;
#10;
rst=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=0;
#10 x=1;
#10 x=0;
#10 x=1;
#10 x=0;
#20 $finish;
```

The testbench also includes:

- Clock generation using `forever #5 clk=~clk`.
- Asynchronous reset verification.
- FSDB waveform generation.
- VCD waveform generation.
- `$monitor` for displaying simulation signal values.

---

## 7. Simulation Environment

The design is simulated using Synopsys VCS, and waveform analysis is performed using Synopsys Verdi.

### 7.1 Simulation Workflow

```text
       Verilog RTL Design
               |
               v
        Verilog Testbench
               |
               v
         Synopsys VCS
               |
               v
         RTL Simulation
               |
               v
       FSDB / VCD Database
               |
               v
        Synopsys Verdi
               |
               v
        Waveform Analysis
```

### 7.2 VCS Compilation

Compile the RTL source and testbench using:

```bash
vcs -full64 -debug_access+all \
seq_det_1010_moore.v \
seq_det_1010_tb.v \
-o simv
```

Ensure that the Verdi FSDB PLI integration is configured correctly in the VCS environment.

### 7.3 Execute Simulation

```bash
./simv
```

The simulation executes the testbench and displays the signal transitions using the `$monitor` system task.

### 7.4 FSDB Waveform Generation

The following commands are included in the testbench to generate an FSDB waveform:

```verilog
initial begin
    $fsdbDumpfile("seq_det_1010.fsdb");
    $fsdbDumpvars(0,seq_det_1010_tb);
end
```

The FSDB PLI support must be enabled during VCS compilation.

The testbench also generates a VCD waveform using:

```verilog
initial begin
    $dumpfile("seq_det_1010.vcd");
    $dumpvars(0,seq_det_1010_tb);
end
```

### 7.5 Open FSDB in Synopsys Verdi

Use the following command to open the generated FSDB waveform:

```bash
verdi -ssf seq_det_1010.fsdb &
```

The waveform database can be explored using the Verdi waveform viewer.

---

## 8. Waveform Analysis

Synopsys Verdi is used to inspect and analyze the simulation waveforms.

The waveform screenshot demonstrates the sequence detector simulation using the generated FSDB database.

### 8.1 Observed Signals

| Signal | Width | Description |
|---|---:|---|
| `clk` | 1 bit | Clock input |
| `rst` | 1 bit | Active-high reset |
| `x` | 1 bit | Serial data input |
| `y` | 1 bit | Sequence detection output |
| `state` | 3 bits | Current FSM state |

### 8.2 Verdi Simulation Waveform

![Sequence Detector Verdi Waveform](screenshots/verdi_waveform.png)

Waveform analysis helps to:

- Inspect clock and reset behavior.
- Verify serial input transitions.
- Observe FSM state transitions.
- Verify the detection of binary sequence `1010`.
- Check the output activation in state S4.
- Analyze Moore FSM output behavior.
- Debug sequential circuit functionality.

---

## 9. Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design implementation |
| Finite State Machine | Controller architecture |
| Moore FSM | Sequence detection architecture |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| FSDB | Simulation waveform database |
| VCD | Value Change Dump waveform format |
| Git | Version control |
| GitHub | Source code management and documentation |

---

## 10. Key Learning Outcomes

Through this project, the following concepts are explored:

- Sequential digital circuit design.
- Finite State Machine architecture.
- Moore FSM implementation.
- Binary sequence detection.
- State encoding and state transitions.
- Clock and asynchronous reset implementation.
- Combinational next-state logic.
- Overlapping sequence detection.
- Verilog RTL modeling.
- Testbench development and functional verification.
- RTL simulation using Synopsys VCS.
- Waveform analysis and debugging using Synopsys Verdi.
- FSDB and VCD waveform generation and inspection.

---

## 11. Future Enhancements

Potential extensions to this project include:

- Implementing a Mealy FSM architecture.
- Developing a parameterized sequence detector.
- Supporting multiple sequence detection patterns.
- Implementing a programmable sequence detector.
- Adding detection for longer binary sequences.
- Developing a SystemVerilog testbench.
- Implementing assertions and functional coverage.
- Performing RTL synthesis and hardware area analysis.
- Evaluating timing performance and critical paths.
- Comparing Moore and Mealy FSM implementations.

---

## 12. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Design | VLSI Engineering

- GitHub: [@santhoshkumar-1412](https://github.com/santhoshkumar-1412) 
- LinkedIn: [@santhosh-kumar-n-a](https://linkedin.com/in/santhosh-kumar-n-a-26b72532b)

---

## 13. License

This project is intended for educational and learning purposes.

You are welcome to explore, modify, and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated with Synopsys VCS | Debugged with Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider starring the repository!
</p>

---

## GitHub Topics

verilog · verilog-hdl · sequence-detector · 1010-sequence-detector · finite-state-machine · fsm-design · moore-fsm · rtl-design · vlsi · digital-design · sequential-logic · synopsys-vcs · synopsys-verdi · fsdb · rtl-verification · asic-design · hardware-design
