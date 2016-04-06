# 手作業時のメモ

# VirtualRoot への設置

# install_name_tool で rpath を削除
`install_name_tool -delete_rpath /Users/tetsuya_miyashita/Qt/5.5/clang_64/lib`

# deploytool の適用

# plist の生成
`pkgbuild --root VirtualRootApp --analyze app.plist`

# plist への変更は以下
```
<key>BundlePostInstallScriptPath</key>
<string>pkg-script.sh</string>
```

# VirtualRoot への設置, plist が生成済ならば pkg を生成
`pkgbuild --root VirtualRootApp --component-plist app.plist --scripts scripts --identifier io.github.opentoonz --version  OpenToonzBuild.pkg`

# xml のひな形生成用の productbuild
`productbuild --synthesize --package OpenToonzBuild.pkg distribution.xml`

```
<title>OpenToonz</title>
<license file="License.rtf"></license>
```

# 最終的な pkg 用の productbuild
`productbuild --distribution distribution.xml --package-path OpenToonzBuild.pkg --resources . OpenToonz.pkg`
