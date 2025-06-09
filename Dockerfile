# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:5d964e2b42d231e78beba4ab87146e7f10b4d93f5c1e29ac4a1b430decfe954b AS builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/checksec/venv/bin:$PATH"

WORKDIR /checksec
RUN git clone --branch 0.7.4.3 https://github.com/Harvester57/checksec.py.git --depth 1

WORKDIR /checksec/checksec.py
RUN pip install poetry
ENV PATH="/home/nonroot/.local/bin:$PATH"
RUN poetry build --output /checksec
RUN rm -rf /checksec/checksec.py

RUN python -m venv /checksec/venv
RUN pip install /checksec/checksec_py-0.7.4-py3-none-any.whl

FROM chainguard/python:latest@sha256:d100c2fc9b03eec266ff76e8f9bcda304ae10c3cb9a5b5bb5739cae5584fe4ed

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