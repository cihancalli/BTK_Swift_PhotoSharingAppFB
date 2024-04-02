//
//  UploadViewController.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 23.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var imageViewUpload: UIImageView!
    @IBOutlet weak var textFieldComment: UITextField!
    
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewUpload.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageViewUpload.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageViewUpload.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.isSelected = true
    }
    
    @IBAction func buttonSend(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if self.isSelected {
            if let data = imageViewUpload.image?.jpegData(compressionQuality: 0.5) {
                
                let uuid = UUID().uuidString
                
                let imageReference = mediaFolder.child("\(uuid).jpg")
                
                imageReference.putData(data,metadata: nil) { (storagemetadata,error) in
                    if error != nil {
                        self.errorMessage(title: "Upload Image Error", message: error!.localizedDescription)
                    } else{
                        imageReference.downloadURL { (url,errorImage) in
                            if errorImage != nil {
                                self.errorMessage(title: "Upload URL Error", message: error!.localizedDescription)
                            } else {
                                let imageUrl = url?.absoluteString
                                if let imageUrl = imageUrl {
                                    
                                    let firestoreDatabase = Firestore.firestore()
                                    
                                    let fitrestorePost = [
                                        "imageUrl":imageUrl,
                                        "comment": self.textFieldComment.text!,
                                        "email":Auth.auth().currentUser!.email ?? "",
                                        "date": FieldValue.serverTimestamp()
                                    ] as [String:Any]
                                    
                                    firestoreDatabase.collection("Post").addDocument(data: fitrestorePost) { (error) in
                                        if error != nil {
                                            self.errorMessage(title: "Upload Database Error", message: error!.localizedDescription)
                                        } else {
                                            self.textFieldComment.text = ""
                                            self.imageViewUpload.image = UIImage(named: "select_image")
                                            self.tabBarController?.selectedIndex = 0
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            self.errorMessage(title: "IMAGE NOT SELECTED ERROR", message: "Please select an image to install Firestore")
        }

    }
    
    func errorMessage (title:String, message:String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
}
