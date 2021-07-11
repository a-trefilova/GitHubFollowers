//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Alyona Sabitskaya  on 11.07.2021.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername  = "Entered invalid url. Please try again"
    case unableToComplete = "Unable to complete a request. Check internet connection"
    case invalidResponse  = "Invalid response from the server. Please try again"
    case invalidData      = "The data vas invalid. Please try again"
    case parsingFailure   =  "Parsing data failed. Pleas try again"
}
