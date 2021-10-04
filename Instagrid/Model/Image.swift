//
//  Image.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import Foundation
import UIKit


class Image {

    
    func selectedButton(button: UIButton, view: UIView, hiddenView1: UIView, hiddenView2: UIView){
        button.isHidden = false
        view.isHidden = false
        hiddenView1.isHidden = true
        hiddenView2.isHidden = true

    }
    
}
