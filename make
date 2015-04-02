which curl || apt-get install -qy curl

mkdir -p socat
cd socat
CWD=$(pwd)

mkdir -p /tmp/build
cd /tmp/build
curl -O http://www.dest-unreach.org/socat/download/socat-2.0.0-b7.tar.gz
tar -zxf socat-2.0.0-b7.tar.gz
cd socat-2.0.0-b7
./configure
make

cp socat $CWD
