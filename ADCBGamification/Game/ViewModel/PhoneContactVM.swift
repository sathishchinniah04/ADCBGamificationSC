//
//  PhoneContactsVM.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import Foundation
import Contacts
import ContactsUI

class PhoneContactVM: NSObject {
    private static var contacts = [FetchedContact]()
    
    static func getContacts(complition:(([FetchedContact])->Void)?) {
        contacts.removeAll()
        fetchContacts(complition: complition)
    }
    
    private static func fetchContacts(complition:(([FetchedContact])->Void)?) {
        // 1.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // 2.
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        let contat = contact.phoneNumbers.first?.value.stringValue.trimmingCharacters(in: CharacterSet(charactersIn:"-")).trimmingCharacters(in: CharacterSet(charactersIn:" "))
                        if !contact.phoneNumbers.isEmpty, (contact.phoneNumbers.first?.value.stringValue.count ?? 0) > 3 {
                            self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contat ?? "", image: contact.imageData))
                        }
                    })
                    complition?(self.contacts)
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
}

