//
//  WKWebViewController.m
//  mx
//
//  Created by lyt on 2018/2/5.
//  Copyright © 2018年 chinasns. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>


NSString * const WKCanGoBack = @"canGoBack";
NSString * const WKCanGoForward = @"canGoForward";
NSString * const WKEstimatedProgress = @"estimatedProgress";
NSString * const WKTitle = @"title";
NSString * const WKLoading = @"loading";
//NSString * const WKScriptInAppSharing = @"inAppSharing";//分享到其他APP
//NSString * const WKScriptTransfer = @"transfer";//转账


@interface ScriptController:NSObject<WKScriptMessageHandler>
+(instancetype)jsc;
@end
@implementation ScriptController
+(instancetype)jsc{
    return [[self alloc]init];
}
//window.webkit.messageHandlers.inAppSharing.postMessage(['timeline','webpage','url', 'title','desc'])
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    ////*******切记  记得一定要 - (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;  和  removeScriptMessageHandlerForName： 
    
    
//    if ([message.name isEqualToString:WKScriptInAppSharing]) {
//
//    }else if ([message.name isEqualToString:WKScriptTransfer]){
//
//    }
    
}

@end

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) WKWebView *webView;

@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UIButton *reloadBtn;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation WKWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WKPreferences *preferences = [[WKPreferences alloc]init];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;//很重要，如果没有设置这个，用window.open(url,"_blank”)则不会回调createWebViewWithConfiguration方法，也不会回应window.open()方法
    

    WKUserContentController *userjsC = [[WKUserContentController alloc]init];
//    [userjsC addScriptMessageHandler:[ScriptController jsc] name:WKScriptInAppSharing];
//    [userjsC addScriptMessageHandler:[ScriptController jsc] name:WKScriptTransfer];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences = preferences;
    config.userContentController = userjsC;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:config];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.param[@"url"]]];
    [webView loadRequest:request];
    
    
    [self.view addSubview:webView];
    self.webView = webView;
    
    
    //添加toolbar
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:WKEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:WKCanGoBack options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:WKCanGoForward options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:WKLoading options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.webView.frame = self.view.bounds;
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([object isKindOfClass:[WKWebView class]]) {
        if ([keyPath isEqualToString:WKEstimatedProgress]) {
            self.progressView.progress = self.webView.estimatedProgress;
            self.progressView.hidden = self.webView.estimatedProgress >= 1;
            
        }else if ([keyPath isEqualToString:WKCanGoBack]) {
//            self.toolbar.items[0].enabled = self.webView.canGoBack;
            
        }else if ([keyPath isEqualToString:WKCanGoForward]) {
//            self.toolbar.items[4].enabled = self.webView.canGoForward;
            
        }else if ([keyPath isEqualToString:WKLoading]) {
            self.reloadBtn.selected = self.webView.loading;
            
        }
        
    }
}

-(void)dealloc{
//    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:WKScriptInAppSharing];
    [self.webView removeObserver:self forKeyPath:WKEstimatedProgress];
    [self.webView removeObserver:self forKeyPath:WKCanGoBack];
    [self.webView removeObserver:self forKeyPath:WKCanGoForward];
    [self.webView removeObserver:self forKeyPath:WKLoading];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - set
//-(void)setTitle:(NSString *)title{
//    [super setTitle:title];
//    self.titleLab.text = title;
//}
#pragma mark - get
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2.f);
    }
    
    return _progressView;
}
#pragma mark - view


#pragma mark - action

-(void)homeAction{
    NSArray *arr = self.webView.backForwardList.backList;
    if (arr.count>0) {
        [self.webView goToBackForwardListItem:arr.firstObject];
    }
}
-(void)reloadAction:(UIButton*)btn{
    if (btn.selected) {
        [self.webView stopLoading];
    }else{
        [self.webView reload];
    }
}
#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = webView.title;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.reloadBtn.selected = NO;
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}
#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }else if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
- (void)webViewDidClose:(WKWebView *)webView{
    
}

// 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    __block UITextField  *textF = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textF = textField;
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(nil);
        
    }];
    [alert addAction:cancel];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(textF.text);
        
    }];
    [alert addAction:sure];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}
// 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
        
    }];
    [alert addAction:cancel];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
        
    }];
    [alert addAction:sure];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}
// 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        
    }];
    [alert addAction:cancel];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
    
}


@end

