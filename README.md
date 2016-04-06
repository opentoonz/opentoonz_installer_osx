# MAC 用 Installer 作成スクリプト

## 依存パッケージ・モジュール

- Xcode (`pkgbuild, productbuild`)
- gsed

## 実行コマンド

`./app.rb [BUNDLE_PATH] [STUFF_DIR] [VERSION(optional, floatnum)]`

Pass Bundle path and Version.

実際の例

`$ ./app.rb ~/public-projects/opentoonz/toonz/build/toonz/OpenToonz_1.0.app ~/public-projects/opentoonz/stuff 1.0.2`
