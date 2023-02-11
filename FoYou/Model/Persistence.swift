//
//  Persistence.swift
//  FoYou
//
//  Created by Jason Kenneth on 11/02/23.
//

import CoreData

class Persistence: ObservableObject {
    let container = NSPersistentContainer(name: "FoYou")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
