//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import UIKit

    class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        
        let image = Image()
        
        @IBOutlet var image1: UIImageView!
        @IBOutlet weak var image2: UIImageView!
        @IBOutlet weak var image3: UIImageView!
        var imagePicker = UIImagePickerController()
        var selectedImage: UIImageView!
        
   
        
        
        @IBOutlet weak var button1: UIButton!
        @IBOutlet weak var button2: UIButton!
        @IBOutlet weak var button3: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        
        // Layout
        
        @IBOutlet weak var viewLayout2: UIView!
        @IBOutlet weak var viewLayout1: UIView!
        @IBOutlet weak var viewLayout3: UIView!
        
        @IBOutlet weak var layout1: UIButton!
        @IBOutlet weak var layout2: UIButton!
        @IBOutlet weak var layout3: UIButton!
        
        @IBAction func selectedLayout1(_ sender: Any) {
            image.selectedButton(button: layout1, view: viewLayout1)
        }
        @IBAction func selectedLayout2(_ sender: Any) {
            image.selectedButton(button: layout2, view: viewLayout2)
        }
        @IBAction func selectedLayout3(_ sender: Any) {
            image.selectedButton(button: layout3, view: viewLayout3)
        }
        
        
        
        
        
        @IBAction func setP3(_ sender: Any) {
            setPicture(button: button3)
            selectedImage = image3
        }
        @IBAction func setP2(_ sender: Any) {
            setPicture(button: button2)
            selectedImage = image2
        }
        @IBAction func setP1(_ sender: Any) {
            setPicture(button: button1)
            selectedImage = image1
        }
        

        
        
        
        func setPicture(button: UIButton) {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                button.isHidden = true

                present(imagePicker, animated: true, completion: nil)
            }
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage.image = image
            }

        }
}



