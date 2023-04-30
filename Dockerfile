FROM registry.access.redhat.com/ubi9/nginx-120:1-101

ENV releasever=9 \
    basearch=x86_64

USER root
COPY ./ /tmp/src
RUN chown -R 1001:0 /tmp/src

RUN yum remove nginx-mod-http-perl nginx-mod-stream nginx && \
    yum install nginx

USER 1001
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run