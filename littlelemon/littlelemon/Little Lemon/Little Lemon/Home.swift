import SwiftUI

struct Home: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(isLoggedIn: .constant(true))
    }
}
