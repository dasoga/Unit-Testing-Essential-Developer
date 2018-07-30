//
//  Flow.swift
//  QuizEngine
//
//  Created by Dante Solorio on 7/23/18.
//  Copyright © 2018 Dasoga Apps. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start(){
        if let firstQuestion = questions.first{
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        }
    }
    
    func routeNext(_ question: String) -> (String) -> Void{
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            let currentQuestionIndex = strongSelf.questions.index(of: question)!
            let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
            strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(nextQuestion))
        }
    }
}
