# NetWorkEngine

主要依赖于AFN的二次封装。可灵活跟换，也可以快速换成猿题库。

### 安装
通过这个命令直接安装：
> pod 'HGNetWorkEngine'

安装之后，目录是这样的：
![image.png](http://upload-images.jianshu.io/upload_images/1198135-e33783e7a3da2ddd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 使用
在项目中，可以有类似这样的单独模块：
![image.png](http://upload-images.jianshu.io/upload_images/1198135-a592464efc06ed2f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中，NetworkEngine继承于HGNetWorkEngine，在这里面可以配置项目的通用配置以及整个项目中接口拦截处理：

##### 通用配置
![image.png](http://upload-images.jianshu.io/upload_images/1198135-efccafce22732008.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这些都不用手动调用。

##### 接口拦截
![image.png](http://upload-images.jianshu.io/upload_images/1198135-ce82166d7ea45b13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### 接口编写
往往在项目中，会有很多个模块，这里可以通过分类的形式做模块的区分，比如下面是登录模块的所有接口：
![image.png](http://upload-images.jianshu.io/upload_images/1198135-d6017a9ef0db23e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

举一个例子，我现在要写一个登录接口：
在 NetworkEngine+Login.h 文件中是这样的：
```
/**
 登录接口
 
 @param params 参数:
   username 登录账号
   password 登录密码
 */
+ (void)loginWithParams:(NSDictionary*)params
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure;
```

在 NetworkEngine+Login.m 文件中是这样的:
```
/**
 登录接口
 
 @param params 参数:
   username 登录账号
   password 登录密码
 */
+ (void)loginWithParams:(NSDictionary*)params
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure {
    [self POSTWithPath:@"post" param:params success:success failure:failure];
}
```

**其中要注意的是POSTWithPath参数就是实际上的接口名, 比如:login, 上面写成了post是为了在https://httpbin.org/网站模拟一个post请求.**

可以参考项目[NewStart](https://github.com/Summary2017/NewStart.git)，这里面简单的使用了一下这个框架。

## 谢谢！


