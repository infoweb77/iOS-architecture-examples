<h1 align="center">iOS architecture examples</h1>

<div align="center">
<strong>Demystifying MVC, MVVM, VIPER, RIBs and many others</strong>
</div>
<div align="center">
 A collection of simple one screen apps to showcase and discuss different architectural approaches in iOS
</div>

<div align="center">
<sub>Built with ❤︎ by Aleksander Shubin</sub>
</div>
<br />
<br />

## Architectures
This repository hosts each sample app in separate directory.

### Single screen app examples
The purpose of having examples with single page applications is highlighting connection between view code and business logic code.

| Example | Description |
| ------------- | ------------- |
| [mvc](mvc) | Standard MVC pattern recommended by Apple. Uses composition design pattern to make `ViewController`  smaller.  (README in progress)  |
| [mvp](mvp) | Standard MVP pattern.  (README in progress)    |
| [mvvm-rxswift-pure](mvvm-rxswift-pure) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) and observables as binding mechanism between `ViewController` and `ViewModel`. |
| [mvvm-rxswift-subjects-observables](mvvm-rxswift-subjects-observables) | Uses [RxSwift](https://github.com/ReactiveX/RxSwift) with observables as `ViewModel` outputs and subjects as `ViewModel` inputs. |
| [mvvm-closures](mvvm-closures) | Binds `ViewController` and `ViewModel` using closures and swift functions (README in progress)  |
| [rxfeedback-mvc](rxfeedback-mvc) | Uses RxFeedback in MVC architecture  (README in progress)    |
| [viper](viper) | Uses VIPER architecture (README in progress) |

## Licence
MIT.
