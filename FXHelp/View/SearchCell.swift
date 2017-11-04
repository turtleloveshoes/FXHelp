//
//
//

import UIKit

class SearchCell: UITableViewCell {
	
	lazy var itemLabel: UILabel = {
		let il: UILabel = UILabel.init(frame: CGRect.init(x: 60, y: 0, width: self.contentView.bounds.width - 48, height: self.contentView.bounds.height))
		il.textColor = .black
		il.translatesAutoresizingMaskIntoConstraints = false
		return il
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: "Cell")
		self.addSubview(itemLabel)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}
