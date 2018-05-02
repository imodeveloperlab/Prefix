swift build -c release -Xswiftc -static-stdlib
cp -f .build/x86_64-apple-macosx10.10/release/Prefix /usr/local/bin/prefix
