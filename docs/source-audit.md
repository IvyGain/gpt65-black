# Phase 1 source audit — initial verified findings

Status: PARTIAL. Source repositories were accessed through GitHub; physical/electrical validation remains outstanding.

## Repositories
- [grt65-expkit](https://github.com/geek-rabb1t/grt65-expkit), default branch `master`, commit SHA `b5f1f13de7174624f89a41ebc992bdd7102dd792`.
- [GR-Trackpad65](https://github.com/geek-rabb1t/GR-Trackpad65), default branch `main`, commit SHA `79e68a0a344df3488b5fa36183299b8b5d22439a`.
- Both repository licenses need to be preserved when copying their source files. The expkit LICENSE was directly read and is MIT, copyright 2025 geek-rabb1t. GR-Trackpad65 LICENSE was also read directly. It is MIT, copyright 2024 geek-rabb1t. Both license notices accompany the exported XML.

## Verified upstream file inventory
Expkit: `pcb/grt65_exp_kit.kicad_sch`, `pcb/grt65_exp_kit.kicad_pcb`, `pcb/grt65_exp_kit_plate.kicad_pcb`, `firmware/geek_rabb1t_grt65_exp_kit_vial.uf2`, `firmware/grt65_expkit_default_keymap.vil`. The schematic is KiCad 8 format and has been opened.
Trackpad: `pcb/trackpad.kicad_sch`, `pcb/trackpad.kicad_pcb`, `config/GR-Trackpad65.ini`, `config/GR-Trackpad65_V0.3.hex`.

## Verified trackpad README facts
- GR-Trackpad65 uses Azoteq IQS550.
- Module active PCB outline is listed as 49 x 65 mm (49 x 79 mm with fabrication tab).
- FFC pin assignment, left to right: 1 RDY; 2 NRST; 3 GND; 4 VCC; 5 SCL; 6 SDA.
- Trackpad PCB is specified as 4-layer, 1.6 mm. Changing thickness may affect operation.
- Surface overlay is required; recommended matte acrylic thickness is 2 mm. Other overlays require calibration.
- Newly manufactured IQS550 boards require programming; CT210A tool and Azoteq software are referenced. Do not assume supplied kit module needs reprogramming.
- The expkit README describes a macro pad supporting up to four fingers; its firmware is linked to a Vial-QMK branch.

## Unverified / pending
- Actual supply and I/O levels, trackpad current, and physical FFC orientation remain unverified. Schematic power domains, GPIOs and switches are recorded in [pin map](pin-map.md).
- BLE HID support for Mac native multi-touch gestures; expected workaround may be keyboard-shortcut emulation.
- Measured overall case/keys/PCB/battery stack-up.

Sources:
- https://github.com/geek-rabb1t/grt65-expkit/blob/master/README.md
- https://github.com/geek-rabb1t/grt65-expkit/blob/master/pcb/grt65_exp_kit.kicad_sch
- https://github.com/geek-rabb1t/GR-Trackpad65/blob/main/README.md

See [netlist recheck and Issue #1 status](issue-1-electrical-audit.md) for current evidence.
