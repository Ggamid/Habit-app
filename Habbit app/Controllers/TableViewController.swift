//
//  TableViewController.swift
//  Habbit app
//
//  Created by Gamıd Khalıdov on 22.08.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    let habitStorage: HabitStorage = HabitStorage()
    var habits: [Habit] = []{
        didSet{
            habitStorage.saveHabit(habits)
        }
    }
    
    let colors = [UIColor.systemPink, UIColor.cyan, UIColor.red, UIColor.purple, UIColor.systemOrange, #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                    ]



    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. получение значение типа UINib, соответствующее xib-файлу кастом- ной ячейки
        let habitCell = UINib(nibName: "TableViewCell", bundle: nil)
        
        // 2. регистрация кастомной ячейки в табличном представлении
        tableView.register(habitCell, forCellReuseIdentifier: "TableViewCell")
        
        loadHabit()
        //123
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return habits.count
    }

    // MARK: CellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. получение переиспользуемой кастомной ячейки по ее идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        // 2. получаем текущий элемент, информация о котором должна быть выведена в строке
        let currentHabit = habits[indexPath.row]
        
        let forColorNum: Int = indexPath.row % colors.count
        
        let colorForCurCell = colors[forColorNum]
        
        // 3. заполняем ячейку данными
        cell.strickLabel.text = "\(currentHabit.strick)"
        
        cell.titleLabel.text = currentHabit.title
        cell.titleLabel.textColor = colorForCurCell
        
        cell.timeLabel.text = "Every day in: \(currentHabit.time)"
        
        switch currentHabit.status{
        case .completed:
            cell.checkmarkImage.image = UIImage(systemName: "checkmark.circle.fill")
        default:
            cell.checkmarkImage.image = UIImage(systemName: "checkmark.circle")
        }
        cell.checkmarkImage.tintColor = colorForCurCell
        

        return cell
    }
    
    // MARK: didSelectRowAt (change state of habit)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard type(of: habits[indexPath.row]) == Habit.self else {return}
        
        let curHabit = habits[indexPath.row]
        
        switch curHabit.status{
        case .completed:
            habits[indexPath.row].status = .notCompleted
            habits[indexPath.row].strick -= 1
        case .notCompleted:
            habits[indexPath.row].status = .completed
            habits[indexPath.row].strick += 1
        }
        
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController{
    // MARK: laodHabit
    func loadHabit(){
        habitStorage.loadHabit().forEach { habit in
            habits.append(habit as! Habit)
        }
    }
    
    // MARK: Segue to EditScreen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditScreen"{
            let destination = segue.destination as! EditController
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            
            destination.doAfterEdit = { [unowned self] title, date in
                let newHabit = Habit(title: title, time: dateFormatter.string(from: date), strick: 0, status: .notCompleted)
                habits.append(newHabit)
                tableView.reloadData()
            }
        }
    }
}
