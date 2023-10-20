FROM alpine:3.14
ARG PROM_VERSION="2.47.2"
ARG PROM_CPU="amd64"
ARG DATA_PATH="/home/runner"
RUN apk add --no-cache prometheus nano busybox-extras prometheus-node-exporter openssl wget curl nfs-utils
RUN wget --no-clobber --no-verbose --directory-prefix=/opt https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-${PROM_CPU}.tar.gz
RUN tar -xf /opt/prometheus-${PROM_VERSION}.linux-${PROM_CPU}.tar.gz
RUN cp -f prometheus-${PROM_VERSION}.linux-${PROM_CPU}/prometheus /usr/local/bin
RUN cp -fr prometheus-${PROM_VERSION}.linux-${PROM_CPU}/console* /etc/prometheus
RUN addgroup -S -g 10000 runner
RUN adduser -S -s /sbin/nologin -u 10000 -G runner -h /home/runner runner
RUN addgroup runner runner
EXPOSE 9090
EXPOSE 9100
CMD ["while true ; do echo "keep running" ; sleep 60 ; done;"]
