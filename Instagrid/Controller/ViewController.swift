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
        @IBOutlet weak var image4: UIImageView!
        @IBOutlet weak var image5: UIImageView!
        @IBOutlet weak var image6: UIImageView!
        @IBOutlet weak var image7: UIImageView!
        @IBOutlet weak var image8: UIImageView!
        @IBOutlet weak var image9: UIImageView!
        @IBOutlet weak var image10: UIImageView!
        
        
        
        
        var imagePicker = UIImagePickerController()
        var selectedImage: UIImageView!

   

        @IBAction func setPicture(_ sender: UIButton) {
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
            case 5:
                setPicture(button: sender)
                selectedImage = image5
            case 6:
                setPicture(button: sender)
                selectedImage = image6
            case 7:
                setPicture(button: sender)
                selectedImage = image7
            case 8:
                setPicture(button: sender)
                selectedImage = image8
            case 9:
                setPicture(button: sender)
                selectedImage = image9
            case 10:
                setPicture(button: sender)
                selectedImage = image10
            default:
                break
            }
        }
        
        @IBAction func selectedLayout(_ sender: UIButton) {
            switch sender.tag {
            case 1:
                image.selectedButton(button: sender, view: viewLayout1, hiddenView1: viewLayout2, hiddenView2: viewLayout3)
            case 2:
                image.selectedButton(button: sender, view: viewLayout2, hiddenView1: viewLayout1, hiddenView2: viewLayout3)
            case 3:
                image.selectedButton(button: sender, view: viewLayout3, hiddenView1: viewLayout1, hiddenView2: viewLayout2)
            default:
                break
            }
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
        
        // Layout
        
        @IBOutlet weak var viewLayout2: UIView!
        @IBOutlet weak var viewLayout1: UIView!
        @IBOutlet weak var viewLayout3: UIView!

        
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



