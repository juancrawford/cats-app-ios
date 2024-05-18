//
//  DetailView.swift
//  CatsApp
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import SwiftUI
import URLImage

// A view representing detailed information about a cat.
struct DetailView: View {
    // The cat object associated with this detail view.
    var cat: Cat
    
    // The body of the detail view.
    var body: some View {
        // Vertical scroll view to enable scrolling vertically.
        ScrollView(.vertical) {
            // Vertical stack to layout the content vertically.
            VStack {
                // Display the cat image using URLImage.
                URLImage(URL(string: cat.url)!) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width - 30)
                        .clipped()
                }
                // Horizontal stack for the description title.
                HStack {
                    Text("Description")
                        .foregroundColor(.black)
                        .font(.title2)
                    Spacer()
                }
                .padding(.vertical, 10)
                // Display the cat description.
                Text(cat.breeds.first?.description ?? "")
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                Spacer()
            }
            // Set the navigation bar title with the cat's name.
            .navigationBarTitle(Text(cat.breeds.first?.name ?? ""), displayMode: .inline)
            .padding()
        }
    }
}

#Preview {
    DetailView(cat: catMock)
}
