//
//  SongTypeView.swift
//  MusicPlayer
//
//  Created by User22 on 2020/11/2.
//

import SwiftUI
import AVFoundation

struct SongTypeView: View {
    var musicType = ["搖滾", "抒情", "嘻哈", "R&B", "有點難解釋"]
    @State private var selectedIndex = 0
    @State private var selectedSong = what[0]
    @State private var song = what[0]
    @State private var musicPlayer = AVPlayer(url: URL(string: what[0].url)!)
    @State private var isShow = false
    @State private var isPlay = false
    @State private var showSongInfo = false
    @State private var bgColor = Color.black
    @State private var ftColor = Color.white
    @State private var redVal = 1.0
    @State private var greenVal = 1.0
    @State private var blueVal = 1.0
    @State private var brightnessAmount = 0.1
    
    func selectRandomSong(songType: Int) -> Song {
        isShow = true
        
        switch songType {
        case 0:
            selectedSong = rock.randomElement()!
        case 1:
            selectedSong = lyrical.randomElement()!
        case 2:
            selectedSong = HipHop.randomElement()!
        case 3:
            selectedSong = rnb.randomElement()!
        default:
            selectedSong = what.randomElement()!
        }
        musicPlayer = AVPlayer(url: URL(string: selectedSong.url)!)
        
        return selectedSong
    }

    var body: some View {
        VStack {
                Image("music")
                    .resizable()
                    .scaledToFit()
                    .brightness(brightnessAmount)
                    //.colorMultiply(Color(red: redVal, green: greenVal, blue: blueVal))
                
                HStack{
                    Text("今晚，我想來點")
                    
                    Picker(selection: $selectedIndex, label: Text("選擇音樂類型")) {
                        ForEach(musicType.indices) { (index) in
                            Text(musicType[index])
                                .foregroundColor(ftColor)
                        }
                    }
                    .frame(width: 130, height: 90)
                    .clipped()
                    
                    Text("的音樂")
                    
                    Button(action: {song = selectRandomSong(songType: selectedIndex)}) {
                        Text("Go")
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.gray)
                            .background(Color(red: 220/255, green: 220/255, blue: 220/255))
                            .cornerRadius(30)
                    }
                    .padding(.leading, 20.0)
                }
                
                Group {
                   if isShow == true {
                        Text("\(song.name)\n\(song.singer)")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        
                        Button("給我說個故事吧！") {
                            showSongInfo = true
                        }
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .sheet(isPresented: $showSongInfo) {
                            SongInfoView(showSongInfo: self.$showSongInfo)
                        }
                        
                    
                        //musicPlayer = AVPlayer(url: URL(string: song.url)!)
                        // Bug : 不能播歌QQ
                        Toggle("要播歌嗎？要啦要啦٩(๑>∀<๑)۶", isOn: $isPlay)
                            .onChange(of: isPlay, perform: { value in
                                if value {
                                    musicPlayer.play()
                                } else {
                                    musicPlayer.pause()
                                }
                            })
                    }
                }
                .padding()
                
                Spacer()
                
                DisclosureGroup("想改設定嗎？我聽到你的聲音了( ͡° ͜ ʖ ͡°)✧") {
                    Form {
                        ColorSlider(bgColor: $bgColor, ftColor: $ftColor)
                        BrightnessSlider(brightnessAmount: $brightnessAmount)
                            
                        /*VStack{
                            Text("調個喜歡的圖片顏色吧（依序為紅綠藍色）")
                            HStack{
                                Slider(value: $redVal, in: 0...1)
                                Slider(value: $greenVal, in: 0...1)
                                Slider(value: $blueVal, in: 0...1)
                            }
                        }*/
                    }
                    .foregroundColor(Color.black)
                    .frame(height: 160)
                    //.background(bgColor)
                }
                .padding()
        }
        .background(bgColor)
        .foregroundColor(ftColor)
    }
}

struct SongTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SongTypeView()
    }
}

struct ColorSlider: View {
    @Binding var bgColor: Color
    @Binding var ftColor: Color
    
    var body: some View {
        HStack {
            ColorPicker("設背景顏色", selection: $bgColor)
            ColorPicker("設字體顏色", selection: $ftColor)
        }
    }
}

struct BrightnessSlider: View {
    @Binding var brightnessAmount: Double
    
    var body: some View {
        HStack{
            Text("調圖片亮度")
            Slider(value: $brightnessAmount, in: 0...1)
        }
    }
}
