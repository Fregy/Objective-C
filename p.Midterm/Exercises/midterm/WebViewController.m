//
//  WebViewController.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize myHtml;
@synthesize myLink;
@synthesize bandR;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (bandR) {
        NSURL *url = [NSURL URLWithString:myLink];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    } else {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Not Internet Connection"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        [_webView loadHTMLString:myHtml baseURL:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
