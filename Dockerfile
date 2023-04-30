FROM registry.access.redhat.com/ubi9/nginx-120:1-101

USER root
COPY upload/src /tmp/src
RUN chown -R 1001:0 /tmp/src
USER 1001
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run