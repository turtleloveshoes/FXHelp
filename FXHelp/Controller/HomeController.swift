//
//
//

import UIKit

class HomeController: UICollectionViewController {
	
	let cellID = "cellID"
	let pageTitle = ["Home","Knowledge Base", "Support Forum", "Statistic"]
	
	var refreshScreen: UIRefreshControl!
	
	let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
		indicator.backgroundColor = .black
		indicator.alpha = 1
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
		return indicator
	}()
	
	var loadingTextLabel: UILabel = {
		let la = UILabel()
		la.textColor = .white
		la.text = "No internet connection"
		la.font = UIFont(name: "ZillaSlab-LightItalic", size: 20)
		la.sizeToFit()
		return la
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
		//let language = Locale.current.debugDescription
		
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
		navigationController?.navigationBar.isTranslucent = false
		
		testConnection()
		setupMenu()
		setupCollectionView()
		setupPageTitle()
		setupRefreshScreen()
		iconMore()
		iconSearch(color:.black, enable: false)
		preloadAbout()
	}
	
	func setupCollectionView(){
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
		collectionView?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
		collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(60.0, 0, 0, 0)
		collectionView?.isPagingEnabled = true
		collectionView?.showsHorizontalScrollIndicator = false
		collectionView?.backgroundColor = .white
	}
	
	func setupPageTitle(){
		let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
		title.text = "Home"
		title.font = UIFont(name: "ZillaSlab-Bold", size: 20)
		title.textColor = .white
		title.textAlignment = NSTextAlignment.center
		navigationItem.titleView = title
	}
	
	func setupRefreshScreen(){
		refreshScreen = UIRefreshControl()
		refreshScreen.attributedTitle = NSAttributedString(string: "", attributes: [NSAttributedStringKey.font: UIFont(name: "ZillaSlab-Light", size:14)!])
		refreshScreen.translatesAutoresizingMaskIntoConstraints = false
		refreshScreen.addTarget(self, action: #selector(refreshScreenPhone), for: .valueChanged)
		collectionView?.refreshControl = refreshScreen
		refreshScreen.tintColor = .black

		NSLayoutConstraint.activate([
			refreshScreen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			refreshScreen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			refreshScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
			refreshScreen.heightAnchor.constraint(equalToConstant: 80)
			])
		
		// Pull refresh
		activityIndicator.addSubview(loadingTextLabel)
		loadingTextLabel.center = CGPoint(x: view.frame.width/2, y: activityIndicator.frame.height/5)
	}
	
	func testConnection(){
		DispatchQueue.global(qos: .userInteractive).async{
			DispatchQueue.main.async{
				
				if self.currentReachabilityStatus == .notReachable{
					self.activityIndicator.startAnimating()
					self.activityIndicator.color = UIColor(white: 1, alpha: 0)
					self.activityIndicator.backgroundColor = .red
					self.activityIndicator.frame = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 25)
				}else{
					self.activityIndicator.stopAnimating()
				}
			}
		}
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
		
		NSLayoutConstraint.activate([
			menuBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			menuBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			menuBar.heightAnchor.constraint(equalToConstant: 60)
			])
	}
	
	@objc func openSettings(){
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
	
	@objc func refreshScreenPhone(){
		collectionView?.reloadData()
		testConnection()
		self.refreshScreen.endRefreshing()
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout{
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
		cell.backgroundColor = .white
		testConnection()
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height)
	}
	
	func scrollMenu(indexMenu: Int){
		let indexPath = NSIndexPath(item: indexMenu, section: 0) as IndexPath
		collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		testConnection()
	}
}
