# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.233.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"

FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ARG SERVER_VERSION="latest-recommended"
ARG RESOURCES_VERSION="latest"
ARG CFX_PATH="/home/vscode/cfx/"

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends tmux btop xz-utils mariadb-client

COPY scripts/cfx-setup.sh /tmp/scripts/cfx-setup.sh
RUN echo "${CFX_PATH}" "${SERVER_VERSION}" "${RESOURCES_VERSION}"
RUN bash /tmp/scripts/cfx-setup.sh "${CFX_PATH}" "${SERVER_VERSION}" "${RESOURCES_VERSION}"