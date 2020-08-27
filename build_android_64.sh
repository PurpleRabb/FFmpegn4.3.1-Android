#!/bin/sh
export NDK=/home/liushuo/workspace/ndk/android-ndk-r21b/
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64/
API=29
ARCH=arm64
CPU=armv8-a
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"

function build_android
{
    echo "Compiling FFmpeg for $CPU"
    ./configure \
        --prefix=$PREFIX \
        --enable-neon \
        --enable-hwaccels \
        --enable-gpl \
        --enable-postproc \
        --enable-shared \
        --enable-jni \
        --enable-mediacodec \
        --enable-decoder=h264_mediacodec \
        --disable-static \
        --disable-doc \
        --enable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --enable-avdevice \
        --disable-doc \
        --disable-symver \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=android \
        --arch=$ARCH \
        --cpu=$CPU \
        --cc=$CC \
        --cxx=$CXX \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        --extra-cflags="-Os -fpic -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD $OPTIMIZE_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        $ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
echo "The Compilation of FFmpeg for $CPU is completed"
}
build_android
