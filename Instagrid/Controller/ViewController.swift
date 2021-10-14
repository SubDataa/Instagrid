//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import UIKit

    class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        
        private let image = Image()
        
        @IBOutlet private weak var ViewImage: UIView!
        
        @IBOutlet private weak var image1: UIImageView!
        @IBOutlet private weak var image2: UIImageView!
        @IBOutlet private weak var image3: UIImageView!
        @IBOutlet private weak var image4: UIImageView!
        
        @IBOutlet private weak var viewLayout2: UIView!
        @IBOutlet private weak var viewLayout1: UIView!
        @IBOutlet private weak var viewLayout3: UIView!
        @IBOutlet private weak var viewLayout4: UIView!
        
        @IBOutlet private weak var button1: UIButton!
        @IBOutlet private weak var button2: UIButton!
        @IBOutlet private weak var button3: UIButton!
        
        @IBOutlet weak var swipeLabel: UILabel!
        @IBOutlet weak var arrowImg: UIImageView!
        
        
        private var imagePicker = UIImagePickerController()
        private var selectedImage: UIImageView!
        let btnImage = UIImage(named: "Selected")
        let arrowLandscape = UIImage(named: "Arrow Left")
    
    
    

        
        override func viewDidLoad() {
            super.viewDidLoad()
           // let topSwipe = UIPanGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
           // let leftSwipe = UIPanGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
          //  view.addGestureRecognizer(topSwipe)
           // view.addGestureRecognizer(leftSwipe)
 
            
            let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
            swipeTop.direction = .up
            self.ViewImage.addGestureRecognizer(swipeTop)
            landscape()
        }
    
        
      private func landscape() {
            if UIDevice.current.orientation.isLandscape {
                arrowImg.image = arrowLandscape
                swipeLabel.text = "Swipe Left to share"
            }
        }
        
        


   
        @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
            
            var frame = ViewImage.frame
            frame.origin.y = -frame.size.height
            UIView.animate(withDuration: 0.3) {
                self.ViewImage.frame = frame
                self.shareImage()
              }
            
        }
//        @objc private func handleSwipes(_ sender:UIPanGestureRecognizer) {
//
//            let translation = sender.translation(in: ViewImage)
//            let translationTransform = CGAffineTransform(translationX: 0, y: translation.y)
//
//            ViewImage.transform = translationTransform
//
//
//
//            if translation.y < ViewImage.bounds.midY - UIScreen.main.bounds.midY {
//                self.shareImage()
//               }
//
//            UIView.animate(withDuration: 1.5, animations: {
//                self.ViewImage.transform = translationTransform
//            }, completion:nil)
//
//            UIView.animate(withDuration: 0.5, animations: {
//                       self.ViewImage.transform = .identity
//                   }, completion:nil)
//
//        }

        
        @IBAction private func setPictureAction(_ sender: UIButton) {
            
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
        

        @IBAction private func selectedLayout(_ sender: UIButton) {
            button1.setBackgroundImage(btnImage, for: .selected)
            button2.setBackgroundImage(btnImage, for: .selected)
            button3.setBackgroundImage(btnImage, for: .selected)
            button1.isSelected = false
            button2.isSelected = false
            button3.isSelected = false
            
            switch sender.tag {
            case 1:
                //image.selectedButton(button: sender)
                viewLayout2.isHidden = true
                viewLayout4.isHidden = false
                sender.isSelected = true
             
            case 2:
                //image.selectedButton(button: sender)
                viewLayout2.isHidden = false
                viewLayout4.isHidden = true
                sender.isSelected = true

            case 3:
                //image.selectedButton(button: sender)
                viewLayout2.isHidden = false
                viewLayout4.isHidden = false
                sender.isSelected = true
                //sender.setBackgroundImage(btnImage, for: .normal)
            default:
                break
            }
        }
     
        
        private func setPicture(button: UIButton) {
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
        
        private func shareImage() {
            let img = [UIImage.init(view: self.ViewImage)]
            let ac = UIActivityViewController(activityItems: img, applicationActivities: nil)
            present(ac, animated: true)
           
            
        }
        
}



extension UIImage {
    convenience init(viewA: UIView) {
        UIGraphicsBeginImageContext(viewA.frame.size)
        viewA.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}



