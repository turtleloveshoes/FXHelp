//
//
//

import UIKit

private let cellId = "cellId"

class IntroController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	let pages: [IntroPage] = {
		
		let pageOne = IntroPage(title: "Why should I help?", message: "Help millions of users get the most out of their favourite browser. Your contributions will reach millions of users worldwide, and you can do it from the comfort of your couch!", imageName: "page1")
		
		let pageTwo = IntroPage(title: "We need your help!", message: "Used by more than 400 million people, Mozilla support is fully powered by volunteers, and it’s more important than ever. This is where you come in.", imageName: "page2")
		
		let pageThree = IntroPage(title: "About Us", message: "Mozilla Support is a community of enthusiastic volunteers and employees trying to support our users around the globe. Join us for an incredible adventure!", imageName: "page3")
		
		let pageFour = IntroPage(title: "Pick a way to get involved", message: "", imageName: "page2")
		
		return [pageOne, pageTwo, pageThree, pageFour]
	}()
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = .white
		cv.dataSource = self
		cv.delegate = self
		cv.isPagingEnabled = true
		return cv
	}()
	
	lazy var pageControl: UIPageControl = {
		let pc = UIPageControl()
		pc.pageIndicatorTintColor = .lightGray
		pc.currentPageIndicatorTintColor = UIConstants.blueColor
		pc.numberOfPages = self.pages.count
		return pc
	}()
	
	var startApp: UIButton = {
		let bt = UIButton()
		bt.backgroundColor = UIConstants.blueColor
		bt.isHidden = true
		bt.setTitleColor(.white, for: .normal)
		bt.setTitle("GO", for: .normal)
		bt.titleLabel?.font = UIFont(name: "systemFont", size: UIConstants.DefaultChromeSize)
		bt.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
		return bt
	}()
	
	func goToHome(){
		let hc = HomeController()
		present(hc, animated: true, completion: nil)
	}
	
	var pageControlBottomAnchor: NSLayoutConstraint?
	var buttonControlStartApp: NSLayoutConstraint?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.isNavigationBarHidden = true
		collectionView.showsHorizontalScrollIndicator = false
		
		view.addSubview(collectionView)
		view.addSubview(pageControl)
		view.addSubview(startApp)
		
		let views = [
			"collectionView": self.collectionView
		]
		
		let collectionHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
		let collectionVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-20)-[collectionView]|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views)
		
		view.addConstraints(collectionVertical)
		view.addConstraints(collectionHorizontal)
		
		pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
		buttonControlStartApp = startApp.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50).first
		
		registerCells()
		
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		
		let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
		pageControl.currentPage = pageNumber
		
		if pageNumber == 3 {
			self.pageControlBottomAnchor?.constant = 40
			self.startApp.isHidden = false
		}else {
			self.pageControlBottomAnchor?.constant = 0
			self.startApp.isHidden = true
		}
		
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	fileprivate func moveControlConstraintsOffScreen() {
		pageControlBottomAnchor?.constant = 40
	}
	
	fileprivate func registerCells() {
		collectionView.register(IntroPageCell.self, forCellWithReuseIdentifier: cellId)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IntroPageCell
		
		let page = pages[(indexPath as NSIndexPath).item]
		cell.page = page
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: view.frame.height)
	}
	
	override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
		
		collectionView.collectionViewLayout.invalidateLayout()
		
		let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
		DispatchQueue.main.async {
			self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
			self.collectionView.reloadData()
		}
		
	}
	
}
