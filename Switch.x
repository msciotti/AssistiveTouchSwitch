#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import "notify.h"

#define assistiveTouchPlist @"/var/mobile/Library/Preferences/com.apple.Accessibility.plist" //Make file path a variable

@interface AssistiveTouchSwitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation AssistiveTouchSwitchSwitch

// Return the current state of the switch.
-(FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier { //Set switch state on or off
	NSDictionary* assistiveTouchSettings = [NSDictionary dictionaryWithContentsOfFile:assistiveTouchPlist]; //Read the Accessibility plist
	return [[assistiveTouchSettings objectForKey:@"AssistiveTouchEnabled"] boolValue] ? FSSwitchStateOn : FSSwitchStateOff; //Switch state matches AT state
}
 
// Set a new state for the switch.
- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {

	NSMutableDictionary* assistiveTouchSettings = [NSMutableDictionary dictionaryWithContentsOfFile:assistiveTouchPlist]; //Get file contents

	if(newState == FSSwitchStateIndeterminate) { //If switch is neither on or off
		return; //Don't do anything

	} else if(newState == FSSwitchStateOn) { //If on..
		[assistiveTouchSettings setObject:[NSNumber numberWithBool:YES] forKey:@"AssistiveTouchEnabled"]; //Turn AT on

	} else if(newState == FSSwitchStateOff) { //But if off..
		[assistiveTouchSettings setObject:[NSNumber numberWithBool:NO] forKey:@"AssistiveTouchEnabled"]; //Turn AT off
	}

	[assistiveTouchSettings writeToFile:assistiveTouchPlist atomically:YES]; // Write changes to file
	notify_post("com.apple.Accessibility-prefsChanged"); //Notify that changes were made
}

- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {	//Title of flipswitch
	return @"Assistive Touch";
}

@end