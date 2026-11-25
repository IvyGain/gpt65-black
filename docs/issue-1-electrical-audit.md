# Issue #1 — 回路図・XIAO 接続仕様の再検証

[GitHub Issue #1](https://github.com/IvyGain/gpt65-black/issues/1) · [引き継ぎ文書](conversation-handoff.md)

**VERIFIED（資料）** GitHubの引き継ぎ文書と Issue #1 本文を確認した。別添の `grt65-codex-handoff/CONVERSATION_HANDOFF.md` と `references/` は当初未取得で、後から受領したZIPで確認した。 [添付資料の照合](visual-reference-review.md)引き継ぎ文書のマットブラック、横一列の3キー、控えめな拡散RGBと、このスレッドで合意した使用時の向きを設計基準とする。今回の作業で外観・CAD・部品表を変更していない。

## 静的検証

- **VERIFIED** 公式 expkit コミット `b5f1f13de7174624f89a41ebc992bdd7102dd792` と GR-Trackpad65 コミット `79e68a0a344df3488b5fa36183299b8b5d22439a` の回路図 blob SHA を確認。KiCad 9.0.2 で XML を再生成し、保存済みXMLの全端子と照合した。expkit は63端子、トラックパッドは91端子が一致。
- **VERIFIED** PCB実データと照合したパッド・ネットの組は expkit が63組（J1/J2/J3、U1、R1/R2、SW1–3）、トラックパッドが61組（J1、U1、R1/R2、C6）。KiCad のネット名の `{slash}` 表記は `/` に正規化した。両方のFFCの全6ピン、expkitのスイッチ、3.3 Vと5 Vの区別を確認。 [再生成方法](schematic-inspection.md) · [全ピンと電源](pin-map.md)
- **VERIFIED（メーカー資料とBSP）** XIAO nRF52840標準版の D4/P0.04 がSDA、D5/P0.05 がSCL、D0/P0.02 はGPIO。3V3はメーカー資料上の出力、5VはUSBのVBUS系。BSP 1.1.13で `Wire` の定義を照合した。3V3出力の表記だけでは、モジュールの起動電流を供給できるとは判断できない。 [Seeed ピン表](https://github.com/Seeed-Studio/wiki-documents/blob/91013e1d12ef77feb95b30ec1f340704f235e218/sites/en/docs/Sensor/SeeedStudio_XIAO/SeeedStudio_XIAO_nRF52840-Sense/XIAO_BLE.md) · [BSP](https://github.com/Seeed-Studio/Adafruit_nRF52_Arduino/tree/667f05fdaafd01a05d8027d7dbbf1f4e0b137047/variants/Seeed_XIAO_nRF52840)
- **VERIFIED（クロスビルド）** 既存のIQS550プローブを標準版向けに再ビルドして成功。Arduino CLI 1.3.1、Seeed BSP 1.1.13。ARM ELF/HEXを出力し、プログラム43,952バイト、静的RAM 7,524バイト。 [プロトコル根拠と実行条件](../firmware/iqs550_probe/README.md)

## 通電前の残項目

**INFERRED** モジュール側4.7 kΩのプルアップを使い、XIAOへ直接接続する案。3.3 Vでの抵抗電流は線をLowにした際に1本当たり約0.70 mA（VOLを0 Vとした抵抗分の計算値）。この計算値には立ち上がり時間、実装公差、機器の電流余力は含まれない。expkit側の1 kΩはこの直接接続案に加えない。

**UNVERIFIED** 実物の端子面、FFC両端の導通と1番、VDD–GND短絡、電源容量と起動電流、I²Cの電圧・立ち上がり、RDYの極性と駆動形式、NRSTの解除条件。Seeed標準版の回路図PDFとAzoteqのIQS5xxデータシートは今回HTTP 403。メーカー資料で絶対最大定格と動作条件を確認し、実物の導通照合まで済む前は通電しない。5V/VBUSと電池はこのI²C検証配線の対象外。 [ベンチ手順](bench-test-plan.md)

**UNVERIFIED（Issue #1の後続）** 実機I²C、macOSでのBLE HIDキーボード・ポインター・スクロール、ジェスチャーの区別、電流測定、現物採寸による12 mm判定。部品の選定と製造判定はこれらの結果を反映する。今回、実機への通電・配線・加工、製造発注は未実施。Issue #1は未完了。
