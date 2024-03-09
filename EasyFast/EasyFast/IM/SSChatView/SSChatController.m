//
//  SSChatController.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//if (IOS7_And_Later) {
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}

#import "SSChatController.h"
#import "SSChatKeyBoardInputView.h"
#import "SSAddImage.h"
#import "SSChatBaseCell.h"
#import "SSChatLocationController.h"
#import "SSImageGroupView.h"
#import "SSChatMapController.h"
#import "EFIMVM.h"

@interface SSChatController ()<SSChatKeyBoardInputViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SSChatBaseCellDelegate,V2TIMAdvancedMsgListener>

//承载表单的视图 视图原高度
@property (strong, nonatomic) UIView    *mBackView;
@property (assign, nonatomic) CGFloat   backViewH;

//表单
@property(nonatomic,strong)UITableView *mTableView;
@property(nonatomic,strong)NSMutableArray *datas;

//刷新
@property(nonatomic,strong)UIRefreshControl *refreshControl;

//底部输入框 携带表情视图和多功能视图
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;

//访问相册 摄像头
@property(nonatomic,strong)SSAddImage *mAddImage;


@end

@implementation SSChatController

-(instancetype)init{
    if(self = [super init]){
        _chatType = SSChatConversationTypeChat;
        _datas = [NSMutableArray new];
    }
    return self;
}

//不采用系统的旋转
- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = _titleString;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mInputView = [SSChatKeyBoardInputView new];
    _mInputView.delegate = self;
    [self.view addSubview:_mInputView];
    
    _backViewH = SCREEN_Height-SSChatKeyBoardInputViewH-SafeAreaTop_Height-SafeAreaBottom_Height;
    
    _mBackView = [UIView new];
    _mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, _backViewH);
    _mBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mBackView];
    
    _mTableView = [[UITableView alloc]initWithFrame:_mBackView.bounds style:UITableViewStylePlain];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.backgroundColor = SSChatCellColor;
    _mTableView.backgroundView.backgroundColor = SSChatCellColor;
    [_mBackView addSubview:self.mTableView];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    _mTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mTableView.scrollIndicatorInsets = _mTableView.contentInset;
    if (@available(iOS 11.0, *)){
        _mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _mTableView.estimatedRowHeight = 0;
        _mTableView.estimatedSectionHeaderHeight = 0;
        _mTableView.estimatedSectionFooterHeight = 0;
    }else {
        if (@available(iOS 13.0, *)) {
            _mTableView.automaticallyAdjustsScrollIndicatorInsets = NO;
        } else {

        }
    }
    
    [_mTableView registerClass:NSClassFromString(@"SSChatTextCell") forCellReuseIdentifier:SSChatTextCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatImageCell") forCellReuseIdentifier:SSChatImageCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatVoiceCell") forCellReuseIdentifier:SSChatVoiceCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatMapCell") forCellReuseIdentifier:SSChatMapCellId];
    [_mTableView registerClass:NSClassFromString(@"SSChatVideoCell") forCellReuseIdentifier:SSChatVideoCellId];
    
    
    //单聊
    if(_chatType == SSChatConversationTypeChat){
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//             [self.datas addObjectsFromArray:[SSChatDatas LoadingMessagesStartWithChat:self.sessionId]];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.mTableView reloadData];
//            });
//        });
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
        [[EFIMVM pageMsgHistoryDateTimeMills:[NSString stringWithFormat:@"%llu",recordTime] userId:self.sessionId pageSize:@20] subscribeNext:^(NSArray *x) {
            
        }];
    }
    //群聊
    else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.datas addObjectsFromArray:[SSChatDatas LoadingMessagesStartWithGroupChat:self.sessionId]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mTableView reloadData];
            });
        });
        
    }
    
    
    
    _refreshControl = [UIRefreshControl new];
    _refreshControl.tintColor = [UIColor grayColor];
    [_refreshControl addTarget:self action:@selector(refreshTabView) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        [_mTableView addSubview:_refreshControl];
    } else {

    }
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
}

-(void)refreshTabView{
    
    [self performSelector:@selector(refreshEnd) withObject:nil afterDelay:1];
}

-(void)refreshEnd{
    
    if (@available(iOS 10.0, *)) {
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    }
    
    NSInteger index = random() % (_datas.count-1);
    SSChatMessagelLayout *layout = _datas[index];
    [_datas insertObject:layout atIndex:0];
    [_mTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datas.count==0?0:1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [(SSChatMessagelLayout *)_datas[indexPath.row] cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSChatMessagelLayout *layout = _datas[indexPath.row];
    SSChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:layout.message.cellString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.layout = layout;
    return cell;
}


//视图归位
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}


#pragma SSChatKeyBoardInputViewDelegate 底部输入框代理回调
//点击按钮视图frame发生变化 调整当前列表frame
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
 
    CGFloat height = _backViewH - keyBoardHeight;
    [UIView animateWithDuration:changeTime animations:^{
        self.mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, height);
        self.mTableView.frame = self.mBackView.bounds;
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}


//发送文本 列表滚动至底部
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string{
    
    NSDictionary *dic = @{@"text":string};
    [self sendMessage:dic messageType:SSChatMessageTypeText];
}


//发送语音
-(void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second{

    NSDictionary *dic = @{@"voice":voice,
                          @"second":@(second)};
    [self sendMessage:dic messageType:SSChatMessageTypeVoice];
}


//多功能视图点击回调  图片10  视频11  位置12
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index{
    
    if(index==10 || index==11){
        if(!_mAddImage) _mAddImage = [[SSAddImage alloc]init];

        [_mAddImage getImagePickerWithAlertController:self modelType:SSImagePickerModelImage + index-10 pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
            
            //发送图片和gif图
            if(index==10){
                if(modelType == SSImagePickerModelImage){
                    UIImage *image = (UIImage *)object;
                    NSLog(@"%@",image);
                    NSDictionary *dic = @{@"image":image};
                    [self sendMessage:dic messageType:SSChatMessageTypeImage];
                }
                else{
                    NSURL *imgUrl = (NSURL *)object;
                    NSDictionary *dic = @{@"imageLocalPath":imgUrl};
                    [self sendMessage:dic messageType:SSChatMessageTypeGif];
                }
            }
            
            else{
                NSString *localPath = (NSString *)object;
                NSLog(@"%@",localPath);
                NSDictionary *dic = @{@"videoLocalPath":localPath};
                [self sendMessage:dic messageType:SSChatMessageTypeVideo];
            }
        }];
        
    }else{
        SSChatLocationController *vc = [SSChatLocationController new];
        vc.locationBlock = ^(NSDictionary *locationDic, NSError *error) {
            [self sendMessage:locationDic messageType:SSChatMessageTypeMap];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


//发送消息
-(void)sendMessage:(NSDictionary *)dic messageType:(SSChatMessageType)messageType{

    [SSChatDatas sendMessage:dic sessionId:_sessionId messageType:messageType messageBlock:^(SSChatMessagelLayout *layout, NSError *error, NSProgress *progress) {
        
        [self.datas addObject:layout];
        [self.mTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }];
}


#pragma SSChatBaseCellDelegate 点击图片 点击短视频
-(void)SSChatImageVideoCellClick:(NSIndexPath *)indexPath layout:(SSChatMessagelLayout *)layout{
    
    NSInteger currentIndex = 0;
    NSMutableArray *groupItems = [NSMutableArray new];
    
    for(int i=0;i<self.datas.count;++i){
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        SSChatBaseCell *cell = [_mTableView cellForRowAtIndexPath:ip];
        SSChatMessagelLayout *mLayout = self.datas[i];
        
        SSImageGroupItem *item = [SSImageGroupItem new];
        if(mLayout.message.messageType == SSChatMessageTypeImage){
            item.imageType = SSImageGroupImage;
            item.fromImgView = cell.mImgView;
            item.fromImage = mLayout.message.image;
        }
        else if(mLayout.message.messageType == SSChatMessageTypeGif){
            item.imageType = SSImageGroupGif;
            item.fromImgView = cell.mImgView;
            item.fromImages = mLayout.message.imageArr;
        }
        else if (mLayout.message.messageType == SSChatMessageTypeVideo){
            item.imageType = SSImageGroupVideo;
            item.videoPath = mLayout.message.videoLocalPath;
            item.fromImgView = cell.mImgView;
            item.fromImage = mLayout.message.videoImage;
        }
        else continue;
        
        item.contentMode = mLayout.message.contentMode;
        item.itemTag = groupItems.count + 10;
        if([mLayout isEqual:layout])currentIndex = groupItems.count;
        [groupItems addObject:item];
        
    }
    
    SSImageGroupView *imageGroupView = [[SSImageGroupView alloc]initWithGroupItems:groupItems currentIndex:currentIndex];
    [self.navigationController.view addSubview:imageGroupView];
    
    __block SSImageGroupView *blockView = imageGroupView;
    blockView.dismissBlock = ^{
        [blockView removeFromSuperview];
        blockView = nil;
    };
    
    [self.mInputView SetSSChatKeyBoardInputViewEndEditing];
}

#pragma SSChatBaseCellDelegate 点击定位
-(void)SSChatMapCellClick:(NSIndexPath *)indexPath layout:(SSChatMessagelLayout *)layout{
    
    SSChatMapController *vc = [SSChatMapController new];
    vc.latitude = layout.message.latitude;
    vc.longitude = layout.message.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)onRecvNewMessage:(V2TIMMessage *)msg {
    XYLog(@"收到消息>>>>%@",msg);
    NSMutableDictionary *messageDic = [[NSMutableDictionary alloc] init];
    [messageDic setObject:@"2" forKey:@"from"];
    NSString *time = [NSTimer getTimeWithTimeStamp:[NSTimer getStampWithTime:[msg.timestamp stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]]];
    [messageDic setValue:time forKey:@"date"];
    [messageDic setValue:msg.textElem.text forKey:@"text"];
    int type = 0;
    switch (msg.elemType) {
        case V2TIM_ELEM_TYPE_TEXT:
            type = 1;
            break;
        case V2TIM_ELEM_TYPE_IMAGE:
        {
            type = 2;
            NSArray<V2TIMImage *> *imageList = msg.imageElem.imageList;
            for (V2TIMImage *timImage in imageList) {
                NSString *uuid = timImage.uuid; // 图片 ID
                V2TIMImageType type = timImage.type; // 图片类型
                int size = timImage.size; // 图片大小（字节）
                int width = timImage.width; // 图片宽度
                int height = timImage.height; // 图片高度
                // 设置图片下载路径 imagePath，这里可以用 uuid 作为标识，避免重复下载
                NSString *imagePath = [NSTemporaryDirectory() stringByAppendingPathComponent:
                                    [NSString stringWithFormat: @"testImage%@",timImage.uuid]];
                if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                        [timImage downloadImage:imagePath
                                        progress:^(NSInteger curSize, NSInteger totalSize) {
                            NSLog(@"图片下载进度：curSize：%lu,totalSize:%lu",curSize,totalSize);
                        } succ:^{
                            NSLog(@"图片下载完成");
                        } fail:^(int code, NSString *msg) {
                            NSLog(@"图片下载失败：code：%d,msg:%@",code,msg);
                        }];
                } else {
                        // 图片已存在
                }
            }
            [messageDic setValue:msg.imageElem.imageList[0].url forKey:@"image"];
        }
            break;
        case V2TIM_ELEM_TYPE_VIDEO:
        {
            [msg.videoElem getSnapshotUrl:^(NSString *url) {
                XYLog(@"url>>%@",url);
            }];
            type = 6;
            
        }
            break;
        case V2TIM_ELEM_TYPE_CUSTOM :
        {
            break;
        }
        default:
            break;
    }
    [messageDic setValue:@(type) forKey:@"type"];
    [messageDic setValue:msg.msgID forKey:@"messageId"];
    [messageDic setValue:msg.faceURL forKey:@"headerImg"];
    SSChatMessagelLayout *layout = [SSChatDatas getMessageWithDic:messageDic];
    [self.datas addObject:layout];
    [self.mTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
    [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
@end
