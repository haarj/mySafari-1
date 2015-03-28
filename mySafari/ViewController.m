//
//  ViewController.m
//  mySafari
//
//  Created by Antonio Perez on 3/11/15.
//  Copyright (c) 2015 antonioperez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *onBackButton;
@property (weak, nonatomic) IBOutlet UIButton *onForwardButton;
@property (nonatomic) CGFloat coordinateY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;

    self.onBackButton.enabled = self.webView.canGoBack;
    self.onForwardButton.enabled = self.webView.canGoForward;

    self.webView.scrollView.delegate = self;
    self.webView.delegate = self;
    self.urlTextField.delegate = self;
    self.urlTextField.clearButtonMode = NO;

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
    self.urlTextField.clearButtonMode = YES;


}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];

    self.onBackButton.enabled = self.webView.canGoBack;
    self.onForwardButton.enabled = self.webView.canGoForward;

    self.urlTextField.text = webView.request.URL.absoluteString;
    //shows the url of the request in the webview
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

}

-(void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];

    if(!url.scheme)
    {
        NSString *modifiedURLString = [NSString stringWithFormat:@"http://%@", string];
        url = [NSURL URLWithString:modifiedURLString];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [self.webView loadRequest: request];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlString;
    NSLog(@"text URL is %@", textField.text);
    NSString *head = [textField.text substringToIndex:6];

    if (![head isEqualToString:@"http://"]) {
        urlString = [NSString stringWithFormat:@"http://%@", textField.text];
    }

    [self performLoadRequestWithString:textField.text];
    [textField resignFirstResponder];
    return YES;
    // this is used as a method instead of repeating the code to load the URL
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

- (IBAction)plusButton:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"New Features Coming Soon" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try Again", nil];
    [alertView show];
}

#pragma mark UIScrollViewDelegate Protocols

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.coordinateY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.coordinateY < scrollView.contentOffset.y)
    {
        self.urlTextField.hidden = YES;
    } else if (self.coordinateY > scrollView.contentOffset.y)
        self.urlTextField.hidden = NO;
}

@end
