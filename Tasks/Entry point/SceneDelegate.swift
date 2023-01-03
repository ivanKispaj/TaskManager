//
//  SceneDelegate.swift
//  Tasks
//
//  Created by Ivan Konishchev on 02.01.2023.
//

import Foundation
import SwiftUI

enum ScreenOrientation {
    case lanscape
    case portrait
}
class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    
    var window: UIWindow?
    @Published private(set) var sceneSize: CGRect?
    @Published private(set) var screenOrientation: ScreenOrientation?
    func scene( _ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions ) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            sceneSize = window.screen.bounds
            if let width = sceneSize?.width , let height = sceneSize?.height, width < height {
                screenOrientation = .portrait
            } else {
                screenOrientation = .portrait
            }
        }
    }
}
