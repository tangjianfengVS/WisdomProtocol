Pod::Spec.new do |s|
  s.name         = "WisdomProtocol"
  s.version      = "0.1.5"
  s.summary      = "A Protocol of Wisdom SDK"
  s.description  = "A Protocol of Wisdom SDK. Support Class/Param/UIViewController/UIView router protocol. Support dictionary/Json, model coding conversion. Support OC/Swift Class timer timer/countdown task protocol. Support catch tracking OC/Swift Class run crash error, log trace. Support tracking UIViewController viewDidAppear/viewDidDisappear display time duration statistics."

  s.homepage     = "https://github.com/tangjianfengVS/WisdomProtocol"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "tangjianfeng" => "497609288@qq.com" }

  s.platform     = :ios, "9.0"
  s.swift_version= '5.0'
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = " "
  # s.watchos.deployment_target = " "
  # s.tvos.deployment_target = " "
  s.source       = { :git => "https://github.com/tangjianfengVS/WisdomProtocol.git", :tag => s.version }
  s.source_files  = "Source/*.swift", "Source/*.{h,m}"
end
