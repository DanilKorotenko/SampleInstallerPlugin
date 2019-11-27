//
//  MyInstallerPane.h
//  GrantAccess
//
//  Created by Danil Korotenko on 11/27/19.
//

#import <InstallerPlugins/InstallerPlugins.h>

@interface MyInstallerPane : InstallerPane

@property (assign) IBOutlet NSTextField *statusLabel;
@property (assign) IBOutlet NSButton *updateButton;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;

- (IBAction)grantAccess:(id)sender;
- (IBAction)updateStatus:(id)sender;

@end
