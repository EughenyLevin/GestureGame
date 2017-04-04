//
//  ViewController.h
//  HW#3.2
//
//  Created by Evgheny on 29.09.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController :   UIViewController<UITextFieldDelegate>

@property (weak, nonatomic)   IBOutlet UIView *gameView;
@property (weak, nonatomic)   IBOutlet UITextField *nameField;
@property (weak, nonatomic)   IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic)   IBOutlet UILabel *rezultLabel;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeOnLeft;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeOnRight;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

- (IBAction)onStartGame:(UIButton *)sender;
- (IBAction)onTap:(UITapGestureRecognizer *)sender;
- (IBAction)onStopButton:(UIButton *)sender;
- (IBAction)onDoubleTap:(UITapGestureRecognizer *)sender;
- (IBAction)onRightSwipeAction:(UISwipeGestureRecognizer *)sender;
- (IBAction)onSwipeLeftAction:(UISwipeGestureRecognizer *)sender;
- (IBAction)onSegmentChanged:(UISegmentedControl *)sender;

@end

