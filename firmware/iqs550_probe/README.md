# XIAO nRF52840 用 IQS550 I²C プローブ

**INFERRED（検証手順）** 対象は Seeed XIAO nRF52840 標準版と GR-Trackpad65。先に [接続表と通電前の条件](../../docs/pin-map.md) を確認する。Seeed nRF52 Boards 1.1.13 で以下をビルドできる。コマンドは CLI のワークスペースにボードパッケージがインストール済みの場合のもの。

```sh
arduino-cli compile --fqbn Seeeduino:nrf52:xiaonRF52840 firmware/iqs550_probe
```

実機確認時は、USB シリアルを 115200 baud で開き、小文字の `p` を送る。1 回の要求につき、D0 の RDY が Low になるまで最大 1 秒待つ。100 kHz の I²C で 7-bit アドレス `0x74` にレジスタポインタ `00 00` を送り、repeated START から 2 バイトを MSB 順に読み、STOP を送る。続いて `EE EE 01` で通信ウィンドウを閉じる。設定・フラッシュへの書き込み、リセット駆動、自動スキャンは行わない。

- `PASS product=40` と `End communication status=0` が成功条件。
- RDY タイムアウト、アドレス送信エラー、短い読み取り、製品番号不一致、終了コマンド失敗は別々に確認できる。
- RDY の待ち時間のみ上限付き。Seeed 1.1.13 の `Wire` は TWIM のイベントを待つループにタイムアウトがない。バス固着時はログが止まる可能性があるため、実機試験では波形と電源を確認する。

## 根拠と検証状態

- **VERIFIED（ソース）** Seeed の標準版ピン表と BSP の `variant.h` / `variant.cpp` で D4/SDA、D5/SCL、D0/P0.02 を照合。BSP の `Wire_nRF52.cpp` で 7-bit アドレスと STOP の指定を確認。 [Seeed ピン表](https://github.com/Seeed-Studio/wiki-documents/blob/91013e1d12ef77feb95b30ec1f340704f235e218/sites/en/docs/Sensor/SeeedStudio_XIAO/SeeedStudio_XIAO_nRF52840-Sense/XIAO_BLE.md) · [Seeed BSP 1.1.13](https://github.com/Seeed-Studio/Adafruit_nRF52_Arduino/tree/667f05fdaafd01a05d8027d7dbbf1f4e0b137047)
- **VERIFIED（ソース）** expkit 用の Vial 設定は GP2/GP3。共通 IQS5xx ドライバが `0x74`、製品番号レジスタ `0x0000`、IQS550 の番号 40、終了コマンド `0xEEEE` とデータ 1 を使用する。ChibiOS 側の `i2c_read_register16` で上位バイト先行の複合転送を確認。 [Vial 設定](https://github.com/geek-rabb1t/vial-qmk/blob/716cb6d7074d19f7337eb3d62666b990b5dbb7c2/keyboards/geek_rabb1t/grt65_exp_kit/config.h) · [IQS5xx ドライバ](https://github.com/geek-rabb1t/vial-qmk/tree/716cb6d7074d19f7337eb3d62666b990b5dbb7c2/keyboards/geek_rabb1t/trackpad) · [I²C 実装](https://github.com/geek-rabb1t/vial-qmk/blob/716cb6d7074d19f7337eb3d62666b990b5dbb7c2/platforms/chibios/drivers/i2c_master.c)
- **UNVERIFIED（電気・実機）** RDY の Low 判定はベンチ検証用の前提。Azoteq のデータシートは今回の環境から HTTP 403。RDY の駆動形式・極性、NRST 開放時の起動、基板の電流と波形、ACK、製品番号の実読み出しが未確認。 [Azoteq IQS5xx-B000 データシート](https://www.azoteq.com/images/stories/pdf/iqs5xx-b000_trackpad_datasheet.pdf)
- **VERIFIED（クロスビルド）** Arduino CLI 1.3.1、Seeed nRF52 BSP 1.1.13、Arm GNU 9-2019-q4、CMSIS 5.7.0 でコンパイルとリンクに成功。ARM ELF と HEX を生成。プログラム領域 43,952 バイト、静的 RAM 7,524 バイト。クラウドではパッケージ配布インデックスが利用できなかったため、固定リビジョンの BSP、チェックサム確認済みツール、ローカル CLI 設定を使用。シリアル機器の検出と DFU ZIP 生成はビルド確認の対象外。
