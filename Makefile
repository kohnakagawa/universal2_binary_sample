all: universal_app.hexdump

x86_app: main.c
	clang main.c -o x86_app -target x86_64-apple-macos10.12

arm_app: main.c
	clang main.c -o arm_app -target arm64-apple-macos11

universal_app: x86_app arm_app
	lipo -create -output universal_app x86_app arm_app

universal_app.hexdump: universal_app
	od -tx1 universal_app > universal_app.hexdump	

clean:
	rm -f x86_app arm_app universal_app universal_app.hexdump
