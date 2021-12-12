FROM hashicorp/terraform:1.1.0

RUN apk add --update --no-cache \
        make \
        bash \
        python3 \
        py3-pip \
        jq && \
    pip3 install --upgrade pip && \
    pip3 install \
        google \
        google-api-python-client \
        google-auth \
        awscli

# use custom entrypoint to always use hosts user UID and GID
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

# set default home directory for root
ENV HOME /home/terraform

# set default working directory to try and determine UID and GID
VOLUME ["/opt/app"]
WORKDIR /opt/app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--version"]