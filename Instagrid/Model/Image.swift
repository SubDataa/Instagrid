//
//  Image.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import Foundation
import UIKit


class Image {

    
    func selectedButton(button: UIButton){
        button.isHidden = false
        
    }
    
  
    
}

extension UIImage{
    convenience init(view: UIView) {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)

  }
}
