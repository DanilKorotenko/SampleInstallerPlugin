//
//  MyInstallerPane.m
//  GrantAccess
//
//  Created by Danil Korotenko on 11/27/19.
//

#import "MyInstallerPane.h"

@implementation MyInstallerPane

- (NSString *)title
{
    return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

@end
