FROM nvidia/cuda:11.4.3-base-ubuntu20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install make wget git xz-utils gcc g++ libx264-dev frei0r-plugins-dev yasm libgmp-dev libgnutls28-dev libass-dev libgme-dev libmp3lame-dev libopenjp2-7-dev libopus-dev librubberband-dev libsoxr-dev libspeex-dev libtheora-dev libvorbis-dev libvpx-dev libwebp-dev libx265-dev libxvidcore-dev libzvbi-dev libxml++2.6-dev -y

RUN git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git && cd nv-codec-headers && make install && cd ..

RUN wget -q https://ffmpeg.org/releases/ffmpeg-6.1.tar.xz  && xz -d  ffmpeg-6.1.tar.xz && tar -xvf ffmpeg-6.1.tar &&  cd ffmpeg-6.1 && ./configure --enable-gpl --enable-version3 --enable-static --disable-debug --disable-ffplay --disable-indev=sndio --disable-outdev=sndio --cc=gcc --enable-fontconfig --enable-frei0r --enable-gnutls --enable-gmp --enable-libgme --enable-gray  --enable-libfribidi --enable-libass  --enable-libfreetype --enable-libmp3lame --enable-libopenjpeg --enable-librubberband --enable-libsoxr --enable-libspeex  --enable-libvorbis --enable-libopus --enable-libtheora  --enable-libvpx --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxml2  --enable-libxvid --enable-libzvbi --enable-decoder=png --enable-encoder=png --enable-cuda --enable-cuvid --enable-nvenc --enable-filter=movie && make -j32 && make install

RUN apt clean && rm ffmpeg-6.1.tar && rm -rf ffmpeg-6.1 && rm -rf nv-codec-headers