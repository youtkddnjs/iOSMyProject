//
//  OnboardingContent.swift
//  voiceMemo
//

import Foundation

struct OnboardingContent: Hashable { // Tab에서도 사용하도록 Hashable 추가함
    var imageFileName: String
    var title: String
    var subTitle: String
    
    init(
        imageFileName: String,
        title: String,
        subTitle: String) {
        self.imageFileName = imageFileName
        self.title = title
        self.subTitle = subTitle
    }
    
    
}//struct OnboardingContent
