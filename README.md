# MacOSX 用 Installer (pkg) 作成スクリプト

## 依存パッケージ・モジュール

- Xcode (`pkgbuild, productbuild`)
- gsed

## スクリプト実行

`./app.rb [BUNDLE_PATH] [STUFF_DIR] [VERSION(floatnum)]`

上記のように実行時引数で

- ビルド済バンドルへのパス
- 本体リポジトリの stuff ディレクトリへのパス
- pkg のバージョン

を与えて下さい。スクリプト内の途中で外部コマンドの実行に失敗すると途中で止まります。

実際の実行例

```
$ ./app.rb ~/public-projects/opentoonz/toonz/build/toonz/OpenToonz_1.0.app ~/public-projects/opentoonz/stuff 1.0.2
```
