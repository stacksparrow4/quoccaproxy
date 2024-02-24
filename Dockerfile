FROM nginx:latest

WORKDIR /root

COPY pass.key quocca.p12 ./
RUN openssl pkcs12 -in quocca.p12 -out /quocca.key -provider legacy -provider default -nodes -nocerts -passin file:pass.key && \
    openssl pkcs12 -in quocca.p12 -out /quocca.crt -provider legacy -provider default -nokeys -passin file:pass.key

COPY nginx.conf /etc/nginx/conf.d/default.conf
