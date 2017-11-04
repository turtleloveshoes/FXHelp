//
//
//

import UIKit

class NotificationsController: UIViewController {

	let notificationsForum: UILabel = {
		let nf = UILabel()
		nf.text = "Support Forum "
		nf.textColor = UIConstants.blueColor
		nf.font = UIFont(name: "ZillaSlab-Bold", size: 19)
		nf.translatesAutoresizingMaskIntoConstraints = false
		return nf
	}()
	
	let notificationsKB: UILabel = {
		let nkb = UILabel()
		nkb.text = "Knowledge Base "
		nkb.textColor = UIConstants.blueColor
		nkb.font = UIFont(name: "ZillaSlab-Bold", size: 19)
		nkb.translatesAutoresizingMaskIntoConstraints = false
		return nkb
	}()
	
	let notificationsKBDescription: UILabel = {
		let nkbd = UILabel()
		nkbd.text = "Receive notifications when\nnew articles are add to translate"
		nkbd.textColor = .black
		nkbd.numberOfLines = 2
		nkbd.font = UIFont(name: "ZillaSlab-Medium", size: 15)
		nkbd.translatesAutoresizingMaskIntoConstraints = false
		return nkbd
	}()
	
	let notificationsForumDescription: UILabel = {
		let nfd = UILabel()
		nfd.text = "Receive notifications when\nnew questions are made"
		nfd.textColor = .black
		nfd.numberOfLines = 2
		nfd.font = UIFont(name: "ZillaSlab-Medium", size: 15)
		nfd.translatesAutoresizingMaskIntoConstraints = false
		return nfd
	}()
	
	let viewForum: UIView = {
		let vi = UIView()
		vi.alpha = 1
		vi.backgroundColor = .white
		vi.translatesAutoresizingMaskIntoConstraints = false
		return vi
	}()
	
	let viewKB: UIView = {
		let vi = UIView()
		vi.alpha = 1
		vi.backgroundColor = .white
		vi.translatesAutoresizingMaskIntoConstraints = false
		return vi
	}()
	
	var switchKB: RAMPaperSwitch = {
		let sw = RAMPaperSwitch(view: nil, color: nil)
		sw.onTintColor = UIConstants.blueColor
		sw.translatesAutoresizingMaskIntoConstraints = false
		return sw
	}()
	
	var switchForum: RAMPaperSwitch = {
		let sf  = RAMPaperSwitch(view: nil, color: nil)
		sf.onTintColor = UIConstants.blueColor
		sf.translatesAutoresizingMaskIntoConstraints = false
		return sf
	}()
	
	var separatorView: UIView = {
		var separator = UIView()
		separator.backgroundColor = .black
		separator.translatesAutoresizingMaskIntoConstraints = false
		return separator
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		setupPaperSwitch()
		setupConstraints()
	}
	
	fileprivate func setupPaperSwitch() {
		self.switchKB.animationDidStartClosure = {(onAnimation: Bool) in
			self.animateLabel(self.notificationsKB, onAnimation: onAnimation, duration: self.switchKB.duration)
		}
		self.switchForum.animationDidStartClosure = {(onAnimation: Bool) in
			self.animateLabel(self.self.notificationsForum, onAnimation: onAnimation, duration: self.switchForum.duration)
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
	
	func setupConstraints() {
		view.addSubview(viewForum)
		view.addSubview(viewKB)
		view.addSubview(switchKB)
		view.addSubview(switchForum)
		view.addSubview(notificationsKB)
		view.addSubview(notificationsForum)
		view.addSubview(notificationsKBDescription)
		view.addSubview(notificationsForumDescription)
		view.addSubview(separatorView)

		// Constraint Switch's
		NSLayoutConstraint.activate([
			switchForum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2.0),
			switchForum.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
			])
		NSLayoutConstraint.activate([
			switchKB.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
			switchKB.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
			])
		
		// Constraint Label's
		NSLayoutConstraint.activate([
			notificationsForum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2.0),
			notificationsForum.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
			notificationsForum.heightAnchor.constraint(equalToConstant: 40)
			])
		NSLayoutConstraint.activate([
			notificationsForumDescription.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2.0 + 40),
			notificationsForumDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
			notificationsForumDescription.heightAnchor.constraint(equalToConstant: 40)
			])
		NSLayoutConstraint.activate([
			notificationsKB.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
			notificationsKB.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
			notificationsKB.widthAnchor.constraint(equalToConstant: view.frame.width),
			notificationsKB.heightAnchor.constraint(equalToConstant: 40)
			])
		NSLayoutConstraint.activate([
			notificationsKBDescription.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
			notificationsKBDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
			notificationsKBDescription.widthAnchor.constraint(equalToConstant: view.frame.width),
			notificationsKBDescription.heightAnchor.constraint(equalToConstant: 40)
			])
		
		// Constraint View's
		NSLayoutConstraint.activate([
			viewForum.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2.2),
			viewForum.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			viewForum.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			viewForum.widthAnchor.constraint(equalToConstant: view.frame.width),
			viewForum.heightAnchor.constraint(equalToConstant: view.frame.height/2.2)
			])
		NSLayoutConstraint.activate([
			viewKB.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			viewKB.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			viewKB.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
			viewKB.heightAnchor.constraint(equalToConstant: view.frame.height/2.2)
			])
		NSLayoutConstraint.activate([
			separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2.2),
			separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			separatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			separatorView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 2)
			])
	}
}
