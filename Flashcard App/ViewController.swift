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
    
    let blackColor = UIColor.black.cgColor
    let whiteColor = UIColor.white
    let chosenColor = UIColor.lightGray
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    //holds all four answer choices
    @IBOutlet var answerChoices: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorders()
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if (frontLabel.isHidden) {
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
        }
    }
    
    func addBorders(){
        //Question border init
        backLabel.layer.borderColor = blackColor
        backLabel.layer.borderWidth = 1.0
        frontLabel.layer.borderColor = blackColor
        frontLabel.layer.borderWidth = 1.0
        
        //answer border init
        for answer in answerChoices{
            answer.layer.borderColor = blackColor
            answer.layer.borderWidth = 0.5
        }
    }
    
    //actions connected to all four answer buttons
    @IBAction func answerPressed(_ sender: UIButton) {
        for answer in answerChoices{
            answer.backgroundColor = whiteColor
        }
        sender.backgroundColor = chosenColor
    }
    
    //reset answer choice if pressed outside a button
    @IBAction func didTapOutside(_ sender: Any) {
        
        for answer in answerChoices{
            answer.backgroundColor = whiteColor
        }
    }
    
    
    
}

