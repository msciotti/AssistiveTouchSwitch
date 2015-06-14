include theos/makefiles/common.mk

BUNDLE_NAME = AssistiveTouchSwitch
AssistiveTouchSwitch_FILES = Switch.x
AssistiveTouchSwitch_FRAMEWORKS = UIKit
AssistiveTouchSwitch_PRIVATE_FRAMEWORKS = GraphicsServices
AssistiveTouchSwitch_LIBRARIES = flipswitch
AssistiveTouchSwitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/library.mk


after-install::
	install.exec "killall -9 SpringBoard"