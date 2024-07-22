//
//  OnboardingView.swift
//  voiceMemo
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel_my = OnboardingViewModel()
    
  var body: some View {
    // TODO: - 화면 전환 구현 필요
      NavigationStack(path: $pathModel.paths) {
          OnboardingContentView(onboardingViewModel_input: onboardingViewModel_my)
              .navigationDestination(
                for: PathType.self) { pathType_st in
                    switch pathType_st{
                    case .homeView:
                        HomeView()
                            .navigationBarBackButtonHidden()
                        
                    case .todoView:
                        TodoView()
                            .navigationBarBackButtonHidden()
                        
                    case .memoView:
                        MemoView()
                            .navigationBarBackButtonHidden()
                    }//switch pathType_st
                }
      }//NavigationStack(path: $pathModel.paths)
      .environmentObject(pathModel)
  }
}

// MARK: - 온보딩 컨테츠 뷰
private struct OnboardingContentView: View {
    
    @ObservedObject private var onboardingViewModel_ss: OnboardingViewModel
    
    fileprivate init(onboardingViewModel_input: OnboardingViewModel) {
        self.onboardingViewModel_ss = onboardingViewModel_input
    }
    
    fileprivate var body: some View {
        VStack{
            // 온보딩 셀리스트 뷰
            
            OnbardingCellListView(onboardingViewModel_WW: onboardingViewModel_ss)
            
            Spacer()
            // 시작버튼 뷰
            
            StartButtonView()
            
        }
        .edgesIgnoringSafeArea(.top) // 상단 배경 채우기위함
    }
} //private struct OnboardingContentView: View

// MARK: - 온보딩 셀 리스트 뷰
private struct OnbardingCellListView: View {
    @ObservedObject private var onboardingViewModel_WW: OnboardingViewModel
    @State private var selectedIndex: Int //TabView에서 사용함. 값에 따라 배경이 변하는 변수
    
    fileprivate init(
        onboardingViewModel_WW: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel_WW = onboardingViewModel_WW
        self.selectedIndex = selectedIndex
    }
    
    fileprivate var body: some View{
        TabView(selection: $selectedIndex,
                content:  {
            ForEach(Array(onboardingViewModel_WW.onboardingContents.enumerated()), id: \.element){ index, onboardingContent in
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(
            selectedIndex % 2 == 0
            ? Color.customSky : Color.customBackgroundGreen
        )
        .clipped() // 잘리는 부분 절삭을 위한 코드
    }
    
} //private struct OnbardingCellListView:

// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {
    private var onboardingContent_YY: OnboardingContent
    
    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent_YY = onboardingContent
    }
    
    fileprivate var body: some View {
        VStack{
            Image(onboardingContent_YY.imageFileName)
                .resizable()
                .scaledToFit()
            
            HStack{
                Spacer()
                VStack{
                    Spacer()
                        .frame(height: 46)
                    Text(onboardingContent_YY.title)
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                        .frame(height: 5)
                    
                    Text(onboardingContent_YY.subTitle)
                        .font(.system(size: 14))
                }
                Spacer()
            }
//            .background(Color.mycustomWhite)
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}


// MARK: - 시작하기 버튼 뷰
private struct StartButtonView: View {
    
    @EnvironmentObject private var pathMode_st: PathModel
    
    fileprivate var body: some View {
        Button(action: {
            pathMode_st.paths.append(.homeView)
        }, label: {
            HStack{
                Text("START!!!")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.customGreen)
                
                Image("startHome")
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.customGreen)
            }
        })
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
