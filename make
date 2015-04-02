which curl || apt-get install -qy curl

mkdir -p socat
cd socat
CWD=$(pwd)

mkdir -p /tmp/build
cd /tmp/build
curl -O http://www.dest-unreach.org/socat/download/socat-1.7.3.0.tar.gz
tar -zxf socat-1.7.3.0.tar.gz
cd socat-1.7.3.0
./configure
make

cp socat $CWD
