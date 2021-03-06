//
//  SceneDelegate.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/03/16.
//

import UIKit
import FirebaseAuth
import Lottie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var userVerified = false
    let defaults = UserDefaults.standard

    var theVC = UIViewController()
    let navi = UINavigationController(rootViewController: ViewController())
    
    
    
    fileprivate func getUserverified() -> Bool{
        let verified : [Verified] = CoreDataManager.shared.getVerified()
        print("dddddd")
        
        print("now sssssss",verified)
        return verified[0].emailVerified
    }
    
    func checkFirstOrnot(){
        if defaults.bool(forKey: "First Launch") == true {
            print("Second+")
            userVerified =  getUserverified()
            print("๊ทธ๋์ USER verified ", userVerified)
            defaults.set(true, forKey: "FirstLaunch")
            
        } else {
            print("First")
            //save
            CoreDataManager.shared.saveVerified(emailVerified: false){
            onSuccess in print("saved = \(onSuccess)")
                }

            defaults.set(true, forKey: "First Launch")
        }
        print("so now verified is ", userVerified)
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
        //case2 ์ฃผ์ ์ฒ๋ฆฌ ๋ ์ง๊ธ ์คํํ๋ฉด ๋ณด๋ด์ค ์์์ฒ๋ผ navigationcontroller ์ ์ฐ๊ฒฐ ๋จ
        //rootview ์ค์? ๋ฌธ์? ๊ฐ์๋ฐ ์ด ๊ฑฐ ์ ๋ชจ๋ฅด๊ฒ?์ด
//        let navi = UINavigationController(rootViewController: ViewController())
//        navi.viewControllers = [ViewController(),MissionViewController()]
        
        //MARK: - CASE 2
        
  
        
        if userVerified == true { //์ธ์ฆ์ด ์๋ฃ๋ ์ฌ์ฉ์ // ๋ค๋น๋ก ์ฐ๊ฒฐ
            theVC =  navi
            print("verified")
        }
        else { //์ธ์ฆ์ด ์๋ฃ๋์ง ์์ ์ฌ์ฉ์
            theVC =  FirstViewController()
            // ์ด๊ฑธ ์ด๋์๋ทฐ๋ก ํ๊ณ? navi root ์ค์? ์ด๋ป๊ฒ ํ? ์ง ๊ณ?๋ฏผํด๋ด์ผํ? ๋ฏ
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

