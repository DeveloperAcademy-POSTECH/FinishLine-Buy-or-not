//
//  Posts.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/12.
//
import Firebase
import FirebaseFirestore
import CoreVideo
import SwiftUI
import Foundation


//struct Post: Codable, Identifiable{
//    @DocumentID var id: String? = UUID().uuidString
//
//    var title: String
//    var timeStamp: String
//    var items: [[String]]
//
//    enum CodingKeys: CodingKey {
//        case title
//        case timeStamp
//        case items
//    }
//
//}

class Posts {
    
    let db = Firestore.firestore()
    //@Published var localPosts = [Post]()
    
    func postData(
        title: String,
        timeStamp: String,
        items: [[String]]
    ) {
        var ref: DocumentReference? = nil
        ref = db.collection("Post").addDocument(data: [
            "title": title,
            "timeStamp": timeStamp,
            "items": items
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
//    func fetchData() {
//        db.collection("Post").addSnapshotListener {(querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("Not Doc")
//                return
//            }
//            self.localPosts = documents.map { querySnapshot -> Post in
//                let data = querySnapshot.data()
//                let title = data["title"] as? String ?? ""
//                let timeStamp = data["timeStamp"] as? String ?? ""
//                let items = data["items"] as? [[String]] ?? []
//                return Post(title:title, timeStamp:timeStamp, items:items)
//            }
//        }
//    }
}
