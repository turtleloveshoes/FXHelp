//
//
//

import UIKit

class MenuSettingsController: NSObject, UITableViewDelegate, UITableViewDataSource {
	
	let cellID = "cellID"
	let settingsOptions = ["Notifications", "Feedback", "About", "Cancel"]
	
	lazy var settingsTableView: UITableView = {
		let tv = UITableView(frame: .zero, style: UITableViewStyle.plain)
		tv.separatorStyle = .none
		tv.backgroundColor = .white
		tv.showsVerticalScrollIndicator = false
		tv.isScrollEnabled = false
		tv.delegate = self
		tv.dataSource = self
		tv.translatesAutoresizingMaskIntoConstraints = false
		return tv
	}()
	
	lazy var backgroundView: UIView = {
		let bv = UIView()
		bv.backgroundColor = .black
		bv.alpha = 0
		return bv
	}()

	var homeController: HomeController?
	
	override init() {
		super.init()
		settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellID)
	}
	
	func showSettings() {
		if let window = UIApplication.shared.keyWindow {
			backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
			backgroundView.frame = window.frame
			backgroundView.alpha = 0
			backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
			window.addSubview(backgroundView)
			window.addSubview(settingsTableView)
			
			let settingsTableViewHeight = 50 * CGFloat(settingsOptions.count)
			settingsTableView.frame = CGRect(x: UIConstants.widthScreen/22, y: UIConstants.heightScreen/3, width: window.frame.width/1.1, height: settingsTableViewHeight)
			
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .beginFromCurrentState, animations: {
				self.backgroundView.alpha = 0.9
				self.settingsTableView.alpha = 1
				self.settingsTableView.frame.origin.x = UIConstants.widthScreen/22
				self.settingsTableView.frame.origin.y = UIConstants.heightScreen/3
			}, completion: nil)
		}
	}
	
	@objc func dismissMenu() {
		UIView.animate(withDuration: 0.5) {
			self.backgroundView.alpha = 0
			self.settingsTableView.alpha = 0
		}
	}
	
	// MARK: - UITableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return settingsOptions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = settingsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SettingsTableViewCell
		cell.textLabel?.text = settingsOptions[indexPath.item]
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		settingsTableView.deselectRow(at: indexPath, animated: true)
		
		UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionCurlDown, animations: {
			self.backgroundView.alpha = 0
			self.settingsTableView.alpha = 0
		}) { (completed) in
			if completed {
				if indexPath.item != self.settingsOptions.count - 1 {
					self.homeController?.showSettingsController((self.settingsTableView.cellForRow(at: indexPath)?.textLabel?.text))
				}
			}
		}
	}
}
