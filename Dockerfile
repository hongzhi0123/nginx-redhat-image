FROM registry.access.redhat.com/ubi9/nginx-120:1-101

ENV releasever=9 \
    basearch=x86_64

USER root
COPY ./ /tmp/src
RUN chown -R 1001:0 /tmp/src
COPY ./nginx_signing.key /etc/pki/rpm-gpg/

RUN yum -y remove nginx-mod-http-perl nginx-mod-stream nginx && \
    yum -y install nginx-1.24.0-1

USER 1001
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run