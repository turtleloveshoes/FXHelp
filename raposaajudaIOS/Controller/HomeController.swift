//
//
//

import UIKit

class HomeController: UIViewController, DelegateOfMenuSettings {
	
	let menuBar: MenuBar = {
		let mb = MenuBar()
		mb.translatesAutoresizingMaskIntoConstraints = false
		return mb
	}()
	
	lazy var settings: MenuSettingsView = {
		let st = MenuSettingsView.init(frame: UIScreen.main.bounds)
		st.delegate = self
		return st
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.isTranslucent = false
		let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - UIConstants.halfWidthScreen, height: view.frame.height))
		title.text = "Home"
		title.textColor = .white
		navigationItem.titleView = title
		
		view.backgroundColor = .white
		
		setupMenu()
		iconMore()
	}
	
	private func setupMenu(){
		view.addSubview(menuBar)
		
		let horizontalMenu = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: .alignAllCenterX, metrics: nil, views: ["v0": menuBar])
		let verticalMenu = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(60)]|", options: .alignAllCenterY, metrics: nil, views: ["v0": menuBar])
		
		view.addConstraints(horizontalMenu)
		view.addConstraints(verticalMenu)
	}
	
	func openSettings(){
		if let window = UIApplication.shared.keyWindow {
			window.addSubview(self.settings)
			self.settings.animateMenu()
		}
	}
	
	func hideMenuSettings(status: Bool) {
		if status == true {
			self.settings.removeFromSuperview()
		}
	}
	
	func iconMore(){
		let icon	= UIBarButtonItem(image: #imageLiteral(resourceName: "icon_more"), style: .plain, target: self, action: #selector(openSettings))
		icon.tintColor = .white
		navigationItem.leftBarButtonItem = icon
	}
}
