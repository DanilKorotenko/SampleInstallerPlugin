//
//  MyInstallerPane.m
//  DragPlugin
//
//  Created by Danil Korotenko on 11/11/20.
//

#import "MyInstallerPane.h"

@implementation MyInstallerPane

- (NSString *)title
{
    return [[NSBundle bundleForClass:[self class]] localizedStringForKey:@"PaneTitle" value:nil table:nil];
}

@end
