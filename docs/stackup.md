# Mechanical stack-up — measurement pending

Target: 12 mm maximum device thickness including keycap top, excluding rubber feet. This is not validated.

Known from GR-Trackpad65 README: touchpad PCB 1.6 mm and recommended overlay 2 mm. These are separate layers and do not alone determine finished enclosure thickness.

Measure: MBK cap on Sunset switch at rest and bottomed out; PCB thickness; mounting/plate offsets; touchpad module including FFC connector; XIAO board including USB-C; protected LiPo thickness plus swelling allowance; LED and light-guide space; case top/bottom wall; screws and standoffs.

Avoid stacking battery underneath the trackpad or controller if 12 mm is a hard limit. Consider lateral placement and an RF-transparent region for the BLE antenna. Do not reduce touchpad PCB thickness without sensor revalidation.

## A0 の採寸欄

単位は mm。部品の向きと測定の基準面も記録する。A0 の初期値と編集可能な CAD は [設計資料](design-a0.md) にある。

| 実測項目 | 基準・測り方 | 反映先 | 実測値 |
|---|---|---|---|
| キー頂点、静止／底打ち | 実装状態のPCB上面 → MBK頂点。押し込んだときのキャップ外周の横ずれも確認 | ケース全高と開口 | 未測定 |
| Chocの足・端子の突出 | PCB裏面 → 最も低い足／端子。はんだ高さを別記 | 底と基板のクリアランス | 未測定 |
| トラックパッド裏面の突出 | PCB裏面 → 最も高い部品。FFCコネクタとラッチを別記 | 支持台とケーブル経路 | 未測定 |
| トラックパッドの実装外形 | 持っている基板の最大幅・奥行きと外周タブの位置 | 外形、支持台、ケース内壁 | 未測定 |
| USB-Cの面と中心 | XIAO PCBの前端・底面を基準に、端子の挿入口中心と端子面を測る。挿すケーブルの外装幅も記録 | 背面開口と保持具 | 未測定 |
| 電池と保護基板 | メーカー外形上限、厚み公差、圧縮禁止域、リード出口と最小曲げ半径 | 電池ベイの寸法 | 部品未選定 |
