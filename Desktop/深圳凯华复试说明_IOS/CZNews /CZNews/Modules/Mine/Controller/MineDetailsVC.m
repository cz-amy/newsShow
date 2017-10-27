//
//  MineDetailsVC.m
//  CZNews
//
//  Created by tarena on 17/10/26.
//  Copyright © 2017年 Caizhi. All rights reserved.
//

#import "MineDetailsVC.h"
#import "ImageTableViewCell.h"
#import "UserMessageCell.h"


@interface MineDetailsVC ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    
    UIImagePickerController *_pickerController;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titileLabel;
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) ImageTableViewCell *cell;
@property (nonatomic, strong) UIImageView * iconImageView;
@end

@implementation MineDetailsVC


// 懒加载 UITableView
- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self  initProperty];
    [self setUpNavigation];
}

-(void)initProperty{
    //初始化pickerController
    _pickerController = [[UIImagePickerController alloc]init];
    _pickerController.view.backgroundColor = [UIColor orangeColor];
    _pickerController.delegate = self;
    _pickerController.allowsEditing = YES;

}

// 自定义导航栏样式
- (void)setUpNavigation
{
    [self addNavigationItemWithTitles:@[@"返回"] isLeft:YES target:self action:@selector(goBack) tags:nil];
   
    self.title = @"个人信息";
    
  
    
}
-(void)goBack{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 66.f;
    }
    else
    {
        return 44.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IconDentifier    = @"IconCell";
    static NSString *dentifierOne     = @"Cell";
    
    
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        self.cell = [tableView dequeueReusableCellWithIdentifier:IconDentifier];
        if (self.cell == nil)
        {
            self.cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IconDentifier];
        }
        
        self.cell.nameLabel.text = @"头像";
        self.iconImageView =  self.cell.iconImage;
        
//        self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         self.cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return self.cell;
        
    }
    else{
        
        UserMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifierOne];
        if (cell == nil)
        {
            cell = [[UserMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifierOne];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        if (indexPath.section == 0 && indexPath.row == 1)
        {
            cell.nameLabel.text = @"名字";
            NSString * name    = [self.userInfo objectForKey:@"name"];
            cell.detialLabel.text = name;
        }
        else if (indexPath.section == 0 && indexPath.row == 2)
        {
            cell.nameLabel.text = @"我的地址";
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            NSNumber * gender    = [self.userInfo objectForKey:@"gender"];
            if ([gender isEqualToNumber:@1]) {
                cell.detialLabel.text = @"男";

            }else{
                cell.detialLabel.text = @"女";
            }

            cell.nameLabel.text = @"性别";
        }
        else if (indexPath.section == 1 && indexPath.row == 1)
        {
            NSString * province    = [self.userInfo objectForKey:@"province"];
            NSString * city        = [self.userInfo objectForKey:@"city"];
            
            
            cell.nameLabel.text = @"地区";
            cell.detialLabel.text = [NSString stringWithFormat:@"%@,%@",province,city];
        }
        else if (indexPath.section == 1 && indexPath.row == 2)
        {
            NSArray * expertise    = [self.userInfo objectForKey:@"expertise"];

            cell.nameLabel.text = @"专长领域";
            NSString *string = [expertise componentsJoinedByString:@","];
            cell.detialLabel.text = string;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickUserImage];
}

//点击用户头像
-(void)clickUserImage{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: @"选择头像" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"拍照", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        [self  clickPhoto];
        
        
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"相册", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击相册
        [self  clickPictures];
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"图库", nil) style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击图库
        [self  clickPictureLib];
    }]];
    
    
    [alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"取消", nil) style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
    
}


//点击拍照
#pragma mark ----------------------------点击拍照-----------------------------------

-(void)clickPhoto{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"支持相机");
        [self makePhoto];
    }else{
        
        [self  alertUser:NSLocalizedString(@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！", nil)];
    }
    
    
}
//点击相册
-(void)clickPictures{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        NSLog(@"支持相册");
        [self choosePicture];
    }else{
        [self  alertUser:NSLocalizedString(@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！", nil)];
    }
    
    
}
//点击图库
-(void)clickPictureLib{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        NSLog(@"支持图库");
        [self pictureLibrary];
        
    }else{
        
        [self  alertUser:NSLocalizedString(@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！", nil)];
    }
    
    
}
/*
 hahahhahha
 */

//提醒用户
-(void)alertUser:(NSString*)message{
    
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"我知道了", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }]];
    
    [alertControl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil]];
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alertControl animated:YES completion:nil];
    
    
    UIPopoverPresentationController *popover = alertControl.popoverPresentationController;
    
    if (popover) {
        
        popover.sourceView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2-10, KScreenHeight/2+10, 10, 10)];
        popover.sourceRect = CGRectMake(KScreenWidth/2-10, KScreenHeight/2+10, 10, 10);
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    
}

//跳转到imagePicker里
- (void)makePhoto
{
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_pickerController animated:YES completion:nil];
}
//跳转到相册
- (void)choosePicture
{
    _pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:_pickerController animated:YES completion:nil];
}
//跳转图库
- (void)pictureLibrary
{
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_pickerController animated:YES completion:nil];
}
//用户取消退出picker时候调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"%@",picker);
    [_pickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *userImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    userImage = [self scaleImage:userImage toScale:0.2];
    
    //    选中之后临时显示的图片
    
    [self.iconImageView setImage:userImage];
    DLog(@"选中之后临时显示的图片");
    
    
    [_pickerController dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    //    上传头像
    
    [self  upDateHeadIcon:userImage];
}

//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}


//上传图片
-(void)upDateHeadIcon:(UIImage*)image{
    
    if (image) {
        //方法内
        DLog(@"上传图片==%@",image);
        
        /*使用NSData数据流传图片*/
        NSDictionary * userDic  = [kUserDefaults objectForKey:CZUserInfo];
        NSString * access_token = [userDic objectForKey:@"access_token"];
        NSDictionary * paramesDic = @{@"access_token":access_token,@"portrait":@"20"};
        
          NSString * newsUrl     = [NSString stringWithFormat:@"%@%@",URL_main,URL_user_change_photo];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"MMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15;
        
    
        [manager POST:newsUrl parameters:paramesDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0) name:@"image" fileName:fileName  mimeType:@"image/jpg"];
            
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            DLog(@"responseObjecterror==%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            
            DLog(@"responseObjecterror==%@",error);
            
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
