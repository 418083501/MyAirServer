//
//  ViewController.m
//  MyAirServer
//
//  Created by 鹿容 on 2017/7/25.
//  Copyright © 2017年 鹿容. All rights reserved.
//

#import "ViewController.h"

#import <GCDWebServer.h>

@interface ViewController ()<NSNetServiceDelegate,GCDWebServerDelegate>
{
    NSNetService *_serVice;
    GCDWebServer *_webServer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _serVice = [[NSNetService alloc] initWithDomain:@"local." type:@"_airplay._tcp." name:@"lugeV587"port:7000];
    NSDictionary *airPlayTXT = @{
                                 @"deviceid": @"CC:08:8D:03:E8:F8",
                                 @"features": @"0x4A7FFFF7,0xE",
                                 //                                     @"features": @"0x4A00180,0xE",
                                 @"flags": @"0x4",
                                 @"model": @"AppleTV5,3",
                                 @"srcvers": @"220.68",
                                 @"vv": @"2",
                                 @"pk": @"d02e124a749eef1ffbd11db9a6b84fd7e1f5ee7acdf1420e607e50e08e8ea950",
                                 @"pi": @"2e388006-13ba-4041-9a67-25dd4a43d536",
                                 @"pw": @"0",
                                 @"rhd": @"3.0.0.0",
                                 };
    
    _serVice.delegate = self;
    [_serVice setTXTRecordData:[NSNetService dataFromTXTRecordDictionary:airPlayTXT]];
    [_serVice publish];
    
    _webServer =  [[GCDWebServer alloc] init];
    _webServer.delegate = self;
    
    
    
    
    
    
    
    [_webServer addHandlerWithMatchBlock:^GCDWebServerRequest *(NSString* requestMethod, NSURL* requestURL, NSDictionary* requestHeaders, NSString* urlPath, NSDictionary* urlQuery) {
        
        return [[GCDWebServerRequest alloc] initWithMethod:requestMethod url:requestURL headers:requestHeaders path:urlPath query:urlQuery];
        
    } processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
        
        
        NSString *method = request.method;
        NSString *url = request.URL.relativePath;
        NSString *path = request.path;
        NSString *contentType = request.contentType;
        
        
        NSLog(@"newLink   method=%@,,,,\n   url=%@,,,,,,,\n     path=%@,,,,,,\n    contentType=%@,,,,",method,url,path,contentType);
        
        GCDWebServerResponse *response = nil;
        
        
        if ([method isEqualToString:@"POST"]) {
            
            if ([path isEqualToString:@"/pair-setup"]) {
                
                response = [[GCDWebServerResponse alloc] init];
                response.contentType = @"RTSP/1.0";
                response.contentLength = 32;
                response.statusCode = 200;
                
            }
            
            
        }
        
        return response;
        
    }];
    
    
//    [_webServer startWithPort:7000 bonjourName:@"lugeV587"];
    [_webServer startWithOptions:@{GCDWebServerOption_AutomaticallySuspendInBackground:@NO
                                   ,GCDWebServerOption_Port:@7000,
                                   GCDWebServerOption_BonjourName:@"lugeV587"
                                   
                                   } error:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  This method is called after the server has successfully started.
 */
- (void)webServerDidStart:(GCDWebServer*)server
{
    

}

/**
 *  This method is called after the Bonjour registration for the server has
 *  successfully completed.
 *
 *  Use the "bonjourServerURL" property to retrieve the Bonjour address of the
 *  server.
 */
- (void)webServerDidCompleteBonjourRegistration:(GCDWebServer*)server
{
    
}

/**
 *  This method is called after the NAT port mapping for the server has been
 *  updated.
 *
 *  Use the "publicServerURL" property to retrieve the public address of the
 *  server.
 */
- (void)webServerDidUpdateNATPortMapping:(GCDWebServer*)server
{
    
}

/**
 *  This method is called when the first GCDWebServerConnection is opened by the
 *  server to serve a series of HTTP requests.
 *
 *  A series of HTTP requests is considered ongoing as long as new HTTP requests
 *  keep coming (and new GCDWebServerConnection instances keep being opened),
 *  until before the last HTTP request has been responded to (and the
 *  corresponding last GCDWebServerConnection closed).
 */
- (void)webServerDidConnect:(GCDWebServer*)server
{
    
}

/**
 *  This method is called when the last GCDWebServerConnection is closed after
 *  the server has served a series of HTTP requests.
 *
 *  The GCDWebServerOption_ConnectedStateCoalescingInterval option can be used
 *  to have the server wait some extra delay before considering that the series
 *  of HTTP requests has ended (in case there some latency between consecutive
 *  requests). This effectively coalesces the calls to -webServerDidConnect:
 *  and -webServerDidDisconnect:.
 */
- (void)webServerDidDisconnect:(GCDWebServer*)server
{
    
}

/**
 *  This method is called after the server has stopped.
 */
- (void)webServerDidStop:(GCDWebServer*)server
{
    
}


@end
