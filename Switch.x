#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"

#ifndef GSEVENT_H
extern void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);
#endif

#define kATPreferences CFSTR("com.apple.Accessibility")
#define kATKey CFSTR("AssistiveTouchEnabled")

@interface AssistiveTouchSwitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation AssistiveTouchSwitchSwitch


// Return the current state of the switch.
-(FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier { //Set switch state on or off
	CFPreferencesAppSynchronize(kATPreferences);
	Boolean enabled = CFPreferencesGetAppBooleanValue(kATKey, kATPreferences,NULL);
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}
 
// Set a new state for the switch.
- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {

	
	if(newState == FSSwitchStateIndeterminate) //If switch is neither on or off
		return; //Don't do anything
	
	CFPreferencesSetAppValue(kATKey, newState ? kCFBooleanTrue : kCFBooleanFalse, kATPreferences);
	CFPreferencesAppSynchronize(kATPreferences);
	GSSendAppPreferencesChanged(kATPreferences, kATKey);
}


@end