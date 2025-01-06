//
//  FramedApp.swift
//  Framed
//
//  Created by Eric on 06/01/2025.
//

import SwiftData
import SwiftUI

@main
struct FramedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Album.self)
    }
}
