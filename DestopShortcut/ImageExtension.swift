//
//  ImageExtension.swift
//  DestopShortcut
//
//  Created by Ray on 2018/7/13.
//  Copyright © 2018年 Ray. All rights reserved.
//
import UIKit

extension UIImage {
    /// 默認不帶有data標示
    func toBase64(headerSign: Bool = false) -> String? {
        // 根據圖片得到對應的二進制編碼
        guard let imageData = UIImagePNGRepresentation(self) else { return nil }
        // 根據二進制編碼得到對應的base64字串
        var base64String = imageData.base64EncodedString(options: .init(rawValue: 0))
        if headerSign {
            base64String = "data:image/png;base64," + base64String
        }
        return base64String
    }
}
