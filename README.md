# RxUnsplashSource

[![CI Status](http://img.shields.io/travis/muukii/RxUnsplashSource.svg?style=flat)](https://travis-ci.org/muukii/RxUnsplashSource) [![Version](https://img.shields.io/cocoapods/v/RxUnsplashSource.svg?style=flat)](http://cocoapods.org/pods/RxUnsplashSource) [![License](https://img.shields.io/cocoapods/l/RxUnsplashSource.svg?style=flat)](http://cocoapods.org/pods/RxUnsplashSource) [![Platform](https://img.shields.io/cocoapods/p/RxUnsplashSource.svg?style=flat)](http://cocoapods.org/pods/RxUnsplashSource)

Get photo form [Unsplash Source](https://source.unsplash.com/) with [RxSwift](https://github.com/ReactiveX/RxSwift)

## Basic Usage

- Get random photo

```swift
RxUnsplashSource.random(size: UIScreen.mainScreen().bounds.size)
    .bindTo(imageView.rx_image)
```

- Get random photo from category

```swift
RxUnsplashSource
    .random(
        category: .Food,     
        size: UIScreen.mainScreen().bounds.size
    )
    .bindTo(imageView.rx_image)
```

## Advanced Usage

- Change the image every minute

```swift

Observable<Int>
    .interval(60, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Default))
    .startWith(0)
    .flatMap { _ in RxUnsplashSource.random(size: UIScreen.mainScreen().bounds.size) }
    .bindTo(imageView.rx_image)

```

## Installation

```ruby
pod "RxUnsplashSource"
```

## Author
muukii, m@muukii.me

## License
RxUnsplashSource is available under the MIT license. See the LICENSE file for more info.
