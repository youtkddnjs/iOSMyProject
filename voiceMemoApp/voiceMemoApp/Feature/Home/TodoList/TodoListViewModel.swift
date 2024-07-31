//
//  TodoListViewModel.swift
//  voiceMemo
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo]
    @Published var isEdiTodoMode: Bool
    @Published var removeTodos: [Todo]
    @Published var isDisplayRemoveTodoAlert: Bool
    
    var removeTodocount: Int{
        return removeTodos.count
    }
    var navigationBarRightBtnMode: NavigationBtnType{
        isEdiTodoMode ? .complete : .edit
    }
    
    init(todos: [Todo] = [],
         isEditModeTodoMode: Bool = false,
         removeTodos: [Todo] = [],
         isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEdiTodoMode = isEditModeTodoMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }
  
}

extension TodoListViewModel {
    // Model/Todo/Todo.swift 의 seleted 값을 토글 시켜주기 위함.
    func selectedBoxTapped(_ todo: Todo){
        if let index = todos.firstIndex(where: {$0 == todo}) {
            todos[index].seleted.toggle()
        }
    }
    
    func addTodo(_ todo: Todo){
        todos.append(todo)
    }
    
    func navigationRightBtnTapped() {
        if isEdiTodoMode{
            if removeTodos.isEmpty{
                isEdiTodoMode = false
            }else{
                // alert을 출력
            }
        } else {
            isEdiTodoMode = true
        }
    }
    
    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool){
        isDisplayRemoveTodoAlert = isDisplay
    }
    
    func todoRemoveSeleteBoxTapped(_ todo: Todo){
        if let index = removeTodos.firstIndex(of: todo){
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    
    func removeBtnTapped(){
        todos.removeAll(){ todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEdiTodoMode = false
        
    }
    
}
