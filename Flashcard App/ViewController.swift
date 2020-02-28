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
    let correctColor = UIColor.init(red: 166/255, green: 198/255, blue: 76/255, alpha: 1)
    let wrongColor = UIColor.init(red: 200/255, green: 0/255, blue: 3/255, alpha: 1)
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    //holds all four answer choices
    @IBOutlet var answerChoices: [UIButton]!
    
    var questionBank: [Question] = []
    var questionNumber: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorders()
        
        let sample = Question(questionText: "Favorite Animal?", inputAnswers: ["Dog", "Cat", "Owl", "Horse"], correctAnswerText: "Cat")
        let sample2 = Question(questionText: "Favorite Color", inputAnswers: ["Red", "Green", "Blue"], correctAnswerText: "Blue")
        questionBank.append(sample)
        questionBank.append(sample2)
        
        frontLabel.text = questionBank[questionNumber].question
        backLabel.text = questionBank[questionNumber].correctAnswer
        populateAnswers()
    }
    
    
    
    func populateAnswers(){
        
        //Set all slots to empty
        for slots in answerChoices{
            slots.setTitle("", for: .normal)
            slots.layer.borderWidth = 0.0
        }
        //populate slots according to given answer choices
        var count = 0
        for answer in questionBank[questionNumber].answers{
            answerChoices[count].setTitle(answer, for: .normal)
            answerChoices[count].layer.borderWidth = 1.0
            count += 1
        }
    }
    
    func updateCards(){
        //if finished the deck
        if (questionNumber >= questionBank.count){
            let alertController = UIAlertController(title: "Finished!", message:
                "Your deck will be reset", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                self.questionNumber = 0
               self.frontLabel.text = self.questionBank[self.questionNumber].question
               self.backLabel.text = self.questionBank[self.questionNumber].correctAnswer
               self.populateAnswers()
            }))
            self.present(alertController, animated: true){
               
            }
        }else{  //if did not finish the deck
            frontLabel.text = questionBank[questionNumber].question
            backLabel.text = questionBank[questionNumber].correctAnswer
            populateAnswers()
        }
        
    }
    //actions connected to all four answer buttons
    @IBAction func answerPressed(_ sender: UIButton) {
        
        //if correct answer is pressed
        if (sender.titleLabel?.text == questionBank[questionNumber].correctAnswer){
            sender.backgroundColor = correctColor
            questionNumber += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.backgroundColor = .none
            }
            updateCards()
            
        //if wrong answer is pressed
        }else{
            sender.backgroundColor = wrongColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.backgroundColor = .none
            }
            
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if (frontLabel.isHidden) {
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
            
            //highlights correct answer is the backLabel is revealed
            for choice in answerChoices{
                if (choice.titleLabel?.text == backLabel.text){
                    choice.backgroundColor = correctColor
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        choice.backgroundColor = .none
                    }
                }
            }
            
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
    
    
    
    //reset answer choice if pressed outside a button
    @IBAction func didTapOutside(_ sender: Any) {
        
        for answer in answerChoices{
            answer.backgroundColor = whiteColor
        }
    }
    
    func updateFlashcard(question: String, answers: [String], correctAnswer: String ){
           let newQuestion = Question(questionText: question, inputAnswers: answers, correctAnswerText: correctAnswer)
        
        questionBank.append(newQuestion)
        
        updateCards()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //We know the destination of the segue is the Nakvigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
    
}

