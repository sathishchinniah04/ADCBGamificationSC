//
//  ContactListController.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit
import ContactsUI

class ContactListController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var inviteButton: NeumorphicButton!
    @IBOutlet weak var inviteButtonContainerView: UIView!
    
    var contacts = [FetchedContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        setupTableView()
        fetchContact()
        //neumorphicEffect()
    }
    
    
    
    func fetchContact() {
        PhoneContactVM.getContacts { (contacts) in
            self.contacts = contacts
            self.contactTableView.reloadData()
        }
    }
    
    func setupTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.register(UINib(nibName: "CustomContactCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "CustomContactCell")
    }
    
    func buttonSetup() {
        DispatchQueue.main.async {
            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:))
            self.chooseContactButton.chooseContact.isHidden = true
            self.chooseContactButton.titleLabel.isHidden = false
            self.chooseContactButton.titleLabel.alpha = 0.00
            self.chooseContactButton.textField.clearButtonMode = .always
            self.chooseContactButton.textField.becomeFirstResponder()
            self.neumorphicEffect()
            self.inviteButtonContainerView.isHidden = true
        }
    }

    func neumorphicEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.03) {
            self.chooseContactButton.buttonState(isPressed: false)
        }
    }
    
    
    func chooseContactButtonTapped(action: ReferContactButtonAction) {
        switch action {
        case .chooseContact:
            print("chooseContact")
            
        default:
            break
        }
    }
    
    func unHideInviteButon() {
        UIView.animate(withDuration: 0.3) {
            self.inviteButtonContainerView.isHidden = false
            self.inviteButton.buttonState(isPressed: true)
        } completion: { (done) in
            print("done")
        }

    }
    
}
extension ContactListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomContactCell") as! CustomContactCell
        cell.populateView(info: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        chooseContactButton.titleLabel.isHidden = false
        chooseContactButton.titleLabel.text = contact.firstName
        chooseContactButton.buttonState(isPressed: false)
        self.chooseContactButton.titleLabel.alpha = 1.0
        chooseContactButton.textField.text = contact.telephone
        self.unHideInviteButon()
    }
    
    
}
