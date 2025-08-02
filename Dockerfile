# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:b080419db9405e51ab87b394f6437b5ba2e93f45b9a119418f6f3189a3bf403f

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
