apt-get update -q
apt-get install -qy busybox-static
mkdir /rootfs
cd /rootfs
mkdir bin etc dev dev/pts lib proc sys tmp
touch etc/resolv.conf
cp /etc/nsswitch.conf etc/nsswitch.conf
echo root:x:0:0:root:/:/bin/sh > etc/passwd
echo root:x:0: > etc/group
ln -s lib lib64
ln -s bin sbin
cp /bin/busybox bin
for X in $(busybox --list) ; do ln -s busybox bin/$X ; done
bash -c "cp /lib/x86_64-linux-gnu/lib{c,m,dl,rt,nsl,nss_*,pthread,resolv}.so.* lib"
cp /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 lib
tar cf /rootfs.tar .
for X in console null ptmx random stdin stdout stderr tty urandom zero ; do tar uf /rootfs.tar -C/ ./dev/$X ; done
