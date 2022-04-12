//
//  UserData.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class UserData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case name
        case comment
        case email
        case password
        case imageURL
        case interested
    }
    @DocumentID var id: String? = UUID().uuidString
    let name: String
    var comment: String
    var email: String
    var password: String
    var imageURL: String
    var interested: String
    
    
    
    @Published var users = [UserData]()
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("User").addSnapshotListener{ (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
            print("No documents")
            return
        }
        

        self.users = documents.compactMap{ (QueryDocumentSnapshot) -> UserData? in return try? QueryDocumentSnapshot.data(as: UserData.self)
            
//
//            let data = QueryDocumentSnapshot.data()
//
//            let name = data["name"]
//            let email = data ["email"]
//            let comment = data["comment"]
//            let imageUrl = data["imageUrl"]
//            let interest = data["interest"]
        }
        }
    }
}

