if [ -d "/riplet/annex/ubuntu" ]; then
mv /var/cache/apt/archives /var/cache/apt/archives-orig
ln -s /riplet/annex/ubuntu /var/cache/apt/archives
fi;

/riplet/service/nginx/ubuntu/make
