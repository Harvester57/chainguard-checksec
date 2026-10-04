# Cf. https://hub.docker.com/r/chainguard/python/
ARG BUILDKIT_SBOM_SCAN_STAGE=true
FROM chainguard/python:latest-dev@sha256:c23539f80289046e2fa734d3f3fc418833fc22d064a50cc43fa9a6edc28c1615 AS builder

ENV LANG=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ="Europe/Paris"

WORKDIR /checksec

RUN python -m venv /checksec/venv
ENV PATH="/checksec/venv/bin:$PATH"

RUN pip install checksec-py==0.7.5 --no-cache-dir

FROM cgr.dev/chainguard/python:latest@sha256:1f37785e5cdb70151f36aaa15e1e3cef4571424dbefbf4b0d8a9222535cb13ff

LABEL org.opencontainers.image.authors="Florian Stosse <florian.stosse@gmail.com>"
LABEL org.opencontainers.image.created="2025-07-17"
LABEL org.opencontainers.image.description="Checksec.py v0.7.5, built using Python Chainguard based image"
LABEL org.opencontainers.image.licenses="MIT license"

WORKDIR /venv

ENV LANG=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ="Europe/Paris" \
    PATH="/venv/bin:$PATH"

COPY --from=builder /checksec/venv /venv

ENTRYPOINT [ "python3", "/venv/bin/checksec" ]
