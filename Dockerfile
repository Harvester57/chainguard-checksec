# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:197dc1b7c30dc150d8f8e7c4f9d314674ea41a95602f97fd4a4cd84d7fa7f480 AS builder

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"

WORKDIR /checksec

RUN python -m venv /checksec/venv
ENV PATH="/checksec/venv/bin:$PATH"

RUN pip install checksec-py==0.7.5 --no-cache-dir

FROM cgr.dev/chainguard/python:latest@sha256:dc6d95fe490f76869974e1dbe96d4db01c06d194030467a9501584c19466bb30

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
