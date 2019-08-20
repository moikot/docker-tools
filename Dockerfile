FROM scratch

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/moikot/docker-tools.git"

COPY scripts.sh /

# Just a dummy entry point to make `docker create` happy.
ENTRYPOINT ["null"]
