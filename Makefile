all: clean package
package: 
	cp fan.cy layout/usr/bin/
	cp fancy layout/usr/bin/
	chmod +x layout/usr/bin/fancy
	dpkg-deb -b layout/ .
clean:
	rm *.deb
