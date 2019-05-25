//
//  ViewEx.swift
//  attach_view_in_textview
//
//  Created by AamirR on 5/25/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit

extension UIView {
    
    var toImage: UIImage {
        let image: UIImage
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: self.frame.size)
            image = renderer.image {
                self.layer.render(in: $0.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
            self.layer.render(in: UIGraphicsGetCurrentContext()! )
            image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return image
    }
    
}

