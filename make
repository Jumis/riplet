#!/bin/bash
### In all cases, we could use dnsmasq and nginx to proxy requests into a cache.

### Link apt cache directory. We could just use docker volume.
if [ -d "/riplet/annex/ubuntu" ]; then :;
if [ -f "/var/cache/apt/archives" ]; then :;
mv -f /var/cache/apt/archives /var/cache/apt/archives-original;
fi;
ln -s /riplet/annex/ubuntu /var/cache/apt/archives;
fi;

### Wrap git. We could just use tar.
if [ -d "/riplet/annex/github" ]; then :;
if [ -f "/usr/bin/git-original" ]; then :; else :;
if [ -f "/usr/bin/git" ]; then :; mv /usr/bin/git /usr/bin/git-original; fi;
touch /usr/bin/git; chmod +x /usr/bin/git;

cat << PROXY > /usr/bin/curl;
#!/bin/bash
function git_annex() {
# export GIT_SSL_NO_VERIFY=1;
RIPLET_ANNEX_URI=/riplet/annex/uri;
GIT_BIN=/usr/bin/git-original;
GITOPT_ARGS=$(echo $@)
GITOPT_URL="https://github.com";
GITOPT_ANNEX_URI="file:/root/annex/uri/$GITOPT_URL";
git ${GITOPT_ARGS/$GITOPT_URL/$GITOPT_ANNEX_URI}
}
git_annex $@
PROXY
fi; 
fi;

### Wrap curl. We could just use cp.
if [ -d "/riplet/annex/uri" ]; then
if [ -f "/usr/bin/curl-original" ]; then :; else :;
if [ -f "/usr/bin/curl" ]; then :; mv /usr/bin/curl /usr/bin/curl-original; fi;
touch /usr/bin/curl; chmod +x /usr/bin/curl;
cat << PROXY > /usr/bin/curl;
#!/bin/bash
function curl_annex() {
RIPLET_ANNEX_URI=/riplet/annex/uri;
CURL_BIN=/usr/bin/curl-original;
CURLOPT_ARGS=$(echo $@);
CURLOPT_URL=$($CURL_BIN $CURLOPT_ARGS --libcurl - -s --proxy 0:0 | fgrep CURLOPT_URL | cut -f 2 -d '"');
CURLOPT_ANNEX_URI="file:$RIPLET_ANNEX_URI/$CURLOPT_URL";
$CURL_BIN ${CURLOPT_ARGS/$CURLOPT_URL/$CURLOPT_ANNEX_URI};
};
curl_annex $@;
PROXY
fi;
fi;

/riplet/service/nginx/ubuntu/make
