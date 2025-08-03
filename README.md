# Checksec.py Docker Image

This repository contains a Dockerfile to build a container image for `checksec.py` version 0.7.5. The image is built using Chainguard's hardened Python base images for enhanced security and a smaller footprint.

`checksec.py` is a Python tool designed to check the security properties of executables and the process address space.

## Image Details

*   **Base Image (Build Stage):** `chainguard/python:latest-dev`
*   **Base Image (Final Stage):** `chainguard/python:latest`
*   **`checksec.py` Version:** 0.7.5
*   **Maintainer:** florian.stosse@gmail.com
*   **Author:** Florian Stosse
*   **License:** MIT license
*   **Description:** Checksec.py v0.7.5, built using Python Chainguard based image

## Build

To build the Docker image, navigate to the directory containing the `Dockerfile` and run:

```sh
docker build -t checksec-chainguard .
```
