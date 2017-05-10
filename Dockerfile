# This Dockerfile is used to build packages for intel galileo gen 2.
FROM galileogen2/buildenv:stable
MAINTAINER Vipin Madhavanunni <vipmadha@gmail.com>

# In case you need proxy
#RUN echo 'Acquire::http::Proxy "http://127.0.0.1:8080";' >> /etc/apt/apt.conf

# Lets chnage to bash
#RUN rm /bin/sh && ln -s /bin/bash /bin/sh
SHELL ["/bin/bash"]

# Lets work on
WORKDIR /tmp
# Extract the source
RUN tar -xvzf /source/meta-clanton_v1.2.1.1.tar.gz 
# simplify the directory name
RUN mv meta-clanton_v1.2.1.1 clanton_v1
WORKDIR /tmp/clanton_v1/
# run the setup script which will get all required code base
RUN chmod +x setup.sh
RUN ./setup.sh
# create the build env files
RUN source oe-init-build-env build
# If building in docker or as root
WORKDIR /tmp/clanton_v1/build
RUN touch conf/sanity.conf
# build the full image
WORKDIR /tmp/clanton_v1/
RUN source oe-init-build-env build && bitbake image-full
# 
