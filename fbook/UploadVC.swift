//
//  UploadVC.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import UIKit
import Firebase
import FirebaseStorage



class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagev: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(closekeyboard))
        view.addGestureRecognizer(gestureRecog)
        
        imagev.isUserInteractionEnabled = true
    let imageGesture = UITapGestureRecognizer(target: self, action: #selector(chooseimage))
        imagev.addGestureRecognizer(imageGesture)
    
    
    }
    @objc func chooseimage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        //picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagev.image = info[.originalImage] as? UIImage
        uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func closekeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func upload(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let media = storageRef.child("medias")
        
        if let data = imagev.image?.jpegData(compressionQuality: 0.5) {
            
            let  uuid = UUID().uuidString
            let imageRef = media.child("\(uuid).jpg")
            
            imageRef.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil {
                    self.Error(titleInput: "Error !", messageInput: "There is an error occured. Please try again")
                } else {
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            let firestoredb = Firestore.firestore()
                            if let imageUrl = imageUrl {
                                let fireSpost = ["imageurl" : imageUrl, "comment" : self.commentText.text, "email" : Auth.auth().currentUser!.email, "tarih" : FieldValue.serverTimestamp()] as [String : Any]
                                firestoredb.collection("post").addDocument(data: fireSpost) { (error) in
                                    if error != nil {
                                        self.Error(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again !")
                                    } else {
                                        self.imagev.image = UIImage(named: "gorselsec")
                                        self.commentText.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func Error(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelUpload(_ sender: Any) {
        performSegue(withIdentifier: "tofeedagain", sender: nil)
    }
}
