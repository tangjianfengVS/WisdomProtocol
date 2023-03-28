//
//  Language.swift
//  Pods
//
//  Created by tangjianfeng on 2023/1/12.
//

import UIKit

@objc public enum WisdomLanguageStatus: Int, CaseIterable {
    
    /// 跟随系统语言
    case system=1
    /// 英语
    case en
    /// 简体中文
    case zh_Hans
    /// 繁体中文
    case zh_Hant
    /// 繁体中文(香港特别行政区)
    case zh_Hant_HK
    /// 繁体中文(中国台湾省)
    case zh_Hant_TW
    /// 法语
    case fr
    /// 德语
    case de
    /// 意大利语
    case it
    /// 日语
    case ja
    /// 韩语
    case ko
    /// 葡萄牙语
    case pt_PT
    /// 俄语
    case ru
    /// 西班牙语
    case es
    /// 荷兰语
    case nl
    /// 泰语
    case th
    /// 阿拉伯语
    case ar
    /// 乌克兰
    case uk
    
    // 文件名称/File name
    public var fileName: String {
        get {
            switch self {
            case .system:  return "system"
            case .en:      return "en"
            case .zh_Hans: return "zh-Hans"
            case .zh_Hant: return "zh-Hant"
            case .zh_Hant_HK: return "zh-Hant-HK"
            case .zh_Hant_TW: return "zh-Hant-TW"
            case .fr:      return "fr"
            case .de:      return "de"
            case .it:      return "it"
            case .ja:      return "ja"
            case .ko:      return "ko"
            case .pt_PT:   return "pt-PT"
            case .ru:      return "ru"
            case .es:      return "es"
            case .nl:      return "nl"
            case .th:      return "th"
            case .ar:      return "ar-001"
            case .uk:      return "uk"
            }
        }
    }
    
    // 'file'.lproj
    public var file_lproj: String { return fileName+".lproj" }
}

// ---------------------------------------- Language ------------------------------------------------------- //
// * Need basis 'WisdomLanguageStatus' 'file_lproj' mame/store the file                                      //
// (1). 'static func getCurrentLanguage()->WisdomLanguageStatus?'          : the language currently set      //
// (2). 'static func getSystemLanguage()->String'                          : the language of system Settings //
// (3). 'static func updateLanguage(language: WisdomLanguageStatus)->Bool' : update the language             //
// (4). 'static func resetLanguage()'                                      : reset the language              //
// --------------------------------------------------------------------------------------------------------- //

// MARK: Languageable. < No need to implement >
@objc public protocol WisdomLanguageable {
    
}

extension WisdomLanguageable {
    
    // MARK: return - WisdomLanguageStatus?
    // Gets the language type of the setting
    public static func getCurrentLanguage()->WisdomLanguageStatus?{
        return WisdomProtocolCore.getCurrentLanguage()
    }
    
    // MARK: return - String
    // Gets the language type of the System
    public static func getSystemLanguage()->String{
        return WisdomProtocolCore.getSystemLanguage()
    }
    
    // MARK: Param - WisdomLanguageStatus, return - Bool
    // Update Language
    @discardableResult
    public static func updateLanguage(language: WisdomLanguageStatus)->Bool{
        return WisdomProtocolCore.updateLanguage(language: language)
    }
    
    // MARK: Reset Language
    public static func resetLanguage(){
        WisdomProtocolCore.resetLanguage()
    }
}


// ---------------------------------------- Register Language ---------------------------------------------------- //
// * Need register language 'UIApplicationDelegate'                                                                //
// (1). 'func registerLanguageKey()->String?'                           : gets save data key                       //
// (2). 'func registerLanguage(language: WisdomLanguageStatus)->Bundle' : gets resources by 'WisdomLanguageStatus' //
// (3). 'func registerLanguageUpdate(language: WisdomLanguageStatus)'   : language Switch callback                 //
// --------------------------------------------------------------------------------------------------------------- //

// MARK: Language Registerable
@objc public protocol WisdomRegisterLanguageable where Self: UIApplicationDelegate {
    
    // MARK: return - String?
    // Get the 'String' local save language key
    @objc func registerLanguageKey()->String?
    
    // MARK: Param - WisdomLanguageStatus, return - Bundle
    // Get the ‘Bundle’ based on the type
    @objc func registerLanguage(language: WisdomLanguageStatus)->Bundle
    
    // MARK: Param - WisdomLanguageStatus
    // Current Language Update
    @objc func registerLanguageUpdate(language: WisdomLanguageStatus)
}

extension NSString {
    
    // MARK: NSString localizable
    @objc public var localizable: String {
        return WisdomProtocolCore.getLocalizable(localizable: self as String)
    }
}

extension String {
    
    // MARK: String localizable
    public var localizable: String {
        return WisdomProtocolCore.getLocalizable(localizable: self)
    }
}
