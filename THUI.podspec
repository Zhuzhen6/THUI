Pod::Spec.new do |s|
s.name        = 'THUI'
s.version     = '1.0.4'
s.authors     = { 'ZhuZhen' => '295111806@qq.com' }
s.homepage    = 'https://github.com/Zhuzhen6/THUI'
s.summary     = 'a tool menu for ios like wechat homepage.'
s.source      = { :git => 'https://github.com/Zhuzhen6/THUI.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '10.0'
s.requires_arc = true
s.source_files = 'THUIDemo/THUI/**/*.{h,m}'
s.public_header_files = 'THUIDemo/THUI/**/*.h'
s.ios.deployment_target = '10.0'
end
