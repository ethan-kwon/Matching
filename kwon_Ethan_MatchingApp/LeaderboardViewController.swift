import UIKit
public var leaderBoardPractice: [String] = []
public var leaderBoardTime: [String] = []
class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // This function counts the number of items in the array and returns the counted value
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the practice mode is selected, return the counted number of elements of leaderBoardPractice
        if switchLeaderboard.selectedSegmentIndex == 0 {
            return(leaderBoardPractice.count)
        }
        // If the time mode is selected, return the counted number of elements of leaderBoardTime
        else if switchLeaderboard.selectedSegmentIndex == 1 {
            return(leaderBoardTime.count)
        }
        // Otherwise return 1
        else {
            return(1)
        }
    }
    
    // This function creates cells and inputs the value of the string into the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Assign cell to a UITableViewCell
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        // If practice mode is selected, set the text of each cell to the string elements in leaderBoardPractice
        if switchLeaderboard.selectedSegmentIndex == 0 {
            cell.textLabel?.text = leaderBoardPractice[indexPath.row]
        }
        // If time mode is selected, set the text of each cell to the string elements in leaderBoardTime
        else if switchLeaderboard.selectedSegmentIndex == 1 {
            cell.textLabel?.text = leaderBoardTime[indexPath.row]
        }
        // Return the value of cell
        return(cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet var leaderboard: UITableView!
    @IBOutlet var switchLeaderboard: UISegmentedControl!
    
    @IBAction func switchLeaderboardPressed(_ sender: UISegmentedControl) {
        // Reload the data in the tableView
        leaderboard.reloadData()
    }
}
