ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

BUNDLE_NAME = AssistiveTouchSwitch
AssistiveTouchSwitch_FILES = Switch.x
AssistiveTouchSwitch_FRAMEWORKS = UIKit
AssistiveTouchSwitch_LIBRARIES = flipswitch
AssistiveTouchSwitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk