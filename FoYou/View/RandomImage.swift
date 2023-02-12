//
//  RandomImage.swift
//  FoYou
//
//  Created by Jason Kenneth on 13/02/23.
//

import SwiftUI

struct RandomImage: View {

@State var random: String = ""

var body: some View {
    VStack {

        Image(systemName: random)

        Button(action: {
            self.random = chooseRandomImage()
        }) {
            Text("Another one!")
        }

    }


}
}

var images = ["sun.max.fill", "moon.fill", "star.fill"]

func chooseRandomImage() -> String {
    let array = images

    let result = array.randomElement()!

    return result
}
struct RandomImage_Previews: PreviewProvider {
    static var previews: some View {
        RandomImage()
    }
}
