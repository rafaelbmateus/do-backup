FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    s3cmd \
    curl \
    tar \
    && rm -rf /var/lib/apt/lists/*

COPY .s3cfg /root/.s3cfg

COPY scripts/backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

COPY scripts/check.sh /usr/local/bin/check.sh
RUN chmod +x /usr/local/bin/check.sh

COPY scripts/rotate.sh /usr/local/bin/rotate.sh
RUN chmod +x /usr/local/bin/rotate.sh

COPY scripts/run-daily.sh /usr/local/bin/run-daily.sh
RUN chmod +x /usr/local/bin/run-daily.sh

COPY scripts/slack.sh /usr/local/bin/slack.sh
RUN chmod +x /usr/local/bin/slack.sh

CMD ["check.sh"]
