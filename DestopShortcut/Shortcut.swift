//
//  Shortcut.swift
//  DestopShortcut
//
//  Created by Ray on 2018/7/13.
//  Copyright © 2018年 Ray. All rights reserved.
//

import Foundation
import UIKit

class Shortcut {
    
    private static let share: Shortcut = Shortcut()
    // 1995年 Data URI
    // https://hk.saowen.com/a/abe0a182a0542dfdaba07dd5afe4715f18045962ecca9f1791233c5c6818511f
    private func replace(_ title: String, openLink: String, closeLink: String, shortcutImage: UIImage, titleImage: UIImage?) -> String? {
        guard let _ = URL(string: openLink), let _ = URL(string: closeLink) else { return nil }
        guard let path = Bundle.main.path(forResource: "DestopShortcut", ofType: "html") else { return nil }
        do {
            var htmlStr = try String(contentsOfFile: path)
            htmlStr = htmlStr.replacingOccurrences(of: "MyDestopShortcut", with: title, options: .literal, range: nil)
            htmlStr = htmlStr.replacingOccurrences(of: "OpenLink", with: openLink, options: .literal, range: nil)
            htmlStr = htmlStr.replacingOccurrences(of: "CloseLink", with: closeLink, options: .literal, range: nil)
            htmlStr = htmlStr.replacingOccurrences(of: "ImageLink", with: self.imageToBase64(shortcutImage), options: .literal, range: nil)
            htmlStr = htmlStr.replacingOccurrences(of: "TitleImage", with: self.imageToBase64(titleImage), options: .literal, range: nil)
            return self.urlEncode(htmlStr)
        } catch {
            return nil
        }
    }
    
    private func urlEncode(_ html: String) -> String? {
        guard let encode = html.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        return encode
    }
    
    private func imageToBase64(_ image: UIImage?) -> String {
        guard let image = image else { return "" }
        // 根據圖片得到對應的二進制編碼
        guard let imageData = UIImagePNGRepresentation(image) else { return "" }
        // 根據二進制編碼得到對應的base64字串
        var base64String = imageData.base64EncodedString(options: .init(rawValue: 0))
        base64String = "data:image/png;base64," + base64String
        return base64String
    }
    
    static func create(_ title: String, openLink: String, closeLink: String, shortcutImage: UIImage, titleImage: UIImage? = nil) -> URL? {
        
        let shortcut = Shortcut.share
        guard let htmlStr = shortcut.replace(title, openLink: openLink, closeLink: closeLink, shortcutImage: shortcutImage, titleImage: titleImage) else { return nil }
        let dataURL = "data:text/html;charset=utf8," + htmlStr
        guard let url = URL(string: dataURL) else { return nil }
        return url
    }
}
