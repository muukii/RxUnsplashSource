Pod::Spec.new do |s|
  s.name             = "RxUnsplashSource"
  s.version          = "0.1.0"
  s.summary          = "Unsplash Source with RxSwift"
  s.description      = "Get high resolution image from Unsplash Source with RxSwift"
  s.homepage         = "https://github.com/muukii/RxUnsplashSource"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/RxUnsplashSource.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.requires_arc = true

  s.source_files = 'RxUnsplashSource/*.swift'
  s.dependency 'RxSwift', '~> 2.0'
end
