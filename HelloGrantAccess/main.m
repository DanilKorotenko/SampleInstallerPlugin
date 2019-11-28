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
        NSLog(@"argc: %d", argc);
        
		// Check if this process is launched with check full disk access key
		if (argc > 1)
		{
			NSString *param = [NSString stringWithUTF8String:argv[1]];
			if ([param isEqualToString:@"-c"])
			{
                NSString *path = nil;

                NSLog(@"enumerating thru Desktop");
                path = NSHomeDirectory();
                path = [path stringByAppendingPathComponent:@"Desktop"];
                // Find the first any file in the user Library deirectory
                NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:path];
                    
                if (nil == [enumerator nextObject])
                {
                    NSLog(@"enumerator next object is nil");
                    return 1;
                }
                    
                NSString *filename = nil;
                while (filename = [enumerator nextObject])
                {
                    NSLog(@"filename: %@", filename);

                    BOOL isDirectory = NO;
                    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filename
                        isDirectory:&isDirectory];
                    NSLog(@"isExist:     %@", isExist ? @"YES" : @"NO");
                    NSLog(@"isDirectory: %@", isDirectory ? @"YES" : @"NO");
                    if (isExist && !isDirectory)
                    {
                        int c = open([filename UTF8String], O_RDONLY);

                        if (c > 0)
                        {
                            return 0;
                        }
                        else if (errno == EPERM || errno == EACCES)
                        {
                            return 1; // not authorized
                        }
                        else
                        {
                            return errno;
                        }
                    }
                }
			}
		}
    }
    return NSApplicationMain(argc, argv);
}
