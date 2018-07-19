//
//  StringExtension.swift
//  DestopShortcut
//
//  Created by Ray on 2018/7/13.
//  Copyright © 2018年 Ray. All rights reserved.
//

import UIKit

extension String {
    
    /// base64 轉 圖片
    var toImage: UIImage? {
        var str = self
        // 判斷base64字串是否是以data開始的
        if str.hasPrefix("data:image") {
            guard let newBase64 = str.components(separatedBy: ",").last else { return nil }
            str = newBase64
        }
        // base64 轉成 Data
        guard let imageData = Data(base64Encoded: str, options: Data.Base64DecodingOptions()) else { return nil }
        // Data 轉成 image
        guard let codeImage = UIImage(data: imageData) else { return nil }
        return codeImage
    }
}
