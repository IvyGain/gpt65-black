# Feasibility assessment — preliminary

| Requirement | Current assessment | Evidence / blocker |
|---|---|---|
| 3 physical keys | Feasible in principle | Existing kit supports three switches; custom GPIO mapping not yet verified |
| IQS550 I2C host | Likely feasible | Module has SCL/SDA, RDY and NRST; protocol, timing and voltage need verification |
| BLE keyboard + pointing | Feasible in principle | Requires actual nRF52840 firmware and macOS bench testing |
| Native macOS multitouch | **Unverified/high risk** | BLE mouse HID is not equivalent to an Apple Magic Trackpad; shortcut-emulated gestures are a fallback |
| RGB underglow | Feasible in principle | LED part, voltage, current and mechanical diffusion not selected |
| Rechargeable 1S LiPo | Feasible in principle | Must validate XIAO charging, protection, polarity, power switch architecture and battery placement |
| <=12 mm including keys | **Unverified/high risk** | Need measured switch/keycap height, travel clearance, trackpad overlay and battery stack-up |
| CNC aluminum shell | Feasible in principle | Must provide RF-transparent antenna area and avoid metal above touch sensing surface |

## GO/NO-GO bench gates
1. Confirm correct IQS550 electrical supply and I2C response without altering the kit.
2. Obtain stable cursor/scroll data on XIAO and transmit as BLE HID to macOS.
3. Confirm intended three-key shortcuts and define gestures achievable via shortcut emulation.
4. Measure physical stack-up and reject the 12 mm target if measured constraints cannot fit safely.
5. Verify battery and charging design against component datasheets before battery connection.

No final PCB routing or battery selection until gates are satisfied.
