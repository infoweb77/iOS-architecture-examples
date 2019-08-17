<h1 align="center">iOS architecture examples</h1>

<div align="center">
<strong>Demystifying MVC, MVP, MVVM, VIPER, Redux and many others</strong>
</div>
<div align="center">
 A collection of simple one screen apps to showcase and discuss different architectural approaches in iOS
</div>

<div align="center">
<sub>Built with ❤︎ by Aleksander Shubin</sub>
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
| [mvc](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVC) | Standard MVC pattern recommended by Apple. Uses composition design pattern to make `ViewController`  smaller.  (README in progress)  |
| [mvp](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVP) | Standard MVP pattern.  (README in progress)    |
| [mvvm-closures](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-Closures) | Binds `ViewController` and `ViewModel` using closures and swift functions (README in progress)  |
| [mvvm-rxswift-pure](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-RxSwift) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) and observables as binding mechanism between `ViewController` and `ViewModel`. |
| [mvvm-rxswift-subjects-observables](https://github.com/infoweb77/iOS-architecture-examples/tree/master/MVVM-Subjects-Observables) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) with observables as `ViewModel` outputs and subjects as `ViewModel` inputs. |
| [reactorkit](https://github.com/infoweb77/iOS-architecture-examples/tree/master/Reactor) | Uses ReactorKit as a framework for a reactive and unidirectional Swift application architecture.  (README in progress)  |
| [rxfeedback-mvc](https://github.com/infoweb77/iOS-architecture-examples/tree/master/RxFeedback-MVC) | Uses RxFeedback in MVC architecture  (README in progress)    |
| [viper](https://github.com/infoweb77/iOS-architecture-examples/tree/master/VIPER) | Uses VIPER architecture (README in progress) |

<br />

### Licence
MIT.
