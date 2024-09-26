## This is a hack, we need to find a base that works properly
FROM thmhoag/rclone:1.0.0

RUN apk update && apk add openssl ca-certificates fuse
RUN cd /tmp \
    && wget -q https://downloads.rclone.org/v1.68.0/rclone-v1.68.0-linux-amd64.zip \
    && unzip /tmp/rclone-v1.68.0-linux-amd64.zip \
    && mv /tmp/rclone-*-linux-amd64/rclone /usr/bin \
    && rm -r /tmp/rclone*

VOLUME /config
VOLUME /data

ENV CRON_SCHEDULE="0 * * * *"
ENV SYNC_DESTINATION_SUBPATH=/

COPY rclone.sh /rclone.sh
COPY entrypoint.sh .
COPY run.sh /etc/services.d/cron/run

ENTRYPOINT [ "./entrypoint.sh" ]
