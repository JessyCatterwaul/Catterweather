import SwiftUI

@main struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      // TODO: Ask the designer(s) what they would like to display in the unlikely event of disk corruption.
      try? HomeView.Stack()
    }
  }
}
