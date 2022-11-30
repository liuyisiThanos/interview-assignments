//
//  RankCellView.swift
//  iAppStore
//
//  Created by Thanos_Liu on 2022/11/29.
//  Copyright © 2022 liuyisi. All rights reserved.
//

import SwiftUI

struct AppCellView: View {

    var item: Results
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            
            Avatar(icon: item.artworkUrl512)
            
            HStack() {
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Name(name: item.trackName)
                    
                    Spacer().frame(height: 5)
                    
                    if let text = item.description {
                        TextContent(text: text)
                    }
                }
                
                VStack(alignment: .trailing, spacing: 5) {
                    iconBtnView(isPlaying: false, icon: "icon_home_heart_n")
                }
            }
        }.padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color("chat_friend_background"))
        //            .padding(5)
            .cornerRadius(10)
            .listRowInsets(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)).background(Color.clear)
            .listRowBackground(Color("light_gray"))
            .modifier(ListRemoveSeparator())
//        .contextMenu { AppContextMenu(appleID: item.id.attributes.imID, bundleID: item.id.attributes.imBundleID, appUrl: item.id.label) }
    }
    
    struct iconBtnView: View {
        
        @State var isPlaying : Bool = false
        
        let icon: String
        var body: some View {
            Button(action: {
                print("touch")
                self.isPlaying.toggle()
            }) {
                HStack {
                Image(uiImage: self.isPlaying == true ? UIImage.init(named: "icon_home_heart_h")! : UIImage.init(named: "icon_home_heart_n")!)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.secondary)
//                        Spacer()
            }
        }
            //渐变
//            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                      .cornerRadius(40)

            //边框
//                    .background(.red.opacity(0.5))
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.red, lineWidth: 1))
        }
        
    }
    struct Avatar: View {
        let icon: String
        var body: some View {
            ImageLoaderView(
                url: icon,
                placeholder: {
                    Image("icon_placeholder")
                        .resizable()
                        .renderingMode(.original)
                        .cornerRadius(8)
                        .frame(width: 60, height: 60)
                },
                image: {
                    $0.resizable()
                        .resizable()
                        .renderingMode(.original)
                        .cornerRadius(8)
//                            .padding(.leading, 5)
//                            .clipped()
                        .frame(width: 60, height: 60)
                }
            )
        }
    }
    
    struct Name: View {
        let name: String
        var body: some View {
            Text(name)
//                .foregroundColor(.tsmg_blue)
                .lineLimit(1)
                .truncationMode(.tail)
            //                .font(.headline)
                .font(.system(size: 16, weight: .medium))
                .padding(.bottom, -6)
        }
    }
    
    struct TextContent: View {
        let text: String
        var body: some View {
            Text(text.replacingOccurrences(of: "\n", with: ""))
                .font(.system(size: 13, weight: .light))
                .lineLimit(2)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color("tsmg_background"))
    }
}

struct ListRemoveSeparator: ViewModifier {
    func body(content: Content) -> some View {
        content.onAppear(perform: {
                UITableView.appearance().tableFooterView = UIView()
                UITableView.appearance().separatorStyle = .none
            })
            .onDisappear(perform: {
                UITableView.appearance().tableFooterView = nil
                UITableView.appearance().separatorStyle = .singleLine

            })
    }

}
