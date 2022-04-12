//
//  Question.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/07.
//

import SwiftUI

private let categorys: [String] = [
    "패션/뷰티", "가구/인테리어", "식품/외식", "전자제품/디지털가전", "취미/여가", "기타"]

struct Contents: View{
    let number: Int
    @State private var topExpand: [Bool] = [true, false, false]
    @State private var name: String = ""
    @State private var price: String = ""
    @State private var link: String = ""
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @Binding var contentName: String
    
    @Binding var contentPrice: String
    
    @Binding var contentLink: String
    
//    func getData() -> [String] {
//        var image_to_String = image.toP
//        [name, price, link, image, ]
//    }
    
    
    var body: some View{
        DisclosureGroup("고민항목 \(number + 1)", isExpanded: $topExpand[number]) {
            TextField("고민항목 이름", text: $contentName)
            TextField("(선택) 가격을 입력해주세요", text: $contentPrice).keyboardType(.numberPad)
            TextField("(선택) 링크 추가", text: $contentLink)
            //let _ = print(name, price, link)
            Image(uiImage: self.image)
                .resizable()
                .frame(width: 100, height: 100)
                .background(Color.black.opacity(0.2))
                .background(
                    Image(systemName: "camera.fill"))
                .aspectRatio(contentMode: .fill).onTapGesture {
                    showSheet = true
                }
                .sheet(isPresented: $showSheet) {
                    // Pick an image from the photo library:
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
        }
    }
}

struct Question: View {
    
    @State private var qCategory: String = "카테고리"
    @State private var qTitle: String = ""
    @State private var content = ""
    
    // 고민항목 (데이터베이스 저장할 항목들)
    @State private var names = ["", "", ""]
    @State private var prices = ["", "", ""]
    @State private var links = ["", "", ""]
    
    @State private var categoryExpand: Bool = false
    @State private var Bools: [Bool] = [true, false]
    @State private var addItem: [Bool] = [true, false, false, false]
    
    
    @State var posts = PostData()
    var num = 0
    
    var body: some View {
        
        VStack{
            Form{
                TextField("글 제목", text: $qTitle)
                // 카테고리
                DisclosureGroup(qCategory, isExpanded: $categoryExpand) {
                    List{
                        ForEach(categorys, id: \.self){ category in
                            Text(category).onTapGesture {
                                qCategory = category
                                categoryExpand.toggle()
                            }.listRowBackground(
                                self.qCategory == category ?
                                Color.gray : Color(UIColor.white))
                        }
                    }
                }
                Contents(number: 0, contentName: $names[0], contentPrice: $prices[0], contentLink: $links[0])
                
                Contents(number: 1, contentName: $names[1], contentPrice: $prices[1], contentLink: $links[1])
                //self.num = 2
                Contents(number: 2, contentName: $names[2], contentPrice: $prices[2], contentLink: $links[2])
                
                // 고민내용
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color(UIColor.secondarySystemBackground))
                    
                    if content.isEmpty {
                        Text("고민내용")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 20)
                    }
                    
                    TextEditor(text: $content)
                        .padding(10)
                    
                }
                .frame(width: 300, height: 300)
            }
            
            
            Button("등록하기") {
                print(names)
                print(prices)
                print(links)
                //print(qTitle)
                //print(qCategory)
                //print(
               
                
            }.foregroundColor(.white)
                .frame(width: 180, height: 42, alignment: .center)
                .background(Color(hex: "8A67E8"))
                .cornerRadius(5)
                .padding(.vertical, 24.0)
        }.navigationBarTitle("질문하기")
    }
}

//IMAGE PICKER
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        Question()
    }
}
