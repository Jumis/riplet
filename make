which curl || apt-get install -qy curl

mkdir -p socat
cd socat
CWD=$(pwd)

mkdir -p /tmp/build
cd /tmp/build
curl -O http://www.dest-unreach.org/socat/download/socat-1.7.3.0.tar.gz
tar -zxf socat-1.7.3.0.tar.gz
cd socat-1.7.3.0
## openssl 1.0.0 seems to use __fdelt_chk of glibc 2.15
./configure --disable-openssl
make

cp socat $CWD
cd $CWD
cd ..
