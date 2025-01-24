FROM alpine:3.21 AS build

RUN apk add build-base autoconf automake libtool

WORKDIR /app
RUN wget -qO- https://github.com/enzo1982/mp4v2/archive/refs/tags/v2.1.3.tar.gz | tar zxvf - -C /app

WORKDIR /app/mp4v2-2.1.3
RUN <<EOT
        autoreconf -i
        ./configure
        make
	make install
EOT

FROM alpine:3.21

RUN apk add --no-cache ffmpeg coreutils bc bash dpkg gcompat

# install gpac
COPY --from=gpac/ubuntu /gpac/binaries/gpac /gpac/binaries/MP4Box /bin/

# install mp4chaps
COPY --from=build /usr/local/bin/mp4* /bin/
COPY --from=build /usr/local/lib/libmp4v2.so.2.1.3 /lib/
COPY --from=build /usr/local/lib/libmp4v2.la /lib/

WORKDIR /lib
RUN <<EOT
	ln -s -f libmp4v2.so.2.1.3 libmp4v2.so.2
	ln -s -f libmp4v2.so.2.1.3 libmp4v2.so
EOT

#RUN ln -s $(which date) /bin/gdate

COPY mp4.sh /bin/
RUN chmod 700 /bin/mp4.sh

WORKDIR /config

ENTRYPOINT [ "/bin/mp4.sh" ]
