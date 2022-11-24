Pod::Spec.new do |s|
  s.name         = "WisdomProtocol"
  s.version      = "0.0.3"
  s.summary      = "A Protocol of Wisdom SDK"
  s.description  = "A Protocol of Wisdom SDK. Support protocol routing.Support dictionary /Json, encoding/decoding, turn model."

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
