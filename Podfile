# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def rx_pods 
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxFeedback'
end

def core_pods
    rx_pods
    pod 'Prelude'
end

def test_pods 
    pod 'RxTest'
    pod 'RxBlocking'
end

target 'NASA' do
    use_frameworks!
    core_pods
  
    target 'NASATests' do
      core_pods
      test_pods
    end
  end

target 'APOD' do
  use_frameworks!
  core_pods

  target 'APODTests' do
    core_pods
    test_pods
  end
end

target 'Core' do
  use_frameworks!
  core_pods

  target 'CoreTests' do
    core_pods
    test_pods
  end
end
