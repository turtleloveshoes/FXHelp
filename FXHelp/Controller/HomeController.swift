//
//
//

import UIKit

class HomeController: UICollectionViewController {
	
	let cellID = "cellID"
	let pageTitle = ["Home","Knowledge Base", "Support Forum", "Statistic"]
	
	let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
		indicator.backgroundColor = .black
		indicator.alpha = 1
		indicator.clipsToBounds = true
		indicator.layer.cornerRadius = 10
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
		return indicator
	}()
	
	lazy var menuBar: MenuBar = {
		let mb = MenuBar()
		mb.homeController = self
		mb.translatesAutoresizingMaskIntoConstraints = false
		return mb
	}()
	
	lazy var settings: MenuSettingsController = {
		let st = MenuSettingsController()
		st.homeController = self
		return st
	}()
	
	let titleMenuSettings: UILabel = {
		let title = UILabel()
		title.text = "Notifications"
		title.font = UIFont(name: "ZillaSlab-Bold", size: 20)
		title.textColor = .white
		return title
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		navigationController?.navigationBar.isTranslucent = false
		
		let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
		title.text = "Home"
		title.font = UIFont(name: "ZillaSlab-Bold", size: 20)
		title.textColor = .white
		title.textAlignment = NSTextAlignment.center
		navigationItem.titleView = title
		
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
		collectionView?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(60.0, 0, 0, 0)
		collectionView?.isPagingEnabled = true
		collectionView?.showsHorizontalScrollIndicator = false
		collectionView?.backgroundColor = .white
	
		setupMenu()
		iconMore()
		iconSearch(color:.black, enable: false)
		preloadAbout()
	}
	
	func changeTitle(index: CGFloat){
		if let titleslabel = navigationItem.titleView as? UILabel {
			titleslabel.text = pageTitle[Int(index)]
		}
		if pageTitle[Int(index)] == "Knowledge Base" {
			iconSearch(color:.white, enable: true)
		}else{
			iconSearch(color:.black, enable: false)
		}
	}
	
	private func setupMenu(){
		view.addSubview(menuBar)
		view.addSubview(activityIndicator)
		
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: .alignAllCenterX, metrics: nil, views: ["v0": menuBar]))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(60)]|", options: .alignAllCenterY, metrics: nil, views: ["v0": menuBar]))
		
		DispatchQueue.global(qos: .userInteractive).async{
			DispatchQueue.main.async{
				self.activityIndicator.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
				self.activityIndicator.startAnimating()
			}
		}
	}
	
	func openSettings(){
		settings.showSettings()
	}

	func iconMore(){
		let icon	= UIBarButtonItem(image: #imageLiteral(resourceName: "icon_more"), style: .plain, target: self, action: #selector(openSettings))
		icon.tintColor = .white
		navigationItem.leftBarButtonItem = icon
	}
	
	func iconSearch(color: UIColor, enable: Bool){
		let iconS = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: nil)
		iconS.tintColor = color
		iconS.isEnabled = enable
		navigationItem.rightBarButtonItem = iconS
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
	}
	
	override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let index = targetContentOffset.pointee.x / view.frame.width
		let indexPath = IndexPath(item: Int(index), section: 0)
		menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
		changeTitle(index: index)
	}
	
	func showSettingsController(_ title: String?) {
		if title == "Notifications" {
			titleMenuSettings.text = "Notifications"
			titleMenuSettings.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
		
			let settingsController = NotificationsController()
			settingsController.navigationItem.titleView = titleMenuSettings
			navigationController?.pushViewController(settingsController, animated: true)
			navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
			
		}else if title == "Feedback" {
			titleMenuSettings.text = "Feedback"
			titleMenuSettings.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
			
			let settingsController = FeedbackController()
			settingsController.navigationItem.titleView = titleMenuSettings
			settingsController.view.backgroundColor = .white
			navigationController?.pushViewController(settingsController, animated: true)
			navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		}else if title == "About" {
			titleMenuSettings.text = "About"
			titleMenuSettings.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
		
			let settingsController = AboutController()
			settingsController.navigationItem.titleView = titleMenuSettings
			navigationController?.pushViewController(settingsController, animated: true)
			navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		}
	}
	
	func preloadAbout(){
		let webViewPreLoad = AboutController()
		DispatchQueue.global().async {
				webViewPreLoad.view.setNeedsLayout()
			}
		}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout{

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
		cell.backgroundColor = .white
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height)
	}
	
	func scrollMenu(indexMenu: Int){
		let indexPath = NSIndexPath(item: indexMenu, section: 0) as IndexPath
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
	}
}

