//
//  MovieDBSwiftUIApp.swift
//  MovieDBSwiftUI
//
//  Created by Surya Rayala on 2/18/26.
//

import SwiftUI

@main
struct MovieDBSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    handleDeepLink(url)
                }
        }
    }
    
    func handleDeepLink(_ url: URL) {
        print("Handling deep link to: \(url)")
    }
}
