//
//  Entry.swift
//  JournalCK35
//
//  Created by Alex Lundquist on 8/17/20.
//

import Foundation
import CloudKit

struct EntryStrings {
    
    static let recordTypeKey = "Entry"
    fileprivate static let titleKey = "title"
    fileprivate static let bodyKey = "body"
    fileprivate static let timeStampKey = "timeStamp"
}
class Entry {
    
    var title: String
    var body: String
    var timeStamp: Date
    init(title: String, body: String, timeStamp: Date = Date() ) {
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
    }
}

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey)
        self.setValuesForKeys([
            EntryStrings.titleKey : entry.title,
            EntryStrings.bodyKey : entry.body,
            EntryStrings.timeStampKey : entry.timeStamp
            
        ])
    }
}

extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
              let body = ckRecord[EntryStrings.bodyKey] as? String,
              let timeStamp = ckRecord[EntryStrings.timeStampKey] as? Date else { return nil}
        self.init(title: title, body: body, timeStamp: timeStamp)
    }
}
