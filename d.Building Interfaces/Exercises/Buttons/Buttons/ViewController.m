//
//  ViewController.m
//  Buttons
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) NSMutableString *text;
@property (nonatomic) BOOL band;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Label Control
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 335, 21)];
    self.label.text=@"Label";
    self.label.font=[UIFont fontWithName:@"System " size:17.0];
    self.label.textColor=[UIColor blackColor];
    self.label.textAlignment=NSTextAlignmentCenter;
    //label.shadowColor=[UIColor blueColor]; label.shadowOffset=CGSizeMake(0, 0);
    [self.view addSubview:self.label];
    //TextField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(37, 184, 300, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.placeholder = @"Enter Text";
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //textField.delegate = self;
    [self.view addSubview:self.textField];
    //Buttons
    self.button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = CGRectMake(37.0, 319.0, 55.0, 30.0);
    self.button.titleLabel.text=@"Button1";
    [self.button setTitle:@"Button1" forState:UIControlStateNormal];
    //[self.button setTitle:@"I'm Selected" forState:UIControlStateSelected];
    //[button setImage:[UIImage imageNamed:@"NotSelected"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [self.button addTarget:self action:@selector(pressButton1:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button3.frame = CGRectMake(160.0, 540.0, 42.0, 21.0);
    self.button3.titleLabel.text=@"Clear";
    [self.button3 setTitle:@"Clear" forState:UIControlStateNormal];
    //[self.button3 setTitle:@"I'm Selected" forState:UIControlStateSelected];
    //[button setImage:[UIImage imageNamed:@"NotSelected"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [self.button3 addTarget:self action:@selector(pressButton3:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:self.button3];
    
    UIButton* button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.frame = CGRectMake(263.0, 319.0, 55.0, 30.0);
    button2.titleLabel.text=@"Button2";
    [button2 setTitle:@"Button2" forState:UIControlStateNormal];
    //[button2 setTitle:@"I'm Selected" forState:UIControlStateSelected];
    //[button setImage:[UIImage imageNamed:@"NotSelected"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [button2 addTarget:self action:@selector(pressButton2:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    //Switch
    UISwitch *onoff = [[UISwitch alloc] initWithFrame: CGRectMake(160,400 , 200.0, 10.0)];
    [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: onoff];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return NO;
}

-(void)flip:(UISwitch*)flipedSwitch {
    
    self.band = NO;
    
    if([flipedSwitch isOn]){
        self.button.titleLabel.text = @"ON";
        self.band = YES;
    } else{
        self.button.titleLabel.text=@"Button1";
        self.band = NO;
    }
}

-(void)pressButton2:(UIButton*)sender {
    
    [sender setSelected:sender.isSelected];
    
    if (self.band) {
        
        if(!sender.isSelected){
            self.label.frame = CGRectMake(20, 60, 335, 21);
            self.label.text = [self.textField.text stringByAppendingString:self.label.text];
        }
    }
}
-(void)pressButton1:(UIButton*)sender {
    
    [sender setSelected:sender.isSelected];
    
    self.text = [[NSMutableString alloc]init];
    
    if (self.band) {
        
        if(!sender.isSelected){
            self.button.titleLabel.text=@"ON";
            self.label.frame = CGRectMake(20, 60, 335, 21);
            self.text = [self.label.text mutableCopy];
            [self.text appendString:self.textField.text];
            self.label.text = self.text;
        }
    }
}

-(void)pressButton3:(UIButton*)sender {
    
    [sender setSelected:sender.isSelected];
    
    self.label.text = @"Label";
    self.label.frame = CGRectMake(20, 60, 335, 21);
}

@end

















