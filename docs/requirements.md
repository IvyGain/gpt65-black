# Product requirements (draft)

## Physical
- In use, the trackpad is nearest the operator and the three Sunset Choc V1 keys form a row on the far side. The compact reference design puts USB-C and the power switch on the far edge.
- Matte black minimal industrial design; controlled diffuse RGB key underglow.
- Thickness target <=12 mm including keycaps, excluding feet. Must verify via measured stack-up.
- RF-transparent antenna region even if using CNC aluminum.

## Electronics
- Reuse existing IQS550-based trackpad where feasible.
- Prototype controller: Seeed XIAO nRF52840.
- BLE HID keyboard + pointing device; Mac compatibility verified on real hardware.
- USB-C charging, protected 1S LiPo, physical switch, battery monitoring, sleep.
- Addressable RGB LEDs, brightness limits and power gating where needed.

## Software
- Configurable three-key shortcuts, pointing, scrolling, gesture mapping.
- Separate macOS-native multitouch gestures from shortcut-emulated gestures.
- Future macOS configuration app over a documented BLE GATT service.

## Non-goals for Phase 1
- No PCB manufacturing, battery purchase, enclosure machining or irreversible soldering.
