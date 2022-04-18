//
//  SceneDelegate.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var verified = false
    
    var theVC = UIViewController()
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
        let window = UIWindow(windowScene: windowScene)
        
        //MARK: - CASE 1
        //case2 주석 처리 된 지금 실행하면 보내준 영상처럼 navigationcontroller 잘 연결 됨
        //rootview 설정 문제 같은데 이 거 잘 모르겠어 스바루
        
        
        //MARK: - CASE 2
        if verified == true { //인증이 완료된 사용자 // 네비로 연결
            let rootViewcontroller = UINavigationController(rootViewController:ViewController())
            window.rootViewController = rootViewcontroller
            print("verified")
        }
        else { //인증이 완료되지 않은 사용자
            theVC =  FirstViewController()
            window.rootViewController = theVC // Your initial view controller.
        }

        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

