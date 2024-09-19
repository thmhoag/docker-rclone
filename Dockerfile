FROM alpine:3.8

ENV RCLONE_VERSION=current
ENV ARCH=amd64

RUN apk update && apk add openssl ca-certificates fuse
RUN cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip \
    && unzip /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

VOLUME /config
VOLUME /data

ENV CRON_SCHEDULE="0 * * * *"
ENV SYNC_DESTINATION_SUBPATH=/

COPY rclone.sh /rclone.sh
COPY entrypoint.sh .
COPY run.sh /etc/services.d/cron/run

ENTRYPOINT [ "./entrypoint.sh" ]