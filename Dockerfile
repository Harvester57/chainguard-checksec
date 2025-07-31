# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:71271354480c32cb2adcbc8548d075a13a592bb6704da34ef79f4b5c40ae0b39

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-17"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.5, built using Python Chainguard based image"
LABEL license="MIT license"

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"

WORKDIR /checksec

RUN python -m venv /checksec/venv
ENV PATH="/checksec/venv/bin:$PATH"

RUN pip install checksec-py==0.7.5 --no-cache-dir

# Test run
RUN checksec -h

ENTRYPOINT [ "checksec" ]
