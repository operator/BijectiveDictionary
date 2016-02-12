Pod::Spec.new do |s|
  s.name                = 'BijectiveDictionary'
  s.version             = '1.0.3'
  s.summary             = 'A dictionary that preserves the uniqueness of both its keys and its values.'
  s.homepage            = 'https://github.com/Operator/BijectiveDictionary'
  s.license             = 'MIT'
  s.authors             = { 'Peter Meyers' => 'meyers@operator.com', 'Zach Langley' => 'zach@operator.com' }
  s.source              = { git: 'https://github.com/Operator/BijectiveDictionary.git', tag: s.version.to_s }
  s.platform            = :ios, '5.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc        = true
  s.source_files        = 'Pod/Classes/*.{h,m}'
  s.public_header_files = 'Pod/Classes/*.h'
  s.ios.frameworks      = 'Foundation'

  s.subspec 'OPCCopying' do |ss|
    ss.source_files = 'Pod/Classes/OPCCopying/OPCCopying.h'
    ss.public_header_files = 'Pod/Classes/OPCCopying/OPCCopying.h'
  end

end
