//
//  OnboardingPagesView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/18/23.
//

import SwiftUI

struct OnboardingPagesView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var pageIndex = 0
    @State private var readyToNavigate: Bool = false
    private let pages: [OnboardingPage] = OnboardingPage.pages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .ignoresSafeArea()
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack(spacing: 50) {
                            GeometryReader{ proxy in
                               OnboardingView(page: page, width: proxy.size.width / 1 , height: proxy.size.height / 1.2 )
                                    .padding(.bottom,40)
                            }
                            
                            if page == pages.last {
                                Button {
                                    readyToNavigate = true
                                    //TODO: UnComment this function for production testing
                                    //Action: Save joined date of user
                                    
                                    CoreDataController().addUserJoinedDate(context: moc)
                                    print("DeBug: Saved joined date")
                                    
                                } label: {
                                    Text("Get Started")
                                        .font(.custom(.abrilFatfaceRegular, size:20))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(Color(.selectedPartOfSpeech))
                                }
                                .navigationDestination(isPresented: $readyToNavigate){ ReviewVocView()
                                }
                                
                              
                                
                            } else {
                                   
                                Button {
                                    // move to next page
                                    incrementPage()
                                } label: {
                                    Text("Next")
                                        .font(.custom(.abrilFatfaceRegular, size: 20))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(Color(.selectedPartOfSpeech))
                                    
                                }
                            }
                            Spacer()
                            
                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: pageIndex)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                
                .onAppear{
                    dotAppearance.currentPageIndicatorTintColor = .black
                    dotAppearance.pageIndicatorTintColor = .gray
                }
            }
           
        }.tint(Color(UIColor.label))
    }
    
    func incrementPage(){
        pageIndex += 1
    }
    

}

#Preview {
    OnboardingPagesView()
}
