# Bench test plan (no soldering to kit yet)

1. Photograph all board faces and connector markings; measure thickness and external dimensions with calipers.
2. Inspect original expkit schematic and GR-Trackpad65 schematic in KiCad; generate and review netlist.
3. Validate FFC cable orientation and connector numbering against manufacturer datasheets.
4. Identify IQS550 voltage requirements from exact part datasheet and trackpad schematic; check logic-level compatibility with XIAO.
5. Only then create a current-limited test hookup with appropriate connector breakout; check for shorts before power.
6. Scan/read IQS550 on I2C and log RDY/NRST timing; do not flash configuration without evidence it is required.
7. Prototype BLE keyboard and relative mouse movement; test on macOS.
8. Test scrolling and gestures separately, documenting what is native vs shortcut-emulated.
9. Record idle/active current before selecting battery capacity.
10. Only after electrical tests, evaluate LEDs, battery circuit, and 12 mm CAD stack-up.

STOP conditions: unknown VCC, unknown cable orientation, unexpected current, overheating, battery polarity ambiguity.
