# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:83368419da958ef8f7b049c1dc52238a77a8daa2ed1f264e2fb8444bc9f82b06 as builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/checksec/venv/bin:$PATH"

WORKDIR /checksec
RUN python -m venv /checksec/venv

# Cf. https://pypi.org/project/checksec.py/
RUN pip install checksec.py==0.7.4

FROM chainguard/python:latest@sha256:0ed9f745adb1df1131a46e89945bde7117eadde7b904c74188ec81df3f488c2b

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-04-27"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.4, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /checksec

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /checksec/venv /venv