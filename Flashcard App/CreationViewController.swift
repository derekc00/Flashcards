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
    @IBOutlet weak var answerTextField: UITextField!
    
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
        let answerText = answerTextField.text
        
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
            print(questionText, " ", answerText)
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
            dismiss(animated: true, completion: nil)
        }
       
        
        
        
    }
   

}
