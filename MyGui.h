#import <Cocoa/Cocoa.h>
#import <stdio.h> 
#import <stdlib.h> 
#import <unistd.h> 
#import <errno.h> 
#import <string.h> 
#import <sys/types.h> 
#import <sys/socket.h> 
#import <netinet/in.h> 
#import <arpa/inet.h> 
#import <netdb.h> 



@interface MyGui : NSObject {
    IBOutlet id SendField;
	IBOutlet id IPField;
	IBOutlet id PortField;
	IBOutlet id ResponseField;
}

- (IBAction)SendPacket:(id)sender;
@end
