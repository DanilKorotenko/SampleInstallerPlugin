//
//  main.m
//  HelloGrantAccess
//
//  Created by Danil Korotenko on 11/27/19.
//

#import <Cocoa/Cocoa.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
		// Check if this process is launched with check full disk access key
		if (argc > 1)
		{
			NSString *param = [NSString stringWithUTF8String:argv[1]];
			if ([param isEqualToString:@"-c"])
			{
				int c = open("/Library/Application Support/com.apple.TCC/TCC.db", O_RDONLY);

				if (c == -1 && (errno == EPERM || errno == EACCES))
				{
					return 1; // not authorized
				}
				else
				{
					return 0;
				}
			}
		}
    }
    return NSApplicationMain(argc, argv);
}
