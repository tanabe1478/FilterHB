
# coding: utf-8
# Uncomment the next line to define a global platform for your project
 platform :ios, '12.1'

target 'FileterHB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings! # ライブラリの警告を非表示にする
  # Pods for FileterHB
  pod 'XLPagerTabStrip'
  # 画像の表示、キャッシュ
  pod 'SDWebImage'
  # Rx
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'

  target 'FileterHBTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

end

target 'Models' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings! # ライブラリの警告を非表示にする
  # Pods for Models

  pod 'RealmSwift'
  # Rx
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'

  target 'ModelsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

end
