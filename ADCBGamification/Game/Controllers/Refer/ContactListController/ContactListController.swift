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
    var referSuccessViewHelper = ReferSuccessViewHelper()
    var handle: ((_ name: String,_ ph: String)->Void)?
    var contacts = [FetchedContact]()
    var newList  = [FetchedContact]()
    var referCode: String = ""
    var bPart: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetup()
        setupTableView()
        fetchContact()
        inviteButton.alpha = 0.3
        inviteButton.isUserInteractionEnabled = false
        inviteButton.populateView { (done) in
            self.inviteApiCall()
        }
        //neumorphicEffect()
        
        delete()
        chooseContactButton.textField.keyboardType = .phonePad
    }
    
    func delete() {
        DispatchQueue.main.async {

        self.unHideInviteButon()
        
        self.inviteButton.isUserInteractionEnabled = true
        self.inviteButton.alpha = 1.0
        }
    }
    
    
    func fetchContact() {
        PhoneContactVM.getContacts { (contacts) in
            DispatchQueue.main.async {
                self.contacts.removeAll()
                self.newList.removeAll()
                self.contacts = contacts
                self.newList = contacts
                self.contactTableView.reloadData()
            }
        }
    }
    
    func inviteApiCall() {
        
        self.bPart = self.chooseContactButton.textField.text!
        if self.bPart!.isEmpty {
            self.view.showAlert(message: "Please eneter a valid mobile number") { (done) in
                self.inviteButton.setButtonTitle(title: "Invite", titleColor: UIColor.darkBlueColor())
            }
            return}
        
        let no = bPart?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        ReferViewModel.recordRefer(referCode: self.referCode, bParty: no ?? "") { (data) in
            print("data is \(data)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            DispatchQueue.main.async {
                self.referSuccessViewHelper.loadScreen(info: nil){ action in
                    switch action {
                    case .homePageTapped:
                        self.referSuccessViewHelper.animateAndRemove()
                        self.dismiss(animated: true, completion: nil)   
                    case .referAgain:
                        self.referSuccessViewHelper.animateAndRemove()
                    }
                }
            }
        }
    }
    
    func setupTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.register(UINib(nibName: "CustomContactCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "CustomContactCell")
    }
    
    func buttonSetup() {
        DispatchQueue.main.async {
            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:), textAction: self.textFieldDelegateHandle(action:))
            self.chooseContactButton.chooseContact.isHidden = true
            self.chooseContactButton.titleLabel.isHidden = false
            self.chooseContactButton.titleLabel.alpha = 0.00
            self.chooseContactButton.textField.clearButtonMode = .always
            self.chooseContactButton.textField.becomeFirstResponder()
            self.neumorphicEffect()
            self.inviteButtonContainerView.isHidden = false
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
    
    func textFieldDelegateHandle(action: ReferTextFieldAction) {
        switch action {
        case .onEdit(let text):
            self.onEditionTextField(text: text)
            self.chooseContactButton.titleLabel.alpha = 1.0
            self.chooseContactButton.titleLabel.isHidden = false
            self.chooseContactButton.titleLabel.text = "Enter a contact name or mobile number"
        case .cleared:
            print("text field cleared")
            self.newList = self.contacts
            self.chooseContactButton.titleLabel.text = self.chooseContactButton.textField.placeholder
            self.contactTableView.reloadData()
        default:
            break
        }
    }
    
    func onEditionTextField(text: String) {
        self.newList = self.contacts.filter {
            $0.firstName.range(of: text, options: [.caseInsensitive, .diacriticInsensitive ]) != nil ||
                $0.telephone.range(of: text, options: [.caseInsensitive, .diacriticInsensitive ]) != nil
        }
        if text.isEmpty {
            self.newList = self.contacts
        }
        self.contactTableView.reloadData()
    }
    
    func unHideInviteButon() {
        UIView.animate(withDuration: 0.3) {
            self.inviteButtonContainerView.isHidden = false
            self.inviteButton.buttonState(isPressed: true)
            self.inviteButtonAppearance()
        } completion: { (done) in
            print("done")
        }
        
    }
    func onCellTap(indexPath: IndexPath) {
        self.view.endEditing(true)
        let contact = self.newList[indexPath.row]
        chooseContactButton.titleLabel.isHidden = false
        chooseContactButton.titleLabel.text = contact.firstName + " " + contact.lastName
        chooseContactButton.buttonState(isPressed: false)
        self.chooseContactButton.titleLabel.alpha = 1.0
        chooseContactButton.textField.text = contact.telephone
        self.unHideInviteButon()
        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
        self.bPart = contact.telephone
        self.inviteButton.isUserInteractionEnabled = true
        self.inviteButton.alpha = 1.0
       // self.dismiss(animated: true, completion: nil)
    }
    
    func inviteButtonAppearance() {
        self.inviteButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.inviteButton.setButtonTitle(title: "Invite", titleColor: UIColor.darkBlueColor())
    }
}
extension ContactListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomContactCell") as! CustomContactCell
        cell.populateView(info: self.newList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onCellTap(indexPath: indexPath)
    }
    
}
