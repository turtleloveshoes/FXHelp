//
//  
//

import UIKit

protocol DelegateOfMenuSettings {
	func hideMenuSettings(status : Bool)
}

private let cellMenu = "cellMenu"

class MenuSettingsView: UIView {

	var delegate: DelegateOfMenuSettings?
	
	let names = ["Notifications", "Send Feedback", "About", "Cancel"]
	let icons = ["notifications", "feedback", "about", "cancel"]
	
	lazy var tableView: UITableView = {
		let tv = UITableView.init(frame: CGRect.init(x: 0, y: self.bounds.height, width: self.bounds.width, height: UIConstants.menuSettings))
		tv.isScrollEnabled = false
		tv.delegate = self
		tv.dataSource = self
		return tv
	}()
	
	lazy var backgroundView: UIView = {
		let bv = UIView.init(frame: self.frame)
		bv.backgroundColor = .black
		bv.alpha = 0
		return bv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(MenuSettingsView.dismissMenu)))
		self.addSubview(backgroundView)
		self.addSubview(tableView)
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellMenu)
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.tableView.separatorStyle = .none
	}
	
	func animateMenu()  {
		UIView.animate(withDuration: 0.3, animations: {
			self.tableView.frame.origin.y -= UIConstants.menuSettings
			self.backgroundView.alpha = 0.6
		})
	}
	
	func  dismissMenu()  {
		UIView.animate(withDuration: 0.3, animations: {
			self.backgroundView.alpha = 0
			self.tableView.frame.origin.y += UIConstants.menuSettings
		}, completion: {(Bool) in
			self.delegate?.hideMenuSettings(status: true)
		})
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuSettingsView: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.names.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellMenu, for: indexPath)
		cell.selectionStyle = .none
		cell.textLabel?.text = names[indexPath.row]
		cell.imageView?.image = UIImage.init(named: icons[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return frame.height / 11
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 3{
			dismissMenu()
		}
	}
}
