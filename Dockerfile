# Get matching PI friendly python base
FROM --platform=linux/arm32/v7 python:3.7-buster AS base

FROM base as build
RUN apt-get update && apt-get -y install --no-install-recommends \
	gcc \
	g++ \
	gfortran \
	libopenblas-dev \
	libblas-dev \
	liblapack-dev \
	libatlas-base-dev \
	libhdf5-dev \
	libhdf5-100 \
	pkg-config \
	wget
RUN pip3 install wheel==0.34.2 cython==0.29.14 pybind11==2.4.3
RUN pip3 wheel numpy==1.18.1 && pip3 install numpy-*.whl
RUN pip3 wheel scipy==1.4.1
RUN pip3 wheel --no-deps h5py==2.10.0


FROM base
RUN apt-get update && apt-get -y install --no-install-recommends \
	python3-pip \
	python3-setuptools \
	libopenblas-base \
	wget \
&& rm -rf /var/lib/apt/lists/*
COPY --from=build /*.whl /
RUN pip3 install *.whl
RUN wget https://github.com/bitsy-ai/tensorflow-arm-bin/releases/download/v2.4.0/tensorflow-2.4.0-cp37-none-linux_armv7l.whl
RUN pip3 install tensorflow-*.whl
RUN rm *.whl
