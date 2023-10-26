FROM alpine:3.14
ARG PROM_VERSION="2.47.2"
ARG PROM_CPU="amd64"
ARG DATA_PATH="/home/runner"
RUN apk add --no-cache prometheus nano busybox-extras prometheus-node-exporter openssl wget curl nfs-utils
RUN wget --no-clobber --no-verbose --directory-prefix=/opt https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-${PROM_CPU}.tar.gz
RUN tar -xf /opt/prometheus-${PROM_VERSION}.linux-${PROM_CPU}.tar.gz
RUN cp -f prometheus-${PROM_VERSION}.linux-${PROM_CPU}/prometheus /usr/local/bin
RUN cp -f prometheus-${PROM_VERSION}.linux-${PROM_CPU}/promtool /usr/local/bin
RUN cp -fr prometheus-${PROM_VERSION}.linux-${PROM_CPU}/console* /etc/prometheus
RUN rm -rf prometheus*
RUN addgroup -S -g 10000 runner
RUN adduser -S -s /sbin/nologin -u 10000 -G runner -h /home/runner runner
RUN addgroup runner runner
RUN wget --directory-prefix=/tmp --no-verbose https://storage.googleapis.com/kubernetes-release/release/stable.txt
RUN wget --directory-prefix=/tmp --no-verbose https://dl.k8s.io/"$(cat /tmp/stable.txt)"/kubernetes-client-linux-${PROM_CPU}.tar.gz
RUN tar -xvf /tmp/kubernetes-client-linux-${PROM_CPU}.tar.gz
RUN mv /kubernetes/client/bin/* /usr/local/bin
RUM rm -r /kubernetes
RUN chmod +x /usr/local/bin/kube*
EXPOSE 9090
EXPOSE 9100
CMD ["sleep 50000"]
