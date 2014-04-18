# Introducing Riplet
  

## Building software from bash
  
Riplet is a set of shell scripts and a naming convention for building software, installing it and running it. Riplet has an added layer for caching dependencies, allowing the build script to be run within a virtual container that has no network access. Riplet templates are verified both by the Travis CI tool and by running them in a docker.io instance. These steps are [mostly] automated.

  
The following example looks at the nginx branch, a custom build of nginx needed by Folders.io.

  

### Example: nginx
  
Folders.io requires an unbuffered proxy server to operate. With various patches and modules, nginx can handle message queues as well as direct proxying to select endpoints and access validation through a postgresql connection.

  
The following shell script downloads the necessary patches and modules and builds nginx:

[https://github.com/Jumis/riplet/blob/nginx/ubuntu/build](https://github.com/Jumis/riplet/blob/nginx/ubuntu/build)

  
Following is an example of a Travis CI configuration file for building, installing and testing nginx:

[https://github.com/Jumis/riplet/blob/nginx/.travis.yml ](https://github.com/Jumis/riplet/blob/nginx/.travis.yml)

  
This repository is public and registered with Travis CI. When a change is made to a branch, Travis CI will attempt to rebuild and re-run any associated tests:

[https://travis-ci.org/Jumis/riplet/branches](https://travis-ci.org/Jumis/riplet/branches)

  

### Travis CI
  
Travis CI is a free continuous integration (build system) available to any projects on github which are publically available. It monitors for updates to any branches that have a “.travis.yml” file in their root directory. When an update is seen, it runs the build script in a vanilla Ubuntu environment. These environments are based on docker.io virtual containers.

  

### Docker.io virtual containers
  
Docker.io provides convenience interfaces for Linux Virtual Containers (LXC). These are lightweight containers, a combination of “chroot”, symlinks and virtual network devices.  Docker is an excellent tool for testing automated deployment solutions.

  
Docker.io instances can be booted quite quickly, taken down quickly and cloned easily. The containers may be designed with various root file systems, allowing an Ubuntu host to be used to test a CentOS layout.

  

### Riplet templates
  
When a repository is stable, changes may be made directly from Github’s code editor, a worthwhile convenience.

  
Riplet uses some standard naming schemes within its templates to make things easier across repositories. This does not work particularly well with git, but it works well enough.

  
“./cli” is a standard directory present in all of the branches, tracking the master branch. The primary script in this directory is “annex”.

  
“./build” is used to install any dependencies needed to build the project from scratch, or from some scratch-like state.

  
“./make” is used to install the project. Build may install “gcc” whereas “./make” would simply download a pre-built binary.

  
“./run” is used to run the installed binary.

  
“./test” is used with Travis CI to test that the installed binary ran successfully.

  
“./init” is used with Docker.io to install (if needed) and boot the project.

  
“./ubuntu” directory is a naming convention for branches targeting Ubuntu. Travis CI is Ubuntu-based. Some branches may support CentOS. Testing both layouts is fairly easy using Docker.io.

  
When running within a docker instance, riplet uses “/data” as a special writable root directory. This directory is linked within the host system making it easier to see logs and to link services when needed.

  
  

### The Annex
  
Riplet build scripts are run within a docker instance which has no network connectivity. They can also be run in a normal Ubuntu instance which has network access. Docker instances are created with a link to a read-only directory containing a cache of all dependencies. This read-only directory is called the annex.

  
Annex supports several repository types: github, http(s), and yum. The annex is the most complex part of Riplet; it’s fair to say that the rest of the shell scripts in the “./cli” directory are not used.

  
Annex downloads dependencies ahead of time. It knows about dependencies because they are named within the service directory. Annex is also used to build projects and save their binary results to be used by other Riplet projects.

  
This is the annex code:

  
[https://github.com/Jumis/riplet/blob/nginx/cli/annex](https://github.com/Jumis/riplet/blob/nginx/cli/annex)

[https://github.com/Jumis/riplet/blob/nginx/cli/ubuntu/deps](https://github.com/Jumis/riplet/blob/nginx/cli/ubuntu/deps)

  
The annex will create three folders as needed:

  
“./github”: folders containing git repositories as well as tar.gz files of their contents.

“./ubuntu”: a flat collection of “.deb” files used to install packages on ubuntu.

“./uri”: a folder hierarchy mirroring any http(s) resources needed.

  
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

  
When used this way, the annex folder contains all files needed to rebuild the nginx or install the nginx service. Note that the git and uri files are not needed if the nginx service has already been built. But, other files are still needed, as the nginx service expects to install over the stock nginx package. Thus the ubuntu “.deb” files are still a requirement.**EndFragment

