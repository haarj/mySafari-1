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
@property (weak, nonatomic) IBOutlet UIButton *onBackButton;
@property (weak, nonatomic) IBOutlet UIButton *onForwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"canGoBack:%d canGoForward:%d", self.webView.canGoBack, self.webView.canGoForward);

    [self.activityIndicator startAnimating];

    if (self.webView.canGoBack) {
        self.onBackButton.enabled = YES;
    } else {
        self.onBackButton.enabled = NO;
    }

    if (self.webView.canGoForward) {
        self.onForwardButton.enabled = YES;
    } else {
        self.onForwardButton.enabled = NO;
    }


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
- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender
{
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender
{
    [self.webView reload];
}







@end
