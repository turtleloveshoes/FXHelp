//
//  
//

import UIKit
import MessageUI

class FeedbackController: UIViewController, MFMailComposeViewControllerDelegate {
	
	let messageText: UILabel = {
		let message = UILabel()
		message.text = "Write a short review"
		message.textColor = .black
		message.lineBreakMode = NSLineBreakMode.byCharWrapping
		message.numberOfLines = 10
		message.translatesAutoresizingMaskIntoConstraints = false
		message.font = UIFont(name: "ZillaSlab-Bold", size: 15)
		return message
	}()

	let rateText: UILabel = {
		let rate = UILabel()
		rate.text = "Tap a dot to rate"
		rate.textColor = .black
		rate.lineBreakMode = NSLineBreakMode.byCharWrapping
		rate.numberOfLines = 10
		rate.translatesAutoresizingMaskIntoConstraints = false
		rate.font = UIFont(name: "ZillaSlab-Bold", size: 15)
		return rate
	}()
	
	let message: UITextField = {
		let message = UITextField(frame: CGRect(x: 0, y: 0, width: 1000, height: 100))
		message.returnKeyType = UIReturnKeyType.done
		message.autocorrectionType = UITextAutocorrectionType.no
		message.font = UIFont(name: "ZillaSlab-Light", size: 15)
		message.borderStyle = UITextBorderStyle.bezel
		message.tintColor = .black
		message.translatesAutoresizingMaskIntoConstraints = false
		return message
	}()
	
	var messageTextConstraint: NSLayoutConstraint?
	var rateTextConstraint: NSLayoutConstraint?
	var messageConstraint: NSLayoutConstraint?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
		view.addSubview(messageText)
		view.addSubview(message)
		view.addSubview(rateText)
		
		sendButton()
		setupConstraints()
	}
	
	func sendButton(){
		let button	= UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
		button.tintColor = .white
		navigationItem.rightBarButtonItem = button
	}
	
	func send(){
		let mailComposeViewController = sendFeedback()
		if MFMailComposeViewController.canSendMail(){
			self.present(mailComposeViewController, animated:true, completion: nil)
		}
	}
	
	func sendFeedback() -> MFMailComposeViewController{
		let sendEmail = MFMailComposeViewController()
		sendEmail.mailComposeDelegate = self
		sendEmail.setToRecipients(["jhonatasrm@gmail.com"])
		sendEmail.setSubject("App message")
		sendEmail.setMessageBody("Email from App iOS", isHTML: false)
		
		return sendEmail
	}
	
	func setupConstraints(){
		rateTextConstraint = rateText.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 25, bottomConstant: 0, rightConstant: 25, widthConstant: 130, heightConstant: 50).first
		messageTextConstraint = messageText.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 100, leftConstant: 25, bottomConstant: 0, rightConstant: 25, widthConstant: 130, heightConstant: 50).first
		messageConstraint = message.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 140, leftConstant: 25, bottomConstant: 0, rightConstant: 25, widthConstant: 130, heightConstant: 200).first
	}
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	//MARK: - Email Delegate
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

		controller.dismiss(animated: true, completion: nil)
	}
	
}
