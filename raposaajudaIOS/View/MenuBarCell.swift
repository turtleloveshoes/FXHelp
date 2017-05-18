//
//
//

import UIKit

class MenuBarCell: UICollectionViewCell {
	
	var imageMenu: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraints()
		addSubview(imageMenu)
		
	}
	
	override var isHighlighted: Bool {
		didSet{
			imageMenu.tintColor = isHighlighted ? .white : UIConstants.colorImageMenuNotSelected
		}
	
	}
	
	override var isSelected: Bool {
		didSet{
			imageMenu.tintColor = isSelected ? .white : UIConstants.colorImageMenuNotSelected
		}
	}
	
	func setupConstraints(){
		addConstraint(NSLayoutConstraint(item: imageMenu, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: imageMenu, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
