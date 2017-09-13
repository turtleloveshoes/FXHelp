//
//
//

import UIKit

public struct UIConstants {
	static let greenColor = UIColor(red: 44/255, green: 255/255, blue: 185/255, alpha: 1)
	static let blueColor = UIColor(red: 61/255, green: 178/255, blue: 218/255, alpha: 1)
	static let colorLine = UIColor(white: 0.2, alpha: 1)
	static let greenAlive = UIColor(red: 125/255, green: 192/55, blue: 43/255, alpha: 1)
	static let colorImageMenuNotSelected = UIColor(red: 44/255, green: 138/255, blue: 169/255, alpha: 1)
	static let MenuToolbarBackgroundColorNormal = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
	
	// Static distance
	static let menuSettings: CGFloat = 288
	
	// Static sizes
	static let widthScreen: CGFloat = UIScreen.main.bounds.width
	static let heightScreen: CGFloat = UIScreen.main.bounds.height
	
	// Static Fonts
	static let DefaultChromeSize: CGFloat = 14
	static let DefaultChromeSmallSize: CGFloat = 11
	static let PasscodeEntryFontSize: CGFloat = 36
	static let DefaultChromeFont: UIFont = UIFont.systemFont(ofSize: DefaultChromeSize, weight: UIFontWeightRegular)
	static let DefaultChromeBoldFont = UIFont.boldSystemFont(ofSize: DefaultChromeSize)
	static let DefaultChromeSmallFontBold = UIFont.boldSystemFont(ofSize: DefaultChromeSmallSize)
	static let PasscodeEntryFont = UIFont.systemFont(ofSize: PasscodeEntryFontSize, weight: UIFontWeightBold)
	
}
