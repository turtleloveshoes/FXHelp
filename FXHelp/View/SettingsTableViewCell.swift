//
//
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

	override func awakeFromNib() {
        super.awakeFromNib()
				self.accessoryType = .none
		}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		var textLabelFrame = self.textLabel?.frame
		textLabelFrame?.origin.x += 2
		textLabelFrame?.size.width += 10
		self.textLabel?.frame = textLabelFrame!
		self.textLabel?.font = UIFont(name: "ZillaSlab-Light", size: 18)
	}
}
