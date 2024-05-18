//
//  ItemView.swift
//  CatsApp
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import SwiftUI
import URLImage

// A view representing an item in the list of cats.
struct ItemView: View {
    // The cat object associated with this item view.
    var cat: Cat
    
    // The body of the item view.
    var body: some View {
        // Horizontal stack to layout the image and text content horizontally.
        HStack(alignment: .center) {
            // Display the cat image using URLImage.
            URLImage(URL(string: cat.url)!) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 86, height: 86)
                    .clipped()
            }
            // Vertical stack to layout the text content vertically.
            VStack {
                // Horizontal stack for the cat name.
                HStack {
                    Text(cat.breeds.first?.name ?? "")
                        .foregroundColor(.black)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                }
                // Horizontal stack for the cat description.
                HStack {
                    Text(cat.breeds.first?.description ?? "")
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    Spacer()
                }
            }
        }
        // Set the height of the item view.
        .frame(height: 100)
    }
}

#Preview {
    ItemView(cat: catMock)
}

