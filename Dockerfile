# Cf. https://hub.docker.com/r/chainguard/python/
FROM chainguard/python:latest@sha256:92c3483c8ac7eda088e51952b744cce1f3087fe7560a5da672d918b7c57a65fc

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-04-27"
LABEL author="Florian Stosse"
LABEL description="Checksec.py v0.7.4, built using Python Chainguard based image"
LABEL license="MIT license"

# Cf. https://pypi.org/project/checksec.py/
RUN pip install checksec.py==0.7.4 --user