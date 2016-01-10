//
//  ViewController.m
//  WFDownLoader
//
//  Created by JackWong on 15/11/24.
//  Copyright © 2015年 JackWong. All rights reserved.
//

#import "ViewController.h"
#import "WFDownLoad.h"

#define DOWNLOADURL @"http://a.hiphotos.baidu.com/image/pic/item/1f178a82b9014a905ee129bdab773912b21beed7.jpg"
//@"http://b.zol-img.com.cn/sjbizhi/images/7/800x1280/1416382184881.jpg?downfile=1416382184881.jpg"

@interface ViewController ()<WFDownLoadDelegate> {
    //判断当前按钮的状态
    BOOL _isDownLoad;
    
    WFDownLoad *_download;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    _download =  [[WFDownLoad alloc] initWithURL:DOWNLOADURL delegate:self overFile:NO];
#elif 1
    _download = [[WFDownLoad alloc] initWithURL:DOWNLOADURL startBlock:^(WFDownLoad *download) {
        NSLog(@"以Block开始下载");
        
        
    } loadingBlock:^(WFDownLoad *download, double progressValue) {
        NSLog(@"进度(%f)",progressValue);
        _progressView.progress = progressValue;
        
    } finishBlock:^(WFDownLoad *download, NSString *filePath) {
        NSLog(@"下载完成%@",filePath);
        _imageView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
        
    } faildBlock:^(WFDownLoad *downLoad, NSError *faildError) {
        NSLog(@"%@",[faildError description]);
        
    } overFile:YES];
#endif

}
- (IBAction)downLoadAction:(id)sender {
    UIButton *downLoadButon = (UIButton *)sender;
    
    NSString *titleString = nil;
    _isDownLoad = !_isDownLoad;
    
    _isDownLoad?(titleString = @"暂停"):(titleString = @"下载");
    if (_isDownLoad)
        [_download start];
     else
        [_download stop];
    
    [downLoadButon setTitle:titleString forState:UIControlStateNormal];
    
}
- (IBAction)cleanButtonAction:(id)sender {
    [_download clean];
}

- (void)downLoadStart:(WFDownLoad *)downLoad {
    
    NSLog(@"%s",__func__);
}

- (void)downLoad:(WFDownLoad *)downLoad progressChanaged:(double)progressValue {
    
    NSLog(@"%s",__func__);
    NSLog(@"下载进度---%f",progressValue);
    
    _progressView.progress = progressValue;
    
}

- (void)downLoadDidFinish:(WFDownLoad *)downLoad filePath:(NSString *)filePath {
    NSLog(@"%s",__func__);
    NSLog(@"%@",filePath);
    
    _imageView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    
}

- (void)downLoadFaild:(WFDownLoad *)downLoad faildError:(NSError *)faildError {
    NSLog(@"%s",__func__);
    NSLog(@"%@",[faildError description]);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
