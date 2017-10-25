//
//
//

import UIKit

public struct UIConstants {
	static let greenColor = UIColor(red: 0/255, green: 153/255, blue: 51/255, alpha: 1)
	static let blueColor = UIColor(red: 136/255, green: 209/255, blue: 241/255, alpha: 1)
	static let colorLine = UIColor(white: 0.2, alpha: 1)
	static let greenAlive = UIColor(red: 125/255, green: 192/55, blue: 43/255, alpha: 1)
	static let colorImageMenuNotSelected = UIColor(red: 51/250, green: 82/250, blue: 93/250, alpha: 1)
	static let MenuToolbarBackgroundColorNormal = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
	static let orangeColor = UIColor(red: 248/250, green: 184/250, blue: 62/250, alpha: 1)
	static let grayColor = UIColor(red: 54/250, green: 59/250, blue: 64/250, alpha: 1)
	
	// Static distance
	static let menuSettings: CGFloat = 288
	
	// Static sizes
	static let widthScreen: CGFloat = UIScreen.main.bounds.width
	static let heightScreen: CGFloat = UIScreen.main.bounds.height
	
	// Static Fonts
	static let DefaultChromeSize: CGFloat = 14
	static let DefaultChromeSmallSize: CGFloat = 11
	static let PasscodeEntryFontSize: CGFloat = 36
	static let DefaultChromeFont: UIFont = UIFont.systemFont(ofSize: DefaultChromeSize, weight: UIFont.Weight.regular)
	static let DefaultChromeBoldFont = UIFont.boldSystemFont(ofSize: DefaultChromeSize)
	static let DefaultChromeSmallFontBold = UIFont.boldSystemFont(ofSize: DefaultChromeSmallSize)
	static let PasscodeEntryFont = UIFont.systemFont(ofSize: PasscodeEntryFontSize, weight: UIFont.Weight.bold)
	
}
