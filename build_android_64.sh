#!/bin/sh
ANDROID_NDK_ROOT=/home/liushuo/workspace/ndk/android-ndk-r21b/
ARM_ROOT=$ANDROID_NDK_ROOT
SYSROOT=$ARM_ROOT/toolchains/llvm/prebuilt/linux-x86_64/sysroot
#ARM_INC=$ARM_ROOT/platforms/android-29/arch-arm64/usr/include/
#ARM_LIB=$ARM_ROOT/platforms/android-29/arch-arm64/usr/lib
#ARM_LIBO=$ARM_TOOL/lib/gcc/aarch64-linux-android/4.9.x
ARM_TOOL=$ARM_ROOT/toolchains/llvm/prebuilt/linux-x86_64
PATH=$ARM_TOOL/bin:$PATH
ARM_PRE=arm-linux-androideabi
CPU=arm64
PREFIX=$(pwd)/android/$CPU
CC=$ARM_ROOT/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin
ADDI_LDFLAGS="-fPIE -pie"
ADDI_CFLAGS="-fPIE -pie -mfloat-abi=softfp -mfpu=neon"

./configure \
    --target-os=android \
    --arch=aarch64 \
    --prefix=$PREFIX \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --cross-prefix=$ARM_TOOL/bin/aarch64-linux-android- \
    --cc=$ARM_TOOL/bin/aarch64-linux-android29-clang \
    --cxx=$ARM_TOOL/bin/aarch64-linux-android29-clang++ \
    --nm=$ARM_TOOL/bin/aarch64-linux-android-nm \
    --disable-encoders \
    --disable-decoders \
    --disable-avdevice \
    --disable-static \
    --disable-doc \
    --disable-ffplay \
    --disable-network \
    --disable-doc \
    --disable-symver \
    --disable-ffprobe \
    --enable-neon \
    --enable-shared \
    --enable-gpl \
    --enable-pic \
    --enable-jni \
    --enable-pthreads \
    --enable-mediacodec \
    --enable-encoder=aac \
    --enable-encoder=gif \
    --enable-encoder=libopenjpeg \
    --enable-encoder=libmp3lame \
    --enable-encoder=libwavpack \
    --enable-encoder=libx264 \
    --enable-encoder=mpeg4 \
    --enable-encoder=pcm_s16le \
    --enable-encoder=png \
    --enable-encoder=mjpeg \
    --enable-encoder=srt \
    --enable-encoder=subrip \
    --enable-encoder=yuv4 \
    --enable-encoder=text \
    --enable-decoder=aac \
    --enable-decoder=aac_latm \
    --enable-decoder=libopenjpeg \
    --enable-decoder=mp3 \
    --enable-decoder=mpeg4_mediacodec \
    --enable-decoder=pcm_s16le \
    --enable-decoder=flac \
    --enable-decoder=flv \
    --enable-decoder=gif \
    --enable-decoder=png \
    --enable-decoder=srt \
    --enable-decoder=xsub \
    --enable-decoder=yuv4 \
    --enable-decoder=vp8_mediacodec \
    --enable-decoder=h264_mediacodec \
    --enable-decoder=hevc_mediacodec \
    --enable-bsf=aac_adtstoasc \
    --enable-bsf=h264_mp4toannexb \
    --enable-bsf=hevc_mp4toannexb \
    --enable-bsf=mpeg4_unpack_bframes \
    --extra-cflags="$ADDI_CFLAGS" \
    --extra-ldflags="$ADDI_LDFLAGS"

# build for arm64
make clean
make -j4
make install
