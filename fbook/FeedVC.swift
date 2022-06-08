//
//  FeedVC.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableV: UITableView!
    
    //var postsArray = [String]()
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableV.delegate = self
        tableV.dataSource = self
        
        fbGetdata()
    }
    
    func fbGetdata() {
        let fsDB = Firestore.firestore()
        
        fsDB.collection("post").order(by: "tarih", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {

                if snapshot?.isEmpty == false && snapshot != nil {
                    //self.postsArray.removeAll(keepingCapacity: false)
                   self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        if let imageUrl = document.get("imageurl") as? String {
                            self.imageArray.append(imageUrl)
                            if let email = document.get("email") as? String {
                                self.emailArray.append(email)
                                if let comment = document.get("comment") as? String {
                                    self.commentArray.append(comment)
                                }
                            }
                        }
                    }
                    self.tableV.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "fcell", for: indexPath) as! FeedCell
        cell.emailText.text = emailArray[indexPath.row]
        cell.commentText.text = commentArray[indexPath.row]
        cell.postimagev.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }

}
