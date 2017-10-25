////
////
////

import UIKit

private let cellId = "cellId"

class Home: UICollectionViewCell {
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.dataSource = self
		cv.delegate = self
		return cv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		setupView()
	}
	
	func setupView(){
		addSubview(collectionView)
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H: |[collectionView]|", options: .alignAllCenterX, metrics: nil, views: ["collectionView": self.collectionView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V: |[collectionView]|", options: .alignAllCenterY, metrics: nil, views: ["collectionView": self.collectionView]))
	
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension Home: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
		return cell
	}
}
