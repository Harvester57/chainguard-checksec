# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:79a3c0faff705cfd3963399c9835e079a24b5655883e42171fe1a6bf27e794df AS builder

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"

WORKDIR /checksec

RUN python -m venv /checksec/venv
ENV PATH="/checksec/venv/bin:$PATH"

RUN pip install checksec-py==0.7.5 --no-cache-dir

FROM cgr.dev/chainguard/python:latest@sha256:80c9b043c8f231f130b0d0dd71cfbdc79e8a9855430ea2fad0ded34de12116c4

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-17"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.5, built using Python Chainguard based image"
LABEL license="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /checksec/venv /venv

ENTRYPOINT [ "python3", "/venv/bin/checksec" ]
