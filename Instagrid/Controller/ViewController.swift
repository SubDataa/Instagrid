//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import UIKit

    class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        
        let image = Image()
        
        
        @IBOutlet weak var image1: UIImageView!
        @IBOutlet weak var image2: UIImageView!
        @IBOutlet weak var image3: UIImageView!
        @IBOutlet weak var image4: UIImageView!
        
        @IBOutlet weak var viewLayout2: UIView!
        @IBOutlet weak var viewLayout1: UIView!
        @IBOutlet weak var viewLayout3: UIView!
        @IBOutlet weak var viewLayout4: UIView!
        
        var imagePicker = UIImagePickerController()
        var selectedImage: UIImageView!
      
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
   

        @IBAction func setPictureAction(_ sender: UIButton) {
            switch sender.tag {
            case 1:
                setPicture(button: sender)
                selectedImage = image1
            case 2:
                setPicture(button: sender)
                selectedImage = image2
            case 3:
                setPicture(button: sender)
                selectedImage = image3
            case 4:
                setPicture(button: sender)
                selectedImage = image4
            default:
                break
            }
        }
        

        @IBAction func selectedLayout(_ sender: UIButton) {
            switch sender.tag {
            case 1:
                image.selectedButton(button: sender)
                viewLayout2.isHidden = true
                viewLayout4.isHidden = false
            case 2:
                image.selectedButton(button: sender)
                viewLayout2.isHidden = false
                viewLayout4.isHidden = true
            case 3:
                image.selectedButton(button: sender)
                viewLayout2.isHidden = false
                viewLayout4.isHidden = false
               default:
                break
            }
        }
     
        
        func setPicture(button: UIButton) {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false


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



