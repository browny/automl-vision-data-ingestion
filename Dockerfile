FROM python:2.7-slim
MAINTAINER browny.lin@gcp.expert

ENV GCLOUD=/root/google-cloud-sdk/bin/gcloud
ENV GSUTIL=/root/google-cloud-sdk/bin/gsutil

# install curl and gcloud SDK
RUN \
  apt-get update && \
  apt-get install -y curl && \
  curl https://sdk.cloud.google.com | bash && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY run.sh /opt/run.sh
RUN touch /opt/key.json
ENTRYPOINT ["/opt/run.sh"]
CMD []
