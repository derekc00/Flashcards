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
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer3: UITextField!
    @IBOutlet weak var answer4: UITextField!
    
    @IBOutlet weak var correctAnswerControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //Get the text in the question text field
        let questionText = questionTextField.text
        
        //Get the text in the answer text field
        let answerText = answer1.text
        
        if (questionText == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please Enter a Question", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else if (answerText == ""){
            let alertController = UIAlertController(title: "Error", message:
                "Please enter your answer(s)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }else {
           
            var inputtedAnswers:[String] = [answerText!]
            if (answer2.text != ""){
                inputtedAnswers.append(answer2.text!)
            }
            if (answer3.text != ""){
                inputtedAnswers.append(answer3.text!)
            }
            if (answer4.text != ""){
                inputtedAnswers.append(answer4.text!)
            }
            
            var correctAnswerString: String = inputtedAnswers[correctAnswerControl.selectedSegmentIndex]
            if (correctAnswerString == ""){
                correctAnswerString = answerText!
            }
            
            flashcardsController.updateFlashcard(question: questionText!, answers: inputtedAnswers, correctAnswer: correctAnswerString)
            dismiss(animated: true, completion: nil)
        }
       
        
        
        
    }
   

}
