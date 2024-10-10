//
//  ContentView.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var selectedTab = 1
    
    var body: some View {
        
        
        TabView(selection: $selectedTab) {
                    
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
                        VStack {
                            TicketsView()
                            .foregroundColor(.gray)
                        }
                        .tabItem {
                            Image(systemName: "menucard")
                            Text("Tickets")
                        }
                        .tag(1)
                    
                        CustomersView()
                        .tabItem {
                            Image(systemName: "person.2")
                            Text("Customers")
                        }
                        .tag(2)
                    
                    Text("Welcome")
                        .tabItem {
                            Image(systemName: "creditcard")
                            Text("Billing")
                        }
                        .tag(3)
                }
                .padding()
                .preferredColorScheme(.dark)
        
        
        
    }
        
}
    

#Preview {
    ContentView()
}
