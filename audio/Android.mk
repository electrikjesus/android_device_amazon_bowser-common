ifeq ($(findstring bowser, $(TARGET_BOOTLOADER_BOARD_NAME)),bowser)

LOCAL_PATH := $(call my-dir)

###
### AUDIO PRIMARY FOR BOWSER
###

include $(CLEAR_VARS)

# Should change this so the enable variable gets used as the name?
LOCAL_MODULE := audio.primary.$(TARGET_BOOTLOADER_BOARD_NAME)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SRC_FILES := audio_hw.c
LOCAL_C_INCLUDES += \
	external/tinyalsa/include \
	external/expat/lib \
	system/media/audio_utils/include \
	system/media/audio_effects/include
LOCAL_SHARED_LIBRARIES := liblog libcutils libtinyalsa libaudioutils \
	libdl libexpat
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

###
### OMAP HDMI AUDIO HAL
###

include $(CLEAR_VARS)

LOCAL_MODULE := audio.hdmi.$(TARGET_BOOTLOADER_BOARD_NAME)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_SRC_FILES := hdmi_audio_hw.c \
	hdmi_audio_utils.c

LOCAL_C_INCLUDES += \
	external/tinyalsa/include \
	system/media/audio_utils/include \
	system/media/audio_effects/include
LOCAL_SHARED_LIBRARIES := liblog libcutils libtinyalsa libaudioutils libdl
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

###
### SLIGHTLY CUSTOM AUDIO_POLICY WITH VOLUME HOOKS FOR AUDIO PRIMARY
###

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    AudioPolicyManagerDefault.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper

LOCAL_WHOLE_STATIC_LIBRARIES := \
    libaudiopolicy_legacy

LOCAL_MODULE := audio_policy.$(TARGET_BOOTLOADER_BOARD_NAME)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif
