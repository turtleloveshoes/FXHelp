//
//  
//

import UIKit

class MenuBar: UIView {

	let cellMenu = "cellMenuBar"
	let menuImages = ["home", "knowledge_base", "questions_forum", "statistic"]
	
	var homeController = HomeController()
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
	  let menuCv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		menuCv.backgroundColor = UIConstants.blueColor
		menuCv.translatesAutoresizingMaskIntoConstraints = false
		menuCv.delegate = self
		menuCv.dataSource = self
		return menuCv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellMenu)

		setupConstraints()
		homeSelected()
	}
	
	func setupConstraints(){
		addSubview(collectionView)
		backgroundColor = UIConstants.blueColor
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
			])
	}
	
	func homeSelected(){
		let homeIndex = NSIndexPath(item: 0, section: 0)
		collectionView.selectItem(at: homeIndex as IndexPath, animated: true, scrollPosition: .top)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource
extension MenuBar: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMenu, for: indexPath) as! MenuBarCell
		cell.imageMenu.image = UIImage(named: menuImages[indexPath.item])?.withRenderingMode(.alwaysTemplate)
		cell.tintColor = UIConstants.colorImageMenuNotSelected
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		homeController.scrollMenu(indexMenu: indexPath.item)
		homeController.changeTitle(index: CGFloat(indexPath.item))
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width / 4, height: frame.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}
