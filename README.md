# WisdomProtocol

  一. 简介：

  WisdomProtocol：一款iOS 面向协议 编程框架，Swift特别版。
   
  在开发中，以遵守实现 对应协议，即可得到 相应能力 的理念，来定义一批定制的协议，通过他们绑定实现定制的功能和需求。
   
  协议功能 支持 如下列表。
   
  
  
  二. 协议功能支持：

    1). 定时器功能
  
    2). 模型数据: 编/解码
  
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


# 【2】模型数据 编/解码

   -> 模型数据 编/解码 继承主协议：
   
     // MARK: Swift Class/NSObject/Value to coding/decoding Protocol
     public protocol WisdomCodingable {}
     
     简介：
     继承编/解码协议 对象，拥有对模型和数据编/解吗的能力，且支持集合，结构体，枚举类型。下面具体介绍协议的几个方法API。


   -> 模型数据 几种解码场景：
   
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

   -> 模型数据 几种编码场景：

    extension WisdomCodingable where Self: Encodable {
    
         // MARK: return - String?
         // swift model to json string, use 'Encodable' protocol
         public func ableJson()->String?{}
         
         // MARK: return - [String:Any]?
         // swift model to dictionary, use 'Encodable' protocol
         public func ableEncod()->[String:Any]?{}
    }

   -> 模型数据 集合编码场景：
   
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
     
   -> 模型数据 案例：
   
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
   -> 1. 崩溃信息的跟踪；
   -> 2. 控制器的 显示/掩藏 状态跟踪，和显示时间统计；
   -> 3. 协议限制 条件对象：UIApplicationDelegate
     protocol WisdomCrashingable where Self: UIApplicationDelegate

   1). 崩溃跟踪协议
   
     @objc public protocol WisdomCrashingable where Self: UIApplicationDelegate {
    
         // MARK: Catch Crashing Param - String
         // Swift object type, this parameter is valid in the relase environment but invalid in the debug environment
         // objective-c object type, both debug and relase environments are supported
         @objc func catchCrashing(crash: String)
     }

     说明：崩溃跟踪，同时支持OC和Swift 语言崩溃场景抓取。

   2). 控制器展示跟踪协议
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
     说明：控制器将要隐藏协议回调中，会带过来时间参数，为当前控制器所展示的时长。

   3). 协议使用案例
     extension AppDelegate: WisdomCrashingable {
    
         func catchCrashing(crash: String) {
             //  crash 崩溃溃消息
         }
     }

extension AppDelegate: WisdomTrackingable {
    
    //页面跟踪
    func catchTracking(viewDidAppear controller: UIViewController.Type, title: String) {
        RCLog.info(text: "vc: \(controller) title: "+title)
    }
}
上面案例为：崩溃消息监听；
下面案例为：控制器展示状态监听，这里只实现了展示协议；



## Routing Protocol/路由协议篇
## Routing protocol is the core function of WisdomProtocol. The following describes how to use it/路由协议是 WisdomProtocol 核心功能，以下为您介绍如何去使用

【**协议支持**】：跨工程/模块/动态库/静态库 中 类/UIView/UIViewController/参数 之间的交互/传递/调用功能。

【**protocol support**】: across the project/module/dynamic library/class/UIView UIViewController/parameters in static library interaction/transfer/call function.

【**注册绑定**】：路由协议在使用之前，需要实现 WisdomRegisterable 注册协议，将唯一的协议与类绑定，注册到 WisdomProtocol sdk 中，像这样：

【**registering binding**】：Before the routing protocol is used, it is necessary to implement the WisdomRegisterable registration protocol, bind the unique protocol with the class, and register it in the WisdomProtocol sdk as follows:

    @objc protocol WisdomProtocolLeftVCProtocol {}

    class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {

       // Here the protocol is registered and bound to the class/这里协议与类进行注册绑定
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
       }
    }

【**路由功能**】

【**Routing Function**】

 【1】. Class Routing protocol/路由协议：
 
    // MARK: - Router Class Protocol
    @objc public protocol **WisdomRouterClassable** {

       // MARK: Param - Any?
       @discardableResult
       @objc optional static func routerClassable(param: Any?)->Self

       // MARK: Param - Any?, ((Any)->Void)?
       @discardableResult
       @objc optional static func routerClassable(param: Any?, closure: ((Any)->Void)?)->Self

       // MARK: Param - Any?, ((Any)->(Any))?
       @discardableResult
       @objc optional static func routerClassable(param: Any?, returnClosure: ((Any)->(Any))?)->Self
    }

---> **Class Route Application Case/路由使用案例**：

Registering a binding/注册绑定：

    @objc protocol WisdomProtocolLeftModelable {}

    class WisdomProtocolLeftModel: WisdomRegisterable, WisdomProtocolLeftModelable {

       // Register the binding protocol/class/注册绑定协议/类
       static func registerable() -> WisdomClassable {
          return WisdomClassable(register: WisdomProtocolLeftModelable.self, conform: Self.self)
       }
    
       var bgColor: String?
       var textColor: String?
       var codeColor: String?
    }

Implementation of Protocol/协议实现：

    extension WisdomProtocolLeftModel: WisdomRouterClassable{

       // Implementing Routing Protocols/实现路由协议
       static func routerClassable(param: Any?) -> Self {
           var dict: [String:Any] = [:]
           if let value = param as? [String:Any] {
               dict = value
           }
           let cla = WisdomProtocolLeftModel.decodable(value: dict)
           return cla as! Self
        }
    }

---> **External start routing/外部开始路由**：

    // Get the category by registering with the protocol/通过注册到协议，获取到类别
    let cla = WisdomProtocol.getRouterClassable(from: WisdomProtocolLeftModelable.self)
    let param = ["bgColor":"708069","textColor":"FFFFFF","codeColor":"33A1C9"]
    // Creating an Object/创建对象
    let objc = cla?.routerClassable?(param: param)
    print(objc)

 【2】. UIViewController Routing protocol/路由协议：
 
    // MARK: - Router UIViewController Protocol
    @objc public protocol WisdomRouterControlable where Self: UIViewController {

       // MARK: Param - UIViewController?, Any?
       @discardableResult
       @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?)->Self

       // MARK: Param - UIViewController?, Any?, ((Any)->Void)?
       @discardableResult
       @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?, closure: ((Any)->Void)?)->Self

       // MARK: Param - UIViewController?, Any?, ((Any)->(Any))?
       @discardableResult
       @objc optional static func routerControlable(rootVC: UIViewController?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
    }

 --> **UIViewController Route Application Case/路由使用案例**：
 
 Registering a binding/注册绑定：
 
    @objc protocol WisdomProtocolLeftVCProtocol {}
    
    class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {
    
       // Registering a binding protocol/注册绑定协议/UIViewController
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
       }
    }

Implementation of Protocol/协议实现：

    extension WisdomProtocolLeftVC: WisdomRouterControlable {
    
       // 实现路由协议
       @discardableResult
       static func routerControlable(rootVC: UIViewController?, param: Any?) -> Self {
           let vc = Self.init()
           vc.modalPresentationStyle = .fullScreen
           rootVC?.navigationController?.pushViewController(vc, animated: true)
           return vc
       }
    }

--> External start routing/外部开始路由:

    // Get the UIViewController by registering with the protocol/通过注册到协议，获取到UIViewController
    // MARK: WisdomRouterControlable Route controller - None/WisdomRouterControlable 路由控制器-无参数
    let vcClass = WisdomProtocol.getRouterControlable(from: LeftVCProtocol.self)
    // Creating an Object/创建对象
    _=vcClass?.routerControlable?(rootVC: self, param: nil)

 【3】. UIView Routing protocol/路由协议：
 
    // MARK: - Router UIView Protocol
    @objc public protocol WisdomRouterViewable where Self: UIView  {

       // MARK: Param - UIView?, Any?
       @discardableResult
       @objc optional static func routerViewable(superview: UIView?, param: Any?)->Self

       // MARK: Param - UIView?, Any?, ((Any)->Void)?
       @discardableResult
       @objc optional static func routerViewable(superview: UIView?, param: Any?, closure: ((Any)->Void)?)->Self

       // MARK: Param - UIView?, Any?, ((Any)->(Any))?
       @discardableResult
       @objc optional static func routerViewable(superview: UIView?, param: Any?, returnClosure: ((Any)->(Any))?)->Self
    }

--> **UIView Route Application Case/路由使用案例**：

Registration Agreement/注册协议：

    @objc protocol WisdomProtocolLeftVIProtocol {}
    
    class WisdomProtocolLeftVI: UIView, WisdomRegisterable, WisdomProtocolLeftVIProtocol {
       // Registering a binding protocol/注册绑定协议/UIView
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVIProtocol.self, conform: Self.self)
       }
    }

Implementation protocol/实现协议：

    extension WisdomProtocolLeftVI: WisdomRouterViewable {
    
        // Implementing Routing Protocols/实现路由协议
        static func routerViewable(superview: UIView?, param: Any?) -> Self {
           let vi = Self.init()
           // Add/layout view/添加/布局视图
           if let supervi = superview {
               supervi.addSubview(vi)
               vi.snp.makeConstraints { make in
                   make.top.equalTo(supervi).offset(10)
                   make.bottom.equalTo(supervi).offset(-20)
                   make.left.equalTo(supervi).offset(30)
                   make.right.equalTo(supervi).offset(-30)
              }
           }
           return vi
       }
    }

--> External start routing/外部开始路由:

    // You get the UIView by registering with the protocol/通过注册到协议，获取到UIView
    // MARK: WisdomRouterViewable Route UIView- No parameter/WisdomRouterViewable 路由UIView-无参数
    let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
    // Creating an Object/创建对象
    let viewable=viClass?.routerViewable?(superview: self.view, param: nil)

 【4】. Param Routing protocol/Param 路由协议：
 
    // MARK: - Router Param Protocol
    @objc public protocol WisdomRouterParamable {

       // MARK: Param - Any?
       @objc optional func routerParamable(param: Any?)

       // MARK: Param - Any?, ((Any)->Void)?
       @objc optional func routerParamable(param: Any?, closure: ((Any)->Void)?)

       // MARK: Param - Any?, ((Any)->(Any))?
       @objc optional func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)
    }

--> **Param Route Application Case/路由使用案例**：

Implementation protocol/实现协议：

    extension WisdomProtocolLeftVI: WisdomRouterParamable{
    
       // Receive the external to route/接收外部到路由
       func routerParamable(param: Any?) {
           if let colorDic = param as? [String:Any] {
               model = WisdomProtocolLeftModel.decodable(value: colorDic)
               paramLabel.text = " 6. 参数路由代码示例：\n\n (1). WisdomProtocolLeftVI 需实现协议: \n -- WisdomRouterParamable 参数路由协议\n\n // MARK: 调用 路由参数方法\nlet param = ['bgColor':bgColor,'textColor':textColor,'codeColor':codeColor]\n (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)\n"
           }
       }
    }

---> External start routing/外部开始路由:

    // MARK: WisdomRouterViewable Route UIView- No parameter/WisdomRouterViewable 路由UIView-无参数
    let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
    viewable=viClass?.routerViewable?(superview: self.view, param: nil)
                
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { [weak self] in
    
       // MARK: WisdomRouterParamable Indicates the routing protocol/WisdomRouterParamable 参数路由协议
       let param = ["bgColor":"708069","textColor":"FFFFFF","codeColor":"33A1C9"]
       // Optional unpack, route parameters/可选解包，路由参数
       (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)
    }

### 以上就是SDK路由核心功能介绍，完成

如果您热衷于iOS/swift开发，是一位热爱学习进步的童鞋，欢迎来一起研究/讨论 开发中遇到的问题。联系QQ：497609288 。
请给予我支持，我会继续我的创作。

The above is the introduction of the core functions of SDK routing, finished
If you are keen on iOS/swift development, you are a child who loves learning and progress, welcome to study/discuss the problems encountered in the development together. Contact QQ: 497609288.
Please give me your support and I will continue my creation.


