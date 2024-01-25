color="\033[0;32m"
end="\033[0m"

export KBUILD_BUILD_USER=Burhanverse
export KBUILD_BUILD_HOST=burhancodes
export BUILD_USERNAME=Burhanverse
export BUILD_HOSTNAME=burhancodes
export TARGET_KERNEL_BUILD_USER=Burhanverse
export TARGET_KERNEL_BUILD_HOST=burhancodes

# Clone dependencies
echo -e "${color}Cloning dependencies...${end}"
#motowidgets
git clone --depth 1 https://github.com/burhancodes/package_apps_MyUIWidgets packages/apps/MyUIWidgets
#GoogleCamera
git clone --depth 1 https://github.com/burhancodes/packages_apps_GoogleCamera_8.1 packages/apps/GoogleCamera_8.1
# custom installer
git clone --depth 1 https://github.com/burhancodes/packages_apps_CustomPackageInstaller packages/apps/CustomPackageInstaller
# vendor
git clone --depth 1 https://github.com/burhancodes/vendor_xiaomi_lancelot vendor/xiaomi/lancelot
# kernel
git clone --depth 1 https://github.com/Burhanverse/KernelTree kernel/xiaomi/mt6768
# mtk sepolicy vendor
rm -rf device/mediatek/sepolicy_vndr
git clone --depth 1 https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
# mtk hardware 
rm -rf hardware/mediatek
git clone --depth 1 https://github.com/LineageOS/android_hardware_mediatek hardware/mediatek
# clang
git clone --depth 1 https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r487747c prebuilts/clang/host/linux-x86/clang-r487747c

echo -e "Dependencies cloned successfully!"

# Configure the patches path
patchDir="device/xiaomi/lancelot/patches"
echo -e "Patches Path: ${patchDir}"

echo -e "${color}Applying patches !${end}"

# Patch bootanimation lag
rm -rf frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp

cp ${patchDir}/frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp frameworks/native/libs/renderengine/threaded/

# Patch media codec issues
echo -e "Applying Media Codec patches!"
rm -rf frameworks/av/include/media/MediaExtractorPluginHelper.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/GenericSource.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/NuPlayerSource.h
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/GenericSource.cpp
rm -rf frameworks/av/media/libmediaplayerservice/nuplayer/NuPlayerDecoder.cpp
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h
rm -rf frameworks/av/media/libstagefright/ACodec.cpp
rm -rf frameworks/av/media/libstagefright/MediaCodecSource.cpp
rm -rf frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp
rm -rf frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp
rm -rf frameworks/av/media/mediaserver/mediaserver.rc
rm -rf frameworks/av/media/extractors/ogg/OggExtractor.cpp
rm -rf frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy
rm -rf frameworks/av/services/mediaextractor/mediaextractor.rc

cp ${patchDir}/frameworks/av/include/media/MediaExtractorPluginHelper.h frameworks/av/include/media/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/GenericSource.h frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/NuPlayerSource.h frameworks/av/media/libmediaplayerservice/nuplayer/include/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/GenericSource.cpp frameworks/av/media/libmediaplayerservice/nuplayer/
cp ${patchDir}/frameworks/av/media/libmediaplayerservice/nuplayer/NuPlayerDecoder.cpp frameworks/av/media/libmediaplayerservice/nuplayer/
cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/ACodec.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/MediaCodecSource.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/mediaserver/mediaserver.rc frameworks/av/media/mediaserver/
cp ${patchDir}/frameworks/av/media/extractors/ogg/OggExtractor.cpp frameworks/av/media/extractors/ogg/
cp ${patchDir}/frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy frameworks/av/services/mediacodec/seccomp_policy/
cp ${patchDir}/frameworks/av/services/mediaextractor/mediaextractor.rc frameworks/av/services/mediaextractor/

echo -e "${color}Patch applied successfully!${end}"
# Navigate to the kernel directory
cd kernel/xiaomi/mt6768
# Install KernelSU
echo -e "${color}Patching Kernel for KernelSU...${end}"
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
# Return to the original directory
cd ../../..
echo -e "${color}Kernel patched!${end}"