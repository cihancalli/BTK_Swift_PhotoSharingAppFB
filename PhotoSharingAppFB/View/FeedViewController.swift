//
//  FeedViewController.swift
//  PhotoSharingAppFB
//
//  Created by Cihan on 23.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        firebaseGetData()
    }
    
    func firebaseGetData() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot,error) in
            if error != nil {
                self.errorMessage(title: "FireStore Error", message: error!.localizedDescription)
            } else {
                if snapshot?.isEmpty !=  true && snapshot != nil {
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        if let comment = document.get("comment") as? String {
                            if let email = document.get("email") as? String {
                                if let imageUrl = document.get("imageUrl") as? String {
                                    self.postArray.append(Post(email: email,comment: comment,imageUrl: imageUrl))
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.labelEmail.text = postArray[indexPath.row].email
        cell.imageViewUpload.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl))
        cell.labelCommet.text = postArray[indexPath.row].comment
        return cell
    }
    
    func errorMessage (title:String, message:String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
}
