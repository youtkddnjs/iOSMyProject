//
//  ToodoListView.swift
//  voiceMemo
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
  var body: some View {
      ZStack{
          VStack{
              if !todoListViewModel.todos.isEmpty {
                  CustomNavigationBar(
                    isDisplayBackBtn: false,
                    frontBtnAction: {
                        todoListViewModel.navigationRightBtnTapped()
                    },
                    frontBtnType: todoListViewModel.navigationBarRightBtnMode
                  )
              } else {
                  Spacer()
                      .frame(height: 30)
              }
              TitleView()
                  .padding(.top, 20)
              // 타이블뷰 다른 방식으로 사용하기
//              titleview
//              titleView()
              if todoListViewModel.todos.isEmpty{
                  TodoListGuideView()
              }else{
                  TodoListContentView()
                      .padding(.top,20)
              }
              
              WriteTodoBtnView()
                  .padding(.trailing,20)
                  .padding(.bottom, 50)
          } //VStack
          .alert(
            "To do list \(todoListViewModel.removeTodocount) 개 삭제하시겠습니까?",
            isPresented: $todoListViewModel.isDisplayRemoveTodoAlert
          ){
              Button("삭제", role: .destructive){
                  todoListViewModel.removeBtnTapped()
              }
              Button("취소", role: .cancel){}
          }
      } //ZStack
  }// var body
    
    
    // 프로퍼티로 사용하기
//    var titleView: some View{
//        Text("Title 1")
//    }
    // 메소드로 사용하기
//    func titleView() -> some View{
//        Text("Title 2")
//    }
    
} //struct TodoListView: View

// MARK: - TodoList Title View
private struct TitleView: View{ //자주 사용하거나 여러번 사용될 때 편한 방법
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View{
        HStack{
            if ( todoListViewModel.todos.isEmpty){
                Text("To do List를\n추가 해보세요.")
            }else{
                Text("\(todoListViewModel.todos.count)개의 목록이\n있습니다.")
            }
            Spacer()
        }
        .font(.system(size: 30,weight: .bold))
        .padding(.leading, 20)
    }
    
} //private struct TitleView: View

// MARK: - TodoList 안내 뷰
private struct TodoListGuideView: View{
    fileprivate var body: some View{
        VStack(spacing: 20){
            Spacer()
            Image("pencil")
                .renderingMode(.template)
            Text("\"매임 아침 6시 명상하자\"")
            Text("\"내임 아침 9시 카페 가자\"")
            Text("\"1시반 점심 약속\"")
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}//private struct TodoListGuideView: View

// MARK: - Todo List Content View
private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    
    fileprivate var body: some View{
        VStack{
            HStack{
                Text("할 일 목록")
                    .font(.system(size:16, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.vertical){
                VStack(spacing:0){
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)
                    
                    ForEach(todoListViewModel.todos, id: \.self){ todo in
                        //TODO: - todo 셀 뷰 todo 넣어서 뷰 호출
                    }
                }
            }
        }
    }
} //private struct TodoListContentView: View

// MARK: - Todo Cell View
private struct TodoCellView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo
    
    fileprivate init(
        isRemoveSelected: Bool = false,
        todo: Todo) {
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }
    
    fileprivate var body: some View{
        VStack(spacing: 20){
            HStack{
                if !todoListViewModel.isEdiTodoMode {
                    Button(action: {todoListViewModel.selectedBoxTapped(todo) },
                           label: { todo.selected ? Image("selectedBox") : Image("unSelectedBox") }
                    )
              }
                
                VStack(alignment: .leading , spacing: 5){
                    Text(todo.title)
                        .font(.system(size:16))
                        .foregroundColor(todo.selected ? .customIconGray : .customBlack)
                    Text(todo.convertedDayAndTime)
                        .font(.system(size:16))
                        .foregroundColor(.customIconGray)
                }
                Spacer()
                
                if todoListViewModel.isEdiTodoMode{
                    Button(
                        action:{
                            isRemoveSelected.toggle()
                            todoListViewModel.todoRemoveSeleteBoxTapped(todo)
                        },
                        label: {
                            isRemoveSelected ? Image("seletedBox") : Image("unSelectedBox")
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top,10)
            
            Rectangle()
                .fill(Color.customGray0)
                .frame(height:1)
        }//VStack(spacing: 20)
    } //fileprivate var body: some View
} //private struct TodoCellView: View

// MARK: Todo 작성 버튼 뷰

private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(
                    action: {
                        pathModel.paths.append(.todoView)
                    },
                    label: {
                        Image("writeBtn")
                    }
                )
            }
        }
    }

}

struct TodoListView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
          .environmentObject(PathModel())
          .environmentObject(TodoListViewModel())
  }
}
