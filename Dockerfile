# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:a3d3a0d10d1db83b83f61e082d59d5cdddcd92f8ace43642b5d14b4a12624355

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
