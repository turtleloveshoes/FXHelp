//
//
//

protocol SearchDelegate {
	func hideSearchView(status : Bool)
}

import UIKit

class SearchController: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	
	let statusView: UIView = {
		let st = UIView.init(frame: UIApplication.shared.statusBarFrame)
		st.backgroundColor = .black
		st.alpha = 0.15
		return st
	}()
	
	lazy var searchView: UIView = {
		let sv = UIView()
		sv.backgroundColor = .black
		sv.alpha = 0
		sv.translatesAutoresizingMaskIntoConstraints = false
		return sv
	}()
	
	lazy var backgroundView: UIView = {
		let bv = UIView.init(frame: self.frame)
		bv.backgroundColor = .black
		bv.alpha = 0
		return bv
	}()
	
	lazy var backButton: UIButton = {
		let bb = UIButton()
		bb.setBackgroundImage(UIImage.init(named: "close"), for: [])
		bb.backgroundColor = .black
		bb.addTarget(self, action: #selector(SearchController.dismiss), for: .touchUpInside)
		bb.translatesAutoresizingMaskIntoConstraints = false
		return bb
	}()
	
	lazy var searchButton: UIButton = {
		let sb = UIButton()
		sb.setBackgroundImage(UIImage.init(named: "search"), for: [])
		sb.backgroundColor = .black
		sb.addTarget(self, action: #selector(SearchController.dismiss), for: .touchUpInside)
		sb.translatesAutoresizingMaskIntoConstraints = false
		return sb
	}()
	
	lazy var searchField: UITextField = {
		let sf = UITextField()
		sf.attributedPlaceholder = NSAttributedString(string: "Search on Knowledge Base", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
		sf.textColor = .white
		sf.font = UIFont(name: "ZillaSlab-Medium", size: 18)
		sf.translatesAutoresizingMaskIntoConstraints = false
		return sf
	}()
	
	lazy var tableView: UITableView = {
		let tv = UITableView()
		tv.separatorStyle = .none
		tv.delegate = self
		tv.dataSource = self
		tv.translatesAutoresizingMaskIntoConstraints = false
		return tv
	}()
	
	var items = [String]()
	var delegate: SearchDelegate?
	
	func initView() {
		self.addSubview(tableView)
		self.addSubview(backgroundView)
		self.addSubview(statusView)
		self.addSubview(searchView)
		self.searchView.addSubview(searchField)
		self.searchView.addSubview(backButton)
		self.searchView.addSubview(searchButton)
		self.backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(SearchController.dismiss)))
		self.tableView.register(SearchCell.self, forCellReuseIdentifier: "Cell")
		self.searchField.delegate = self
		
		setupConstraints()
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			searchView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			searchView.heightAnchor.constraint(equalToConstant: self.frame.height/6),
			searchView.widthAnchor.constraint(equalToConstant: self.frame.width)
			])
		NSLayoutConstraint.activate([
			searchField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 60),
			searchField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 60),
			searchField.widthAnchor.constraint(equalToConstant: self.frame.width)
			])
		NSLayoutConstraint.activate([
			backButton.heightAnchor.constraint(equalToConstant: 18),
			backButton.widthAnchor.constraint(equalToConstant: 20),
			backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
			])
		NSLayoutConstraint.activate([
			searchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
			])
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: self.frame.height/6),
			tableView.heightAnchor.constraint(equalToConstant: 250),
			tableView.widthAnchor.constraint(equalToConstant: self.frame.width),
			tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
			])
		
		addConstraint(NSLayoutConstraint(item: searchField, attribute: .centerY, relatedBy: .equal, toItem: searchView, attribute: .centerY, multiplier: 1.5, constant: 0))
		addConstraint(NSLayoutConstraint(item: backButton, attribute: .centerX, relatedBy: .lessThanOrEqual, toItem: searchField, attribute: .centerX, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: backButton, attribute: .centerY, relatedBy: .equal, toItem: searchField, attribute: .centerY, multiplier: 1, constant: 0))
		addConstraint(NSLayoutConstraint(item: searchButton, attribute: .centerY, relatedBy: .equal, toItem: searchField, attribute: .centerY, multiplier: 1, constant: 0))
	}
	
	func animate() {
		UIView.animate(withDuration: 0.2, animations:{
			self.backgroundView.alpha = 0.5
			self.searchView.alpha = 1
			self.searchField.becomeFirstResponder()
		})
	}
	
	@objc func dismiss() {
		self.searchField.text = ""
		self.items.removeAll()
		self.tableView.removeFromSuperview()
		UIView.animate(withDuration: 0.2, animations:{
			self.backgroundView.alpha = 0
			self.searchView.alpha = 0
			self.searchField.resignFirstResponder()
		}, completion: {(Bool) in
			self.delegate?.hideSearchView(status: true)
		})
	}
	
	//MARK: TextField Delegates
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if (self.searchField.text == "" || self.searchField.text == nil) {
			self.items = []
			self.tableView.removeFromSuperview()
		} else{
			let _  = URLSession.shared.dataTask(with: requestSuggestionsURL(text: self.searchField.text!), completionHandler: { (data, response, error) in
				if error == nil {
					do {
						let json  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
						self.items = json[1] as! [String]
						DispatchQueue.main.async(execute: {
							if self.items.count > 0  {
								self.addSubview(self.tableView)
								self.setupConstraints()
							} else {
								self.tableView.removeFromSuperview()
							}
							self.tableView.reloadData()
						})
					} catch _ {
						print("Something wrong happened")
					}
				} else {
					print("error downloading suggestions")
				}
			}).resume()
		}
		return true
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		dismiss()
		return true
	}
	
	//MARK: Suggestions Query
	func requestSuggestionsURL(text: String) -> URL {
		let text = text.addingPercentEncoding(withAllowedCharacters: CharacterSet())!
		let url = URL.init(string: "https://api.bing.com/osjson.aspx?query=\(text)")!
		return url
	}
	
	//MARK: TableView Delegates and Datasources
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchCell
		cell.itemLabel.text = items[indexPath.row]
		cell.itemLabel.font = UIFont(name: "ZillaSlab-Medium", size: 18)
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.searchField.text = items[indexPath.row]
		self.tableView.removeFromSuperview()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}