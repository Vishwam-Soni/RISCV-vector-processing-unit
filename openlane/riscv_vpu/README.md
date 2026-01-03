# OpenLane Physical Design – RISC-V Vector Processing Unit

This directory contains the full RTL-to-GDSII ASIC implementation of a
32-bit RISC-V Vector Processing Unit (VPU) using the OpenLane flow
and Sky130 PDK.

---

## 📐 Design Overview

- **Top module:** `vpu_top`
- **ISA:** RISC-V RV32 (scalar control + custom vector datapath)
- **Pipeline:** 5 stages (IF → ID → EX → MEM/VEC → WB)
- **Vector Width:** Configurable (VLEN × EWIDTH)
- **Technology:** Sky130A (sky130_fd_sc_hd)

---

## 🛠️ OpenLane Flow Executed

The complete non-interactive OpenLane flow was successfully run:

1. **RTL Linting & Synthesis**
   - Yosys synthesis
   - Verilator lint checks
   - Area-optimized synthesis strategy

2. **Floorplanning**
   - Custom DIE area
   - IO placement with met2/met3 routing layers
   - Power grid generation

3. **Placement**
   - Global placement
   - Detailed placement
   - Congestion-aware optimization

4. **Clock Tree Synthesis (CTS)**
   - Balanced clock tree insertion
   - Target skew control
   - CTS buffer insertion verified in KLayout

5. **Routing**
   - Global routing
   - Detailed routing using TritonRoute
   - DRC-clean routing achieved

6. **Signoff**
   - STA (setup & hold analysis)
   - DRC and LVS checks
   - Final GDSII generation

---

## 📊 Key Results

- **CTS completed successfully**
- **Timing clean** (no setup violations post-CTS)
- **DRC-clean GDS**
- **Final deliverables generated:**
  - `vpu_top.gds`
  - `vpu_top.lef`
  - `vpu_top.sdf`
  - `vpu_top.lib`

---

## 📂 Directory Structure


---

## 🔍 Visualization

The final layout was verified using **KLayout**, including:
- CTS buffer insertion
- Clock routing
- Power grid integrity

---

## 🧠 Key Learnings

- RTL design for ASIC-friendly synthesis
- Clock tree design and skew control
- IO placement constraints
- Debugging OpenLane routing & timing failures
- End-to-end ASIC implementation workflow

---

## 🚀 Status

✅ RTL → GDSII flow completed successfully  
