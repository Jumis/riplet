which curl || apt-get install -qy curl
# manual musl build
curl -O http://www.musl-libc.org/releases/musl-1.1.8.tar.gz
tar -zxf musl-1.1.8.tar.gz
cd musl-1.1.8
./configure --disable-shared --prefix="$PWD/build"
make
make install

CC="$PWD/build/bin/musl-gcc -static"
cd ..

mkdir -p socat
cd socat
CWD=$(pwd)

mkdir -p /tmp/build
cd /tmp/build
curl -O http://www.dest-unreach.org/socat/download/socat-1.7.3.0.tar.gz
tar -zxf socat-1.7.3.0.tar.gz
cd socat-1.7.3.0
cat <<PATCH >> xio-socket.h
#ifndef NETDB_INTERNAL
#define NETDB_INTERNAL -1
#endif
PATCH

## glibc 2.15+ or ... trying musl.
CC="$CC" ./configure
make

cp socat $CWD
cd $CWD
cd ..
