# WisdomProtocol

  一. 简介：

  WisdomProtocol：一款iOS 面向协议 编程框架，Swift特别版。
   
  在开发中，以遵守实现 对应协议，即可得到 相应能力 的理念，来定义一批定制的协议，通过他们绑定实现定制的功能和需求。
   
  协议功能 支持 如下列表。
   
  
  
  二. 协议功能支持：

    1). 定时器功能
  
    2). 模型: 编/解码
  
    3). 程序信息跟踪
  
    4). 图片: 加载/缓存
  
    5). 多语言切换
  
    6). 网络连接状态变化
  
    7). 7大路由器
  
  

  三. 功能详情：

# 【1】定时器功能

   -> 定时继承主协议：
  
     @objc public protocol WisdomTimerable
     
     简介：
     
     继承定时协议 对象，拥有开启计时的能力，且不用管理内部定时器的生命周期。下面具体介绍协议的几个方法API。
     

   -> 定时功能协议：
  
     // MARK: Class Timerable Protocol
     // * Support for objective-c/Swift Class
     @objc public protocol WisdomTimerable {
    
         // MARK: Class Param - UInt, WisdomTimerable
         // * Timer task in progress, current time
         @objc func timerable(timerDid currentTime: UInt, timerable: WisdomTimerable)
     
         // MARK: Class Param - WisdomTimerable
         // * Example End a scheduled task
         @objc func timerable(timerEnd timerable: WisdomTimerable)
     }

   -> 定时任务说明：
   
     1.支持 Swift / OC 类遵守，且协议简单明了
     
     2.支持 每秒任务状态更新回调 和 定时任务结束状态回调
    
     extension WisdomTimerable {
     
         // MARK: Class Param - NSInteger.  No need to implement 
         // * Start a forward timer task, start the forward time point
         public func startForwardTimer(startTime: UInt)
         
         // MARK: Class Param - NSInteger.  No need to implement 
         // * Start a countdown timer task, start the total time countdown
         public func startDownTimer(totalTime: UInt)
         
         // MARK: Class Timer - destroy.  No need to implement 
         // Destruction/Release timer task
         public func destroyTimer()
     }

     * 支持 从指定时间开始累积计时 和 总时间的倒计时
  
     * 支持 主动摧毁运行中的定时任务

   -> 支持功能：
  
     public func startForwardTimer(startTime: UInt)
  
     * 累积计时
  
     public func startDownTimer(totalTime: UInt)
  
     * 倒计时

  【优势/特点】
  
     -> 开发者无需关心，定时任务的创建和销毁。对于销毁，内部会即时销毁，包括任务结束即时销毁，包括启动任务对象销毁，也会即时销毁定时任务；
  
     -> 定时任务过程中，app前后台状态切换，会对定时数产生的影响，已妥善计算处理，放心使用；


# 【2】模型 编/解码

   -> 模型 编/解码 继承主协议：
   
     // MARK: Swift Class/NSObject/Value to coding/decoding Protocol
     public protocol WisdomCodingable {}
     
     简介：
     继承编/解码协议 对象，拥有对模型和数据编/解吗的能力，且支持集合，结构体，枚举类型。下面具体介绍协议的几个方法API。


   -> 模型 几种解码场景：
   
     extension WisdomCodingable where Self: Decodable {
     
         // MARK: Param - [String: Any], return - Self?
         // swift dictionary to dictionary model, use 'Decodable' protocol
         public static func decodable(value: [String: Any])->Self?{}
         
         // MARK: Param - [String: Any], return - [Self]
         // swift dictionary list to dictionary model list, use 'Decodable' protocol
         public static func decodable(list: [[String: Any]])->[Self]{}
         
         // MARK: Param - String, return - Self?
         // swift json string to model, use 'Decodable' protocol
         public static func jsonable(json: String)->Self?{}
         
         // MARK: Param - String, return - [Self]
         // swift jsons string to model list, use 'Decodable' protocol
         public static func jsonable(jsons: String)->[Self]{}
     }
     
     解码 上到下顺序：
     
     1. 字典 转 模型 

     2. 字典数组 转 模型数组 
     
     3. Json 转 模型 
     
     4. Json 转 模型数组

   -> 模型 几种编码场景：

     extension WisdomCodingable where Self: Encodable {
    
         // MARK: return - String?
         // swift model to json string, use 'Encodable' protocol
         public func ableJson()->String?{}
         
         // MARK: return - [String:Any]?
         // swift model to dictionary, use 'Encodable' protocol
         public func ableEncod()->[String:Any]?{}
     }

   -> 模型 集合编码场景：
   
     public extension Array where Element: WisdomCodingable&Encodable {
     
         // MARK: return - [[String:Any]]
         // swift model list to dictionary list, use 'Encodable' protocol
         func ableEncod()->[[String:Any]]{}
     
         // MARK: return - String?
         // swift model list to jsons string, use 'Encodable' protocol
         func ableJsons()->String?{}
     }
     
     编码 上到下顺序：
     
     1. 模型 转 Json  
     
     2. 模型 转 字典 
     
     3. 模型数组 转 字典数组
     
     4. 模型数组 转Json
     
   -> 模型 案例：
   
     // 必须继承 Codable 和 WisdomCodingable 协议
     struct RCProductFuncModel: Codable, WisdomCodingable {
    
         private(set) var tag: RCProductFuncStauts?
         private(set) var name: String?
     }
     // 转模型
     let product = RCProductFuncModel.jsonable(jsons: ".....") 
     // 等等
   

   【优势/特点】：
   
    -> 只支持 Swift 类，枚举，struct 的 编/解码；
    
    -> 内部 编/解码 实现，使用的 Swift原生Coding协议，所以不需要担心稳定性和兼容性；

    -> 解析流程中添加了断言处理：
    
     assert(able != nil, "decodable failure: \(value)")
     调试环境，断言 便于即时发现不合格数据，即时检测；
     如果不需要，可以注释此处断言代码；




# 【3】程序信息跟踪

   目前支持跟踪功能：
   
     1. 崩溃信息的跟踪；
   
     2. 控制器的 显示/掩藏 状态跟踪，和显示时间统计；
   
     3. 协议限制 条件对象：UIApplicationDelegate
     
         protocol WisdomCrashingable where Self: UIApplicationDelegate
     
     4. OC 和Swift 语言崩溃场景抓取不一样，但是 WisdomProtocol 同时都支持

   1). 崩溃跟踪协议：
   
     @objc public protocol WisdomCrashingable where Self: UIApplicationDelegate {
     
         // MARK: Catch Crashing Param - String
         // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
         // objective-c object type, both debug and relase environments are supported
         @objc func catchCrashing(crash: String)
     }

     说明：
     崩溃跟踪，同时支持OC和Swift 语言崩溃场景抓取。

   2). 控制器展示跟踪协议：
   
     @objc public protocol WisdomTrackingable where Self: UIApplicationDelegate {
     
         // MARK: Catch Controller Tracking Param - String, String
         // UIViewController Catch Tracking 'viewDidAppear'
         // - controller: UIViewController.Type
         // - title: String
         @objc func catchTracking(viewDidAppear controller: UIViewController.Type, title: String)
     
         // MARK: Catch Controller Tracking Param - String, String
         // UIViewController Catch Tracking 'viewDidDisappear'
         // - controller: UIViewController.Type
         // - appearTime: NSInteger
         // - title: String
         @objc optional func catchTracking(viewDidDisappear controller: UIViewController.Type, appearTime: NSInteger, title: String)
     }
     
     说明：
     控制器将要隐藏协议回调中，会带过来时间参数，为当前控制器所展示的时长。

   3). 协议使用案例：
   
     extension AppDelegate: WisdomCrashingable {
         //崩溃跟踪
         func catchCrashing(crash: String) {
         //  crash 崩溃消息
         }
     }
     
     extension AppDelegate: WisdomTrackingable {
         //页面跟踪
         func catchTracking(viewDidAppear controller: UIViewController.Type, title: String) {
         //  controller/title 页面展示消息
         }
     }
     
     上面案例为：崩溃消息监听；
     下面案例为：控制器展示状态监听，这里只实现了展示协议；



# 【4】图片 缓存/加载

   1). UIImage 本地缓存 和 本地加载 扩展：
   
     // * Save/Load Image in Memory/Disk Cache *
     extension UIImage {
     
         // MARK: Save Image in Memory Cache / Disk Cache
         // imageName: Image Name
         @objc public func saveingable(imageName: String) 
         
         // MARK: Load Image in Memory Cache / Disk Cache
         // imageName:    Image Name
         // imageClosure: (UIImage,String)->() (has UIImage)
         // emptyClosure: ()->()               (no UIImage)
         @objc public static func loadingable(imageName: String, imageClosure: @escaping (UIImage,String)->(), emptyClosure: @escaping ()->())
     }

   --> UIImage 本地缓存 案例：
     
     // 按照 imageName 保存
     UIImage().saveingable(imageName: “本地缓存图片名称”)

   --> UIImage 本地加载 案例：
   
     UIImage.loadingable(imageName: “本地缓存图片名称” ) { image, imageName in
       // 获取到本地缓存到图片
     } emptyClosure: {
       // 本地没有缓存的图片 
     }

     说明：
     -> 图片本地缓存为沙盒缓存，如果app内存吃紧，缓存图片会被清除。
   
     -> 图片获取缓存过程：内存缓存 -> 磁盘缓存。

   2). UIImageView本地缓存 和 网络加载 扩展：
   
     extension UIImageView {
         // MARK: Load Image in Memory Cache / Disk Cache
         // imageName:        Image Name (historical save Memory/Disk Cache)
         // placeholderImage: Placeholder picture (Memory/Disk Cache no Image)
         @objc public func loadingImageable(imageName: String, placeholderImage: UIImage?=nil)
    
         // MARK: Load Image in Network / Memory Cache / Disk Cache
         // imageUrl:         Image Url (historical save Memory/Disk Cache, if not, network download)
         // placeholderImage: Placeholder picture (Memory/Disk Cache no Image)
         @objc public func loadingImageable(imageUrl: String, placeholderImage: UIImage?=nil)
     }

     说明：
     -> 第一种，根据 imageName 只在本地缓存中加载图片；
   
     -> 第二种，先本地加载缓存图片，在没有的情况，继续根据 imageUrl 进行网络下载，下载完成做本地缓存；


   3). UIImageView图片动态跟踪 扩展：
   
     extension UIImageView {
     
         // MARK: Tracking save Image in Memory Cache / Disk Cache, Paired use
         // Tracking UIImage ‘@objc public func saveingable(imageName: String)’ method, update icon
         // 当有图片本地缓存, 调用 UIImage ‘@objc public func saveingable(imageName: String)’ 方法时，对跟踪图片控件，刷新图片
         @objc public func trackingImageable()
     
         // MARK: Missing save Image in Memory Cache / Disk Cache, Paired use
         // Make UIImage ‘@objc public func trackingImageable()’ method Missing
         // 使对跟踪图片控件刷新失效，失效设置 UIImage ‘@objc public func saveingable(imageName: String)’ 方法
         @objc public func missingImageable()
     }

     说明：
     -> ‘func trackingImageable()’: 对本地图片缓存任务，进行监听，b并重新刷新之前UIImageView加载失败的图片；
     
     -> ‘func missingImageable()’:  使 ‘func trackingImageable()’监听任务失效；



如果您热衷于iOS/swift开发，是一位热爱学习进步的童鞋，欢迎来一起研究/讨论 开发中遇到的问题。联系QQ：497609288 。
请给予我支持，我会继续我的创作。

The above is the introduction of the core functions of SDK routing, finished
If you are keen on iOS/swift development, you are a child who loves learning and progress, welcome to study/discuss the problems encountered in the development together. Contact QQ: 497609288.
Please give me your support and I will continue my creation.


