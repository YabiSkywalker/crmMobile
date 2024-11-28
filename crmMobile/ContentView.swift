import SwiftUI



struct ContentView: View {
    @State var selectedTab = 1

    var body: some View {
        ZStack {
            // Use system background color that adapts to dark mode
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            TabView(selection: $selectedTab) {
                // Home Tab
                VStack {
                    Text("TBD")
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)

                // Tickets Tab
                VStack {
                    TicketsView()
                }
                .tabItem {
                    Image(systemName: "menucard")
                    Text("Jobs")
                }
                .tag(1)

                // Customers Tab
                CustomersView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Customers")
                    }
                    .tag(2)

                // Billing Tab
                Text("Welcome")
                    .foregroundColor(.primary) // Use system color for text
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Billing")
                    }
                    .tag(3)
            }
            .background(Color(.systemBackground))
            .accentColor(.blue) // Set the accent color
        }
    }
}



#Preview {
    ContentView()
}
