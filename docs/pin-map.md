# Pin mapping — evidence-first

## Verified at the GR-Trackpad65 module FFC
| Contact | Signal | Source |
|---|---|---|
| 1 | RDY | GR-Trackpad65 README |
| 2 | NRST | GR-Trackpad65 README |
| 3 | GND | GR-Trackpad65 README |
| 4 | VCC | GR-Trackpad65 README |
| 5 | SCL | GR-Trackpad65 README |
| 6 | SDA | GR-Trackpad65 README |

**DO NOT WIRE DIRECTLY FROM THIS TABLE.** This is the module-side numbering described by the author, not an independently verified view of the opposite end of the FFC or the expkit host connector. The cable contact orientation, host connector pad numbering, VCC voltage, logic thresholds, and XIAO pin mapping must be validated from schematics, connector datasheets and continuity measurements.

## Pending
- KiCad expkit connector netlist and RP2040-Zero pin assignment.
- XIAO nRF52840 SDA/SCL, IRQ/NRST GPIO choices and available pins.
- Voltage compatibility and pull-ups; ground reference; supply current.
- Bench wiring table, after verification.

Safety gate: no power-on until VCC/GND and logic levels are established.
