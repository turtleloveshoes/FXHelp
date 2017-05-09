//
//
//

import UIKit

class IntroPageCell: UICollectionViewCell {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		return iv
	}()
	
	let textView: UITextView = {
		let tv = UITextView()
		tv.isEditable = false
		tv.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
		return tv
	}()
	
	let lineSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0.9, alpha: 1)
		return view
	}()
	
	var page: IntroPage? {
		didSet {
			
			guard let page = page else {
				return
			}
			
			var imageName = page.imageName
			if UIDevice.current.orientation.isLandscape {
				imageName += "_landscape"
			}
			
			imageView.image = UIImage(named: imageName)
			
			let color = UIConstants.colorLine
			
			let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium), NSForegroundColorAttributeName: color])
			
			attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: color]))
			
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = .center
			
			let length = attributedText.string.characters.count
			attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: length))
			
			textView.attributedText = attributedText
		}
	}
	
	func setupViews() {
		
		addSubview(imageView)
		addSubview(textView)
		addSubview(lineSeparatorView)
		
		imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
		textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 24, rightConstant: 4)
		textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
		lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
		lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
