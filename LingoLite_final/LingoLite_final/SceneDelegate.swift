import UIKit
import SwiftUI
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let isSignedIn = Auth.auth().currentUser != nil

        let rootViewController: UIViewController

        if isSignedIn {
            rootViewController = UINavigationController(
                rootViewController: UIHostingController(rootView: HomeView())
            )
        } else {
            rootViewController = UINavigationController(
                rootViewController: UIHostingController(rootView: SignInView())
            )
        }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
