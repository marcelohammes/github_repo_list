platform :ios, '13.0'
inhibit_all_warnings!

target 'GithubRepoListTests' do
    use_frameworks!
    pod "iOSSnapshotTestCase"
end

target 'GithubRepoListKIFTests' do
  pod 'KIF', :configurations => ['Debug']
end
