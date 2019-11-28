//
//  MyInstallerPane.m
//  GrantAccess
//
//  Created by Danil Korotenko on 11/27/19.
//

#import "MyInstallerPane.h"

@interface MyInstallerPane ()

@property(assign) BOOL isFullDiskAccessGranted;

@end

@implementation MyInstallerPane

- (IBAction)grantAccess:(id)sender
{
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString:
		@"x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"]];
}

- (IBAction)updateStatus:(id)sender
{
	NSLog(@"Updating status");

	NSError *taskError = nil;
	[NSTask launchedTaskWithExecutableURL:
		[NSURL fileURLWithPath:
			@"/Applications/HelloGrantAccess.app/Contents/MacOS/HelloGrantAccess"]
			arguments:@[@"-c"] error:&taskError terminationHandler:^(NSTask * _Nonnull aTask)
		{
			[self.updateButton setEnabled:YES];
			[self.progressIndicator stopAnimation:nil];
			[self.progressIndicator setHidden:YES];

			if ([aTask terminationStatus] == 0) // access is granted
			{
				self.isFullDiskAccessGranted = YES;
			}

			[self updateStatusLabel];
		}];
	[self.updateButton setEnabled:NO];
	[self.progressIndicator setHidden:NO];
	[self.progressIndicator startAnimation:nil];
}

- (void)updateStatusLabel
{
	if (self.isFullDiskAccessGranted)
	{
		[self.statusLabel setStringValue:@"Authorized"];
		[self.statusLabel setTextColor:[NSColor colorWithRed:0 green:0.39 blue:0 alpha:1]];
	}
	else
	{
		[self.statusLabel setStringValue:@"Not Authorized"];
		[self.statusLabel setTextColor:[NSColor redColor]];
	}
}

#pragma mark -

- (NSString *)title
{
    return [[NSBundle bundleForClass:[self class]]
		localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

- (BOOL)shouldExitPane:(InstallerSectionDirection)dir
{
	return self.isFullDiskAccessGranted;
}

- (void)didEnterPane:(InstallerSectionDirection)dir
{
	self.previousEnabled = YES;
	[self updateStatusLabel];
}

@end
