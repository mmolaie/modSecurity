FROM waf/core:1.3
ENV USER=root
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN mkdir /etc/nginx/modsec/ && \
        cp /usr/local/src/ModSecurity/modsecurity.conf-recommended /etc/nginx/modsec/modsecurity.conf && \
        cp /usr/local/src/ModSecurity/unicode.mapping /etc/nginx/modsec/
COPY main.conf /etc/nginx/modsec/main.conf

RUN apt install -y wget && \
        wget https://github.com/coreruleset/coreruleset/archive/v3.3.0.tar.gz && \
        tar xvf v3.3.0.tar.gz && \
        mv coreruleset-3.3.0/ /etc/nginx/modsec/ && \
        mv /etc/nginx/modsec/coreruleset-3.3.0/crs-setup.conf.example /etc/nginx/modsec/coreruleset-3.3.0/crs-setup.conf
