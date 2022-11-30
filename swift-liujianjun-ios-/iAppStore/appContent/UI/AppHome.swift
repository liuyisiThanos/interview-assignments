//
//  RankHome.swift
//  iAppStore
//
//  Created by Thanos_Liu on 2022/11/29.
//  Copyright © 2022 liuyisi. All rights reserved.
//

import SwiftUI
import Network

struct AppHome: View {
    
    @StateObject private var appRankModel = AppRankModel()
    
    @State var isShowAlert = false
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top) {
                if appRankModel.isLoading {
                    LoadingView()
                } else {
                    if appRankModel.results.count == 0 {
                        emptyView
                    } else {
                        VStack() {
                            listView
                        }
                    }
                }
            }
            .background(Color.clear)
            .navigationBarTitle(Text("App"))
            .background(NavigationConfigurator(configure: { nav in
                nav.navigationBar.barTintColor = .black
                nav.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            if appRankModel.results.count == 0 {
                appRankModel.fetchRankData(50)
            }
        }
    }
    
    struct NavigationConfigurator: UIViewControllerRepresentable {
        var configure: (UINavigationController) -> Void = { _ in }

        func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
            UIViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
            if let nc = uiViewController.navigationController {
                self.configure(nc)
            }
        }
    }
        
}

extension AppHome {
    var emptyView: some View {
        VStack() {
            Spacer()
            Image(systemName: "tray.and.arrow.down")
                .font(Font.system(size: 60))
                .foregroundColor(Color.tsmg_tertiaryLabel)
            Spacer()
        }
    }
    
    var listView: some View {
        List {
//            Section(header: SectionHeader(title: "头部"),
//                    footer: Text("尾部")
//                        .foregroundColor(Color.orange)
//                        .padding(.leading, 16)
//                        .font(.system(size: 16, weight: .semibold))
//                        .background(Color.primary)) {
                
                ForEach(appRankModel.results, id: \.trackId) { item in
                    AppCellView(item: item)
                        .frame(height: 80)
                        .listRowSeparator(.hidden)
                }
//            }
            
        }.font(.largeTitle)
//            .listStyle(.grouped).refreshable {
////                .onAppear(perform: load)
//                print("没有更多了")
//            }
    }
    
//    var refreshFooter: some View {
//        RefreshFooter(state: viewModel.refreshState)
//            .foregroundColor(Color(.systemGray))
//            .onAppear {
//                viewModel.loadMoreData()
//            }
//    }
    
    struct SectionHeader: View {
        let title: String
        var body: some View {
            ZStack(alignment: .leading) {
                Color("tsmg_blue")
                    .frame(maxWidth: .infinity)
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.orange)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
    
    
//    func load() {
//        guard moments.isEmpty else { return }
//        moments = Moment.page1
//    }
//
//    func loadMore() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.moments.append(contentsOf: Moment.page2)
//            self.footerRefreshing = false
//            self.noMore = true
//        }
//    }
        
}


struct AppHome_Previews: PreviewProvider {
    static var previews: some View {
        AppHome()
    }
}


