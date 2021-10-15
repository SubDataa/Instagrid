//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Outlets
    @IBOutlet private weak var ViewImage: UIView! // pas de majuscule au debut d'un nom de variable
    
    @IBOutlet private weak var image1: UIImageView!
    @IBOutlet private weak var image2: UIImageView!
    @IBOutlet private weak var image3: UIImageView!
    @IBOutlet private weak var image4: UIImageView!
    
    @IBOutlet private weak var viewLayout2: UIView!
    @IBOutlet private weak var viewLayout1: UIView!
    @IBOutlet private weak var viewLayout3: UIView!
    @IBOutlet private weak var viewLayout4: UIView!
    
    @IBOutlet private weak var button1: UIButton! //template1Button
    @IBOutlet private weak var button2: UIButton!
    @IBOutlet private weak var button3: UIButton!
    
    @IBOutlet private weak var swipeLabel: UILabel!
    @IBOutlet private weak var arrowImg: UIImageView!
    
    // MARK:-
    private var imagePicker = UIImagePickerController()
    private var selectedImage: UIImageView?
    private let btnImage = UIImage(named: "Selected")
    private let arrowLandscape = UIImage(named: "Arrow Left")
    private let arrowPortrait = UIImage(named: "Arrow Up")
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureGesture()
        //Swipe up gesture
        let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeTop.direction = .up
        self.ViewImage.addGestureRecognizer(swipeTop)
        //left swipe gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        self.ViewImage.addGestureRecognizer(swipeLeft)
        
        
        //Default layout
        viewLayout2.isHidden = false
        viewLayout4.isHidden = true
        button2.setBackgroundImage(btnImage, for: .selected)
        button2.isSelected = true
        
        
    }
    
    // MARK: Detection Landscape / Portrait
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIDevice.current.orientation.isLandscape {
                self.arrowImg.image = self.arrowLandscape
                self.swipeLabel.text = "Swipe Left to share"
            } else {
                self.arrowImg.image = self.arrowPortrait
                self.swipeLabel.text = "Swipe up to share"
            }
        })
    }
    
    // MARK: - Animation swipe
    @objc private func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        var frame = ViewImage.frame
        if UIDevice.current.orientation.isLandscape {
            frame.origin.x = -frame.size.height
        } else {
            frame.origin.y = -frame.size.height
        }
        
        UIView.animate(withDuration: 0.3) {
            self.ViewImage.frame = frame
            self.shareImage()
            
        }
        
    }
    
    @IBAction private func setPictureAction(_ sender: UIButton) {
        setPicture(button: sender)
        
        switch sender.tag {
        case 1:
            selectedImage = image1
        case 2:
            selectedImage = image2
        case 3:
            selectedImage = image3
        case 4:
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
            
            viewLayout2.isHidden = true
            viewLayout4.isHidden = false
            
            
        case 2:
            
            viewLayout2.isHidden = false
            viewLayout4.isHidden = true
            
        case 3:
            
            viewLayout2.isHidden = false
            viewLayout4.isHidden = false
            
        default:
            break
        }
        
        sender.isSelected = true
    }
    
    
    private func setPicture(button: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){ //guard
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage?.image = image
        }
        
    }
    
    private func shareImage() {
        let img = [UIImage.init(view: self.ViewImage)]
        let ac = UIActivityViewController(activityItems: img, applicationActivities: nil)
        
        // When UIActivityViewController is closed, reverse animation
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            UIView.animate(withDuration: 0.3) {
                self.ViewImage.center = self.view.center
            }
        }
        present(ac, animated: true)
        
    }
    
    
    
}



