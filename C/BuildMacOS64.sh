PLATFORM="MacOSX"

DEVELOPER_DIR=`xcode-select -print-path`
if [ ! -d $DEVELOPER_DIR ]; then
  echo "Please set up Xcode correctly. '$DEVELOPER_DIR' is not a valid developer tools folder."
  exit 1
fi

SDK_ROOT=$DEVELOPER_DIR/Platforms/$PLATFORM.platform/Developer/SDKs/$PLATFORM.sdk
if [ ! -d $SDK_ROOT ]; then
  echo "The MacOSX SDK was not found in $SDK_ROOT."
  exit 1
fi

rm *.o
rm libyaml_mac64.a
rm libyaml_macarm.a

clang -c -fPIC -O3 -arch x86_64 -isysroot $SDK_ROOT -I src -DYAML_DECARE_STATIC -DHAVE_CONFIG_H src/api.c src/dumper.c src/emitter.c src/loader.c src/parser.c src/reader.c src/scanner.c src/writer.c

ar rcs libyaml_mac64.a *.o
ranlib libyaml_mac64.a
rm *.o

clang -c -fPIC -O3 -arch arm64 -isysroot $SDK_ROOT -I src -DYAML_DECARE_STATIC -DHAVE_CONFIG_H src/api.c src/dumper.c src/emitter.c src/loader.c src/parser.c src/reader.c src/scanner.c src/writer.c

ar rcs libyaml_macarm.a *.o
ranlib libyaml_macarm.a
rm *.o