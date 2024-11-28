//
//  HomeView.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/23/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink("Work Orders", destination: Text("next"))
            }
            .navigationTitle("Recent")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct HomeViewTests_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
