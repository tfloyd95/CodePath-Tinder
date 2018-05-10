//
//  ProfileViewController.swift
//  Tinder_Mock
//
//  Created by Elizabeth on 4/20/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    var profileImageViewHolder: UIImage!
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.image = profileImageViewHolder
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let dest = segue.destination as? CardViewController {
            dest.modalPresentationStyle = UIModalPresentationStyle.custom
            fadeTransition = FadeTransition()
            dest.transitioningDelegate = fadeTransition
            fadeTransition.duration = 1.0
        }
    }
    
    @IBAction func didTapHome(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "CardViewController", sender: nil)
    }
}
