//
//  EntryController.swift
//  JournalCK35
//
//  Created by Alex Lundquist on 8/17/20.
//

import Foundation
import CloudKit

class EntryController {
    
    //MARK: -Properties
    let publicDB = CKContainer.default().publicCloudDatabase
    
    static let sharedInstance = EntryController()
    
    var entries: [Entry] = []
    
    func saveEntry(with titleText: String, andWith bodyText: String, completion: @escaping(Result<Entry?, EntryError>) -> Void) {
        let newEntry = Entry(title: titleText, body: bodyText)
        let entryCKRecord = CKRecord(entry: newEntry)
        
        publicDB.save(entryCKRecord) { (savedRecord, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let savedRecord = savedRecord,
                  let savedEntry = Entry(ckRecord: savedRecord)
            else { return completion(.failure(.couldNotUnWrap)) }
            print("Entry was successfully Saved")
            self.entries.append(savedEntry)
            completion(.success(savedEntry))
        }
    } //End of Save Entry
    
    func fetchAllEntries(completion: @escaping(Result<[Entry]?, EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            guard let records = records else { return completion(.failure(.couldNotUnWrap))}
            print("Fetched all Entries Successfully")
            let entries = records.compactMap({Entry(ckRecord: $0)})
            self.entries = entries
            completion(.success(entries))
        }
    }
} //End of Class
