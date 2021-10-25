//
//  ViewController.swift
//  Instagrid
//
//  Created by Thibault Ballof on 23/09/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:- Outlets
    @IBOutlet private weak var viewImage: UIView!
    
    @IBOutlet private weak var image1: UIImageView!
    @IBOutlet private weak var image2: UIImageView!
    @IBOutlet private weak var image3: UIImageView!
    @IBOutlet private weak var image4: UIImageView!
    
    @IBOutlet private weak var viewLayout2: UIView!
    @IBOutlet private weak var viewLayout1: UIView!
    @IBOutlet private weak var viewLayout3: UIView!
    @IBOutlet private weak var viewLayout4: UIView!
    
    @IBOutlet private weak var LayoutButton1: UIButton!
    @IBOutlet private weak var LayoutButton2: UIButton!
    @IBOutlet private weak var LayoutButton3: UIButton!
    
    @IBOutlet private weak var swipeLabel: UILabel!
    @IBOutlet private weak var arrowImg: UIImageView!
    
    // MARK:- Variables
    private var imagePicker = UIImagePickerController()
    private var selectedImage: UIImageView?
    private let btnImage = UIImage(named: "Selected")
    private let arrowLandscape = UIImage(named: "Arrow Left")
    private let arrowPortrait = UIImage(named: "Arrow Up")
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Swipe up gesture
        let swipeTop = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeTop.direction = .up
        self.viewImage.addGestureRecognizer(swipeTop)
        //left swipe gesture
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeft.direction = .left
        self.viewImage.addGestureRecognizer(swipeLeft)
        
        
        //Default layout
        viewLayout2.isHidden = false
        viewLayout4.isHidden = true
        LayoutButton2.setBackgroundImage(btnImage, for: .selected)
        LayoutButton2.isSelected = true
        
        
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
        var frame = viewImage.frame
        if UIDevice.current.orientation.isLandscape {
            frame.origin.x = -frame.size.height
        } else {
            frame.origin.y = -frame.size.height
        }
        
        UIView.animate(withDuration: 0.3) {
            self.viewImage.frame = frame
            self.shareImage()
            
        }
        
    }
    // MARK:- Set picture
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
    
    // MARK:- Select Layout
    @IBAction private func selectedLayout(_ sender: UIButton) {
        LayoutButton1.setBackgroundImage(btnImage, for: .selected)
        LayoutButton2.setBackgroundImage(btnImage, for: .selected)
        LayoutButton3.setBackgroundImage(btnImage, for: .selected)
        LayoutButton1.isSelected = false
        LayoutButton2.isSelected = false
        LayoutButton3.isSelected = false
        
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
    
    // MARK:- Choose Image from Library
    private func setPicture(button: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    // MARK:- Set Image from UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage?.image = image
        }
        
    }
    // MARK:- Share Image with UIActivityViewController
    private func shareImage() {
        let img = [UIImage.init(view: self.viewImage)]
        let ac = UIActivityViewController(activityItems: img, applicationActivities: nil)
        
        // When UIActivityViewController is closed, reverse animation
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            UIView.animate(withDuration: 0.3) {
                self.viewImage.center = self.view.center
            }
        }
        present(ac, animated: true)
        
    }
    
    
    
}



