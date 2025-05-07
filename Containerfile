ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN rpm --import https://rpm.torproject.org/fedora/public_gpg.key
ADD assets/package.repo /etc/yum.repos.d/tor.repo

RUN dnf install -y \
	    torbrowser-launcher \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && git config -f /etc/rdesktop/rdesktop.ini \
	    rdesktop.title "Personal Onion" \
    && git config -f /etc/rdesktop/rdesktop.ini \
	    rdesktop.exec "torbrowser-launcher"

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
