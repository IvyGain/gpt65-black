# GRT65 BLACK EDITION — Codex Instructions

Goal: build a manufacturable ultra-thin (target <=12 mm including keycaps, excluding feet) wireless macOS trackpad and three-key controller using the GRT65-EXP Kit as reference.

## Sources
- https://geek-rabb1t.github.io/grt65-expkit/build_guide
- https://github.com/geek-rabb1t/grt65-expkit
- https://github.com/geek-rabb1t/GR-Trackpad65
Read original source files, schematics, board files, firmware, and licenses. Do not assume repository paths or pin mappings.

## User-approved design requirements
- IQS550-based touchpad reused where feasible, located above three horizontally arranged keys
- Three Kailh Choc V1 Sunset tactile switches; MBK black 1U caps
- Bluetooth LE HID to Mac; USB-C charging; protected rechargeable single-cell battery; physical power switch
- Addressable RGB key underglow with adjustable color/brightness/modes via future macOS control app
- Matte black enclosure, CNC aluminum candidate, RF-transparent antenna zone
- 12 mm maximum thickness is a TARGET, not an established feasibility result

## Parts already ordered
- Sunset Choc V1 x3
- MBK black 1U keycaps (10 pack)
- Seeed XIAO nRF52840 x1
- 2-in-1 key puller x1
Existing GRT65-EXP kit is unassembled. Keep it unmodified until validation.

## Work sequence and gates
1. Source audit: pin maps, schematics, voltages, mechanical geometry, licensing, BOM; cite file paths and source revisions.
2. Feasibility: IQS550 I2C communication, IRQ/reset, BLE HID pointing and keyboard, macOS gestures, power consumption. Separate native multitouch from shortcut-emulated gestures.
3. Prototype: bench-test XIAO and touchpad without irreversible changes. Verify logic levels and current limits before power-on.
4. Mechanical stack-up: measure actual components, validate switch travel, battery clearance, antenna keepout, LED diffusion and USB-C access; 12 mm is unverified until CAD interference check.
5. Custom PCB and enclosure: KiCad ERC/DRC, fabrication files only after review; battery safety and RF review.
6. macOS control app: BLE GATT for RGB and remapping; no claim of live hardware support until tested.

## Safety / engineering rules
Never invent electrical connections or treat image-derived guesses as verified. No direct 5V to LiPo; validate charging and protection against datasheets. Never commit secrets. Do not order parts or make irreversible hardware changes autonomously. Mark every claim VERIFIED / INFERRED / UNVERIFIED, and list blocking tests.

## Phase 1 deliverables
- docs/source-audit.md
- docs/pin-map.md
- docs/feasibility.md
- docs/stackup.md
- bom/parts.csv
- docs/bench-test-plan.md

Begin with read-only source audit and commit reports. Do not jump into fabrication or firmware claims before source validation.
