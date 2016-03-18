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
PKG_VERSION = ARGV.size > 1 ? ARGV[1] : "1.0"

def build_binary_pkg
  pkg_build_args = 
    [
     "--root #{ARGV[0]}",
     "--identifier io.github.opentoonz ",
     "--install-location /Applications/OpenToonz_1.0.app", # include version?
     "--version #{PKG_VERSION} ",
     PKG_BUILD_FILE_NAME
    ]
  `pkgbuild #{pkg_build_args.join(" ")}`
end

def build_stuff_pkg
  pkg_build_args = 
    [
     "--root #{ARGV[1]}",
     "--identifier io.github.opentoonz ",
     "--install-location /Applications/OpenToonz/OpenToonz_1.1_stuff", # include version?
     "--version #{PKG_VERSION} ",
     PKG_STUFF_FILE_NAME
    ]
  `pkgbuild #{pkg_build_args.join(" ")}`
end

# 0. 
`rm *.pkg *.xml`

# 1. 
build_binary_pkg
build_stuff_pkg

# 2.
# create distribution.xml
`productbuild --synthesize --package #{PKG_BUILD_FILE_NAME} --package #{PKG_STUFF_FILE_NAME} #{XML_PATH}`

# 3.
# modify xml
`gsed -i -e "3i     <title>OpenToonz</title>" #{XML_PATH}`
`gsed -i -e '6i     <license file="License.rtf"></license>' #{XML_PATH}`

# 4.
`productbuild --distribution #{XML_PATH} --package-path . --resources . #{PKG_FINAL_FILE_NAME}`

# 5.
`rm #{PKG_BUILD_FILE_NAME} #{PKG_STUFF_FILE_NAME} #{XML_PATH}`

