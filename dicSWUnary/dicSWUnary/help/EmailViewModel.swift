//
//  EmailViewModel.swift
//  dicSWUnary
//
//  Created by JUEUN KIM on 2022/04/24.
//

import Foundation
import RxSwift

struct EmailViewModel {
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    
    var isValid : Observable<Bool> {
        
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { email, password in
            email.contains("@swu.ac.kr") && password == ""
        }
    }
    
}
