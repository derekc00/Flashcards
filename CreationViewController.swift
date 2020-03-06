//
//  CreationViewController.swift
//  Flashcard App
//
//  Created by Derek Chang on 2/28/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var wrongAnswer1: UITextField!
    @IBOutlet weak var wrongAnswer2: UITextField!
    @IBOutlet weak var wrongAnswer3: UITextField!
    
    @IBOutlet weak var correctAnswerControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //if question is blank
        if (questionTextField.text == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please Enter a Question", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        //if answer is blank
        else if (correctAnswer.text == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please enter your answer", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        //if no wrong answers are given
        else if (wrongAnswer1.text == "" || wrongAnswer2.text == "" || wrongAnswer3.text == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please enter your answer", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true) {
                self.flashcardsController.updateFlashcard(question: self.questionTextField.text!, answers: [], correctAnswer: self.correctAnswer.text!)
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
           
            var wrongAnswers:[String] = [correctAnswer.text!]
            if (wrongAnswer1.text != ""){
                wrongAnswers.append(wrongAnswer1.text!)
            }
            if (wrongAnswer2.text != ""){
                wrongAnswers.append(wrongAnswer2.text!)
            }
            if (wrongAnswer3.text != ""){
                wrongAnswers.append(wrongAnswer3.text!)
            }
            
            flashcardsController.updateFlashcard(question: questionTextField.text!, answers: wrongAnswers, correctAnswer: correctAnswer.text!)
            dismiss(animated: true, completion: nil)
        }
       
        
        
        
    }
   

}
