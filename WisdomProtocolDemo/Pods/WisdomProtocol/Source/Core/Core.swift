//
//  Core.swift
//  WisdomProtocol
//
//  Created by tangjianfeng on 2022/11/14.
//

import UIKit
import RCBacktrace

class WisdomProtocolCore {

    private static var WisdomRegisterState: Int = 0
    
    private static var WisdomTimer: WisdomTimerModel?
    
    private static var WisdomLanguageBundle: Bundle?
    
    private(set) static var WisdomReachability: WisdomNetworkReachability?
    
    private static var WisdomReachabilityListens: [WisdomWeakable<WisdomNetworkReachabilityable>]?
    
    private static var WisdomFPSer: WisdomFPS?
    
    private static var WisdomFluecyer: WisdomFluecy?
    
    static var WisdomProtocolConfig: [String:AnyClass] = [:]
    
    private static func getTimerableKey(able: WisdomTimerable&AnyObject)->String {
        let bit = "\(unsafeBitCast(able, to: Int64.self))"
        print("[WisdomProtocol] getTimerableKey: "+bit)
        assert(bit.count>0, "unsafeBitCast failure: \(able)")
        if let objcable = able as? NSObject {
            return "\(objcable.classForCoder)&"+bit
        }
        return "\(able.self)&"+bit
    }
    
    static func registerable() {
        if WisdomProtocolCore.WisdomRegisterState == 1 {
            return
        }
        WisdomProtocolCore.WisdomRegisterState = 1
        WisdomCrashRegister()
        WisdomProtocolCore.trackingRegister()
        UIViewController.trackingRegister()
        
        let selector = NSSelectorFromString("registerRouterable")
        if let method = class_getClassMethod(Self.self, selector) {
            let imp = method_getImplementation(method)
            typealias Function = @convention(c) (AnyObject, Selector, Any?) -> Void
            let function = unsafeBitCast(imp, to: Function.self)
            function(Self.self, selector, "Red")
        }
    }
}

extension WisdomProtocolCore: WisdomProtocolCreateable{
    
    static func create(protocolName: String) -> Protocol? {
        return NSProtocolFromString(protocolName)
    }
    
    static func create(projectName: String, protocolName: String) -> Protocol? {
        let name = projectName+"."+protocolName
        return NSProtocolFromString(name)
    }
}

extension WisdomProtocolCore: WisdomBundleCoreable {
        
    static func able(projectClass: AnyClass?, resource: String, ofType: String, fileName: String, inDirectory: String?)->Bundle?{
        let b = projectClass != nil ? Bundle.init(for: projectClass!) : Bundle.main
        var bundlePath = b.path(forResource: resource, ofType: ofType, inDirectory: inDirectory) ?? ""
        if !bundlePath.hasSuffix("/") && !fileName.hasPrefix("/") {
            bundlePath.append(contentsOf: "/")
        }
        let bundle = Bundle.init(path: bundlePath+fileName)
        return bundle
    }
}

extension WisdomProtocolCore: WisdomCodingCoreable {
    
    // Any to T
    static func decodable<T>(_ type: T.Type, value: Any)->T? where T: Decodable{
        guard let data = try? JSONSerialization.data(withJSONObject: value) else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return try? decoder.decode(type, from: data)
    }
    
    // [[String:Any]] to [T]
    static func decodable<T>(_ type: T.Type, list: [[String:Any]])->[T] where T: Decodable{
        let result: [T] = list.compactMap { value in
            let able = Self.decodable(type, value: value)
            assert(able != nil, "decodable failure: \(value)")
            return able
        }
        return result
    }
    
    // Json to T
    static func jsonable<T>(_ type: T.Type, json: String)->T? where T: Decodable{
        let decoder = JSONDecoder()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        guard let able = try? decoder.decode(type, from: json.data(using: .utf8)!) else {
            return nil
        }
        return able
    }
    
    // Jsons to [T]
    static func jsonable<T>(_ type: T.Type, jsons: String)->[T] where T: Decodable{
        guard let jsonsData = jsons.data(using: .utf8) else {
            return []
        }
        guard let array = try? JSONSerialization.jsonObject(with: jsonsData, options: .mutableContainers), let result = array as? [[String:Any]] else {
            return []
        }
        return decodable(type, list: result)
    }
    
    // T to String
    static func ableJson<T>(_ able: T)->String? where T: Encodable{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(able) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    // T to [String:Any]
    static func ableEncod<T>(_ able: T)->[String:Any]? where T: Encodable{
        if let jsonString = ableJson(able){
            guard let jsonData = jsonString.data(using: .utf8) else {
                return nil
            }
            guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers), let result = dict as? [String:Any] else {
                return nil
            }
            return result
        }
        return nil
    }
    
    // [T] to [[String:Any]]
    static func ableEncod<T>(ables: [T])->[[String:Any]] where T: Encodable{
        let result: [[String:Any]] = ables.compactMap { able in
            let dict = Self.ableEncod(able)
            assert(dict != nil, "decodable failure: \(able)")
            return dict
        }
        return result
    }
    
    // [T] to Jsons
    static func ableJsons<T>(ables: [T])->String? where T: Encodable{
        let result: [[String:Any]] = Self.ableEncod(ables: ables)
        if !JSONSerialization.isValidJSONObject(result) {
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: result, options: []), let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) as String? {
            return JSONString
        }
        return nil
    }
}

extension WisdomProtocolCore: WisdomTimerCoreable {
    
    static func startForwardTimer(able: WisdomTimerable&AnyObject, startTime: UInt){
        if Thread.isMainThread {
            taskTimer()
        }else {
            DispatchQueue.main.async { taskTimer() }
        }
        func taskTimer(){
            let key = getTimerableKey(able: able)
            if key.count > 0 {
                if WisdomTimer==nil{
                    WisdomTimer=WisdomTimerModel(task: WisdomTimerTask(isDown: false, able: able, startTime: startTime), key: key) {
                        WisdomTimer?.destroy()
                        WisdomTimer=nil
                    }
                }else {
                    WisdomTimer!.appendTask(task: WisdomTimerTask(isDown: false, able: able, startTime: startTime), key: key)
                }
            }
        }
    }
    
    static func startDownTimer(able: WisdomTimerable&AnyObject, totalTime: UInt){
        if Thread.isMainThread {
            taskTimer()
        }else {
            DispatchQueue.main.async { taskTimer() }
        }
        func taskTimer(){
            let key = getTimerableKey(able: able)
            if key.count > 0 {
                if WisdomTimer==nil{
                    WisdomTimer=WisdomTimerModel(task: WisdomTimerTask(isDown: true, able: able, startTime: totalTime), key: key) {
                        WisdomTimer?.destroy()
                        WisdomTimer=nil
                    }
                }else {
                    WisdomTimer!.appendTask(task: WisdomTimerTask(isDown: true, able: able, startTime: totalTime), key: key)
                }
            }
        }
    }
    
    static func suspendTimer(able: WisdomTimerable&AnyObject){
        if Thread.isMainThread {
            taskTimer()
        }else {
            DispatchQueue.main.async { taskTimer() }
        }
        func taskTimer(){
            let key = getTimerableKey(able: able)
            if key.count > 0 {
                
            }
        }
    }
    
    static func resumeTimer(able: WisdomTimerable&AnyObject){
        if Thread.isMainThread {
            taskTimer()
        }else {
            DispatchQueue.main.async { taskTimer() }
        }
        func taskTimer(){
            let key = getTimerableKey(able: able)
            if key.count > 0 {
                
            }
        }
    }
    
    static func destroyTimer(able: WisdomTimerable&AnyObject){
        if Thread.isMainThread {
            taskTimer()
        }else {
            DispatchQueue.main.async { taskTimer() }
        }
        func taskTimer(){
            let key = getTimerableKey(able: able)
            if key.count > 0 {
                WisdomTimer?.destroyTask(key: key)
            }
        }
    }
}

extension WisdomProtocolCore: WisdomTimerFormatable {
    
    static func getH_M_S_Format(seconds: UInt, format: String)->String{
        let hours = seconds/3600
        let minutes = seconds%3600/60
        let second = seconds%3600%60
        let hours_str = hours < 10 ? "0\(hours)" : "\(hours)"
        let minutes_str = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let second_str = second < 10 ? "0\(second)" : "\(second)"
        return hours_str+format+minutes_str+format+second_str
    }
    
    static func dotFormat(seconds: UInt)->String{
        return getH_M_S_Format(seconds: seconds, format: ":")
    }
    
    static func lineFormat(seconds: UInt)->String{
        return getH_M_S_Format(seconds: seconds, format: "-")
    }
    
    static func timeFormat(seconds: UInt, format: String)->String{
        return getH_M_S_Format(seconds: seconds, format: format)
    }
    
    static func versionisHighVersion(masterVersion: String, compareVersion: String)->Bool?{
        var master_versions: [NSInteger] = []
        var compare_versions: [NSInteger] = []
        for tag in masterVersion.components(separatedBy: ".") {
            if let value = NSInteger(tag) {
                master_versions.append(value)
            }else {
                return nil
            }
        }
        for tag in compareVersion.components(separatedBy: ".") {
            if let value = NSInteger(tag) {
                compare_versions.append(value)
            }else {
                return nil
            }
        }
        if master_versions.isEmpty || compare_versions.isEmpty {
            return nil
        }
        let numDiff = master_versions.count - compare_versions.count
        if numDiff < 0 {
            master_versions.append(contentsOf: Array(repeating: 0, count: -numDiff))
        } else if numDiff > 0 {
            compare_versions.append(contentsOf: Array(repeating: 0, count: numDiff))
        }
        for i in 0..<master_versions.count {
            let diff = master_versions[i] - compare_versions[i]
            if diff != 0 {
                return diff < 0 ? false : true
            }
        }
        return false
    }
}

//MARK: - Crash Register
fileprivate func WisdomCrashRegister(){
    signal(SIGINT,  SignalHandler)
    signal(SIGTRAP, SignalHandler)//nil值的非可选类型/一个失败的强制类型转换
    signal(SIGABRT, SignalHandler)//调用abort函数生成的信号
    signal(SIGILL, SignalHandler) //执行了非法指令，通常因为可执行文件本身出席错误，或者试图执行数据段，堆栈溢出时也有可能产生这个信号
    signal(SIGSEGV, SignalHandler)//Wild pointer, zombie object
    signal(SIGFPE, SignalHandler) //在发生致命的算术运算错误时发出
    signal(SIGBUS, SignalHandler) //Illegal address
    signal(SIGPIPE, SignalHandler)//write on a pipe with no one to read it
    signal(SIGKILL, SignalHandler)//Code that the CPU cannot execute
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler)
}

fileprivate func SignalHandler(signal: Int32)->Void{
    if let crashable = UIApplication.shared.delegate as? WisdomCrashCatchingable{
        var mstr = String()
        mstr += "Stack:\n"
        //append slide adress
        mstr = mstr.appendingFormat("slideAdress:0x%0x\r\n", wisdom_calculate())
        //append error info
        for symbol in Thread.callStackSymbols { mstr = mstr.appendingFormat("%@\r\n", symbol) }
        crashable.crashCatching(crash: "*SignalHandler*"+mstr)
        exit(signal)
    }
}

fileprivate func UncaughtExceptionHandler(exception: NSException) {
    if let crashable = UIApplication.shared.delegate as? WisdomCrashCatchingable{
        let arr = exception.callStackSymbols
        let reason = exception.reason
        let name = exception.name.rawValue
        var crash = String()
        crash += "Stack:\n"
        crash = crash.appendingFormat("slideAdress:0x%0x\r\n", wisdom_calculate())
        crash += "\r\n\r\n name:\(name) \r\n reason:\(String(describing: reason)) \r\n \(arr.joined(separator: "\r\n")) \r\n\r\n"
        crashable.crashCatching(crash: "*NSException*"+crash)
    }
}

extension WisdomProtocolCore {
    
    fileprivate static func trackingRegister(){
        let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
        if isSimulator {
            return
        }
        #if DEBUG
        RCBacktrace.setup()
        WisdomFPSer = WisdomFPS()
        WisdomFluecyer = WisdomFluecy(timeout: 2)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+5) {
            if (UIApplication.shared.delegate as? WisdomFPSCatchingable)==nil{
                WisdomProtocolCore.WisdomFPSer=nil
            }
            
            WisdomProtocolCore.WisdomFluecyer?.stopMonitoring()
            WisdomProtocolCore.WisdomFluecyer=nil
            if let able = UIApplication.shared.delegate as? WisdomFluecyCatchingable {
                WisdomFluecyer = WisdomFluecy(timeout: able.getFluecyCatchTime(description: "Monitor the holdup, minimum duration"))
            }
        }
        #endif
    }
}

extension UIViewController {
    
    private struct WisdomController{ static var appearTime = "WisdomProtocolCore.appearTime" }
    
    private var wisdom_appearTime: String? {
        set { objc_setAssociatedObject(self, &WisdomController.appearTime, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
        get { return objc_getAssociatedObject(self, &WisdomController.appearTime) as? String }
    }
    
    fileprivate static func trackingRegister() {
        if let originMethod = class_getInstanceMethod(self, #selector(viewDidAppear(_:))),
           let changeMethod = class_getInstanceMethod(self, #selector(wisdom_viewDidAppear(_:))){
            method_exchangeImplementations(originMethod, changeMethod)
        }
        if let originMethod = class_getInstanceMethod(self, #selector(viewDidDisappear(_:))),
           let changeMethod = class_getInstanceMethod(self, #selector(wisdom_viewDidDisappear(_:))){
            method_exchangeImplementations(originMethod, changeMethod)
        }
    }
    
    @objc fileprivate func wisdom_viewDidAppear(_ animated: Bool) {
        wisdom_viewDidAppear(animated)
        if let trackingable = UIApplication.shared.delegate as? WisdomTrackCatchingable,
           let controller = classForCoder as? UIViewController.Type {
            var cur_title = title ?? ""
            if cur_title.isEmpty {
                cur_title = navigationItem.title ?? ""
            }
            wisdom_appearTime = "\(NSInteger(CFAbsoluteTimeGetCurrent()))"
            trackingable.trackCatching(viewDidAppear: controller, title: cur_title)
        }
    }
    
    @objc fileprivate func wisdom_viewDidDisappear(_ animated: Bool) {
        wisdom_viewDidDisappear(animated)
        if let trackingable = UIApplication.shared.delegate as? WisdomTrackCatchingable,
           let trackingFunc = trackingable.trackCatching,
           let controller = classForCoder as? UIViewController.Type {
            var cur_title = title ?? ""
            if cur_title.isEmpty {
                cur_title = navigationItem.title ?? ""
            }
            var cur_time: NSInteger = 0
            if let time = wisdom_appearTime, let value = NSInteger(time) {
                cur_time = NSInteger(CFAbsoluteTimeGetCurrent())-value
            }
            trackingFunc(controller, cur_time, cur_title)
        }
    }
}

extension WisdomProtocolCore {
    
    static func getBinaryable<T: WisdomBinaryBitable>(value: NSInteger, type: T.Type)->[T]{
        if value <= 0 { return [] }
        var allValue = 0
        for cases in type.allCases {
            allValue += 1<<cases.bitRawValue
        }
        if value >= allValue {
            return type.allCases as! [T]
        }
        var types: [T]=[]
        for state in type.allCases {
            if isBinaryable(value: value, caseBitable: state.bitRawValue) {
                types.append(state)
            }
        }
        return types
    }
    
    static func isBinaryable<T: WisdomBinaryBitable>(value: NSInteger, state: T)->Bool{
        return isBinaryable(value: value, caseBitable: state.bitRawValue)
    }
}

extension WisdomProtocolCore: WisdomBinaryBitValueable {
    
    static func getBinaryable(value: NSInteger, caseBitables: [NSInteger])->[NSInteger]{
        if value <= 0 { return [] }
        var bits: [NSInteger]=[]
        for caseBitable in caseBitables {
            if isBinaryable(value: value, caseBitable: caseBitable) {
                bits.append(caseBitable)
            }
        }
        return bits
    }

    static func isBinaryable(value: NSInteger, caseBitable: NSInteger)->Bool{
        if value <= 0 { return false }
        let result = value>>caseBitable&1
        if result == 1 {
            return true
        }
        return false
    }
}

extension WisdomProtocolCore: WisdomLanguageCoreable {
    
    private static var WisdomLanguageState: WisdomLanguageStatus?{
        get {
            if let languageable = UIApplication.shared.delegate as? WisdomLanguageRegisterable,
               let languageKey = languageable.registerLanguageKey(), languageKey.count > 0 {
                let languageValue = UserDefaults.standard.integer(forKey: languageKey)
                if let state = WisdomLanguageStatus(rawValue: languageValue) {
                    return state
                }
            }
            return nil
        }
        
        set {
            if let languageable = UIApplication.shared.delegate as? WisdomLanguageRegisterable,
               let languageKey = languageable.registerLanguageKey(), languageKey.count > 0 {
                let value: NSInteger = newValue?.rawValue ?? 0
                UserDefaults.standard.setValue(value, forKey: languageKey)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    private static func getLanguageBundle(languageable: WisdomLanguageRegisterable)->Bundle{
        var languageState: WisdomLanguageStatus = .en
        let currentState = WisdomLanguageState
        if currentState==nil || currentState == .system {
            let systemLanguage = getSystemLanguage()
            print("[WisdomProtocol] systemLanguage: "+systemLanguage)
            
            for cases in WisdomLanguageStatus.allCases {
                if systemLanguage.hasPrefix(cases.fileName){
                    languageState = cases
                    break
                }
            }
        }else if let state = currentState {
            print("[WisdomProtocol] currentLanguage: \(state.fileName)")
            languageState = state
        }
        let bundle = languageable.registerLanguage(language: languageState)
        return bundle
    }
    
    static func getLocalizable(localizable: String)->String{
        // unregisterLanguage
        if let languageable = UIApplication.shared.delegate as? WisdomLanguageRegisterable  {
            // set
            if let bundle = WisdomLanguageBundle {
                return bundle.localizedString(forKey: localizable, value: nil, table: nil)
            }
            // unset
            let bundle = getLanguageBundle(languageable: languageable)
            WisdomLanguageBundle = bundle
            return bundle.localizedString(forKey: localizable, value: nil, table: nil)
        }
        return localizable
    }
    
    static func getCurrentLanguage()->WisdomLanguageStatus?{
        if let _ = UIApplication.shared.delegate as? WisdomLanguageRegisterable {
            if let currentState = WisdomLanguageState {
                return currentState
            }else {
                return .system
            }
        }
        return nil
    }
    
    static func getSystemLanguage()->String{
        return Locale.preferredLanguages.first ?? ""
    }
    
    static func updateLanguage(language: WisdomLanguageStatus)->Bool{
        if let languageable = UIApplication.shared.delegate as? WisdomLanguageRegisterable {
            if language == WisdomLanguageState {
                return true
            }
            WisdomLanguageState = language
            
            let bundle = getLanguageBundle(languageable: languageable)
            WisdomLanguageBundle = bundle
            
            languageable.registerLanguageUpdate(language: language)
            return true
        }
        return false
    }
    
    static func resetLanguage(){
        if let languageable = UIApplication.shared.delegate as? WisdomLanguageRegisterable {
            if WisdomLanguageState==nil {
                return
            }
            WisdomLanguageState = nil
            let bundle = getLanguageBundle(languageable: languageable)
            WisdomLanguageBundle = bundle
            languageable.registerLanguageUpdate(language: .system)
        }
    }
}

extension WisdomProtocolCore: WisdomNetworkReachabilityCoreable {
    
    static func startReachabilityListening(able: WisdomNetworkReachabilityable){
        if Thread.isMainThread {
            startListening()
        }else {
            DispatchQueue.main.async { startListening() }
        }
        
        func startListening(){
            if WisdomReachabilityListens==nil{
                WisdomReachabilityListens = []
            }
            
            WisdomReachabilityListens?.append(WisdomWeakable(able: able))
            
            if WisdomReachability==nil {
                WisdomReachability = WisdomNetworkReachability()
                WisdomReachability?.startListening(onUpdatePerforming: { reachabilityState in
                    DispatchQueue.main.async { setListener(reachabilityState: reachabilityState) }
                })
            }
        }
        
        func setListener(reachabilityState: WisdomNetworkReachabilityStatus){
            WisdomReachabilityListens = WisdomReachabilityListens?.compactMap({ weakListener in
                if let listener = weakListener.able {
                    listener.networkReachability(didChange: reachabilityState)
                    return weakListener
                }
                return nil
            })
            
            if WisdomReachabilityListens==nil||WisdomReachabilityListens?.count==0 {
                WisdomReachabilityListens = nil
                WisdomReachability?.stopListening()
                WisdomReachability = nil
            }
        }
    }
    
    static func stopReachabilityListening(able: WisdomNetworkReachabilityable){
        if Thread.isMainThread {
            stopListening()
        }else {
            DispatchQueue.main.async { stopListening() }
        }
        
        func stopListening(){
            let reachabilityable = WisdomWeakable(able: able)
            WisdomReachabilityListens = WisdomReachabilityListens?.compactMap({ weakListener in
                if let _ = weakListener.able{
                    if weakListener == reachabilityable {
                        return nil
                    }
                    return weakListener
                }
                return nil
            })
            
            if WisdomReachabilityListens==nil||WisdomReachabilityListens?.count==0 {
                WisdomReachabilityListens = nil
                WisdomReachability?.stopListening()
                WisdomReachability = nil
            }
        }
    }
}
