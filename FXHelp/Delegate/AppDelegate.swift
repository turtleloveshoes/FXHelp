//
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		if UserDefaults.standard.bool(forKey: "checked"){
			window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
		}else{
			window?.rootViewController = UINavigationController(rootViewController: IntroController())
		}
		
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().barTintColor = .black
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
		
		let statusBarBackgroundView = UIView()
		statusBarBackgroundView.backgroundColor = .black
		
		window?.addSubview(statusBarBackgroundView)
		
		application.statusBarStyle = .lightContent
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		
	}
		
}
