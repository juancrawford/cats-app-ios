//
//  Cat.swift
//  CatsApp
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import Foundation

let catMock = Cat(
    breeds: [
        Breed(
            weight: Weight(imperial: "6 - 15", metric: "3 - 7"),
            id: "birm",
            name: "Birman",
            description: "The Birman is a docile, quiet cat who loves people and will follow them from room to room. Expect the Birman to want to be involved in what you’re doing. He communicates in a soft voice, mainly to remind you that perhaps it’s time for dinner or maybe for a nice cuddle on the sofa. He enjoys being held and will relax in your arms like a furry baby."
        )
    ],
    id: "2LEN_GHmx",
    url: "https://cdn2.thecatapi.com/images/2LEN_GHmx.jpg",
    width: 1600,
    height: 1200
)

struct Cat: Codable, Identifiable {
    var breeds: [Breed]
    var id: String
    var url: String
    var width: Int
    var height: Int
}
