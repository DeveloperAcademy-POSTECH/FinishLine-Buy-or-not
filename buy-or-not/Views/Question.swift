//
//  Question.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/07.
//

import SwiftUI

struct QuestionContentView: View{
    @State var questionButton: Bool = false
    
    var body: some View{
        if questionButton{
            //Main2화면 넣기
            Main()
        }
        else{
            Question(questionButton: $questionButton)
        }
    }
}

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
    
    
    var body: some View{
        DisclosureGroup("고민항목 \(number + 1)", isExpanded: $topExpand[number]) {
            TextField("고민항목 이름", text: $name)
            TextField("(선택) 가격을 입력해주세요", text: $price).keyboardType(.numberPad)
            TextField("(선택) 링크 추가", text: $link)
            
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
    @Environment(\.presentationMode) var presentation // 네비게이션 바 없애기 위함
        //화면 변경
    @Binding var questionButton: Bool
    
    @State private var qCategory: String = "카테고리"
    @State private var qTitle: String = ""
    @State private var content = ""
    
    @State private var categoryExpand: Bool = false
    @State private var Bools: [Bool] = [true, false]
    @State private var addItem: [Bool] = [true, false, false, false]
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
                                categoryExpand = Bools[1]
                            }.listRowBackground(
                                self.qCategory == category ?
                                Color.gray : Color(UIColor.white))
                        }
                    }
                }
                
                // 고민항목
                ForEach(0..<3){num in
                    if addItem[num]{
                        Contents(number: num)
                            .onTapGesture{
                                addItem[num+1] = Bools[0]
                            }
                    }
                }
                
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
                questionButton.toggle()
                self.presentation.wrappedValue.dismiss()
               
                
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
