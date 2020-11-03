//
//  SongInfoView.swift
//  MusicPlayer
//
//  Created by User22 on 2020/11/2.
//

import SwiftUI

struct SongInfoView: View {
    @Binding var showSongInfo: Bool
    @State private var mood = ""
    @State private var favoriteVal = 100
    @State private var showAlert = false
    @State private var showAlertString = ""
    @State private var alertString = ""
    @State private var chooseDate = Date()
    
    func checkFavoriteVal() -> String {
        switch favoriteVal {
        case 0 ..< 60:
            showAlertString = "好吧... 下次會更好的QQ"
        case 60 ..< 75:
            showAlertString = "看來你覺得這首歌還好"
        case 75 ..< 85:
            showAlertString = "哦！看來我推薦對了唷！"
        case 85 ..< 100:
            showAlertString = "喜歡的話可以多推廣歌喔٩(๑>∀<๑)۶"
        default:
            showAlertString = "看來有人音樂品味跟我一樣好(灬´ิω´ิ灬)"
        }
        
        showAlert = true
        return showAlertString
    }
    
    var body: some View {
        VStack {
            
            
            Text("下面可以記錄聽歌感想或生活點滴喔！")
            TextEditor(text: $mood)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 3))
                .frame(height: 300)
            
            DatePicker("快記錄日期 ٩(๑>∀<๑)۶", selection: $chooseDate, displayedComponents: .date)
            
            Stepper(value: $favoriteVal, in: 0...100) {
                Text("快說這首歌有 \(favoriteVal) 分 ٩(๑>∀<๑)۶")
            }
            
            Button("確定分數", action: {alertString = checkFavoriteVal()})
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text(alertString), dismissButton: .default(Text("好ㄉ")))
                     }
            
            Spacer()
            
            Text(chooseDate, style: .date)
                .multilineTextAlignment(.trailing)
                
            
            Button("回到前一頁") {
                showSongInfo = false
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
        .padding()
        .background(Color(red: 252/255, green: 245/255, blue: 221/255))
        .foregroundColor(Color(red: 109/255, green: 100/255, blue: 83/255))

    }
}

struct SongInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SongInfoView(showSongInfo: .constant(true))
    }
}
