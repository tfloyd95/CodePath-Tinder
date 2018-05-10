//
//  CardViewController.swift
//  Tinder_Mock
//
//  Created by Elizabeth on 4/20/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    var divisor: CGFloat!
    var cardInitialCenter: CGPoint!
    
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        divisor = (view.frame.width / 2) / 0.61
        cardInitialCenter = cardImageView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)
        let xFromCenter = imageView.center.x - view.center.x
        
        imageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
        
        if location.y < cardInitialCenter.y {
            imageView.transform = CGAffineTransform(rotationAngle: xFromCenter / divisor)
        } else {
            imageView.transform = CGAffineTransform(rotationAngle: xFromCenter / -divisor)
        }
        
        if sender.state == .began {
            print("Started pan")
        } else if sender.state == .changed{
            
        } else if sender.state == .ended {
            if imageView.center.x < cardInitialCenter.x - 50 {
                //animate to the right
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x: imageView.center.x - 500, y: imageView.center.y)
                    imageView.alpha = 0
                })
            } else if imageView.center.x > cardInitialCenter.x + 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.center = CGPoint(x: imageView.center.x + 500, y: imageView.center.y)
                    imageView.alpha = 0
                })
            } else {
                imageView.center = cardInitialCenter
                imageView.transform = CGAffineTransform.identity
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let dest = segue.destination as? ProfileViewController {
            dest.modalPresentationStyle = UIModalPresentationStyle.custom
            fadeTransition = FadeTransition()
            dest.transitioningDelegate = fadeTransition
            fadeTransition.duration = 1.0
            dest.profileImageViewHolder = cardImageView.image
        }
    }
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
}
