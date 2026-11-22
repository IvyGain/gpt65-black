# Phase 1 — source audit and feasibility

1. Clone/download upstream repositories and record commit hashes, licenses and relevant paths.
2. Inspect KiCad schematics and PCB files, verify switch matrix, trackpad connector pin order, IQS550 supply voltage, reset/ready signals, RP2040-Zero mapping and physical dimensions.
3. Inspect original firmware and identify which gesture logic can be reused and what needs rewriting for BLE.
4. Check XIAO nRF52840 pin availability, I2C voltage compatibility, charging constraints, power budget and antenna clearance.
5. Assess BLE HID support for cursor, scroll, keyboard and native macOS multitouch separately.
6. Produce: source-audit.md, pin-map.md, feasibility.md, stackup.md, bench-test-plan.md, and bom/parts.csv.
7. List unanswered questions, required measurements and explicit GO/NO-GO criteria.

Do not assume upstream assets are redistributable. Link rather than copy until license is checked.
