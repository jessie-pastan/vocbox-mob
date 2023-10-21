//
//  OnboardingPagesView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/18/23.
//

import SwiftUI

struct OnboardingPagesView: View {
    @State private var pageIndex = 0
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
                            
                            Spacer()
                            OnboardingView(page: page)
                            Spacer()
                            if page == pages.last {
                                NavigationLink {
                                    // navigate to registration view
                                    ReviewVocView()
                                } label: {
                                    Text("Get Started")
                                        .font(.custom(.abrilFatfaceRegular, size:20))
                                        .fontWeight(.heavy)
                                        .foregroundStyle(Color(.selectedPartOfSpeech))
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
