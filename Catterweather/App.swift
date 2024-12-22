import SwiftUI

@main struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup(makeContent: HomeView.Stack.init)
  }
}
