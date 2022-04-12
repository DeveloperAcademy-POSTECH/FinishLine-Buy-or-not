//
//  testUser.swift
//  buy-or-not
//
//  Created by David_ADA on 2022/04/12.
//

import Foundation
import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct TestUser: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var comment: String
    var email: String
    var password: String
    var imageURL: String
    var interested: String
    
    enum CodingKeys: CodingKey {
        case name
        case comment
        case email
        case password
        case imageURL
        case interested
    }
    
}
let testUserData = [
    TestUser(name:"홍길동",comment:"반갑습니다 홍길동입니다",email:"gilldong@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민"),
    TestUser(name:"이순신",comment:"반갑습니다 이순신입니다",email:"soonsin@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
             interested: "구휼난민"),
    TestUser(name:"장보고",comment:"반갑습니다 장보고입니다",email:"bogo@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민"),
    TestUser(name:"홍길동",comment:"반갑습니다 홍길동입니다",email:"gilldong@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민"),
    TestUser(name:"이순신",comment:"반갑습니다 이순신입니다",email:"soonsin@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
             interested: "구휼난민"),
    TestUser(name:"장보고",comment:"반갑습니다 장보고입니다",email:"bogo@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민"),
    TestUser(name:"홍길동",comment:"반갑습니다 홍길동입니다",email:"gilldong@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민"),
    TestUser(name:"이순신",comment:"반갑습니다 이순신입니다",email:"soonsin@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
             interested: "구휼난민"),
    TestUser(name:"장보고",comment:"반갑습니다 장보고입니다",email:"bogo@naver.com",password: "rlfehd1234",imageURL:
            "https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.newscj.com%2Fnews%2Fphoto%2F201001%2F31870_28928_182.jpg&imgrefurl=http%3A%2F%2Fwww.newscj.com%2Fnews%2FarticleView.html%3Fidxno%3D31870&tbnid=VfW24Gu7bEjl5M&vet=12ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ..i&docid=oUUsZk9prZ5u1M&w=550&h=379&q=%ED%99%8D%EA%B8%B8%EB%8F%99&ved=2ahUKEwiliLulqo73AhVYTPUHHTK4B0MQMygAegUIARDYAQ",
            interested: "구휼난민")
]

struct TestUserListView: View {
    var testUsers = testUserData

    var body: some View {
        NavigationView {
            List(testUsers) {
                testUser in
                VStack(alignment:.leading) {
                    Text(testUser.name).font(.headline)
                    Text(testUser.comment).font(.subheadline)
                    Text("\(testUser.email)")
                    Text("\(testUser.password)")
                    Image(testUser.imageURL)
                }
            }
            .navigationTitle("TestUsers")
        }
        Button("데이터패치") {
            var testUser = TestUsersViewModel()
            testUser.fetchData()
        }
    }
}

struct TestUserListView_Previews: PreviewProvider {
    static var previews: some View {
        TestUserListView()
    }
}


class TestUsersViewModel: ObservableObject {
    var authInstance = FirebaseAuth.Auth.auth()
    
    @Published var testUsers = [TestUser]()

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("User").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("Not Doc")
                return
            }
            self.testUsers = documents.map { querySnapshot -> TestUser in
                let data = querySnapshot.data()
                let name = data["name"] as? String ?? ""
                let comment = data["comment"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                let interested = data["interested"] as? String ?? ""
                return TestUser(name:name, comment:comment, email:email, password: password,imageURL: imageURL,interested: interested)
                }
    }
    }
    func addData(name:String, comment:String, email:String, password:String, imageURL:String, interested:String) {
        var authInstance = FirebaseAuth.Auth.auth()
        authInstance.createUser(withEmail: email, password: password)
        { (user, error) in
            if error == nil{
                print("1")
                guard let userID = Auth.auth().currentUser?.uid else {
                    print("2")
                    return }
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("User").addDocument(data: [
                    "id":userID,
                    "name":name,
                    "comment":comment,
                    "email":email,
                    "password":password,
                    "imageURL:":imageURL,
                    "interestd":interested
                    ]
                )}
}
    }
    func deleteData() {
        
    }
    
}
//
//            func getData() {
//            ////            let docRef = Firestore.firestore().collection("User").whereField("id", isEqualTo: authInstance.currentUser?.uid ?? "")
//            ////
//            ////            docRef.getDocuments{(querySnapshot, err) in
//            ////                if let err = err {
//            ////                    print(err.localizedDescription)
//            ////                } else if querySnapshot!.documents.count != 1 {
//            ////                    print("More than one document or none")
//            ////                } else {
//            ////                    let document = querySnapshot!.documents.first
//            ////                    let dataDescription = document?.data()
//            ////                    guard let userName = dataDescription?["name"] else {
//            ////                        return
//            ////                    }
//            ////                    print(userName)
//            ////                }
//            ////            }
//            //        }
