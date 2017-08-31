//
//  ViewController.m
//  Alertview&ActionSheet
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alertButton:(UIButton *)sender {
    
    //AlertSheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Action Sheet"
        delegate:self
        cancelButtonTitle:@"Cancel"
        destructiveButtonTitle:nil
        otherButtonTitles:@"Option 1", @"Option 2", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:@"Option 1" message:@"ActionView 1" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    
    UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Option 2" message:@"ActionView 2" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];

    if (buttonIndex == 0)
    {
        
        [alertView1 show];
         alertView1.tag = 100;
    }
    if (buttonIndex == 1)
    {
        
        [alertView2 show];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"%@ Option 1 Button Clicked", title);
    
    if(alertView.tag==100)
        self.label1.text = title;
    else
        self.label2.text= title;
    
}


@end
