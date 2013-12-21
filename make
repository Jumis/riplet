if [ -d "/riplet/annex/ubuntu" ]; then
mv /var/cache/apt/archives /var/cache/apt/archives-orig
ln -s /riplet/annex/ubuntu /var/cache/apt/archives
fi;

if [ -d "/riplet/annex/github" ]; then
export GIT_SSL_NO_VERIFY=1
fi;

/riplet/service/nginx/ubuntu/make
