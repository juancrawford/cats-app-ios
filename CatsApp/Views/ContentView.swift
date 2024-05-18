//
//  ContentView.swift
//  CatsApp
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import Foundation
import SwiftUI

// A view representing the main content of the CatsApp.
struct ContentView: View {
    // The network manager responsible for fetching cat data.
    @ObservedObject var networkManager = NetworkManager()
    
    // The body of the content view.
    var body: some View {
        // Navigation view for navigating between views.
        NavigationView {
            // Vertical stack to layout the content vertically.
            VStack {
                // If loading, display a loading message.
                if networkManager.isLoading {
                    Text("Loading ...")
                } else {
                    // If not loading, display a list of cats.
                    List {
                        ForEach(networkManager.cats) { cat in
                            // Navigation link to navigate to the detail view.
                            NavigationLink(destination: DetailView(cat: cat)) {
                                // Item view representing each cat in the list.
                                ItemView(cat: cat)
                                    .onAppear {
                                        // Fetch more cats if current item is at the end of the list.
                                        networkManager.getCatsIfNeeded(currentItem: cat)
                                    }
                            }
                        }
                        // If loading page, display a progress view.
                        if networkManager.isLoadingPage {
                            ProgressView()
                        }
                    }
                }
            }
            // Set the navigation bar title.
            .navigationBarTitle(Text("CatsApp"))
        }
    }
}

#Preview {
    ContentView()
}
