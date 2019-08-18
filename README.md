<h1 align="center">iOS architecture examples</h1>

<div align="center">
<strong>MVC, MVP, MVVM, VIPER, Redux and others by examples</strong>
</div>
<div align="center">
 A collection of simple one screen weather apps to showcase and discuss different architectural approaches in iOS
</div>

<br />

<div align="center">
<!-- Last commit -->
<img src="https://img.shields.io/github/last-commit/infoweb77/ios-architecture-examples.svg" alt="last commit"/>
<!-- Swift version -->
<img src="https://img.shields.io/badge/swift%20version-4.2-brightgreen.svg" alt="swift version">
<!-- Platform -->
<img src="https://img.shields.io/badge/platform-ios-lightgrey.svg" alt="platform" />
<!-- License -->
<img src="https://img.shields.io/badge/licence%20-MIT%20-blue.svg" alt="license" />
</div>

<br />
<br />

### Architectures
This repository hosts each sample app in separate directory.

<br />

### Single screen app examples
The purpose of having examples with single page applications is highlighting connection between view code and business logic code.

| Example | Description |
| ------------- | ------------- |
| [mvc](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVC) | Standard MVC pattern recommended by Apple. Uses composition design pattern to make `ViewController`  smaller.  |
| [mvp](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVP) | Standard MVP pattern.    |
| [mvvm-closures](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-Closures) | Binds `ViewController` and `ViewModel` using closures and swift functions  |
| [mvvm-rxswift-pure](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-RxSwift) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) and observables as binding mechanism between `ViewController` and `ViewModel`. |
| [mvvm-rxswift-subjects-observables](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-Subjects-Observables) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) with observables as `ViewModel` outputs and subjects as `ViewModel` inputs. |
| [reactorkit](https://github.com/infoweb77/iOS-architecture-examples/tree/master/Reactor) | Uses ReactorKit as a framework for a reactive and unidirectional Swift application architecture.  |
| [rxfeedback-mvc](https://github.com/infoweb77/iOS-architecture-examples/tree/master/RxFeedback-MVC) | Uses RxFeedback in MVC architecture      |
| [viper](https://github.com/infoweb77/iOS-architecture-examples/tree/master/VIPER) | Uses VIPER architecture  |

<br />

### Licence
MIT.
