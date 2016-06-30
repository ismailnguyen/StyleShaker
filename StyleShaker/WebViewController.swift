import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    var product: Product? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webview.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if (product != nil) {
            let url = "https://www.google.fr/#tbm=shop&q=" + (self.product!.title?.stringByReplacingOccurrencesOfString(" ", withString: "+"))!
            
            let request: NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
            self.webview.loadRequest(request)
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
