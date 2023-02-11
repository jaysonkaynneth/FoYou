//
//  FoYouApp.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import SwiftUI

@main
struct FoYouApp: App {
    let persistence = Persistence()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
