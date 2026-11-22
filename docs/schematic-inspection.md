# Phase 1 schematic inspection — verified snapshot

Inspected directly via GitHub connector on 2026-11-22. This is a **static source inspection**, not a successful electrical test or KiCad netlist export.

## Source revisions
- expkit `pcb/grt65_exp_kit.kicad_sch` blob SHA `5147531e8b4dff36f90a83ebfdcb63db3283fa3c`
- GR-Trackpad65 `pcb/trackpad.kicad_sch` blob SHA `eae575d69d09dc943e16be2da9d8ecb97c884f14`
- expkit source tree `b5f1f13de7174624f89a41ebc992bdd7102dd792`
- GR-Trackpad65 source tree `79e68a0a344df3488b5fa36183299b8b5d22439a`

## Confirmed in expkit schematic
- `U1` is `RP2040-Zero`.
- `J1` and `J2` are 12-pin 2.54 mm headers.
- `J3` is a 6-pin FFC/FPC connector, footprint `gr_keyboard:Jushuo_AFC07-S06FCA-00_1x6-1MP_P0.50_Horizontal-JLC`.
- `SW1`, `SW2`, `SW3` are present.
- `R1` and `R2` are marked `1kΩ` in the schematic.
- Explicit expkit schematic net labels include `SCL`, `SDA`, `VDD`, `GND`; power symbol `+3.3V` appears.
- **Caution:** no `RDY` or `NRST` labels were found in the expkit schematic label scan. This does NOT prove the signals are unconnected; they could be routed without named labels or handled differently. Full netlist verification is mandatory.

## Confirmed in trackpad schematic
- Labels `RDY`, `NRST`, `SCL`, `SDA`, `VDD`, `GND` appear.
- A `+3V3` power symbol appears in this schematic.
- These observations do not establish connector pin direction, all signal levels, or current budget.

## Next executable work
1. Export KiCad netlists from both upstream schematics using KiCad 8+ and record connector pin-to-net mapping.
2. Inspect FFC connector orientation, pin-1 indicators and actual cable contact faces before drawing any wiring diagram.
3. Confirm XIAO nRF52840 board pinout, voltage levels, charging topology, and available pins using the manufacturer's board documentation.
4. Validate IQS550 I2C protocol and whether RDY/NRST are required by the target firmware.
5. Produce reviewed bench wiring and tests. Do not power hardware from inferred pin assignments.

## Source links
- https://github.com/geek-rabb1t/grt65-expkit/blob/master/pcb/grt65_exp_kit.kicad_sch
- https://github.com/geek-rabb1t/GR-Trackpad65/blob/main/pcb/trackpad.kicad_sch

## KiCad ネットリストによる追検証

**VERIFIED（静的）** 上記の expkit と trackpad のリビジョン ID は実際のコミット ID と一致し、両回路図の Git blob SHA も一致した。KiCad 9.0.2+dfsg-1 で以下を実行し、XML のコネクタ全ピンを PCB のパッドネットと照合した。保存した XML は `design/source` の作業場所の接頭辞のみ除去している。隣接する LICENSE は各上流の MIT ライセンス。

```sh
git clone https://github.com/geek-rabb1t/grt65-expkit.git exp
git clone https://github.com/geek-rabb1t/GR-Trackpad65.git pad
git -C exp checkout --detach b5f1f13de7174624f89a41ebc992bdd7102dd792
git -C pad checkout --detach 79e68a0a344df3488b5fa36183299b8b5d22439a
kicad-cli sch export netlist --format kicadxml -o expkit.xml exp/pcb/grt65_exp_kit.kicad_sch
kicad-cli sch export netlist --format kicadxml -o trackpad.xml pad/pcb/trackpad.kicad_sch
```

- [expkit XML](netlists/expkit.xml) · [回路図](https://github.com/geek-rabb1t/grt65-expkit/blob/b5f1f13de7174624f89a41ebc992bdd7102dd792/pcb/grt65_exp_kit.kicad_sch) · [PCB](https://github.com/geek-rabb1t/grt65-expkit/blob/b5f1f13de7174624f89a41ebc992bdd7102dd792/pcb/grt65_exp_kit.kicad_pcb)
- [trackpad XML](netlists/trackpad.xml) · [回路図](https://github.com/geek-rabb1t/GR-Trackpad65/blob/79e68a0a344df3488b5fa36183299b8b5d22439a/pcb/trackpad.kicad_sch) · [PCB](https://github.com/geek-rabb1t/GR-Trackpad65/blob/79e68a0a344df3488b5fa36183299b8b5d22439a/pcb/trackpad.kicad_pcb)

配線案と残る実機確認項目は [ピンマップ](pin-map.md) を参照。
