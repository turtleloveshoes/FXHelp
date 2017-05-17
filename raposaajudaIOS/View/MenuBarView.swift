//
//  
//

import UIKit

private let cellMenu = "cellMenu"

class MenuBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
	
	var menuImages = ["home", "blognews", "statistic", "statistic"]
	
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
		addSubview(collectionView)
		
		collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellMenu)

		backgroundColor = UIConstants.blueColor
		setupConstraints()
	}
	
	func setupConstraints(){
		let horizontalMenu = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: .alignAllCenterX, metrics: nil, views: ["v0": collectionView])
		let verticalMenu = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: .alignAllCenterY, metrics: nil, views: ["v0": collectionView])
		
		addConstraints(horizontalMenu)
		addConstraints(verticalMenu)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMenu, for: indexPath) as! MenuCell
		cell.imageMenu.image = UIImage(named: menuImages[indexPath.item])?.withRenderingMode(.alwaysTemplate)
		cell.tintColor = UIConstants.colorImageMenuNotSelected
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: frame.width / 4, height: frame.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
