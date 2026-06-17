# Bidirectional UART Communication System

## Overview

This project implements a bidirectional UART communication system in Verilog HDL. Two UART devices communicate with each other through independent transmit and receive channels, enabling full-duplex data transfer. The design includes a UART Transmitter, UART Receiver, and Baud Rate Generator, and has been verified through simulation in Vivado.

---

## Design Architecture

### Baud Generator Specifications

| Parameter              | Value    |
| ---------------------- | -------- |
| System Clock Frequency | 500 MHz  |
| Baud Rate              | 9600 bps |
| Oversampling Rate      | 16×      |
| TX Counter Value       | 52083    |
| RX Counter Value       | 3256     |

### System Block Diagram

The communication system consists of two UART devices connected in a full-duplex configuration.

```text
Device A TX  ---------->  Device B RX

Device A RX  <----------  Device B TX
```

Each device contains:

* UART Transmitter (TX)
* UART Receiver (RX)
* Baud Rate Generator

---

## Project Structure

```text
Bidirectional-UART-Verilog
│
├── architecture/
│   ├── bidirectional_uart_architecture.png
│   └── uart_loopback_architecture.png
│
├── rtl_design/
│   ├── uart_tx.vbaud_generator.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   ├── deviceA.v
│   ├── deviceB.v
│   └── Top_module.v
│
├── testbench/
│   └── testbench
│
├── simulation_results/
│   ├── A-B communication
│   └── B-A communication
│   |__ Full-duplex communication
└── README.md
```

---

## Verification

The design was verified using the following test cases:

| Test Case                              | Result |
| -------------------------------------- | ------ |
| Device A → Device B (0x55)             | PASS   |
| Device B → Device A (0xbb)             | PASS   |
| Simultaneous Full-Duplex Communication | PASS   |

### Full-Duplex Test

```text
Device A Sent      : 0x55
Device B Sent      : 0xaa

Device A Received  : 0xaa
Device B Received  : 0x55
```

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* gtkwave
* vscode

---

## Future Improvements

* Parity bit support
* APB-UART peripheral integration
* FPGA implementation and hardware testing

