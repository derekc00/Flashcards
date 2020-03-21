//
//  ViewController.swift
//  Flashcard App
//
//  Created by Derek Chang on 2/27/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import UIKit
import Lottie


struct Flashcard {
    var question: String
    var correctAnswer: String
    var choices: [String]
    
}
class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonImage: UIImageView!
    
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    //holds all four answer choices buttons
    @IBOutlet var answerButtons: [UIButton]!
    
    //holds all flashcard structs
    var flashcards: [Flashcard] = []
    //manages current flashcard being shown
    var currentIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //adds shadows and colors
        configObjects()
        
        //populate flashcard deck with UserDefaults
        readSavedFlashcards()
        
        //shows first flashcard
        if flashcards.count == 0 {
            displayEmptyDeck()
        }else{
            updateCards()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if flashcards.count != 0 {
            
            nextButton.isHidden = false
            backButton.isHidden = false
        }else{
            for slot in answerButtons{
                slot.setTitle("", for: .normal)
            }
        }
    }
    
    func populateAnswers(){
        
        //Set all slots to empty
        for slots in answerButtons{
            slots.setTitle("", for: .normal)
            slots.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        //populate slots according to given answer choices
        var count = 0
        for answer in flashcards[currentIndex].choices.shuffled() {
            answerButtons[count].setTitle(answer, for: .normal)
            count += 1
        }
    }
    
    func updateCards(){
        //if finished the deck
        if (currentIndex >= flashcards.count){
            let alertController = UIAlertController(title: "Finished!", message:
                "Your deck will be reset", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {
                action in
                self.currentIndex = 0
               self.frontLabel.text = self.flashcards[self.currentIndex].question
               self.backLabel.text = self.flashcards[self.currentIndex].correctAnswer
               self.populateAnswers()
            }))
            self.present(alertController, animated: true){
               
            }
        //if question number wraps to from beginning to end
        }else if (currentIndex < 0){
            self.currentIndex = flashcards.count - 1
            frontLabel.text = flashcards[currentIndex].question
            backLabel.text = flashcards[currentIndex].correctAnswer
            populateAnswers()
        //normal back/forth
        }else{
            frontLabel.text = flashcards[currentIndex].question
            backLabel.text = flashcards[currentIndex].correctAnswer
            populateAnswers()
        }
        
        
    }
    
    func displayEmptyDeck(){
        frontLabel.text = "It's empty here :( \n\nAdd some cards to get started!"
        backLabel.text = "It's still empty over here."
        
        //test
        nextButton.isHidden = true
        backButton.isHidden = true
        
    }
    //actions connected to all four answer buttons
    @IBAction func answerPressed(_ sender: UIButton) {
        
        //if correct answer is pressed
        if (sender.titleLabel?.text == flashcards[currentIndex].correctAnswer){
            sender.setTitleColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), for: .normal)
            currentIndex += 1

            updateCards()
            
        //if wrong answer is pressed
        }else{
            sender.setTitleColor(#colorLiteral(red: 0.9472755393, green: 0.3195192864, blue: 0.351960375, alpha: 1), for: .normal)
        }
    }

    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        updateCards()
        
    }
    @IBAction func didTapOnBack(_ sender: Any) {
        currentIndex -= 1
        updateCards()
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
        saveAllFlashcardsToDisk()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //We know the destination of the segue is the Nakvigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = flashcards.map { (card) -> [String:[String]] in
            return ["question": [card.question], "correctAnswer": [card.correctAnswer], "choices": card.choices]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards() {
        
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:[String]]] {
            print(flashcards.count)
            let savedCards = dictionaryArray.map { (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]![0], correctAnswer: dictionary["correctAnswer"]![0], choices: dictionary["choices"]!)
            }
            flashcards.append(contentsOf: savedCards)
            print(flashcards.count)
        }
    }
    
    func configObjects(){
        cardView.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight])
        
        cardView.bringSubviewToFront(backLabel)
        cardView.bringSubviewToFront(frontLabel)
        
        addButton.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 0.0, height: 0.0), opacity: 0.8, shadowRadius: 2.0, cornerRadius: 20.0, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], fillColor: #colorLiteral(red: 0.2146924841, green: 0.3467160454, blue: 0.9650023794, alpha: 1))
        
        nextButton.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 0.0, height: 0.0), opacity: 0.8, shadowRadius: 2.0, cornerRadius: nextButton.frame.size.width / 2, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], fillColor: #colorLiteral(red: 0.2146924841, green: 0.3467160454, blue: 0.9650023794, alpha: 1))
        backButton.addShadow(shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), offSet: CGSize(width: 0.0, height: 0.0), opacity: 0.8, shadowRadius: 2.0, cornerRadius: nextButton.frame.size.width / 2, corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], fillColor: #colorLiteral(red: 0.2146924841, green: 0.3467160454, blue: 0.9650023794, alpha: 1))
        //Flipped
        backButtonImage.transform = CGAffineTransform(scaleX: -1, y: 1);

        
        addShadowsToChoices()
    }

}

