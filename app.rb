#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

if ARGV.size < 2 then
  puts "usage: ./app.rb [TARGET_BUNDLE] [STUFF_DIR] [VERSION(float)]"
  exit 1
end

PKG_BUILD_FILE_NAME = "OpenToonzBuild.pkg"
PKG_STUFF_FILE_NAME = "OpenToonzStuff.pkg"
PKG_FINAL_FILE_NAME = "OpenToonz.pkg"
XML_PATH = "distribution.xml"
BUNDLE_NAME = "OpenToonz_1.0.app"
PKG_VERSION = ARGV.size > 2 ? ARGV[2] : "1.0"
STUFF_NAME = "stuff"

def build_binary_pkg
  pkg_build_args = 
    [
     "--root #{BUNDLE_NAME}",
     "--identifier io.github.opentoonz.bin ",
     "--install-location /Applications/OpenToonz_1.0.app", # include version?
     "--version #{PKG_VERSION} ",
     PKG_BUILD_FILE_NAME
    ]
  `pkgbuild #{pkg_build_args.join(" ")}`
end

def build_stuff_pkg
  pkg_build_args = 
    [
     "--root #{STUFF_NAME}",
     "--identifier io.github.opentoonz.stuff ",
     "--install-location /Applications/OpenToonz/OpenToonz_1.0_stuff", # include version?
     "--version #{PKG_VERSION} ",
     PKG_STUFF_FILE_NAME
    ]
  `pkgbuild #{pkg_build_args.join(" ")}`
end

# 0. 
`rm *.pkg *.xml`

# remove previous bundles
`rm -rf *.app`

# create bundle dylib pacakged
`cp -r #{ARGV[0]} .`
`~/Qt/5.5/clang_64/bin/macdeployqt #{BUNDLE_NAME}`

# create 777 stuff dir
`cp -r #{ARGV[1]} .`
`chmod 777 #{STUFF_NAME}`

# 1. 
build_binary_pkg
build_stuff_pkg

# 2.
# create distribution.xml
`productbuild --synthesize --package #{PKG_STUFF_FILE_NAME} --package #{PKG_BUILD_FILE_NAME} #{XML_PATH}`

# 3.
# modify xml
`gsed -i -e "3i     <title>OpenToonz</title>" #{XML_PATH}`
`gsed -i -e '6i     <license file="License.rtf"></license>' #{XML_PATH}`

# 4.
`productbuild --distribution #{XML_PATH} --package-path #{PKG_BUILD_FILE_NAME} --package-path #{PKG_STUFF_FILE_NAME} --resources . #{PKG_FINAL_FILE_NAME}`

# 5.
`rm #{PKG_BUILD_FILE_NAME} #{PKG_STUFF_FILE_NAME} #{XML_PATH}`

