# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:f81a5bf1332dcd61ee88ab285211005d8b1b27a6f483200b555ddf4bf0bbd8ff as builder

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