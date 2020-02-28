//
//  Question.swift
//  Flashcard App
//
//  Created by Derek Chang on 2/28/20.
//  Copyright © 2020 Derek Chang. All rights reserved.
//

import Foundation

class Question {
    
    let question: String
    let answers: [String]
    let correctAnswer: String
    
    init(questionText: String, inputAnswers:[String], correctAnswerText: String){
        question = questionText
        answers = inputAnswers
        correctAnswer = correctAnswerText
    }
    
}
