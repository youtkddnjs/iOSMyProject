//
//  OnboardingViewModel.swift
//  voiceMemo
//

import Foundation

class OnboardingViewModel: ObservableObject { // 뷰에서 stateObject 또는 ObservedObject 를 사용 하기위해 미리 추가함.
    @Published var onboardingContents: [OnboardingContent]
    
    init(
        onboardingContents: [OnboardingContent] = [
            .init(imageFileName: "onboarding_1", title: "오늘 할일", subTitle:"해야 하는 일"),
            .init(imageFileName: "onboarding_2", title: "기록장", subTitle:"메모 하는 기능"),
            .init(imageFileName: "onboarding_3", title: "음성메모", subTitle:"음성으로 메모"),
            .init(imageFileName: "onboarding_4", title: "타임기능", subTitle:"시간 확인")
        ]
    ) {
        self.onboardingContents = onboardingContents
    }
    
}
