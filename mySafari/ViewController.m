//
//  ViewController.m
//  mySafari
//
//  Created by Antonio Perez on 3/11/15.
//  Copyright (c) 2015 antonioperez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

-(void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performLoadRequestWithString:textField.text];
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)onBackButtonPressed:(UIButton *)sender 
{
    [self.webView goBack];
}




@end
