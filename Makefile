all: universal_app.hexdump arm_app_pa

x86_app: main.c
	clang $< -o $@ -target x86_64-apple-macos10.12

arm_app: main.c
	clang $< -o $@ -target arm64-apple-macos11

arm_app_pa: main.c
	clang -mbranch-protection=standard $< -o $@ -target arm64-apple-macos11

universal_app: x86_app arm_app_pa
	lipo -create -output universal_app x86_app arm_app_pa

universal_app.hexdump: universal_app
	od -tx1 universal_app > universal_app.hexdump	

clean:
	rm -f x86_app arm_app universal_app universal_app.hexdump
