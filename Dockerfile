# Name: trojan Dockerfile
# Date Created: March 6, 2019
# Last Modified: March 6, 2019
# Licensed under the GNU General Public License Version 3 (GNU GPL v3),
#    available at: https://www.gnu.org/licenses/gpl-3.0.txt
# (C) 2019 K4YT3X

FROM alpine

MAINTAINER k4yt3x "k4yt3x@k4yt3x.com"
ENV REFRESHED_AT 2019-03-06

# install libraries for building trojan
RUN apk update
RUN apk add cmake boost-dev openssl-dev mariadb-connector-c-dev build-base git

# clone trojan and compile
RUN git clone https://github.com/trojan-gfw/trojan.git /trojan
RUN mkdir /trojan/build
RUN cd /trojan/build && cmake ..
RUN cd /trojan/build && make

# install trojan to system
RUN cd /trojan/build && make install

# open port 443 for trojan
EXPOSE 443
