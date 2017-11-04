//
//
//

import UIKit

class IntroController: UIViewController {
	
	let cellId = "cellId"
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
		pc.translatesAutoresizingMaskIntoConstraints = false
		return pc
	}()
	
	let previousButton: UIButton = {
		let pvButton = UIButton(type: .system)
		pvButton.setTitle("PREV", for: .normal)
		pvButton.titleLabel?.font = UIFont(name: "ZillaSlab-Bold", size: 15)
		pvButton.tintColor = .gray
		pvButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
		pvButton.translatesAutoresizingMaskIntoConstraints = false
		return pvButton
	}()
	
	let nextButton: UIButton = {
		let nxtButton = UIButton(type: .system)
		nxtButton.setTitle("NEXT", for: .normal)
		nxtButton.titleLabel?.font = UIFont(name: "ZillaSlab-Bold", size: 15)
		nxtButton.tintColor = UIConstants.blueColor
		nxtButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
		nxtButton.translatesAutoresizingMaskIntoConstraints = false
		return nxtButton
	}()
	
	let skipButton: UIButton = {
		let skpButton = UIButton(type: .system)
		skpButton.setTitle("SKIP", for: .normal)
		skpButton.titleLabel?.font = UIFont(name: "ZillaSlab-Bold", size: 18)
		skpButton.tintColor = .white
		skpButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
		skpButton.translatesAutoresizingMaskIntoConstraints = false
		return skpButton
	}()
	
	var startApp: UIButton = {
		let startButton = UIButton()
		startButton.backgroundColor = UIConstants.grayColor
		startButton.isHidden = true
		startButton.setTitleColor(.white, for: .normal)
		startButton.setTitle("START", for: .normal)
		startButton.titleLabel?.font = UIFont(name: "ZillaSlab-Bold", size: 20)
		startButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
		startButton.translatesAutoresizingMaskIntoConstraints = false
		return startButton
	}()
	
	@objc func goToHome() {
		// If accessed once no longer displayed the intro screen
		UserDefaults.standard.set(true, forKey: "checked")
		
		let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		
		let homeController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
		present(homeController, animated: true, completion: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.isNavigationBarHidden = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(IntroPageCell.self, forCellWithReuseIdentifier: cellId)
		
		setupConstraints()
	}
	
	func setupConstraints() {
		let stackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		view.addSubview(startApp)
		view.addSubview(stackView)
		view.addSubview(skipButton)
		
		NSLayoutConstraint.activate([
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.heightAnchor.constraint(equalToConstant: view.frame.height * 1.05),
			collectionView.widthAnchor.constraint(equalToConstant: view.frame.width)
			])
		NSLayoutConstraint.activate([
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			stackView.heightAnchor.constraint(equalToConstant: 45),
			])
		NSLayoutConstraint.activate([
			startApp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
			startApp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			startApp.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			startApp.heightAnchor.constraint(equalToConstant: 60)
			])
		NSLayoutConstraint.activate([
			skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			skipButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
			])
	}
	
	@objc func previousPage() {
		let indexPath = IndexPath(item: pageControl.currentPage - 1, section: 0)
		
		if pageControl.currentPage == 0 {
			previousButton.tintColor = .gray
		}else{
			previousButton.tintColor = UIConstants.blueColor
			collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
			pageControl.currentPage -= 1
			if pageControl.currentPage == 0 {
				previousButton.tintColor = .gray
			}
		}
	}
	
	@objc func nextPage() {
		previousButton.tintColor = UIConstants.blueColor
		
		let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
		collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		pageControl.currentPage += 1
		
		if pageControl.currentPage == 3{
					previousButton.isHidden = true
					nextButton.isHidden = true
					pageControl.isHidden = true
					skipButton.isHidden = true
					startApp.isHidden = false
		}
	}
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
		pageControl.currentPage = pageNumber
		
		if pageNumber >= 1 {
			previousButton.tintColor = UIConstants.blueColor
		}else{
			previousButton.tintColor = .gray
		}
		
		if pageNumber == 3 {
			startApp.isHidden = false
			nextButton.isHidden = true
			previousButton.isHidden = true
			skipButton.isHidden = true
			pageControl.isHidden = true
		}else {
			startApp.isHidden = true
			skipButton.isHidden = false
			nextButton.isHidden = false
			previousButton.isHidden = false
			pageControl.isHidden = false
		}
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

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension IntroController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

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
}


