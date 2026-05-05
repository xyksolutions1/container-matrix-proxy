# SPDX-FileCopyrightText: © 2026 Nfrastack <code@nfrastack.com>
#
# SPDX-License-Identifier: MIT

ARG \
    BASE_IMAGE

FROM docker.io/xyksolutions1/container-nginx:main

LABEL \
        org.opencontainers.image.title="Matrix Proxy" \
        org.opencontainers.image.description="Proxy to your Matrix Homeserver" \
        org.opencontainers.image.url="https://hub.docker.com/r/xyksolutions1/matrix-proxy" \
        org.opencontainers.image.documentation="https://github.com/xyksolutions1/container-matrix-proxy/blob/main/README.md" \
        org.opencontainers.image.source="https://github.com/xyksolutions1/container-matrix-proxy.git" \
        org.opencontainers.image.authors="xyksolutions1" \
        org.opencontainers.image.vendor="xyksolutions1" \
        org.opencontainers.image.licenses="MIT"

COPY CHANGELOG.md /usr/src/container/CHANGELOG.md
COPY LICENSE /usr/src/container/LICENSE
COPY README.md /usr/src/container/README.md

ENV \
    IMAGE_NAME="xyksolutions1/matrix-proxy" \
    IMAGE_REPO_URL="https://github.com/xyksolutions1/container-matrix-proxy/"

RUN echo "" && \
    BUILD_ENV=" \
                NGINX_SITE_ENABLED=matrix_proxy \
                NGINX_CREATE_SAMPLE_HTML=FALSE \
              "\
              && \
    source /container/base/functions/container/build && \
    container_build_log image && \
    sed -i "s|{{NGINX_CLIENT_BODY_BUFFER_SIZE}}|32k|g" /container/data/nginx/templates/server/http-client.template && \
    package update && \
    package upgrade && \
    package cleanup

COPY rootfs /

