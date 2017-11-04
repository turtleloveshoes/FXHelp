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
		message.numberOfLines = 1
		message.translatesAutoresizingMaskIntoConstraints = false
		message.font = UIFont(name: "ZillaSlab-Bold", size: 16)
		return message
	}()

	let rateText: UILabel = {
		let rate = UILabel()
		rate.text = "Tap to rate"
		rate.textColor = .black
		rate.lineBreakMode = NSLineBreakMode.byCharWrapping
		rate.numberOfLines = 1
		rate.translatesAutoresizingMaskIntoConstraints = false
		rate.font = UIFont(name: "ZillaSlab-Bold", size: 16)
		return rate
	}()
	
	let buttonOne: UIButton = {
		let btOne = UIButton()
		btOne.tintColor = .red
		btOne.tag = 1
		btOne.setImage(UIImage(named:"star"), for: .normal)
		btOne.addTarget(self, action: #selector(evaluateApp), for: .touchUpInside)
		return btOne
	}()
	
	let buttonTwo: UIButton = {
		let btTwo = UIButton()
		btTwo.tag = 2
		btTwo.setImage(UIImage(named:"star"), for: .normal)
		btTwo.addTarget(self, action: #selector(evaluateApp), for: .touchUpInside)
		return btTwo
	}()
	
	let buttonThree: UIButton = {
		let btThree = UIButton()
		btThree.tag = 3
		btThree.setImage(UIImage(named:"star"), for: .normal)
		btThree.addTarget(self, action: #selector(evaluateApp), for: .touchUpInside)
		return btThree
	}()
	
	let buttonFour: UIButton = {
		let btFour = UIButton()
		btFour.tag = 4
		btFour.setImage(UIImage(named:"star"), for: .normal)
		btFour.addTarget(self, action: #selector(evaluateApp), for: .touchUpInside)
		return btFour
	}()
	
	let buttonFive: UIButton = {
		let btFive = UIButton()
		btFive.tag = 5
		btFive.setImage(UIImage(named:"star"), for: .normal)
		btFive.addTarget(self, action: #selector(evaluateApp), for: .touchUpInside)
		return btFive
	}()
	
	let containerButtons: UIStackView = {
		let cView = UIStackView()
		cView.alignment = .center
		cView.distribution = .fillEqually
		cView.translatesAutoresizingMaskIntoConstraints = false
		return cView
	}()
	
	var message: UITextField = {
		let message = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		message.returnKeyType = UIReturnKeyType.done
		message.autocorrectionType = UITextAutocorrectionType.yes
		message.font = UIFont(name: "ZillaSlab-Light", size: 16)
		message.borderStyle = UITextBorderStyle.bezel
		message.tintColor = .black
		message.translatesAutoresizingMaskIntoConstraints = false
		return message
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
		
		sendButton()
		setupConstraints()
		
		//Keyboard adjust message field
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}

	@objc func keyboardWillShow(notification: NSNotification) {
		self.view.bounds.origin.y += 100
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		self.view.bounds.origin.y -= 100
	}
	
	func sendButton() {
		let button	= UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(send))
		button.tintColor = .white
		navigationItem.rightBarButtonItem = button
	}
	
	@objc func send() {
		let mailComposeViewController = sendFeedback()
		if MFMailComposeViewController.canSendMail(){
			self.present(mailComposeViewController, animated:true, completion: nil)
		}
	}

	func sendFeedback() -> MFMailComposeViewController {
		let sendEmail = MFMailComposeViewController()
		sendEmail.mailComposeDelegate = self
		sendEmail.setToRecipients(["email@email.com"])
		sendEmail.setSubject("App message")
		sendEmail.setMessageBody("Email from App iOS", isHTML: false)
		
		return sendEmail
	}
	
	func setupConstraints() {
		
		view.addSubview(messageText)
		view.addSubview(message)
		view.addSubview(rateText)
		view.addSubview(containerButtons)
		containerButtons.addArrangedSubview(buttonOne)
		containerButtons.addArrangedSubview(buttonTwo)
		containerButtons.addArrangedSubview(buttonThree)
		containerButtons.addArrangedSubview(buttonFour)
		containerButtons.addArrangedSubview(buttonFive)
		
		NSLayoutConstraint.activate([
			rateText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			rateText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			rateText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			rateText.heightAnchor.constraint(equalToConstant: 50),
			rateText.widthAnchor.constraint(equalToConstant: 130)
			])
		NSLayoutConstraint.activate([
			containerButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
			containerButtons.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			containerButtons.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			containerButtons.heightAnchor.constraint(equalToConstant: 50),
			containerButtons.widthAnchor.constraint(equalToConstant: 100)
			])
		NSLayoutConstraint.activate([
			messageText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
			messageText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			messageText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			messageText.heightAnchor.constraint(equalToConstant: 50),
			messageText.widthAnchor.constraint(equalToConstant: 130)
			])
		NSLayoutConstraint.activate([
			message.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
			message.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
			message.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
			message.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
			message.heightAnchor.constraint(equalToConstant: 150),
			message.widthAnchor.constraint(equalToConstant: 130)
			])
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@objc func evaluateApp(buttonPressed: UIButton!) {
		if buttonPressed.tag == 1{
			buttonOne.setImage(UIImage(named:"star"), for: .normal)
			buttonTwo.setImage(UIImage(named:"dot"), for: .normal)
			buttonThree.setImage(UIImage(named:"dot"), for: .normal)
			buttonFour.setImage(UIImage(named:"dot"), for: .normal)
			buttonFive.setImage(UIImage(named:"dot"), for: .normal)
		}else if buttonPressed.tag == 2{
			buttonOne.setImage(UIImage(named:"star"), for: .normal)
			buttonTwo.setImage(UIImage(named:"star"), for: .normal)
			buttonThree.setImage(UIImage(named:"dot"), for: .normal)
			buttonFour.setImage(UIImage(named:"dot"), for: .normal)
			buttonFive.setImage(UIImage(named:"dot"), for: .normal)
		}else if buttonPressed.tag == 3{
			buttonOne.setImage(UIImage(named:"star"), for: .normal)
			buttonTwo.setImage(UIImage(named:"star"), for: .normal)
			buttonThree.setImage(UIImage(named:"star"), for: .normal)
			buttonFour.setImage(UIImage(named:"dot"), for: .normal)
			buttonFive.setImage(UIImage(named:"dot"), for: .normal)
		}else if buttonPressed.tag == 4{
			buttonOne.setImage(UIImage(named:"star"), for: .normal)
			buttonTwo.setImage(UIImage(named:"star"), for: .normal)
			buttonThree.setImage(UIImage(named:"star"), for: .normal)
			buttonFour.setImage(UIImage(named:"star"), for: .normal)
			buttonFive.setImage(UIImage(named:"dot"), for: .normal)
		}else{
			buttonOne.setImage(UIImage(named:"star"), for: .normal)
			buttonTwo.setImage(UIImage(named:"star"), for: .normal)
			buttonThree.setImage(UIImage(named:"star"), for: .normal)
			buttonFour.setImage(UIImage(named:"star"), for: .normal)
			buttonFive.setImage(UIImage(named:"star"), for: .normal)
		}
	}
	
	//MARK: - Email Delegate
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}
