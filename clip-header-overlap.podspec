

Pod::Spec.new do |spec|
  spec.name         = 'clip-header-overlap'
  spec.summary      = 'clip-header-overlap'
  spec.version      = '0.0.1'
  
  spec.ios.deployment_target  = '11.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/568071718/clip-header-overlap'
  spec.authors      = { 'o.o.c.' => '568071718@qq.com' }
  spec.source       = { :git => 'https://github.com/568071718/clip-header-overlap.git', :tag => "v#{spec.version}" }
  
  spec.source_files = 'app/SourceCode/*.{h,m}'
  # spec.framework    = ''
  # spec.dependency 'Masonry'
end
