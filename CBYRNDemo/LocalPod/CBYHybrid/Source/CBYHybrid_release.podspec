Pod::Spec.new do |spec|
	spec.name         = 'CBYHybrid'
	spec.version      = '1.0.0'
	spec.description  = '封装了RN框架以及一些第三方依赖，可直用于构建ReactNative工程。其中第三方依赖包含(ART,react-image-crop-picker,react-native-svg,react-native-video,react-native-picker等)'
	spec.summary      = 'CBYHybrid Framework'
	spec.homepage     = 'https://'
	spec.author       = { 'Author' => 'Author' }
	spec.source           = { :svn => 'https://192.0.0.241/Civil-Platform/Mobile/common/ios/YS7RemoteRepos/CBYHybrid/branches/1.0.0'}
	spec.source_files = ['CBYHybrid/**/*.{h,m,mm,c}','code/**/*.{h,m,mm,c}']
	spec.prefix_header_file ='CBYHybrid/CBYHybridPch.pch'
	spec.vendored_frameworks = 'CBYHybrid/*.{framework}','ReleaseVender/*.framework','ReleaseVender/RN/*.framework','BaiDu/*.framework'
	spec.vendored_libraries = ['CBYHybrid/ReactLib/*.a','CBYHybrid/vender/*.a','Vender/**/*.a','thirdlibs/**/*.a']
	spec.resources = ['CBYHybrid/**/*.{bundle,storyboard,strings}','Resource/**/*.{bundle,storyboard,strings,plist,png}']
	spec.ios.deployment_target = '8.0'
	spec.requires_arc = true
	spec.libraries = "z","c++","c"
	spec.frameworks = ['JavaScriptCore']
	
end
