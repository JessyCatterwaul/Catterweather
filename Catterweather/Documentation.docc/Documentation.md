# ``Catterweather``

A weather tracker app demonstrating Jessy Catterwauls's skills in Swift, SwiftUI, and clean architecture.

## Overview

While you *can* use this documentation to peruse the app's code, working on the documentation catalog was out of scope for the assignment. So it's better to just open the Xcode project.

You can build and run to device or Simulator as you please.

#### Architecture Notes

Unit tests can be found in the `WeatherAPITests` file in the **CatterweatherTests** target.

---

The simple [App](<doc:App>) file launches a [HomeView.Stack](<doc:HomeView/Stack>), whose initializer creates a [HomeView.Model](<doc:HomeView/Model>). That is an [Observable](https://developer.apple.com/documentation/observation/observable) view model dependency-injected as an [environment object](https://developer.apple.com/documentation/swiftui/view/environment(_:)). It may store a [Location](<doc:Location>), which is persisted using SwiftData via conversion to [Location.PersistentModel](<doc:Location/PersistentModel>).
  
*Note the two `TODO`s in the project, related to persistence. I'd want to chat with the designer(s) about what they'd like to see in the case that SwiftData were ever to throw unlikely errors.*

#### Timing

I spent three and a half hours on this project, then spent another hour and a half, cleaning up and documenting, before sending it over. Some of that involved Git history rebasing, which I thought might be helpful in showing my thought processes better. The Git commit timestamps are all the same, because otherwise some of the flow would have been nonsensical.    
