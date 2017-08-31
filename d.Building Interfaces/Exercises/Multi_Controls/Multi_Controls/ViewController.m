//
//  ViewController.m
//  Multi_Controls
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
//@property (strong, nonatomic) IBOutlet UILabel *label;
//@property (strong, nonatomic) IBOutlet UIButton *button;
//@property (strong, nonatomic) IBOutlet UIButton *button3;
//@property (strong, nonatomic) IBOutlet UITextField *textField;
//@property (strong, nonatomic) NSMutableString *text;
//@property (nonatomic) BOOL band;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //ProgresView
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = CGRectMake(128.0, 50.0 , 118.0, 31.0);
    [self.view addSubview:self.progressView];
    //Switch
    UISwitch *onoff = [[UISwitch alloc] initWithFrame: CGRectMake(163, 250 , 200.0, 10.0)];
    [onoff addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: onoff];
    //Slider
    CGRect frame = CGRectMake(128.0, 112.0 , 118.0, 31.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 10.0;
    slider.continuous = YES;
    slider.value = 25.0;
    [self.view addSubview:slider];
    //Stepper
    UIStepper* stepper = [[UIStepper alloc] init];
    stepper.frame = CGRectMake(140, 389, 99, 29);
    [stepper addTarget:self action:@selector(MyStepper:)forControlEvents: UIControlEventValueChanged];
    [self.view addSubview: stepper];
    //Segment
    NSArray *itemArray = [NSArray arrayWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(20, 527, 335, 29);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:)forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 1;
    [self.view addSubview:segmentedControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)flip:(UISwitch*)flipedSwitch {
    
    if([flipedSwitch isOn]){
    
        self.progressView.progressTintColor = [UIColor redColor];
        [self.progressView setProgress:1 animated:YES];
        
    } else {
        self.progressView.progressTintColor = [UIColor greenColor];
        [self.progressView setProgress:0 animated:YES];
    }
}

-(void)sliderAction:(UISlider*)slider {
    NSLog(@"Segement Selected:%@", slider);
    self.progressView.progress = slider.value/10;
}

-(void)MySegmentControlAction:(UISegmentedControl*)sender {
    
    NSUInteger segment = sender.selectedSegmentIndex;
    NSString* valor = [NSString stringWithFormat:@"%lu", (unsigned long)segment];
    self.progressView.progress = ([valor floatValue])/10;
}

-(void)MyStepper:(UIStepper*)sender {
    
    double value = [sender value];
    NSString* valor = [NSString stringWithFormat:@"%d", (int)value];
    self.progressView.progress = ([valor floatValue])/100;
}
@end
