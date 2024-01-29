Pod::Spec.new do |s|
  s.name      = 'WisdomProtocol'
  s.version   = '0.2.5'
  s.license   = { :type => "MIT", :file => "LICENSE" }
  s.authors   = { 'tangjianfeng' => '497609288@qq.com' }
  s.homepage  = 'https://github.com/tangjianfengVS/WisdomProtocol'
  s.source    = { :git => 'https://github.com/tangjianfengVS/WisdomProtocol.git', :tag => s.version }
  s.summary   = 'A Protocol of Wisdom SDK'

  s.description   = 'A Protocol of Wisdom SDK. Support Class/Param/UIViewController/UIView router protocol. Support dictionary/Json, model coding conversion. Support OC/Swift Class timer timer/countdown task protocol. Support catch tracking OC/Swift Class run crash error, log trace. Support tracking UIViewController viewDidAppear/viewDidDisappear display time duration statistics.'

  s.platform      = :ios, '9.0'
  s.swift_version = ['5.5', '5.6', '5.7']

  s.ios.deployment_target = '9.0'
  # s.osx.deployment_target = ''
  # s.watchos.deployment_target = ''
  # s.tvos.deployment_target = ''

  #s.source_files  = 'Source/*.swift', 'Source/*.{h,m}'
  s.dependency 'RCBacktrace', '0.1.7'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Source/Core/*.swift', 'Source/Core/*.{h,m}'
  end

  s.subspec 'Router' do |ss|
    ss.dependency 'WisdomProtocol/Core'
    ss.source_files = 'Source/Router/*.swift', 'Source/Router/*.{h,m}'
  end

end
