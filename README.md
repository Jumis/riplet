nginx with patches
=================

## nginx with unbuffered client uploads.



  
Building the nginx branch will result in a “./nginx” directory:

nginx/

nginx/ubuntu

nginx/ubuntu/etc-nginx.tgz

nginx/ubuntu/build.log

nginx/ubuntu/nginx

nginx/ubuntu/deps.log

nginx/ubuntu/package.log

  
This directory is mapped to “/data” when the nginx service is being built through docker.io. It contains our custom built nginx binary as well as a simple config file. The config file and binary are installed over the stock nginx package.

  
Building and verifying the nginx branch results in several “.deb” files:

ubuntu/nginx_1.2.1-2.2_all.deb

ubuntu/nginx-full_1.2.1-2.2_amd64.deb

ubuntu/nginx-common_1.2.1-2.2_all.deb

  
It also results in an entry to the “uri” directory:

uri/http:/nginx.org/download/nginx-1.4.2.tar.gz

Additionally, it downloads github files:

  github/agentzh/memc-nginx-module.git
  github/agentzh/memc-nginx-module.git.tgz
  github/agentzh/echo-nginx-module.git.tgz
  github/agentzh/echo-nginx-module.git
  github/FRiCKLE/ngx_postgres.git
  github/FRiCKLE/ngx_postgres.git.tgz
  github/perusio/nginx-auth-request-module.git
  github/perusio/nginx-auth-request-module.git.tgz
  github/wandenberg/nginx-push-stream-module.git.tgz
  github/wandenberg/nginx-push-stream-module.git
