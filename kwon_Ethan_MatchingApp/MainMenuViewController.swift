import UIKit

class MainMenuViewController: UIViewController {
    
    // Prepares the game screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the segue identifier is "goToGame", set the destination of the segue to the MatchingViewController (game)
        if segue.identifier == "goToGame",
            let matchingVC = segue.destination as? MatchingViewController {
        // Let the sender be the sending UIButton, that must be a UIButton or otherwise returns
        guard let sender = sender as? UIButton else {return}
        // If the sending button is buttonPractice, set the value of gameMode to 1
        if sender == buttonPractice {
            matchingVC.gameMode = 1
        }
        // If the sending button is buttonMulti, set the value of gameMode to 2
        else if sender == buttonMulti {
            matchingVC.gameMode = 2
        }
        // If the sending button is buttonTime, set the value of gameMode to 3
        else if sender == buttonTime {
            matchingVC.gameMode = 3
        }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the value of the global variables leaderBoardPractice and leaderBoardTime to the stored data of the respective assigned keys. If there is no stored data yet, assign it to an empty string instead.
        leaderBoardPractice = UserDefaults.standard.stringArray(forKey: "practiceScoreArray") ?? [""]
        leaderBoardTime = UserDefaults.standard.stringArray(forKey: "timedScoreArray") ?? [""]
    }
    @IBAction func practicePressed(_ sender: UIButton) {
        // If the sender is any of the game buttons, set the identifier to "goToGame" and the sender to the sending button
        if sender == buttonPractice || sender == buttonTime || sender == buttonMulti {
        performSegue(withIdentifier: "goToGame", sender: sender)
        }
        // If the sender is the rules button, set the identifier to "goToRules" and the sender to the rules button
        else if sender == buttonRules {
            performSegue(withIdentifier: "goToRules", sender: sender)
        }
        // If the sender is the leaderboard button, set the identifier to "goToLeaderBoard" and the sender to the rules button.
        else if sender == buttonLeaderBoard {
            performSegue(withIdentifier: "goToLeaderBoard", sender: sender)
        }
    }
    @IBOutlet var buttonRules: UIButton!
    @IBOutlet var buttonPractice: UIButton!
    @IBOutlet var buttonMulti: UIButton!
    @IBOutlet var buttonTime: UIButton!
    @IBOutlet var buttonLeaderBoard: UIButton!
}

