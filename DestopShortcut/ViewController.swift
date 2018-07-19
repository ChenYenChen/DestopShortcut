//
//  ViewController.swift
//  DestopShortcut
//
//  Created by Ray on 2018/7/13.
//  Copyright © 2018年 Ray. All rights reserved.
//

import UIKit
import Criollo

class ViewController: UIViewController {

    var server: CRHTTPServer?
    
    @IBOutlet weak var textfield: UITextField!
    @IBAction func action(_ sender: Any) {
        
        let openURL = "DestopShortcut://" + (textfield.text ?? "")
        guard let url = Shortcut.create("測試第一版", openLink: openURL, closeLink: "DestopShortcut://", shortcutImage: #imageLiteral(resourceName: "Image")) else { return }
        
        self.server?.get("/") { (req, res, next) in
            res.redirect(to: url)
            res.finish()
        }
//        self.server?.add({ (request, response, completionHandler) in
//            response.write("<!DOCTYPE HTML>")
//            response.write("<html>")
//            response.write("<body>")
//            response.write("<script>")
////            response.write("window.location.href=[\(url.absoluteString)]")
//            response.write("window.open(\"\(url.absoluteString)\");")
//            response.write("</script>")
//            response.write("</body>")
//            response.write("</html>")
//            response.finish()
//        })
        
        self.server?.startListening(NSErrorPointer.none, portNumber: 5555)
        guard let local = URL(string: "http://localhost:5555") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(local, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.server = CRHTTPServer(delegate: self)
    }
}
extension ViewController: CRServerDelegate {
    
}
