FROM docker:dind

COPY requirements.txt /

RUN apk update &&\
    apk add --update --no-cache \
        py-pip \
        python3 \
        git \
        openssh-client\
        curl \
        libffi\
        py3-cryptography\
        musl\
        py3-pynacl\
        py3-bcrypt\
        openssl &&\ 
    apk add --update --no-cache -t build-dep \
        python3-dev\
        gcc\
        build-base\
        autoconf\
        automake\
        musl-dev\
        linux-headers\
        libffi-dev\
        openssl-dev &&\
    pip install -U pip --no-cache-dir &&\
    pip install --no-cache-dir -r /requirements.txt &&\
    apk del build-dep &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/* &&\
    rm -rf /root/.cache

WORKDIR /ansible

ENTRYPOINT [ "molecule" ]