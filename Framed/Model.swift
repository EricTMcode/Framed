//
//  Model.swift
//  Framed
//
//  Created by Eric on 07/01/2025.
//

import SwiftData

@Model
class Album {
    var name: String
    var photos: [String]
    var speed: Int

    init(name: String, photos: [String], speed: Int) {
        self.name = name
        self.photos = photos
        self.speed = speed
    }
}
