# Use Ubuntu as base image
FROM ubuntu:16.04

RUN apt-get update \
  # Add some package dependencies
  && apt-get install -y --no-install-recommends python3 python3-pip wget software-properties-common \
  # Install ffmpeg 4.x via ppa
  && add-apt-repository -y ppa:jonathonf/ffmpeg-4 \
  && apt-get update \
  && apt-get install -y --no-install-recommends ffmpeg \
  # Add some python dependencies for yle-dl
  && pip3 install --no-cache-dir setuptools wheel \
  # Install yle-dl
  && pip3 install --no-cache-dir --upgrade yle-dl \
  # Clean up by removing not needed packages and apt cache
  && pip3 uninstall -y wheel \
  && apt-get purge -y --auto-remove python3-pip software-properties-common \
  && rm -rf /var/lib/apt/lists/* 

# Change workdir to the the download folder
WORKDIR /download

# yle-dl as entrypoint
ENTRYPOINT [ "yle-dl" ]
