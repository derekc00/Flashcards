//
//  ViewController.swift
//  Flashcard App
//
//  Created by Derek Chang on 2/27/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var correctAnswer: String
    var choices: [String]
    
}
class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
//    let blackColor = UIColor.black.cgColor
//    let whiteColor = UIColor.white
//    let correctColor = UIColor.init(red: 166/255, green: 198/255, blue: 76/255, alpha: 1)
//    let wrongColor = UIColor.init(red: 200/255, green: 0/255, blue: 3/255, alpha: 1)
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    //holds all four answer choices
    @IBOutlet var answerButtons: [UIButton]!
    
    var flashcards: [Flashcard] = []
    var questionNumber: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
        
        cardView.bringSubviewToFront(backLabel)
        cardView.bringSubviewToFront(frontLabel)
        
        addButton.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 0.0, height: 0.0), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 35.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], fillColor: #colorLiteral(red: 0.2146924841, green: 0.3467160454, blue: 0.9650023794, alpha: 1))
        
        
        
        addShadowsToChoices()
        
        let sample = Flashcard(question: "Favorite Color?", correctAnswer: "blue", choices: ["red", "blue", "green","yellow"])

        flashcards.append(sample)

        frontLabel.text = flashcards[questionNumber].question
        backLabel.text = flashcards[questionNumber].correctAnswer
        populateAnswers()
    }
    
    func populateAnswers(){
        
        //Set all slots to empty
        for slots in answerButtons{
            slots.setTitle("", for: .normal)
            slots.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        //populate slots according to given answer choices
        var count = 0
        for answer in flashcards[questionNumber].choices.shuffled() {
            answerButtons[count].setTitle(answer, for: .normal)
            count += 1
        }
    }
    
    func updateCards(){
        //if finished the deck
        if (questionNumber >= flashcards.count){
            let alertController = UIAlertController(title: "Finished!", message:
                "Your deck will be reset", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                self.questionNumber = 0
               self.frontLabel.text = self.flashcards[self.questionNumber].question
               self.backLabel.text = self.flashcards[self.questionNumber].correctAnswer
               self.populateAnswers()
            }))
            self.present(alertController, animated: true){
               
            }
        }else{  //if did not finish the deck
            frontLabel.text = flashcards[questionNumber].question
            backLabel.text = flashcards[questionNumber].correctAnswer
            populateAnswers()
        }
        
    }
    //actions connected to all four answer buttons
    @IBAction func answerPressed(_ sender: UIButton) {
        
        //if correct answer is pressed
        if (sender.titleLabel?.text == flashcards[questionNumber].correctAnswer){
            sender.setTitleColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), for: .normal)
            questionNumber += 1

            updateCards()
            
        //if wrong answer is pressed
        }else{
            sender.setTitleColor(#colorLiteral(red: 0.9472755393, green: 0.3195192864, blue: 0.351960375, alpha: 1), for: .normal)
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if (frontLabel.isHidden) {
            frontLabel.isHidden = false
        } else{
            frontLabel.isHidden = true
            
            //highlights correct answer is the backLabel is revealed
            for choice in answerButtons{
                if (choice.titleLabel?.text == backLabel.text){
                    choice.titleLabel?.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                }
            }
            
        }
    }
    
    func addShadowsToChoices(){

        //answer border init
        for button in answerButtons{
            button.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
        }
    }
    
    
    
    //reset answer choice if pressed outside a button
    @IBAction func didTapOutside(_ sender: Any) {
        
        for answer in answerButtons{
            answer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func updateFlashcard(question: String, answers: [String], correctAnswer: String ){
        let flashcard = Flashcard(question: question, correctAnswer: correctAnswer, choices: answers)
        
        flashcards.append(flashcard)
        
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

