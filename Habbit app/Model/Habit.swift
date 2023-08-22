//
//  Habit.swift
//  Habbit app
//
//  Created by Gamıd Khalıdov on 22.08.2023.
//

import Foundation

enum HabitStatus{
    case completed, notCompleted
}

protocol HabitProtocol{
    
    // title of Habit
    var title: String { get set }
    
    // time to do Habit
    var time: String { get set }
    
    // a series of accomplished habits
    var strick: Int { get set }
    
    // status of habit
    var status: HabitStatus { get set }
    
}

struct Habit: HabitProtocol{
    
    var title: String
    var time: String
    var strick: Int
    var status: HabitStatus
    
}
