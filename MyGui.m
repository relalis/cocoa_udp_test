#import "MyGui.h"

@implementation MyGui

- (IBAction)SendPacket:(id)sender {
	size_t StringLength = [[SendField stringValue] length];
	int sockfd;
	struct addrinfo hints, *servinfo, *p; 
	int rv;
	int numbytes;
	memset(&hints, 0, sizeof hints); 
	hints.ai_family = AF_INET; 
	hints.ai_socktype = SOCK_DGRAM; 
	if ((rv = getaddrinfo([[IPField stringValue] UTF8String], [[PortField stringValue] UTF8String], 
								&hints, &servinfo)) != 0) {
		[ResponseField setStringValue:[NSString stringWithFormat:@"%s", gai_strerror(rv)]];
		return;
	}
	
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((sockfd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) == -1) {
			[ResponseField setStringValue:@"talker: socket"];
			continue;
		}
		break;
	}
	if(p == NULL) {
		[ResponseField setStringValue:@"talker: failed to bind socket"];
		return;
	}
	if((numbytes = sendto(sockfd, [[SendField stringValue] UTF8String], StringLength, 0, p->ai_addr, p->ai_addrlen)) == -1) {
		[ResponseField setStringValue:@"talker: sendto"];
		perror("talker: sendto");
		return;
	}
	[ResponseField setStringValue:[NSString stringWithFormat:@"Sent %d bytes to %s", StringLength, [[IPField stringValue] UTF8String]]];
	freeaddrinfo:servinfo;
	close:sockfd;
}

- (void)awakeFromNib
{
	[ResponseField setStringValue:@"Send a SOCK_DGRAM string to an address!"];
	[IPField setStringValue:@"127.0.0.1"];
	[PortField setStringValue:@"8900"];
}

@end
