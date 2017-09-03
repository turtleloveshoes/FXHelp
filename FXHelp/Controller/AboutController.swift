//

import UIKit

class AboutController: UIViewController {
	
	let webView: UIWebView = {
		let wv = UIWebView()
		wv.isUserInteractionEnabled = false
		return wv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(webView)
		webView.frame = CGRect(x: 0, y: 0.5, width: view.frame.width, height: view.frame.height)
		
		view.backgroundColor = .white
		
  do {
		guard let filePath = Bundle.main.path(forResource: "about", ofType: "html")
			else {
				print ("File reading error")
				return
		}
		
		let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
		let baseUrl = URL(fileURLWithPath: filePath)
		webView.loadHTMLString(contents as String, baseURL: baseUrl)
	}
	catch {
		print ("File HTML error")
		}
	}
}
