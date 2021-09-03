//
//  ContactListController.swift
//  ADCBGamification
//
//  Created by SKY on 10/07/21.
//

import UIKit
import ContactsUI

enum ReferralStatus {
    case success, failure
}

protocol ReferDateDelegate {
    func referAction()
}
class ContactListController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var contactTableView: UITableView!
    //@IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var inviteButton: NeumorphicButton!
    @IBOutlet weak var inviteButtonContainerView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var contentView: UIView! {
        didSet {
            contentView.clipsToBounds = true
            contentView.layer.cornerRadius = 20
            if #available(iOS 11.0, *) {
                contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBOutlet weak var simplylifeUserLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    //@IBOutlet weak var simplylifeUserLabel: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var shareContactLbl: UILabel!
    
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var titleTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var placeholderTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var emptySpaceView: UIView!
    
    @IBOutlet weak var bottomStackView: UIStackView!
    
    
    
    
    var referSuccessViewHelper = ReferSuccessViewHelper()
    var handle: ((_ name: String,_ ph: String)->Void)?
    var contacts = [FetchedContact]()
    var newList  = [FetchedContact]()
    var referCode: String = ""
    var bPart: String?
    var footerHeight = 0
    var errorMsg = ""
    var delegate: ReferDateDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidebaseView()
        self.inviteButton.isHidden = false
        messageView.isHidden = true
        self.contentViewTopConstraint.constant = 100
        placeHolderLbl.isHidden = true
        titleLbl.isHidden = false
        titleTopConstraints.constant = 16
        
        contactTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        titleLbl.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
        
        self.inviteButton.isUserInteractionEnabled = false
        
        titleLbl.delegate = self
        
        
        buttonSetup()
        setupTableView()
        fetchContact()
        inviteButton.alpha = 0.3
        inviteButton.isUserInteractionEnabled = false
        inviteButton.populateView { (done) in
            self.inviteApiCall()
        }
        //simplylifeUserLabel.isHidden = true
        //neumorphicEffect()
        checkLeftToRight()
        delete()
        titleLbl.keyboardType = .phonePad
        
      //  chooseContactButton.textField.keyboardType = .phonePad
        
        shareContactLbl.text = "Select the contact to Invite".localized()
       // self.chooseContactButton.placeHolder = "Enter a contact name or mobile number".localized()
        
        
        self.titleLbl.attributedPlaceholder = NSAttributedString(string: "Enter a contact name or mobile number".localized(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1)])
        
        inviteButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        shareContactLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        addSwipe()
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        contactTableView.layer.removeAllAnimations()
        tableViewHeightConstraints.constant = contactTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        fetchContact()
        self.titleLbl.attributedPlaceholder = NSAttributedString(string: "Enter a contact name or mobile number".localized(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1)])
        titleLbl.text = ""
        placeHolderLbl.isHidden = true
        titleTopConstraints.constant = 16
       
       // self.inviteButton.alpha = 0.3
       // self.inviteButton.isUserInteractionEnabled = false
        hidebaseView()
        messageView.isHidden = true
    }
    
    
    @objc func textFieldTyping(textField: UITextField) {
        
        titleLbl.text = textField.text
        placeHolderLbl.isHidden = false
        self.titleLbl.attributedPlaceholder = nil
        placeHolderLbl.text = "Enter a contact name or mobile number".localized()
        titleLbl.isHidden = false
        titleTopConstraints.constant = 23
        self.onEditionTextField(text: textField.text ?? "")
    }
    
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.contentView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        switch direction {
        case .right:
            print("Gesture direction: Right")
        case .left:
            print("Gesture direction: Left")
        case .up:
            print("Gesture direction: Up")
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                
                self.contentViewTopConstraint.constant = 50
                UIView.animate(withDuration: 0.5) {
                    self.contentView.layoutIfNeeded()
                }
                
            })
            
        case .down:
            print("Gesture direction: Down")
            self.dismiss(animated: true, completion: nil)
        default:
            print("Unrecognized Gesture Direction")
        }
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
        
        self.bPart = self.titleLbl.text!
        
        if self.bPart!.isEmpty {
            
            self.view.showAlert(message: "Please eneter a valid mobile number".localized()) { (done) in
                self.inviteButton.setButtonTitle(title: "Invite".localized(), titleColor: UIColor.darkBlueColor())
            }
            return
            
        }
        
        let no = bPart?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        
        ReferViewModel.referInviteApiCall(bParty: no ?? "") { (data, err) in
            
            print("data is \(data)")
            if data == nil {
                self.referWinFailPopup(.failure, nil)
            } else {
                if data == "201" {
                    self.referWinFailPopup(.success, "")
                } else {
                    self.referWinFailPopup(.failure, nil)
                }
                
            }
            
        }
    }
    
    func referWinFailPopup(_ status: ReferralStatus, _ msg: String?) {
       
       
            DispatchQueue.main.async {
                self.dismiss(animated: false) {
                self.referSuccessViewHelper.loadScreen(status: status, message: msg ?? "" ,info: nil){ action in
                    switch action {
                    case .homePageTapped:
                        self.referSuccessViewHelper.animateAndRemove()
                        self.dismiss(animated: true) {
                            self.delegate?.referAction()
                        }
                    case .referAgain:
                        self.referSuccessViewHelper.animateAndRemove()
                    }
                }
            }
        }

        switch status {
        case .success:
            break;
        case .failure:
            break;
        default:
            break;
        }
//            DispatchQueue.main.async {
//                self.referSuccessViewHelper.loadScreen(info: nil){ action in
//                    switch action {
//                    case .homePageTapped:
//                        self.referSuccessViewHelper.animateAndRemove()
//                        self.dismiss(animated: true, completion: nil)
//                    case .referAgain:
//                        self.referSuccessViewHelper.animateAndRemove()
//                    }
//                }
//            }
       
    }
    
    func setupTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
        contactTableView.register(UINib(nibName: "CustomContactCell", bundle: Bundle(for: Self.self)), forCellReuseIdentifier: "CustomContactCell")
    }
    
    func buttonSetup() {
        DispatchQueue.main.async {
//            self.chooseContactButton.populateView(complition: self.chooseContactButtonTapped(action:), textAction: self.textFieldDelegateHandle(action:))
//            self.chooseContactButton.chooseContact.isHidden = true
//            self.chooseContactButton.titleLabel.isHidden = false
//            self.chooseContactButton.titleLabel.alpha = 0.00
//            self.chooseContactButton.textField.clearButtonMode = .always
//            self.chooseContactButton.textField.becomeFirstResponder()
            self.neumorphicEffect()
            self.inviteButtonContainerView.isHidden = false
        }
    }
    
    
    
    func neumorphicEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.03) {
           // self.chooseContactButton.buttonState(isPressed: false)
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
            // self.chooseContactButton.titleLabel.alpha = 1.0
            // self.chooseContactButton.titleLabel.isHidden = false
            if text.isEmpty {
                //  self.chooseContactButton.placeHolder = "Enter a contact name or mobile number".localized()
                // self.chooseContactButton.titleLabel.alpha = 0.0
                self.inviteButton.alpha = 1.0
            }
            
        case .cleared:
            print("text field cleared")
            self.newList = self.contacts
            //self.chooseContactButton.titleLabel.text = ""
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
        
        
        if self.newList.isEmpty, !text.isEmpty , text.isNumeric {
            let unknownContact = FetchedContact(firstName: "Unknown", lastName: "contact", telephone: text, image: nil, unknowContact: true)
            self.newList.insert(unknownContact, at: 0)
            //self.inviteButton.alpha = 0.0
        }
        
        if text.isEmpty {
            self.newList.removeAll()
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
//        let contact = self.newList[indexPath.row]
//        self.inviteButton.alpha = 0.0
        
        let contact = self.newList[indexPath.row]
        self.newList.removeAll()
        self.newList.append(contact)
        self.contactTableView.reloadData()
        //self.inviteButton.alpha = 0.0
        self.titleTopConstraints.constant = 25
        
        
        ReferViewModel.checkSimpleLifeUser(number: contact.telephone) { data, err   in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                if err == nil {
                    if data?.errorCode == "200" {
                        self.errorMsg = "Sorry, this contact is already a Simplylife user"
                        self.footerHeight = 0
                        self.contactTableView.reloadData()
                       // self.chooseContactButton.titleLabel.isHidden = false
                       // self.chooseContactButton.titleLabel.text = contact.firstName + " " + contact.lastName
                       // self.chooseContactButton.buttonState(isPressed: false)
                       // self.chooseContactButton.titleLabel.alpha = 1.0
                        
                        self.titleLbl.text = contact.telephone
                        self.placeHolderLbl.text = contact.firstName + " " + contact.lastName
                        
                        
                       // self.unHideInviteButon()
                        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
                        self.bPart = contact.telephone
                        self.UnhidebaseViewForexistingUser()
//                        self.inviteButton.isUserInteractionEnabled = false
//                        self.inviteButton.alpha = 0.0
                    } else if data?.errorCode == "400" {
                        self.errorMsg = ""
                        self.footerHeight = 0
                        self.contactTableView.reloadData()
                       // self.chooseContactButton.titleLabel.isHidden = false
                        //self.chooseContactButton.titleLabel.text = contact.firstName + " " + contact.lastName
                       // self.chooseContactButton.buttonState(isPressed: false)
                       // self.chooseContactButton.titleLabel.alpha = 1.0
                        self.titleLbl.text = contact.telephone
                        self.placeHolderLbl.text = contact.firstName + " " + contact.lastName
                        //self.chooseContactButton.textField.text = contact.telephone
                        //self.unHideInviteButon()
                        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
                        self.bPart = contact.telephone
//                        self.inviteButton.isUserInteractionEnabled = true
//                        self.inviteButton.alpha = 1.0
                        
                        self.UnhidebaseViewForValidUser()
                    } else {
                        self.showToast(message: data?.error ?? "Something went wring. Try again !")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }

        }
        
       /* chooseContactButton.titleLabel.isHidden = false
        chooseContactButton.titleLabel.text = contact.firstName + " " + contact.lastName
        chooseContactButton.buttonState(isPressed: false)
        self.chooseContactButton.titleLabel.alpha = 1.0
        chooseContactButton.textField.text = contact.telephone
        self.unHideInviteButon()
        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
        self.bPart = contact.telephone
        self.inviteButton.isUserInteractionEnabled = true 
        self.inviteButton.alpha = 1.0 */
       // self.dismiss(animated: true, completion: nil)
    }
    
    func hidebaseView() {
        bottomStackView.isHidden = true
        emptySpaceView.isHidden = false
        messageView.isHidden = false
    }
    
    func UnhidebaseViewForValidUser() {
        bottomStackView.isHidden = false
        emptySpaceView.isHidden = false
        messageView.isHidden = true
    }
    
    func UnhidebaseViewForexistingUser() {
        bottomStackView.isHidden = false
        emptySpaceView.isHidden = false
        messageView.isHidden = false
    }
    
    func inviteButtonAppearance() {
        self.inviteButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.inviteButton.setButtonTitle(title: "Invite".localized(), titleColor: UIColor.darkBlueColor())
    }
    
    @IBAction func clearFieldAction(_ sender: Any) {
        dismissKeyboard()
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
        let selectedCell = tableView.cellForRow(at: indexPath) as! CustomContactCell
        let contactData = self.newList[indexPath.row]
        selectedCell.isSelectedVal = true
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
//        chooseContactButton.titleLabel.isHidden = false
//        self.chooseContactButton.titleLabel.alpha = 1.0
        placeHolderLbl.isHidden = false
        placeHolderLbl.text = contactData.firstName + contactData.lastName
        //chooseContactButton.titleLabel.text = contactData.firstName + contactData.lastName
        //chooseContactButton.placeHolder = contactData.telephone
        self.titleLbl.text = contactData.telephone
       // self.chooseContactButton.textField.text = contactData.telephone
        onCellTap(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        footerView.backgroundColor = .clear
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        titleLabel.numberOfLines = 0;
        titleLabel.text  = errorMsg
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont(name: "OpenSans-Regular", size: 14)
        titleLabel.frame.origin = CGPoint(x: ((footerView.frame.width) - (titleLabel.intrinsicContentSize.width))/2, y: footerView.frame.height / 2)
        titleLabel.textColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1)
        footerView.addSubview(titleLabel)
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(footerHeight)
    }
    
}
