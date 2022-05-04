//
//  SceneDelegate.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var userVerified = false
    let defaults = UserDefaults.standard

    var theVC = UIViewController()
    let navi = UINavigationController(rootViewController: ViewController())
    
    
    fileprivate func getUserverified() {
        let verified : Verified = CoreDataManager.shared.getVerified()
        userVerified = verified.emailVerified
    }
    
    func checkFirstOrnot(){
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            getUserverified()
            defaults.set(true, forKey: "FirstLaunch")
            
        } else {
            print("First")
            //save
            CoreDataManager.shared.saveVerified(emailVerified: false){
            onSuccess in print("saved = \(onSuccess)")
                }

            defaults.set(true, forKey: "First Launch")
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let webpageURL = userActivity.webpageURL else { return }
        let link = webpageURL.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            UserDefaults.standard.set(link, forKey: "Link")
        }
        print(userActivity.webpageURL)
        /*
         https://exemaillogin.page.link/?link=https://sample-9ca7b.firebaseapp.com/__/auth/action?apiKey%3DAIzaSyDkfsdsd6cdah83MZtMEllERKqWJcV3os14%26mode%3DsignIn%26oobCode%3DcZ-xm1p4pXDuKmSvQ7DqxkcQQYzMLqBR0l331QBZA08AAAF9NeZFOA%26continueUrl%3Dhttps://sample-9ca7b.firebaseapp.com/?email%253Dpalatable7@naver.com%26lang%3Den&ibi=com.jake.ExEmailLogin&ifl=https://sample-9ca7b.firebaseapp.com/__/auth/action?apiKey%3DAIzaSyDkZ2b76cdah83MZtMEllERKqWJcV3os14%26mode%3DsignIn%26oobCode%3DcZ-xm1p4pXDuKmSvQ7DqxkcQQYzMLqBR0l331QBZA08AAAF9NeZFOA%26continueUrl%3Dhttps://sample-9ca7b.firebaseapp.com/?email%253Dpafdsable7@naver.com%26lang%3Den
         */
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
        checkFirstOrnot()
        
        let window = UIWindow(windowScene: windowScene)
        
        //MARK: - CASE 1
        //case2 주석 처리 된 지금 실행하면 보내준 영상처럼 navigationcontroller 잘 연결 됨
        //rootview 설정 문제 같은데 이 거 잘 모르겠어
//        let navi = UINavigationController(rootViewController: ViewController())
//        navi.viewControllers = [ViewController(),MissionViewController()]
        
        //MARK: - CASE 2
        if userVerified == true { //인증이 완료된 사용자 // 네비로 연결
            theVC =  navi
            print("verified")
        }
        else { //인증이 완료되지 않은 사용자
            theVC =  FirstViewController()
            // 이걸 이니셜뷰로 하고 navi root 설정 어떻게 할 지 고민해봐야할 듯
        }
        window.rootViewController = theVC
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

