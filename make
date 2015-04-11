which curl || apt-get install -qy curl musl

mkdir -p socat
cd socat
CWD=$(pwd)

mkdir -p /tmp/build
cd /tmp/build
curl -O http://www.dest-unreach.org/socat/download/socat-1.7.3.0.tar.gz
tar -zxf socat-1.7.3.0.tar.gz
cd socat-1.7.3.0
## glibc 2.15+ or...
CC="musl-gcc -static" ./configure --disable-shared
make

cp socat $CWD
cd $CWD
cd ..
