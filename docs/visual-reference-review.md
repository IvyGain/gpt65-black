# 添付の引き継ぎ資料と外観照合

2026-11-23（JST）。`grt65-codex-complete-handoff.zip` 内の `CONVERSATION_HANDOFF.md` と `CODEX_START_HERE.md` を通読し、`references/` の9画像を確認した。添付文書は会話の再構成であり、購入状況や設計判断の資料として扱う。回路・寸法の根拠は公式データと実測から取得する。

| 資料 | 確認結果 |
|---|---|
| `a_sleek_high_detail_product_render_on_a_dark_gray.png` | **VERIFIED（外観）** 採用画像。角を丸めたマットブラックの外装、面積の大きいタッチ面、横一列の黒い3キー、キーの下から見える控えめな琥珀色の光。端子側から見た画像にUSB-C、スイッチ、表示灯がある。使用時はユーザー確認どおりタッチ面が手前で、3キーと端子面は奥。 |
| `a_highly_detailed_product_photo_cgi_render_of_a_sl.png` | **VERIFIED（外観）** 3キーがタッチ面の脇に並ぶ不採用案。 |
| `a_clean_high_detail_exploded_product_render_on_a.png`、`a_close_up_realistic_product_photo_on_a_desk_a_sl.png` | **VERIFIED（外観）** 分解表現と質感の参考。内部構造・電池型番・固定方法の確定資料ではない。 |
| `IMG_0104.jpeg`、`IMG_0105.jpeg`、`IMG_0106.jpeg` | **VERIFIED（写真）** 未組立の基板とプレート、FFC状の部品、ピンヘッダーなどを確認。FFCの接点面、接続方向、電圧、寸法には実物確認が必要。 |
| `IMG_0102.png`、`IMG_6825BADB-06DF-42AB-80C4-945BB87CA88F.jpeg` | **VERIFIED（資料）** 購入候補のカートとQRカード。注文済みの4品目は引き継ぎ本文と既存BOMで照合した。 |

**INFERRED（CAD）** 85 × 76 mmの `reference` 案は、左右に張り出す部品スペースを設けず、採用画像の配置と端子面を再現している。この案を外観の基準とする。控えめな拡散RGB、マット仕上げ、キー周囲の隙間、端子とスイッチの仕上げには詳細設計が残る。高さ13.9 mmはCADの仮寸法で、キー込み12 mmは実測待ち。 [CADと設計状況](design-a0.md)

**UNVERIFIED（実機）** 購入候補の電池・充電・スイッチ・RGBに確定型番の記載はなかった。既存の注文済み品と分け、部品表の未選定・候補を維持する。公式KiCadのネットリストとXIAOの静的検証は完了済み。通電前の条件とIssue #1の残項目は電気検証記録を参照。 [部品表](../bom/parts.csv) · [電気検証記録](issue-1-electrical-audit.md)
