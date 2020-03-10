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
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var wrong1Label: UILabel!
    @IBOutlet weak var wrong2Label: UILabel!
    @IBOutlet weak var wrong3Label: UILabel!
    
    
    
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var correctAnswer: UITextField!
    @IBOutlet weak var wrongAnswer1: UITextField!
    @IBOutlet weak var wrongAnswer2: UITextField!
    @IBOutlet weak var wrongAnswer3: UITextField!
    
    
    @IBOutlet weak var correctAnswerControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.isHidden = true
        correctAnswerLabel.isHidden = true
        wrong1Label.isHidden = true
        wrong2Label.isHidden = true
        wrong3Label.isHidden = true
        
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func beginEdit(_ sender: UITextField) {
        
        switch sender.tag {
        case 0:
            questionLabel.isHidden = false
            questionLabel.alpha = 0
            questionLabel.center.y += 5
            self.questionLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            UIView.animate(withDuration: 0.2) {
                self.questionLabel.alpha = 1
                self.questionLabel.center.y -= 5
            }
            
        default:
            print("Error recognizing text field pressed")
        }
    }
    
    
    @IBAction func endEdit(_ sender: UITextField) {
        
        switch sender.tag {
        case 0:
//            if let text = myTextField.text, text.isEmpty {
//               // myTextField is not empty here
//            } else {
//               // myTextField is Empty
//            }
            if (questionLabel.text == ""){
                questionLabel.isHidden = true
                print("empty")
            } else{
                questionLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        default:
            print("error recognizing text field exited")
        }
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
