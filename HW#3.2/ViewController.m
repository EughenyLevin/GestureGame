
//  HW#3.2
#import "ViewController.h"

@interface ViewController ()
@property (weak,nonatomic)   NSTimer *timer;
@property (strong,nonatomic) NSTimer *viewTimer;
@property (assign,nonatomic) NSInteger score;
@property (strong,nonatomic) NSMutableArray *array;
@property (assign,nonatomic) int timeInterval;
@property (assign,nonatomic) int labelCount;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (assign,nonatomic) BOOL sleeping;
@end

static int newTimerCount = 3;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray new];
    self.score =1;
    self.doubleTap.numberOfTapsRequired = 2;
    [self.tapGesture requireGestureRecognizerToFail:_doubleTap];
    [self.nameField becomeFirstResponder];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)onStartGame:(UIButton *)sender {
    sender.enabled = NO;
    self.score = 0;
    NSArray *timerAr = [NSArray arrayWithObjects:self.timer,self.viewTimer, nil];
    for (NSTimer *timers in timerAr) {
        [timers invalidate];
    }
        self.sleeping = YES;
        self.labelCount = 3;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3
                                                  target:self
                                                selector:@selector(randomcolor)
                                                userInfo:nil
                                                 repeats:NO];
    self.viewTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerOnView:) userInfo:nil repeats:YES];
    
}
#pragma mark randcolor
-(void)randomcolor{
    UIColor *color;
    NSInteger i =arc4random()%4;
        switch (i) {
            case 0:
                color = [UIColor redColor];
                NSLog(@"REd");
                break; 
            case 1:
                color = [UIColor greenColor];
                NSLog(@"green");
                break;
            case 2:
                color = [UIColor yellowColor];
         NSLog(@"yellow");
                break;
            case 3:
                color = [UIColor blueColor];
                NSLog(@"blue");
                break;
        }
    self.gameView.backgroundColor = color;
   }

- (IBAction)onStopButton:(UIButton *)sender {
    NSArray *timerAr = [NSArray arrayWithObjects:self.timer,self.viewTimer, nil];
    for (NSTimer *timers in timerAr)
        [timers invalidate];
    self.rezultLabel.text = [NSString stringWithFormat:@"%ld",self.score];
    self.score = 0;
}

-(void)animationOnView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.gameView.transform = transform;
    }];
    
}

-(void)rightAnswer{
    [self.timer invalidate];
     self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(randomcolor) userInfo:nil repeats:NO];
}
#pragma mark - AlertView
-(void)alert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Game over! Your score is %ld",self.score]
                                                    message:@"You have made a mistake"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    self.rezultLabel.text = [NSString stringWithFormat:@"Rezult: %ld",self.score-1];
    [alert show];
}
-(void)alertTimeLeft{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Game over! Your score is %ld",self.score]
                                                    message:@"Time over"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    self.rezultLabel.text = [NSString stringWithFormat:@"Rezult: %ld",self.score-1];
    [alert show];
    self.startButton.enabled = YES;
}
-(void)failedOnTouch{
    [self.timer invalidate];
    [self.viewTimer invalidate];
    [self alert];
    self.startButton.enabled = YES;
    
}
#pragma mark - touchActions -
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    if (self.gameView.backgroundColor  == [UIColor redColor]) {
       
        self.score++;
        self.labelCount=newTimerCount;
        [self rightAnswer];
        [self animationOnView];
        self.gameView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    else   [self failedOnTouch];
}
- (IBAction)onDoubleTap:(UITapGestureRecognizer *)sender {
    
    if (self.gameView.backgroundColor == [UIColor greenColor]) {
         self.score++;
         self.labelCount=newTimerCount;
         [self rightAnswer];
        [self animationOnView];
         self.gameView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    else [self failedOnTouch];
}
- (IBAction)onRightSwipeAction:(UISwipeGestureRecognizer *)sender {
    if (self.gameView.backgroundColor == [UIColor blueColor])
    {   self.score++;
        self.labelCount=newTimerCount;
        [self rightAnswer];
        [self animationOnView];
         self.gameView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    else [self failedOnTouch];
}
- (IBAction)onSwipeLeftAction:(UISwipeGestureRecognizer *)sender {
    if (self.gameView.backgroundColor == [UIColor yellowColor]) {
        self.score++;
        self.labelCount=newTimerCount;
        [self rightAnswer];
        [self animationOnView];
         self.gameView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }
    else [self failedOnTouch];
}

- (IBAction)onSegmentChanged:(UISegmentedControl *)sender {
   /* if (sender.selectedSegmentIndex==0) self.timeInterval =  self.labelCount =  3;
    else {
        self.timeInterval = self.labelCount = 2;;
    }
    */
}
#pragma  mark - textFieldDelegate -
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.nameField]) [textField resignFirstResponder];
    return YES;
}
#pragma marktimerOnView

-(void)timerOnView:(NSTimer*)timer{
    if (self.sleeping) //
    sleep(2);
    self.timerLabel.text = [[NSString alloc]initWithFormat:@"%d",self.labelCount];
    self.labelCount--;
    self.sleeping = NO;
   if (self.labelCount<=-1) {
        [self.viewTimer invalidate];
        [self.timer invalidate];
        [self alertTimeLeft];
    }
   
}

@end
