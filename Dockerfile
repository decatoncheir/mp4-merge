FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    ffmpeg \
    gpac \
    coreutils \
    wget \
    bc \
    && rm -rf /var/lib/apt/lists/*

# install mp4v2

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb \
    && wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb \
    && dpkg -i libmp4v2-2_2.0.0~dfsg0-6_amd64.deb \
    && dpkg -i mp4v2-utils_2.0.0~dfsg0-6_amd64.deb

COPY mp4.sh .
 
RUN chmod 755 mp4.sh && mkdir /src && mkdir /target && ln -s $(which date) /bin/gdate

CMD true > /tmp/youtube_chapterfile.log && ./mp4.sh merge_as_chapter /src/*.mp4 /target/output.mp4 && cp /tmp/youtube_chapterfile.log /target/output.log