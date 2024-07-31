//
//  CustomNavigationBar.swift
//  voiceMemo
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayBackBtn: Bool
    let isDisplayFrontBtn: Bool
    let backBtnAction: () -> Void
    let frontBtnAction: () -> Void
    let frontBtnType: NavigationBtnType
    
    init(isDisplayBackBtn: Bool  = true,
         isDisplayFrontBtn: Bool = true,
         backBtnAction: @escaping () -> Void = {},
         frontBtnAction: @escaping () -> Void = {},
         frontBtnType: NavigationBtnType = .edit) {
        self.isDisplayBackBtn = isDisplayBackBtn
        self.isDisplayFrontBtn = isDisplayFrontBtn
        self.backBtnAction = backBtnAction
        self.frontBtnAction = frontBtnAction
        self.frontBtnType = frontBtnType
    }
    
    var body: some View {
        HStack{
            if isDisplayBackBtn{
                Button(action: backBtnAction) {
                    Image("leftArrow")
                }
            }
            Spacer()
            if isDisplayFrontBtn{
                Button(action: frontBtnAction,
                       label: {
                    if frontBtnType == .close {
                        Image("close")
                    }else{
                        Text(frontBtnType.rawValue)
                            .foregroundColor(.customBlack)
                    }
                })
            }
        } //HStack
        .padding(.horizontal, 20)
        .frame(height:20)
    } // body
}
struct CustomNavigationBar_Previews: PreviewProvider {
  static var previews: some View {
    CustomNavigationBar()
  }
}
