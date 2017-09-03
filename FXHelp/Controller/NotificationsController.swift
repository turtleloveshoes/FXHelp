//
//
//

import UIKit

class NotificationsController: UIViewController{
	
	let phone1ImageView: UIImageView = {
		let image = UIImageView(image: UIImage(named: "phone_on"))
		return image
	}()
	
	let phone2ImageView: UIImageView = {
		let image = UIImageView(image: UIImage(named: "phone_off"))
		return image
	}()
	
	let notificationsForum: UILabel = {
		let nf = UILabel()
		nf.text = "Support Forum "
		nf.textColor = UIConstants.blueColor
		nf.translatesAutoresizingMaskIntoConstraints = false
		nf.font = UIFont(name: "ZillaSlab-Bold", size: 19)
		return nf
	}()
	
	let notificationsKB: UILabel = {
		let nkb = UILabel()
		nkb.text = "Knowledge Base "
		nkb.textColor = UIConstants.blueColor
		nkb.translatesAutoresizingMaskIntoConstraints = false
		nkb.font = UIFont(name: "ZillaSlab-Bold", size: 19)
		return nkb
	}()
	
	let notificationsKBDescription: UILabel = {
		let nkbd = UILabel()
		nkbd.text = "Receive notifications when\n new articles are add to translate"
		nkbd.textColor = .black
		nkbd.numberOfLines = 2
		nkbd.translatesAutoresizingMaskIntoConstraints = false
		nkbd.font = UIFont(name: "ZillaSlab-Medium", size: 15)
		return nkbd
	}()
	
	let notificationsForumDescription: UILabel = {
		let nfd = UILabel()
		nfd.text = "Receive notifications when\n new questions are made"
		nfd.textColor = .black
		nfd.numberOfLines = 2
		nfd.translatesAutoresizingMaskIntoConstraints = false
		nfd.font = UIFont(name: "ZillaSlab-Medium", size: 15)
		return nfd
	}()
	
	let viewForum: UIView = {
		let vi = UIView()
		vi.alpha = 1
		vi.backgroundColor = .white
		return vi
	}()
	
	let viewKB: UIView = {
		let vi = UIView()
		vi.alpha = 1
		vi.backgroundColor = .white
		return vi
	}()
	
	var switchKB: RAMPaperSwitch = {
		let sw = RAMPaperSwitch(view: nil, color: nil)
		sw.onTintColor = UIConstants.blueColor
		return sw
	}()
	
	var switchForum: RAMPaperSwitch = {
		let sf  = RAMPaperSwitch(view: nil, color: nil)
		sf.onTintColor = UIConstants.blueColor
		return sf
	}()
	
	var separatorView: UIView = {
		var separator = UIView()
		separator.backgroundColor = .black
		return separator
	}()
	
	var notificationForum: NSLayoutConstraint?
	var notificationKB: NSLayoutConstraint?
	var constraintSwitchKB: NSLayoutConstraint?
	var constraintSwitchForum: NSLayoutConstraint?
	var constraintViewKB: NSLayoutConstraint?
	var constraintViewForum: NSLayoutConstraint?
	var constraintNotificationForumDescription: NSLayoutConstraint?
	var constraintNotificationKBDescription: NSLayoutConstraint?
	var constraintSeparatorView: NSLayoutConstraint?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(viewForum)
		view.addSubview(viewKB)
		view.addSubview(switchKB)
		view.addSubview(switchForum)
		view.addSubview(notificationsKB)
		view.addSubview(notificationsForum)
		view.addSubview(notificationsKBDescription)
		view.addSubview(notificationsForumDescription)
		view.addSubview(separatorView)
		
		setupPaperSwitch()
		setupConstraints()
	}
	
	fileprivate func setupPaperSwitch() {
		
		self.switchKB.animationDidStartClosure = {(onAnimation: Bool) in
			
			self.animateLabel(self.notificationsKB, onAnimation: onAnimation, duration: self.switchKB.duration)
			self.animateImageView(self.phone1ImageView, onAnimation: onAnimation, duration: self.switchKB.duration)
		}
		
		
		self.switchForum.animationDidStartClosure = {(onAnimation: Bool) in
			
			self.animateLabel(self.self.notificationsForum, onAnimation: onAnimation, duration: self.switchForum.duration)
			self.animateImageView(self.phone2ImageView, onAnimation: onAnimation, duration: self.switchForum.duration)
		}
	}
	
	fileprivate func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
		UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
			if label == self.notificationsKB {
				label.textColor = onAnimation ? .white : UIConstants.blueColor
				self.viewKB.backgroundColor = onAnimation ? UIConstants.blueColor : .white
				self.viewKB.alpha = onAnimation ? 1 : 0
			}else{
				
				label.textColor = onAnimation ? .white : UIConstants.blueColor
				self.viewForum.backgroundColor = onAnimation ? UIConstants.blueColor : .white
				self.viewForum.alpha = onAnimation ? 1 : 0

			}
			
		}, completion:nil)
	}
	
	fileprivate func animateImageView(_ imageView: UIImageView, onAnimation: Bool, duration: TimeInterval) {
		UIView.transition(with: imageView, duration: duration, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
			imageView.image = UIImage(named: onAnimation ? "img_phone_on" : "img_phone_off")
		}, completion:nil)
	}
	
	func setupConstraints(){
		
		// Constraint Switch's
		constraintSwitchForum = switchForum.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height/2.0 + 40, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0).first
		constraintSwitchKB = switchKB.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 40, widthConstant: 0, heightConstant: 0).first
		
		// Constraint Label's
		notificationForum = notificationsForum.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: view.frame.height/2.0 + 20, leftConstant: 40, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 40).first
		constraintNotificationForumDescription = notificationsForumDescription.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: view.frame.height/2.0 + 60, leftConstant: 40, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 40).first
		notificationKB = notificationsKB.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 40, leftConstant: 40, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 40).first
		constraintNotificationKBDescription = notificationsKBDescription.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 80, leftConstant: 40, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 40).first
		
		// Constraint View's
		constraintViewKB = viewKB.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height/2.2).first
		constraintViewForum = viewForum.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height/2.2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height/2).first
		constraintSeparatorView = separatorView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: view.frame.height/2.2, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 2).first
	}
}
