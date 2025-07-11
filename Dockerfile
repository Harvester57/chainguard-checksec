# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:50c95e552d7a74f678005fd0d579e4f7fe71c8f371ffe61a651a4648d1da38a7

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-07-11"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.4, built using Python Chainguard based image"
LABEL license="MIT license"

ENV LANG=C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV TZ="Europe/Paris"

WORKDIR /checksec
RUN git clone https://github.com/Harvester57/checksec.py.git --depth 1

WORKDIR /checksec/checksec.py
RUN pip install poetry
ENV PATH="/home/nonroot/.local/bin:$PATH"
RUN poetry build --output /checksec
RUN rm -rf /checksec/checksec.py

RUN python -m venv /checksec/venv
ENV PATH="/checksec/venv/bin:$PATH"

RUN pip install /checksec/checksec_py-0.7.4-py3-none-any.whl --no-cache-dir

# Test run
RUN checksec -h

ENTRYPOINT [ "checksec" ]
