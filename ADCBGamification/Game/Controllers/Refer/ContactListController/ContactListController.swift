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
    func referAction(isToHomePage: Bool)
}
class ContactListController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var contactTableView: UITableView!
    //@IBOutlet weak var chooseContactButton: ReferContactButton!
    @IBOutlet weak var inviteButton: NeumorphicButton!
    @IBOutlet weak var inviteButtonContainerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mycontactLbl: UILabel!
    
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
    
    @IBOutlet weak var closeBtn: UIButton!
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
    @IBOutlet weak var verifyMessageview: UIView!
    @IBOutlet weak var leftMessageLbl: UILabel!
    @IBOutlet weak var leftMessageLblTopConstraints: NSLayoutConstraint!
    var referSuccessViewHelper = ReferSuccessViewHelper()
    var handle: ((_ name: String,_ ph: String)->Void)?
    var contacts = [FetchedContact]()
    var newList  = [FetchedContact]()
    var referCode: String = ""
    var bPart: String?
    var footerHeight = 0
    var errorMsg = ""
    var delegate: ReferDateDelegate? = nil
    var isUnknownContactVerified = false
    var shouldHideBerifyButton = false
    var isContactSelected = false
    var selectedContactRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContact()
        self.leftMessageLblTopConstraints.constant = -30
        self.leftMessageLbl.text = "Click “Verify” to check whether the contact is a Simplylife user.".localized()
        self.verifyMessageview.isHidden = true
        hidebaseView()
        self.inviteButton.isHidden = false
        messageView.isHidden = true
        self.contentViewTopConstraint.constant = 100
        placeHolderLbl.isHidden = true
        titleLbl.isHidden = false
        titleTopConstraints.constant = 16
        closeBtn.isHidden = true
        contactTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        titleLbl.addTarget(self, action: #selector(textFieldTyping), for: .editingChanged)
        
        self.inviteButton.isUserInteractionEnabled = false
        
        titleLbl.delegate = self
        if StoreManager.shared.language.lowercased() == "ar" {
            self.titleLbl.textAlignment = .right
            self.shareContactLbl.textAlignment = .right
        } else {
            self.shareContactLbl.textAlignment = .left
            self.titleLbl.textAlignment = .left
        }
        
        buttonSetup()
        setupTableView()
        
        inviteButton.alpha = 0.3
        inviteButton.isUserInteractionEnabled = false
        inviteButton.populateView { (done) in
            self.inviteApiCall()
        }
        //simplylifeUserLabel.isHidden = true
        //neumorphicEffect()
        checkLeftToRight()
        delete()
       // titleLbl.keyboardType = .phonePad
        
      //  chooseContactButton.textField.keyboardType = .phonePad
        
        shareContactLbl.text = "Select the contact to Invite".localized()
       // self.chooseContactButton.placeHolder = "Enter a contact name or mobile number".localized()
        self.mycontactLbl.text = "My contacts".localized()
        
        self.titleLbl.attributedPlaceholder = NSAttributedString(string: "Enter a contact name or mobile number".localized(), attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.337254902, alpha: 1)])
        
        inviteButton.setButtonFont(fSize: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  16.0 : 16.0, fName: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Medium" : "OpenSans-SemiBold")
        
        
        leftMessageLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  14.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        shareContactLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        mycontactLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  20.0 : 20.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Bold" : "OpenSans-SemiBold")
        
        titleLbl.setSizeFont(sizeFont: (StoreManager.shared.language == GameLanguage.AR.rawValue) ?  13.0 : 14.0, fontFamily: (StoreManager.shared.language == GameLanguage.AR.rawValue) ? "Tajawal-Regular" : "OpenSans-Regular")
        
        
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
                let sortedContactList = contacts.sorted { $0.firstName < $1.firstName }
                self.contacts = sortedContactList
                self.newList = sortedContactList
                self.selectedContactRow = -1
                self.isContactSelected = false
                self.contactTableView.reloadData()
            }
        }
    }
    
    func inviteApiCall() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
       // self.bPart = self.titleLbl.text!
        
        if self.bPart!.isEmpty {
            
            self.view.showAlert(message: "Please eneter a valid mobile number".localized()) { (done) in
                self.inviteButton.setButtonTitle(title: "Invite".localized(), titleColor: UIColor.darkBlueColor())
            }
            return
            
        }
        
        let no = bPart?.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        
        ReferViewModel.referInviteApiCall(bParty: no ?? "") { (data, err) in
            
            print("data is \(data)")
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
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
                            self.delegate?.referAction(isToHomePage: true)
                        }
                    case .referAgain:
                        self.referSuccessViewHelper.animateAndRemove()
                    case .gamePage:
                        self.referSuccessViewHelper.animateAndRemove()
                        self.dismiss(animated: true) {
                            self.delegate?.referAction(isToHomePage: false)
                        }
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
            self.closeBtn.isHidden = true
            shareContactLbl.text = "Select the contact to Invite".localized()
            print("text field cleared")
            self.newList = self.contacts
            //self.chooseContactButton.titleLabel.text = ""
            self.contactTableView.reloadData()
        default:
            break
        }
    }
    
    func onEditionTextField(text: String) {
        self.closeBtn.isHidden = false
       // print("contact listss", self.contacts.filter({ $0.firstName.prefix(text.count
//        ) == text }))
       /* self.newList = self.contacts.filter {
            $0.firstName.range(of: text, options: [.literal ]) != nil ||
                $0.telephone.range(of: text, options: [.literal ]) != nil
        } */
        
        self.newList = self.contacts.filter {
            $0.firstName.lowercased().prefix(text.count) == text.lowercased() ||
            $0.telephone.lowercased().prefix(text.count) == text.lowercased()
        }
        
        if self.newList.count > 1 {
            self.UnhidebaseViewForexistingUser()
        }
//        else {
//            self.UnhidebaseViewForValidUser()
//        }
        
        if self.newList.isEmpty, !text.isEmpty , text.isNumeric, !text.isAlphanumeric {
            let unknownContact = FetchedContact(firstName: "Unknown".localized(), lastName: "contact".localized(), telephone: text, image: nil, unknowContact: true)
            self.newList.insert(unknownContact, at: 0)
            shareContactLbl.text = "No match found".localized()
            //self.inviteButton.alpha = 0.0
            self.isUnknownContactVerified = false
            self.shouldHideBerifyButton = false
            self.verifyMessageview.isHidden = false
        } else {
            self.verifyMessageview.isHidden = true
        }
        
        if text.isEmpty {
            self.UnhidebaseViewForexistingUser()
            self.leftMessageLbl.text = "Click “Verify” to check whether the contact is a Simplylife user.".localized()
            self.shareContactLbl.text = "Select the contact to Invite".localized()
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

    func onCellTap(indexPath: IndexPath, cell: CustomContactCell) {
        self.view.endEditing(true)

        guard !self.newList.isEmpty else { return }
        
        guard self.newList.indices.contains(indexPath.row) else { return }
        
        var contact = self.newList[indexPath.row]
        placeHolderLbl.isHidden = false
        self.titleLbl.text = contact.telephone
        self.placeHolderLbl.text = (contact.firstName + " " + contact.lastName)
        self.newList.removeAll()
        self.newList.append(contact)
       
        self.contactTableView.reloadData()
        
        selectedContactRow = 0
        
        contactTableView.reloadRows(at: [indexPath], with: .fade)
        
        //self.inviteButton.alpha = 0.0
        if !(titleLbl.text?.isEmpty ?? "".isEmpty) {
            self.titleTopConstraints.constant = 25
        }
        
        self.verifyMessageview.isHidden = true
        contact.telephone = contact.telephone.replacingOccurrences(of: "-", with: "")
        ReferViewModel.checkSimpleLifeUserApi(bParty: contact.telephone.trimmingCharacters(in: .whitespaces)) { (data, err) in
            print("data is \(data)")
           
       // ReferViewModel.checkSimpleLifeUser(number: contact.telephone) { data, err   in
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                if data == nil {
                    self.showToast(message: "Something went wrong. Try again !")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    if (data == "201" || data == "200") {
                        self.isUnknownContactVerified = false
                        self.leftMessageLbl.sizeToFit()
                        self.leftMessageLblTopConstraints.constant = -30
                        self.verifyMessageview.isHidden = false
                        self.errorMsg = " "
                        self.shareContactLbl.text = "Sorry, this contact is a Simplylife user".localized()
                        self.leftMessageLbl.text = "Select another contact to refer".localized()
                        self.footerHeight = 0
                        self.contactTableView.reloadData()
                       // self.placeHolderLbl.text = "Enter a contact name or mobile number".localized()
                        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
                        self.bPart = contact.telephone
                        self.UnhidebaseViewForexistingUser()
                        self.leftMessageLbl.isHidden = false
                    } else if (data == "400") {
                        self.isUnknownContactVerified = true
                        self.errorMsg = ""
                        self.footerHeight = 0
                        self.contactTableView.reloadData()
                       // self.placeHolderLbl.text = "Enter a contact name or mobile number".localized()
                        self.handle?(contact.firstName + " " + contact.lastName, contact.telephone)
                        self.bPart = contact.telephone
                        self.UnhidebaseViewForValidUser()
                    } else {
                        self.isUnknownContactVerified = false
                        self.showToast(message: "Something went wrong. Try again !")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }
                
              //  self.contactTableView.reloadData()
                
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
   // }
    
    func hidebaseView() {
        bottomStackView.isHidden = true
        emptySpaceView.isHidden = false
        messageView.isHidden = true
    }
    
    func UnhidebaseViewForValidUser() {
        bottomStackView.isHidden = false
        emptySpaceView.isHidden = false
        messageView.isHidden = true
    }
    
    func UnhidebaseViewForexistingUser() {
        bottomStackView.isHidden = true
        emptySpaceView.isHidden = false
        messageView.isHidden = true
        //self.isContactSelected = false
    }
    
    func inviteButtonAppearance() {
        self.inviteButton.button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.inviteButton.setButtonTitle(title: "Invite".localized(), titleColor: UIColor.darkBlueColor())
    }
    
    @IBAction func clearFieldAction(_ sender: Any) {
        verifyMessageview.isHidden = true
        self.closeBtn.isHidden = true
        self.leftMessageLbl.text = "Click “Verify” to check whether the contact is a Simplylife user.".localized()
        shareContactLbl.text = "Select the contact to Invite".localized()
        dismissKeyboard()
    }
    

    
}
extension ContactListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomContactCell") as! CustomContactCell
        cell.verifyBtnAction = {
            let contactData = self.newList[indexPath.row]
            self.shouldHideBerifyButton = true
            cell.verifyBtn.isHidden = true
            self.isContactSelected = true
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
            self.placeHolderLbl.isHidden = false
            self.placeHolderLbl.text = contactData.firstName + contactData.lastName
            self.titleLbl.text = contactData.telephone
            self.isUnknownContactVerified = false
            self.onCellTap(indexPath: indexPath, cell: cell)
            self.shouldHideBerifyButton = true
        }
        
        cell.populateView(info: self.newList[indexPath.row])
        
        if selectedContactRow == indexPath.row, self.newList.count == 1, self.isContactSelected {
            cell.containerView.layer.borderWidth = 1.0
            cell.containerView.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1294117647, blue: 0.3960784314, alpha: 1)
        } else {
            cell.containerView.layer.borderWidth = 0.0
            cell.containerView.layer.borderColor = UIColor.clear.cgColor
        }
    
        
//        if self.isUnknownContactVerified {
//            cell.verifyBtn.isHidden = true
//        } else if (!isUnknownContactVerified && !verifyMessageview.isHidden) {
//            cell.verifyBtn.isHidden = true
//        }
        
        if shouldHideBerifyButton {
            cell.verifyBtn.isHidden = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? CustomContactCell
        activityIndicatorView.isHidden = false
        selectedCell?.verifyBtn.isHidden = true
        activityIndicatorView.startAnimating()
        self.shouldHideBerifyButton = true
        self.isContactSelected = true
        onCellTap(indexPath: indexPath, cell: selectedCell!)
        
       
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


