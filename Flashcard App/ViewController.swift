//
//  ViewController.swift
//  Flashcard App
//
//  Created by Derek Chang on 2/27/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        frontLabel.isHidden = true
    }
    
}
