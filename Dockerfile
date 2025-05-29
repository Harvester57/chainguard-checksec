# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest-dev@sha256:ad26c1543e1348597b9030d2b320f61127e137f30710c795d82e93791534a018 as builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/checksec/venv/bin:$PATH"

RUN git clone --branch v0.7.4.2 https://github.com/Harvester57/checksec.py.git --depth 1

WORKDIR /checksec
RUN python -m venv /checksec/venv

RUN poetry build

RUN pip install checksec.whl

FROM chainguard/python:latest@sha256:0a32c558cb68f9743a0492377c84c6d838d52b08cabfca962a17fce3d0ef02aa

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