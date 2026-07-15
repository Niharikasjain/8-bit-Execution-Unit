# 8-Bit Mini-Processor Execution Unit (RTL Design & Synthesis)

## 📌 Project Overview
This repository contains the clean, production-grade RTL design, functional simulation validation, and logic synthesis tracking for a custom **8-Bit Single-Cycle Mini-Processor Execution Unit**. Built using **Verilog HDL** inside **Xilinx Vivado**, this hardware block separates a fully combinational control unit from a synchronous register-bounded datapath.

## 🏗️ Hardware Architecture & Instruction Set
The execution unit decodes and executes incoming structured 8-bit instructions, which are split into a 4-bit Opcode (MSB) and a 4-bit immediate Data Operand (LSB).

| Opcode (Bits 7:4) | Instruction | Description |
| :---: | :---: | :--- |
| `0001` | **LOAD** | Bypasses current state; routes immediate data to initialize the Accumulator. |
| `0010` | **ADD** | Computes binary addition between immediate data and the Accumulator. |
| `0011` | **AND** | Executes a bitwise logical AND masking operation. |

### System Module Hierarchy
The design adheres strictly to modular RTL design practices to maximize testability and reuse:
* `design/mini_processor.v`: Top-level structural connector wrapper linking submodules via point-to-point wire buses.
* `design/control_unit.v`: Combinational decoding matrix handling data steering and operation routing.
* `design/datapath.v`: Execution core housing the combinational ALU matrix and an edge-triggered 8-bit Accumulator storage register.
* `simulation/tb_mini_processor.v`: Testbench executing an automated verification string on a clock-driven 100MHz matrix.

---

## 🧪 Verification & Timing Waveforms
Functional logic verification was completed using a clock-driven behavioral testbench operating on a simulated **100MHz system clock**. The simulation timeline confirms perfect calculation execution across multiple clock cycles, showing the total accumulating steadily ($0 \rightarrow 5 \rightarrow 8 \rightarrow 8 \rightarrow 18$, represented as hexadecimal `12`):

![Simulation Waveform](docs/simulation_waveform.png)

---

## 📊 Post-Synthesis Resource Utilization
The design was successfully synthesized targeting a Xilinx Artix-7 FPGA architecture, showing highly optimized hardware footprints with zero DRC or timing violations:

* **LUTs (Look-Up Tables):** Optimized combinational paths matching minimal gate requirements.
* **FFs (Flip-Flops):** Exactly 8 bits used for the internal Accumulator Register storage matrix.
* **IOB (Input/Output Blocks):** 18 hardware pins mapped (8 instruction inputs, 8 result outputs, 1 clock, 1 reset).
* **BUFG (Global Clock Buffer):** 1 mapped to eliminate internal clock skew.

![Resource Utilization](docs/resource_utilization.png)
