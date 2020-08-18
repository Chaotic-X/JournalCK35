//
//  EntryError.swift
//  JournalCK35
//
//  Created by Alex Lundquist on 8/17/20.
//

import Foundation

enum EntryError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnWrap
    
    var errorDescription: String {
        switch self {
        case .ckError(let error):
            return "There was an error: \(error.localizedDescription)"
        case .couldNotUnWrap:
            return "Unable to get this Entry."
        }
    }
}
