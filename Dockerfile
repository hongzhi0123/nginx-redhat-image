FROM registry.access.redhat.com/ubi9/nginx-120:1-101

ENV releasever=9 \
    basearch=x86_64

USER root
COPY ./ /tmp/src
RUN chown -R 1001:0 /tmp/src
COPY ./nginx.repo /etc/yum.repos.d/
COPY ./nginx_signing.key /etc/pki/rpm-gpg/

RUN yum -y --noautoremove remove nginx-mod-http-perl nginx-mod-stream nginx nginx-core nginx-filesystem && \
    yum -y install http://nginx.org/packages/rhel/9/x86_64/RPMS/nginx-1.24.0-1.el9.ngx.x86_64.rpm

# Changing ownership
RUN chown -R 1001:0 ${NGINX_CONF_PATH} && \
    chown -R 1001:0 /var/cache/nginx /var/log/nginx /run && \
    chmod    ug+rw  ${NGINX_CONF_PATH} && \
    chmod -R ug+rwX /var/cache/nginx /var/log/nginx /run

USER 1001
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run