

# TransitionHandler

<div align = "center">
  <a href="https://cocoapods.org/pods/transition-handler">
    <img src="https://img.shields.io/cocoapods/v/transition-handler.svg?style=flat" />
  </a>
  <a href="https://github.com/incetro/transition-handler">
    <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" />
  </a>
  <a href="https://github.com/incetro/transition-handler#installation">
    <img src="https://img.shields.io/badge/compatible-swift%205.0-orange.svg" />
  </a>
</div>
<div align = "center">
  <a href="https://cocoapods.org/pods/transition-handler" target="blank">
    <img src="https://img.shields.io/cocoapods/p/transition-handler.svg?style=flat" />
  </a>
  <a href="https://cocoapods.org/pods/transition-handler" target="blank">
    <img src="https://img.shields.io/cocoapods/l/transition-handler.svg?style=flat" />
  </a>
  <br>
  <br>
</div>

*TransitionHandler* is an assistant for navigating between VIPER modules.
 
- [Usage](#Usage)
- [Extensions](#extensions)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Authors](#license)

## Usage <a name="Usage"></a>

To use a *TransitionHandler*, all you will need to import `TransitionHandler` module into your swift file:

```
import TransitionHandler
```
##### For example we have:

```
// MARK: - YourViewController

final class YourViewController: UIViewController {
/// Your implementation
}

// MARK: - YourModuleInput

protocol YourModuleInput: ModuleInput {
/// Your implementation
}

// MARK: - YourModule

final class YourModule: AdvancedModule {

        // MARK: - Aliases

        typealias Input = YourModuleInput
        typealias View = YourViewController

        struct Data {
            let someString: String
            let someInt: Int
        }

    static func instantiate(withData data: Data) -> YourViewController {
        /// Your implementation returning view controller
    }
}
```
```
/// Transition handler instance
let transitionHandler: TransitionHandler = UIViewController()
```
### Now you can setup your transition:

```
/// Open module with select presentation, animation and setup output
transitionHandler
    .openModule(YourModule.self)
    .to(.present)
    .animate(true)
    .then { $0.setModuleOutput(moduleOutput) }
```
```
/// Open module with data
transitionHandler
    .openModule(YourModule.self, withData: .init(someString: "something", someInt: 13))
    .perform()
```
```
/// Close current module
transitionHandler
    .closeCurrentModule()
```

### Extensions: <a name="extensions"></a>

*TransitionHandler* come with a couple of extensions: `Optional` and `UIViewController`.
 
These methods will help you easily handle optional objects:

```
// MARK: - Optional

extension Optional {

    /// Unwrap with hint
    func unwrap(
        _ hint: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Wrapped {
        guard let unwrapped = self else {
            var message = "Required value was nil in \(file), at line \(line)"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }

    /// Unwrap with error
    func unwrap(
        _ error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Wrapped {
        guard let unwrapped = self else {
            var message = "Required value was nil in \(file), at line \(line)"
            message.append(". Debugging hint: \(error().localizedDescription)")
            preconditionFailure(message)
        }
        return unwrapped
    }

    /// Unwrap type with hint
    func unwrap<T>(
        as type: T.Type,
        _ hint: @autoclosure () -> String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            if let hint = hint() {
                message.append(". Debugging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }

    /// Unwrap type with error
    func unwrap<T>(
        as type: T.Type,
        _ error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) -> T {
        guard let unwrapped = self as? T else {
            var message = "Cannot convert value to type '\(T.self)'"
            message.append(". Debugging hint: \(error().localizedDescription)")
            preconditionFailure(message)
        }
        return unwrapped
    }
}
```


And these methods allow you to make the work of various manipulations between modules even easier:

```
// MARK: - TransitionHandler

extension UIViewController: TransitionHandler {

    /// Setup module input
    public var moduleInput: ModuleInput? {
        if let provider = self as? ViewOutputProvider {
            if let result = provider.viewOutput {
                return result
            } else {
                fatalError("Your UIViewController must return ModuleInput!")
            }
        } else {
            fatalError("Your UIViewController must implement protocol 'ViewOutputProvider'!")
        }
    }

    /// Open the desired module
    public func openModule<M>(
        _ moduleType: M.Type
    ) -> ViperTransitionPromise<M.Input> where M: Module, M.View: UIViewController {
        let destination = M.instantiate()
        let promise = ViperTransitionPromise(
            source: self,
            destination: destination,
            for: M.Input.self
        )
        promise.promise { [weak self] in
            self?.present(destination, animated: true, completion: nil)
        }
        return promise
    }

    /// Open the desired module with data
    public func openModule<M>(
        _ moduleType: M.Type,
        withData data: M.Data
    ) -> ViperTransitionPromise<M.Input> where M: AdvancedModule, M.View: UIViewController {
        let destination = M.instantiate(withData: data)
        let promise = ViperTransitionPromise(
            source: self,
            destination: destination,
            for: M.Input.self
        )
        promise.promise { [weak self] in
            self?.present(destination, animated: true, completion: nil)
        }
        return promise
    }

    /// Close current module
    public func closeCurrentModule() -> CloseTransitionPromise {
        let close = CloseTransitionPromise(source: self)
        close.promise { [unowned self] in
            if let parent = self.parent {
                if let navigationController = parent as? UINavigationController {
                    if navigationController.children.count > 1 {
                        navigationController.popViewController(animated: close.isAnimated)
                    } else if let presentedViewController = navigationController.presentedViewController {
                        presentedViewController.dismiss(animated: close.isAnimated)
                    } else if navigationController.children.count == 1 {
                        navigationController.dismiss(animated: close.isAnimated)
                    }
                } else {
                    self.removeFromParent()
                    self.view.removeFromSuperview()
                }
            } else if self.presentingViewController != nil {
                self.dismiss(animated: close.isAnimated)
            }
        }
        return close
    }
}

```


## Requirements
- iOS 11.0+
- tvOS 11.0+
- Xcode 12.0
- Swift 5

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Installation <a name="installation"></a>

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To install it using [CocoaPods](https://cocoapods.org), simply add the following line to your Podfile:

```ruby
use_frameworks!

target "<Your Target Name>" do
pod "TransitionHandler", :git => "https://github.com/Incetro/transition-handler]", :tag => "[0.0.1]"
end
```
Then, run the following command:

```bash
$ pod install
```
### Manually

If you prefer not to use any dependency managers, you can integrate *TransitionHandler* into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add *TransitionHandler* as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/incetro/transition-handler.git
  ```

- Open the new `TransitionHandler` folder, and drag the `TransitionHandler.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `TransitionHandler.xcodeproj ` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `TransitionHandler.xcodeproj ` folders each with two different versions of the `TransitionHandler.framework` nested inside a `Products` folder.

- Select the `TransitionHandler.framework`.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Nio` will be listed as either `TransitionHandler iOS`.

- And that's it!

  > The `TransitionHandler.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  


## Authors <a name="authors"></a>

Gasol: 1ezya007@gmail.com, incetro: incetro@ya.ru


## License <a name="license"></a>

*TransitionHandler* is available under the MIT license. See the LICENSE file for more info.
