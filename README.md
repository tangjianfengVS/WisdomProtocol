# WisdomProtocol
WisdomProtocol is a Protocol of wisdom sdk. 

github install: pod 'WisdomProtocol'

Function Description:
1. WisdomProtocol sdk: Support compatible syntax 'Swift/objective-c' protocol usage.

2. WisdomProtocol sdk: Support sdk across 'module/project/static library/dynamic library' internal 'Class/UIViewController/UIView/Param' routing protocol.

3. WisdomProtocol sdk: Support data types 'dictionary/json/model/model collection' to 'encoding/decoding' conversion protocol.
   - 'Set class/data' to 'encoding/decoding' task, in the Debug environment, conversion failure, added the assertion processing, it is easy to find data hidden dangers during debugging:
     * assert(able != nil, "decodable failure: \(value)") *
     * assert(dict != nil, "decodable failure: \(able)") *
     
4. WisdomProtocol sdk: Support object enablement 'objective-c/Swift Class' timer 'forward/countdown' task protocol. 
   - Timer life cycle/release does not require the user's concern, the use of timers is maintained/managed automatically within the WisdomProtocol sdk.

5. WisdomProtocol sdk: Support for capture and tracking 'objective-c/Swift Class' when a run crash error occurs, log trace, capture protocol.

6. WisdomProtocol sdk: Support statistical tracking 'UIViewController' 'viewDidAppear(_:)/viewDidDisappear(_:)' page display time and duration statistics protocol.




# WisdomProtocol
WisdomProtocol是一个智能协议 sdk。

github 集成: pod 'WisdomProtocol'

功能描述:
1. WisdomProtocol sdk: 支持兼容语法 'Swift/objective-c' 协议使用。

2. WisdomProtocol sdk: 支持sdk跨越 '模块/项目/静态库/动态库' 内部 'Class/UIViewController/UIView/Param' 路由协议。

3. WisdomProtocol sdk: 支持数据类型 '字典/字典数组/json/模型/模型数组' 的 '编码/解码' 转换协议。
  - '集合 类/数据' 的 '编码/解码' 任务，在调试环境下，转换失败，添加了断言处理，便于调试阶段，发现数据隐患：
    * assert(able != nil, "decodable failure: \(value)") *
    * assert(dict != nil, "decodable failure: \(able)") *

4. WisdomProtocol sdk: 支持对象启用 'objective-c/Swift Class' 定时器 '前进计时/倒计时' 任务协议。
   - 计时器的 生命周期/释放时机 不需要用户关注，计时器的使用在 WisdomProtocol sdk内部，会自动 管理/维护。
   
5. WisdomProtocol sdk: 支持捕捉跟踪 'objective-c/Swift Class' 发生运行崩溃错误时，日志跟踪，捕捉协议。

6. WisdomProtocol sdk: 支持统计跟踪 'UIViewController' 'viewDidAppear(_:)/viewDidDisappear(_:)' 页面展示时机和时长 统计协议。


## 路由协议篇
## 路由协议是 WisdomProtocol 核心功能，以下为您介绍如何去使用

【**协议支持**】：跨工程/模块/动态库/静态库 中 类/UIView/UIViewController/参数 之间的交互/传递/调用功能。

【**注册绑定**】：路由协议在使用之前，需要实现 WisdomRegisterable 注册协议，将唯一的协议与类绑定，注册到 WisdomProtocol sdk 中，像这样：

    @objc protocol WisdomProtocolLeftVCProtocol {}

    class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {

       // 这里协议与类进行注册绑定
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
       }
    }

【**路由功能**】
 【1】. Class 路由协议：
 
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

---> **Class 路由使用案例**：
注册绑定：

    @objc protocol WisdomProtocolLeftModelable {}

    class WisdomProtocolLeftModel: WisdomRegisterable, WisdomProtocolLeftModelable {

       // 注册绑定协议/类
       static func registerable() -> WisdomClassable {
          return WisdomClassable(register: WisdomProtocolLeftModelable.self, conform: Self.self)
       }
    
       var bgColor: String?
       var textColor: String?
       var codeColor: String?
    }

协议实现：

    extension WisdomProtocolLeftModel: WisdomRouterClassable{

       // 实现路由协议
       static func routerClassable(param: Any?) -> Self {
           var dict: [String:Any] = [:]
           if let value = param as? [String:Any] {
               dict = value
           }
           let cla = WisdomProtocolLeftModel.decodable(value: dict)
           return cla as! Self
        }
    }

---> **外部开始路由**：

    // 通过注册到协议，获取到类别
    let cla = WisdomProtocol.getRouterClassable(from: WisdomProtocolLeftModelable.self)
    let param = ["bgColor":"708069","textColor":"FFFFFF","codeColor":"33A1C9"]
    // 创建对象
    let objc = cla?.routerClassable?(param: param)
    print(objc)

 【2】. UIViewController 路由协议：
 
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

 --> **UIViewController 路由使用案例**：
 注册绑定：
 
    @objc protocol WisdomProtocolLeftVCProtocol {}
    
    class WisdomProtocolLeftVC: UIViewController, WisdomRegisterable, WisdomProtocolLeftVCProtocol {
    
       // 注册绑定协议/UIViewController
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVCProtocol.self, conform: Self.self)
       }
    }

协议实现：

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

--> 外部开始路由:

    // 通过注册到协议，获取到UIViewController
    // MARK: WisdomRouterControlable 路由控制器-无参数
    let vcClass = WisdomProtocol.getRouterControlable(from: LeftVCProtocol.self)
    // 创建对象
    _=vcClass?.routerControlable?(rootVC: self, param: nil)

 【3】. UIView 路由协议：
 
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

--> **UIView 路由使用案例**：
注册协议：

    @objc protocol WisdomProtocolLeftVIProtocol {}
    
    class WisdomProtocolLeftVI: UIView, WisdomRegisterable, WisdomProtocolLeftVIProtocol {
       // 注册绑定协议/UIView
       static func registerable() -> WisdomClassable {
           return WisdomClassable(register: WisdomProtocolLeftVIProtocol.self, conform: Self.self)
       }
    }

实现协议：

    extension WisdomProtocolLeftVI: WisdomRouterViewable {
    
        // 实现路由协议
        static func routerViewable(superview: UIView?, param: Any?) -> Self {
           let vi = Self.init()
           // 添加/布局视图
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

--> 外部开始路由:

    // 通过注册到协议，获取到UIView
    // MARK: WisdomRouterViewable 路由UIView-无参数
    let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
    // 创建对象
    let viewable=viClass?.routerViewable?(superview: self.view, param: nil)

 【4】. Param 路由协议：
 
    // MARK: - Router Param Protocol
    @objc public protocol WisdomRouterParamable {

       // MARK: Param - Any?
       @objc optional func routerParamable(param: Any?)

       // MARK: Param - Any?, ((Any)->Void)?
       @objc optional func routerParamable(param: Any?, closure: ((Any)->Void)?)

       // MARK: Param - Any?, ((Any)->(Any))?
       @objc optional func routerParamable(param: Any?, returnClosure: ((Any)->(Any))?)
    }

--> **Param 路由使用案例**：
实现协议：

    extension WisdomProtocolLeftVI: WisdomRouterParamable{
    
       // 接收外部到路由
       func routerParamable(param: Any?) {
           if let colorDic = param as? [String:Any] {
               model = WisdomProtocolLeftModel.decodable(value: colorDic)
               paramLabel.text = " 6. 参数路由代码示例：\n\n (1). WisdomProtocolLeftVI 需实现协议: \n -- WisdomRouterParamable 参数路由协议\n\n // MARK: 调用 路由参数方法\nlet param = ['bgColor':bgColor,'textColor':textColor,'codeColor':codeColor]\n (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)\n"
           }
       }
    }

---> 外部开始路由:

    // MARK: WisdomRouterViewable 路由UIView-无参数
    let viClass = WisdomProtocol.getRouterViewable(from: LeftVIProtocol.self)
    viewable=viClass?.routerViewable?(superview: self.view, param: nil)
                
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) { [weak self] in
    
       // MARK: WisdomRouterParamable 参数路由协议
       let param = ["bgColor":"708069","textColor":"FFFFFF","codeColor":"33A1C9"]
       // 可选解包，路由参数
       (self?.viewable as? WisdomRouterParamable)?.routerParamable?(param: param)
    }

### 以上就是SDK路由核心功能介绍，完成
如果您热衷于iOS/swift开发，是一位热爱学习进步的童鞋，欢迎来一起研究/讨论 开发中遇到的问题。联系QQ：497609288 。
请给予我支持，我会继续我的创作。


