# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:26eaa7a1a5baafb4c00bee9f1fbd744419290facf2ff2d6e1021c7b63a5b471d AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/checksec/venv/bin:$PATH"

WORKDIR /checksec
RUN git clone https://github.com/Harvester57/checksec.py.git --depth 1

WORKDIR /checksec/checksec.py
RUN pip install poetry
ENV PATH="/home/nonroot/.local/bin:$PATH"
RUN poetry build --output /checksec
RUN rm -rf /checksec/checksec.py

RUN python -m venv /checksec/venv
RUN pip install /checksec/checksec_py-0.7.4-py3-none-any.whl

FROM chainguard/python:latest@sha256:e0dbf1d2dd8116bc4c5b9066281b1939777eba163e7e7801d3d34fc8ebe5bedb

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-04-27"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.4, built using Python Chainguard based image"
LABEL license="MIT license"

ENV TZ="Europe/Paris"

WORKDIR /checksec

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY --from=builder /checksec/venv /venv
