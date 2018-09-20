FROM python:3.7

RUN apt-get update && \
        apt-get install -y \
        build-essential \
        checkinstall \
        cmake \
        git \
        wget \
        unzip \
        gfortran \
        yasm \
        pkg-config \
        libtbb-dev \
        libjpeg-dev \
        libtiff5-dev \
        libavformat-dev \
        libavcodec-dev \
        libdc1394-22-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libx264-dev \
        libxine2-dev \
        libvorbis-dev \
        libmp3lame-dev \
        libtheora-dev \
        libgtk-3-dev \
        libgtk2.0-dev \
        libqt5-dev \
        libatlas-base-dev \
        libopenblas-dev \
        libeigen3-dev \
        ffmpeg \
        gstreamer-plugins-base1.0-dev

RUN pip install numpy
RUN pip install matplotlib

WORKDIR /
ENV OPENCV_VERSION="3.3.1"
RUN wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& rm ${OPENCV_VERSION}.zip
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-${OPENCV_VERSION}/modules \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DWITH_QT=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_EXAMPLES=ON \
  -DINSTALL_C_EXAMPLES=ON \
  -DINSTALL_PYTHON_EXAMPLES=ON \
  -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.7) \
  -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.zip \
&& rm -r /opencv-${OPENCV_VERSION}
