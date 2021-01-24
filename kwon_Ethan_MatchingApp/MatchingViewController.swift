import UIKit

public var storedData = UserDefaults.standard

class MatchingViewController: UIViewController {
    // A variable that will be used to determine which mode was selected
    var gameMode: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide the new game button
        buttonNewGame.isHidden = true
        // Hide the give up button
        buttonGiveUp.isHidden = true
        // User disable all of the matching buttons
        disableEnableThings(disableThem: false)
        // Set the value of sending button to startNewGame
        sendingButtonTitle = "startNewGame"
        // Create an alert with an empty title and message
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        // Add an action to the alert with the title "Back", which will send the user back to the main menu screen
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: {(action:UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        // If gameMode is equal to 1
        if gameMode == 1 {
            // Hide the associated labels that are used for other gamemodes such as, player1Points, timer, player2points, etc.
            labelPlayer1Points.isHidden = true
            labelPlayer2Points.isHidden = true
            labelPlayersTurn.isHidden = true
            labelTimer.isHidden = true
            labelTime.isHidden = true
            // Make the title of the alert to "Input Name"
            alert.title = "Input Name"
            // Make the message of the alert to "Please input your name"
            alert.message = "Please input your name"
            // Create a text field for the player's name
            alert.addTextField(configurationHandler: { (textfield:UITextField) in
                textfield.placeholder = "Player Name"
            })
            // Add an action with the title "Ok" that will dismiss the alert and check if a name was inputted
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction) in
                // If the textfield is empty, send a second alert that says error and to give a name.
                if alert.textFields![0].text?.isEmpty == true {
                    let secondAlert = UIAlertController(title: "Error", message: "Write a name.", preferredStyle: .alert)
                    secondAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                        (action:UIAlertAction) in
                        self.present(alert, animated: true, completion: nil)
                    }))
                    self.present(secondAlert, animated: true, completion: nil)
                }
                // If the textfield is not empty, set the value of player name to the inputted text in the textfield, set the text of label points to the name of the player, and run the timer that will flip the buttons
                else if alert.textFields![0].text?.isEmpty == false {
                    self.playerName = alert.textFields![0].text!
                    self.labelPoints.text = "\(self.playerName)'s Points: 0"
                    // Run the card timer that will flip all of the matching buttons indiviually
                    self.cardTimer()
                }
            }))
            // Presents the alert
            self.present(alert, animated: true, completion: nil)
            // Set the title of the view to "Practice Mode"
            navigationItem.title = "Practice Mode"
        }
        // If gameMode is equal to 2
        else if gameMode == 2 {
            // Set the title of the view to "Multiplayer"
            navigationItem.title = "Multiplayer"
            // Hide the labels associated with other modes such as, labelPoints, labelTimer, and labelTime
            labelPoints.isHidden = true
            labelTimer.isHidden = true
            labelTime.isHidden = true
            // Set the title of the alert to "Input Names"
            alert.title = "Input Names"
            // Set the message of the alert to "Please input the names of the first and second player"
            alert.message = "Please input the names of the first and second player"
            // Create a text field that will grab the first player's name
            alert.addTextField(configurationHandler: { (textfield:UITextField) in
                textfield.placeholder = "First Player's Name"
            })
            // Create a text field that will grab the second player's name
            alert.addTextField(configurationHandler: {
                (textfield:UITextField) in
                textfield.placeholder = "Second Player's Name"
            })
            // Add an action that will dismiss the alert, check if there is text in the textfields, set the text of the points labels to the players' names, and run the flip card timer
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction) in
                // If either of the textfields are empty, send a second alert that says "Error" and to write a name
                if alert.textFields![0].text?.isEmpty == true || alert.textFields![1].text?.isEmpty == true {
                    let secondAlert = UIAlertController(title: "Error", message: "Write a name.", preferredStyle: .alert)
                    secondAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                        (action:UIAlertAction) in 
                        self.present(alert, animated: true, completion: nil)
                    }))
                    self.present(secondAlert, animated: true, completion: nil)
                }
                // Otherwise, if both textfields are not empty
                else if alert.textFields![0].text?.isEmpty == false && alert.textFields![1].text?.isEmpty == false {
                    // Run the card timer that will flip all of the matching buttons indiviually
                    self.cardTimer()
                    // Set the value of player1Name to the text of the first textfield
                    self.player1Name = alert.textFields![0].text!
                    // Set the value of player2Name to the text of the second textfield
                    self.player2Name = alert.textFields![1].text!
                    // Set the text of labelPlayer1Points to the text of player1Name
                    self.labelPlayer1Points.text = "\(self.player1Name)'s Points: 0"
                    // Set the text of labelPlayer2Points to the text of player2Name
                    self.labelPlayer2Points.text = "\(self.player2Name)'s Points: 0"
                    // Set the text of labelPlayersTurn to the first player's name
                    self.labelPlayersTurn.text = "\(self.player1Name)'s Turn"
                }
            }))
            // Presents the alert
            self.present(alert, animated: true, completion: nil)
        }
        // If gameMode is equal to 3
        else if gameMode == 3 {
            // Set the title of the alert to "Input Name"
            alert.title = "Input Name"
            // Set the mesage of the alert to "Please input your name"
            alert.message = "Please input your name"
            // Add a textfield with a placeholder "Player Name"
            alert.addTextField(configurationHandler: { (textfield:UITextField) in
                textfield.placeholder = "Player Name"
            })
            // Add an action with the title "Ok". If the textfield is empty, send a second alert that says "Error" and to write a name. If there is a name, run the cardTimer, set player name to the text in the textfield, and set the labelPoints to the name of the player
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction) in
                if alert.textFields![0].text?.isEmpty == true {
                    let secondAlert = UIAlertController(title: "Error", message: "Write a name.", preferredStyle: .alert)
                    secondAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                        (action:UIAlertAction) in
                        self.present(alert, animated: true, completion: nil)
                    }))
                    self.present(secondAlert, animated: true, completion: nil)
                } else if alert.textFields![0].text?.isEmpty == false {
                    // Run the card timer that will flip all of the matching buttons indiviually
                    self.cardTimer()
                    self.playerName = alert.textFields![0].text!
                    self.labelPoints.text = "\(self.playerName)'s Points"
                }
            }))
            // Presents the alert
            self.present(alert, animated: true, completion: nil)
            // Sets the title of the view to "Time Mode"
            navigationItem.title = "Time Mode"
            // Hide the player 1 and 2 point labels and the player turn label
            labelPlayer1Points.isHidden = true
            labelPlayer2Points.isHidden = true
            labelPlayersTurn.isHidden = true
        }
        // Run the shuffle function
        shuffle()
    }
    func shuffle() {
        // Use the shuffle method to shuffle my picture array
        pictureArray.shuffle()
        // For each image in the picture array, match each button to their corresponding image with the dictionary
        for (index, button) in matchingButtons.enumerated() {
            pictureDictionary[button] = pictureArray[index]
        }
    }
    func checkIfFinished() {
        var check: Int = 0
        // For each button in matchingButtons, if it is disabled, add 1 to the check variable
        for button in matchingButtons {
            if button.isEnabled == false {
                check += 1
            }
        }
        // Create an alert called winAlert with the title "Congratulations" with an empty message
        let winAlert = UIAlertController(title: "Congratulations", message: "", preferredStyle: .alert)
        // Add an action called "Main Menu" that will send the user back to the root screen if pressed
        winAlert.addAction(UIAlertAction(title: "Main Menu", style: .default, handler: { (action:UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        // If gamemode is equal to 1
        if gameMode == 1 {
            // If check is 14
            if check == 14 {
                // Hide the give up button
                buttonGiveUp.isHidden = true
                // Reveal the new game button
                buttonNewGame.isHidden = false
                // Make the message of the alert "You got (number of points) points"
                winAlert.message = "You got \(Int(points)) points."
                // Add an action to the alert called "Play Again"
                winAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action:UIAlertAction) in
                    // Assign the value of sendingButtonTitle to "startNewGame"
                    self.sendingButtonTitle = "startNewGame"
                    // Start the cardTimer
                    self.cardTimer()
                    // Hide the new game button
                    self.buttonNewGame.isHidden = true
                    // Make points equal to 0
                    self.points = 0
                    // Make inARow equal to 0
                    self.inARow = 0
                    // Run the shuffle function
                    self.shuffle()
                }))
                // Add an action called "Add to Leaderboard"
                winAlert.addAction(UIAlertAction(title: "Add to Leaderboard", style: .default, handler: {(action:UIAlertAction) in
                    // If the leaderBoardPractice array is empty, or if its first element is ""
                    if leaderBoardPractice.isEmpty || leaderBoardPractice.first == "" {
                       // Append the player's name and points
                        leaderBoardPractice.append("\(self.playerName), Points: \(Int(self.points))")
                        // Remove ""
                        leaderBoardPractice.remove(at: 0)
                        // Otherwise
                    } else {
                        // For each person in the leaderBoardPractice array, add the points of that person to a string. The points will be in reversed order.
                        for (index, person) in leaderBoardPractice.enumerated() {
                            var reversedPointString: String = ""
                            var pointString: String = ""
                            for point in person.reversed() {
                                if point == " " {
                                    break
                                } else {
                                    reversedPointString.append(point)
                                }
                            }
                            // For each character in the reversed points, append the normal points to a new string
                            for character in reversedPointString.reversed() {
                                pointString.append(character)
                            }
                            // If the index is 0 and the pointsString is less than or equal to your current points, append your score to leaderBoardPractice as the first element. Then break the loop
                            if index == 0 && Int(pointString)! <= Int(self.points) {
                                leaderBoardPractice.insert("\(self.playerName), Points: \(Int(self.points))", at: 0)
                                break
                            }
                            // Else, if the pointString is less than or equal to your current score, append your score at the index of the pointString that it is greater than. Then break the loop
                            else if Int(pointString)! <= Int(self.points) {
                                leaderBoardPractice.insert("\(self.playerName), Points: \(Int(self.points))", at: index)
                                break
                            }
                            // Else, if the loop is at the last element and pointString is greater than your current score, append your score at the end of the leaderBoardPractice array. Then break the loop
                            else if leaderBoardPractice[index] == leaderBoardPractice.last && Int(pointString)! >= Int(self.points) {
                                leaderBoardPractice.append("\(self.playerName), Points: \(Int(self.points))")
                                break
                            }
                        }
                    }
                   // Set the persistent data for key "practiceScoreArray" to the leaderBoardPractice array
                    UserDefaults.standard.set(leaderBoardPractice, forKey: "practiceScoreArray")
                    // Perform a segue with "goToLeaderBoard"
                    self.performSegue(withIdentifier: "goToLeaderboard", sender: nil)
                }))
                // Present the alert
                self.present(winAlert, animated: true, completion: nil)
            }
            
        }
        // Else if gamemode is equal to 2
        else if gameMode == 2 {
            // Add an action called "Play Again"
            winAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action:UIAlertAction) in
                // For each button in matchingButtons, enable the button
                for button in self.matchingButtons {
                    button.isEnabled = true
                }
                // User disable all the matchingButtons
                self.disableEnableThings(disableThem: false)
                // Set the sendingButtonTitle value to "startNewGame"
                self.sendingButtonTitle = "startNewGame"
                // Run the cardTimer
                self.cardTimer()
                // Make both players' points equal to 0
                self.player1Points = 0
                self.player2Points = 0
                self.labelPlayer1Points.text = "\(self.player1Name) Points: \(Int(self.player1Points))"
                self.labelPlayer2Points.text = "\(self.player2Name) Points: \(Int(self.player2Points))"
                // Hide the newGame button
                self.buttonNewGame.isHidden = true
                // Set the text of labelPlayersTurn to the name of the first player
                self.labelPlayersTurn.text = "\(self.player1Name)'s Turn"
                // Set inARow to 0
                self.inARow = 0
                // Set playerTurn to true
                self.playerTurn = true
                // Run the shuffle function
                self.shuffle()
            }))
            // If check is equal to 14 and player1Points if greater than player2Points
            if check == 14 && player1Points > player2Points {
                // Hide the give up button
                buttonGiveUp.isHidden = true
                // Reveal the new game button
                buttonNewGame.isHidden = false
                // Set the message of the alert to say that the first player has won with their points
                winAlert.message = "\(player1Name) has won! They got \(Int(player1Points)) points. \(player2Name) got \(Int(player2Points)) points."
                // Present the alert
                self.present(winAlert, animated: true, completion: nil)
            }
            // If the check is equal to 14 and player2Points is greater than player1Points
            else if check == 14 && player2Points > player1Points {
                // Hide the give up button
                buttonGiveUp.isHidden = true
                // Reveal the new game button
                buttonNewGame.isHidden = false
                // Set the message of the alert to say that the second player has won with their points
                winAlert.message = "\(player2Name) has won! They got \(Int(player2Points)) points. \(player1Name) got \(Int(player1Points)) points."
                // Present the alert
                self.present(winAlert, animated: true, completion: nil)
            }
            // If the check is equal to 14 and player1Points is equal to player2Points
            else if check == 14 && player1Points == player2Points {
                // Hide the give up button
                buttonGiveUp.isHidden = true
                // Reveal the new game button
                buttonNewGame.isHidden = false
                // Set the message of the alert to say that it is a tie with the point values for each player
                winAlert.message = "It's a tie! \(player2Name) got \(Int(player2Points)) points and \(player1Name) got \(Int(player1Points)) points."
                // Presents the alert
                self.present(winAlert, animated: true, completion: nil)
            }
        }
        // Else if the gamemode is equal to 3
        else if gameMode == 3 {
            // If check is equal to 14
            if check == 14 {
                // Hide the give up  button
                buttonGiveUp.isHidden = true
                // Reveal the new game button
                buttonNewGame.isHidden = false
                // Stop the timer
                timer.invalidate()
                // Set the message of the alert to the score and the second remaining
                winAlert.message = "You ended with \(Int(points)) points with \(seconds) seconds remaining."
                // Add an action to the alert called "Play Again"
                winAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action:UIAlertAction) in
                    // Set the sendingButtonTitle to "startNewGame"
                    self.sendingButtonTitle = "startNewGame"
                    // Run the cardTimer
                    self.cardTimer()
                    // Set points to 0
                    self.points = 0
                    // Set the text of label points to 0
                    self.labelPoints.text = "\(self.playerName) Points: \(Int(self.points))"
                    // Run the shuffle function
                    self.shuffle()
                    // Set seconds to 60
                    self.seconds = 60
                }))
                // Add an action to the alert called "Add to Leaderboard"
                winAlert.addAction(UIAlertAction(title: "Add to Leaderboard", style: .default, handler: {(action:UIAlertAction) in
                    // If the leaderBoardTime array is empty, or if its first element is ""
                    if leaderBoardTime.isEmpty || leaderBoardTime.first == "" {
                       // Append the current name and score to the leaderBoardTime
                        leaderBoardTime.append("\(self.playerName), Points: \(Int(self.points))")
                        // Remove ""
                        leaderBoardTime.remove(at: 0)
                    }
                    // Otherwise
                    else {
                        // For each person in the leaderBoardTime array, add the points of that person to a string. The points will be in reversed order.
                        for (index, person) in leaderBoardTime.enumerated() {
                            var reversedPointString: String = ""
                            var pointString: String = ""
                            for point in person.reversed() {
                                if point == " " {
                                    break
                                } else {
                                    reversedPointString.append(point)
                                }
                            }
                            // Reverse the reversed points so that they are in the correct order in another string
                            for character in reversedPointString.reversed() {
                                pointString.append(character)
                            }
                            // If the index if 0 and the pointString is less than or equal to the current score, append the current name and score to the start of leaderBoardTime array. Then break the loop
                            if index == 0 && Int(pointString)! <= Int(self.points) {
                                leaderBoardTime.insert("\(self.playerName), Points: \(Int(self.points))", at: 0)
                                break
                            }
                            // If pointString is less than or equal to the current score, append the current name and score to the position of the score it is greater than. Then break the loop
                            else if Int(pointString)! <= Int(self.points) {
                                leaderBoardTime.insert("\(self.playerName), Points: \(Int(self.points))", at: index)
                                break
                            }
                            // If it is the last element of the array and the pointString is greater or equal to the current score, append the current name and score to the end of leaderBoardTime array. Then break the loop.
                            else if leaderBoardTime[index] == leaderBoardTime.last && Int(pointString)! >= Int(self.points) {
                                leaderBoardTime.append("\(self.playerName), Points: \(Int(self.points))")
                                break
                            }
                        }
                    }
                   // Set the persistent data for key "timedScoreArray" to leaderBoardTime
                    UserDefaults.standard.set(leaderBoardTime, forKey: "timedScoreArray")
                    // Perform a segue with "goToLeaderBoard"
                    self.performSegue(withIdentifier: "goToLeaderboard", sender: nil)
                }))
                // Present the segue
                self.present(winAlert, animated: true, completion: nil)
            }
        }
    }
    var playerName: String = ""
    var timer = Timer()
    var seconds = 60
    var cardSeconds = 1
    var player1Name: String = ""
    var player2Name: String = ""
    var player1Points: Double = 0
    var player2Points: Double = 0
    var playerTurn: Bool = true
    var points: Double = 0
    var inARow: Int = 0
    var firstButton: UIButton = UIButton.init()
    var secondButton: UIButton = UIButton.init()
    var checkIfAnotherImage: Bool = false
    var pictureDictionary: [UIButton:UIImage] = [:]
    var pictureArray: [UIImage] = [UIImage(named: "red_guy")!, UIImage(named: "red_guy")!, UIImage(named: "black_guy")!,UIImage(named: "black_guy")!, UIImage(named: "blue_guy")!, UIImage(named: "blue_guy")!,UIImage(named: "forestGreen_guy")!, UIImage(named: "forestGreen_guy")!, UIImage(named: "green_guy")!,UIImage(named: "green_guy")!, UIImage(named: "happyYellow_guy")!, UIImage(named: "happyYellow_guy")!,UIImage(named: "waterBlue_guy")!, UIImage(named: "waterBlue_guy")!, UIImage(named: "yellow_guy")!,UIImage(named: "yellow_guy")!]
    @IBOutlet var matchingButtons: [UIButton]!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var buttonGiveUp: UIButton!
    @IBOutlet var labelTimer: UILabel!
    @IBOutlet var labelPlayer1Points: UILabel!
    @IBOutlet var labelPlayer2Points: UILabel!
    @IBOutlet var labelPlayersTurn: UILabel!
    @IBOutlet var labelPoints: UILabel!
    @IBOutlet var buttonNewGame: UIButton!
    // Function that checks the card and determines if there is a match
    func runMatch(sender: UIButton) {
        // If checkIfAnotherImage is false
        if checkIfAnotherImage == false {
            // Set firstButton to the sender
            firstButton = sender
            // Transition the sending button to its corresponding image using the dictionary
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                sender.setImage(self.pictureDictionary[sender], for: .normal)
            })
            // Set checkIfAnotherImage to true
            checkIfAnotherImage = true
            // Set the user interaction for the first button to false
            firstButton.isUserInteractionEnabled = false
        }
        // Else if checkIfAnotherImage is equal to true
        else if checkIfAnotherImage == true {
            // Set secondButton to sender
            secondButton = sender
            // Transition the sending button to its corresponding image using the dictionary
            UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                sender.setImage(self.pictureDictionary[sender], for: .normal)
            })
            // Disable the user interaction for the second button
            secondButton.isUserInteractionEnabled = false
            // If the firstButton's current image is equal to the secondButton's current image
            if firstButton.currentImage == secondButton.currentImage {
                // If gameMode is equal to 1
                if gameMode == 1 {
                    // Set the points to the points plus two to the power of how many the player has gotten in a row
                    points = points + pow(2, Double(inARow))
                }
                // Else if gameMode is equal to 3
                else if gameMode == 3 {
                    // If there are more than or equal to 40 seconds
                    if seconds >= 40 {
                        // Set the points to points plus four times of two to the power of how many the player has gotten in a row
                        points = points + (4 * pow(2, Double(inARow)))
                    }
                    // If there are more than or equal to 20 seconds
                    else if seconds >= 20 {
                        // Set the points to points plus three times of two to the power of how many the player has gotten in a row
                        points = points + (3 * pow(2, Double(inARow)))
                    }
                    // If there are more than or equal to 10 seconds
                    else if seconds >= 10 {
                        // Set the points to points plus two times of two to the power of how many the player has gotten in a row
                        points = points + (2 * pow(2, Double(inARow)))
                    }
                    // If there are less than 10 seconds
                    else if seconds < 10 {
                        // Set the points to points plus four times of two to the power of how many the player has gotten in a row
                        points = points + pow(2, Double(inARow))
                    }
                }
                // Set the label of the points to the updated amount of points
                labelPoints.text = "\(playerName)'s Points: \(Int(points))"
                // Add one to how many they have in a row
                inARow += 1
                // User disable all the buttons
                disableEnableThings(disableThem: false)
                // Delay the following code by 0.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // Disable the first and second button
                    self.firstButton.isEnabled = false
                    self.secondButton.isEnabled = false
                    // User enable all the buttons
                    self.disableEnableThings(disableThem: true)
                }
                // Run the checkIfFinished function
                checkIfFinished()
            }
            // Else if the firstButton is not the same image as the secondButton
            else if firstButton.currentImage != secondButton.currentImage {
                // User enable the first and second buttons
                firstButton.isUserInteractionEnabled = true
                secondButton.isUserInteractionEnabled = true
                // Set inARow to 0
                inARow = 0
                // User disable all the buttons
                disableEnableThings(disableThem: false)
                // Delay the following code by 0.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // Transition the firstButton to the logo picture
                    UIView.transition(with: self.firstButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        self.firstButton.setImage(UIImage(named: "logo"), for: .normal)
                    })
                    // Transition the secondButton to the logo picture
                    UIView.transition(with: self.secondButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        self.secondButton.setImage(UIImage(named: "logo"), for: .normal)
                        // User enable all the buttons
                        self.disableEnableThings(disableThem: true)
                    })
                }
            }
            // Set checkIfAnotherImage to false
            checkIfAnotherImage = false
        }
    }
    var flipTimer = Timer()
    func runTimer() {
        // Starts the timer with a time interval of 1 using the updateTimer function
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(MatchingViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    var buttonChange = 0
    var sendingButtonTitle: String = ""
    func cardTimer() {
        // Starts the flip timer with a time interval of 0.25 using the updateCardTimer function
        flipTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: (#selector(MatchingViewController.updateCardTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateCardTimer() {
        // If cardSeconds is less than 1 and buttonChange is less than 16
        if cardSeconds < 1 && buttonChange < 16 {
            // Set cardSeconds to 0
            cardSeconds = 0
            // If sendingButtonTitle is equal to "startNewGame"
            if sendingButtonTitle == "startNewGame" {
                // Transition each button one by one with the logo picture
                UIView.transition(with: matchingButtons[buttonChange], duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.matchingButtons[self.buttonChange].setImage(UIImage(named: "logo"), for: .normal)
                }, completion: nil)
            }
            // Else if the sendingButtonTitle is equal to "giveUp"
            else if sendingButtonTitle == "giveUp" {
                // Transition each button one by one with its corresponding image
                UIView.transition(with: matchingButtons[buttonChange], duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.matchingButtons[self.buttonChange].setImage(self.pictureDictionary[self.matchingButtons[self.buttonChange]], for: .normal)
                }, completion: nil)
                // Enable each button one by one
                matchingButtons[buttonChange].isEnabled = true
            }
            // Add one to buttonChange
            buttonChange += 1
        }
        // Else if cardSeconds is less than 1 and buttonChange is greater than or equal to 16
        else if cardSeconds < 1 && buttonChange >= 16 {
            // Invalidate the flip timer
            flipTimer.invalidate()
            // If the sendingButtonTitle is equal to "startNewGame"
            if sendingButtonTitle == "startNewGame" {
                // User enable all the buttons
                disableEnableThings(disableThem: true)
                // If the gameMode is equal to 3, run the timer
                if gameMode == 3 {
                    runTimer()
                }
            }
            // Else if the sendingButtonTitle is equal to "giveUp"
            else if sendingButtonTitle == "giveUp" {
                // Show the new game button
                buttonNewGame.isHidden = false
            }
            // Set buttonChange to 0
            buttonChange = 0
            // Set cardSeconds to 1
            cardSeconds = 1
        }
        // Else if cardSeconds is greater than 0
        else if cardSeconds > 0 {
            // Subtract 1 from cardSeconds
            cardSeconds -= 1
        }
    }
    @objc func updateTimer() {
        // If seconds is less than 1
        if seconds < 1 {
            // Stop the timer
            timer.invalidate()
            // Create a timer alert that says time has run out and the amount of points the player has gotten within one minute
            let timerAlert = UIAlertController(title: "Time's Up!", message: "Time has run out!. You managed to get \(Int(points)) points within 1 minute.", preferredStyle: .alert)
            // Add an action called "Main Menu" that pops back to the main menu view
            timerAlert.addAction(UIAlertAction(title: "Main Menu", style: .default, handler: { (action:UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            // Add an action called "Play Again" that enables all the matching buttons, user disables all the matching buttons, set seconds to 60, run the card timer, set the sendinButtonTitle to "startNewGame", and run the shuffle function
            timerAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { (action:UIAlertAction) in
                for button in self.matchingButtons {
                    button.isEnabled = true
                }
                self.disableEnableThings(disableThem: false)
                self.sendingButtonTitle = "startNewGame"
                self.seconds = 60
                self.cardTimer()
                self.shuffle()
            }))
            // Present the timerAlert
            self.present(timerAlert, animated: true, completion: nil)
        }
        // Otherwise, subtract 1 from seconds and set the timer label to the updated time
        else {
            seconds -= 1
            labelTimer.text = timeString(time: TimeInterval(seconds))
        }
    }
    func timeString(time: TimeInterval) -> String {
        // Formats the time left to a minute value
        let minutes = Int(time) / 60 % 60
        // Formats the time left to a seconds value without the minute value
        let seconds = Int(time) % 60
        // Returns the string form of the formatted minute and seconds value
        return String(format: "%02i:%02i", arguments: [minutes, seconds])
    }
    func disableEnableThings (disableThem: Bool) {
        // User enables/disables each button in matchingButtons
        for index in matchingButtons {
            index.isUserInteractionEnabled = disableThem
        }
    }
    @IBAction func buttonStartNewGamePressed(_ sender: UIButton) {
        // For each button in matchingButtons, enable the button
        for button in matchingButtons {
            button.isEnabled = true
        }
        // User disable all the matching buttons
        disableEnableThings(disableThem: false)
        // Set the sendingButtonTitle to "startNewGame"
        sendingButtonTitle = "startNewGame"
        // Set seconds to 60
        seconds = 60
        // Run the card timer
        cardTimer()
        // Run the shuffle function
        shuffle()
        // Hide the new game button
        buttonNewGame.isHidden = true
        // If gamemode is equal to 1 or 3, set points to 0
        if gameMode == 1 || gameMode == 3 {
            points = 0
        }
        // Else if gamemode is equal to 2
        else if gameMode == 2 {
            // Set player1Points to 0
            player1Points = 0
            // Set player2Points to 0
            player2Points = 0
            // Update the label for first and second player's points
            labelPlayer1Points.text = "\(player1Name) Points: \(Int(player1Points))"
            labelPlayer2Points.text = "\(player2Name) Points: \(Int(player2Points))"
            // Reset the label for player turn to the first player's turn
            labelPlayersTurn.text = "\(player1Name)'s Turn"
        }
    }
    @IBAction func buttonGiveUpPressed(_ sender: UIButton) {
        // Set the sendingButtonTitle to "giveUp"
        sendingButtonTitle = "giveUp"
        // User disable all matching buttons
        disableEnableThings(disableThem: false)
        // Run the card timer
        cardTimer()
        // Create a give up alert that has a title of "Give Up"
        let giveUpAlert = UIAlertController(title: "Give Up", message: "", preferredStyle: .alert)
        // Add an action to the alert called "Main Menu" that goes back to the main menu
        giveUpAlert.addAction(UIAlertAction(title: "Main Menu", style: .default, handler: {(action:UIAlertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        // Add an action called "Dismiss"
        giveUpAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        // If gameMode is equal to 1, set the message of the alert to the following message
        if gameMode == 1 {
            giveUpAlert.message = "The game has ended. You ended with \(Int(points)) points."
        }
        // If gameMode is equal to 2, set the message of the alert to the following message
        else if gameMode == 2 {
            giveUpAlert.message = "The game has ended. \(player1Name) ended up with \(Int(player1Points)) points. \(player2Name) ended up with \(Int(player2Points)) points."
        }
        // If gameMode is equal to 3, set the message of the alert to the following message and stop the timer
        else if gameMode == 3 {
            timer.invalidate()
            giveUpAlert.message =  "The game has ended. You ended with \(Int(points)) points with \(seconds) seconds remaining."
        }
        // Presents the give up alert
        self.present(giveUpAlert, animated: true, completion: nil)
        // Hide the give up button
        buttonGiveUp.isHidden = true
    }
    @IBAction func matchPressed(_ sender: UIButton) {
        // If gameMode is equal to 1
        if gameMode == 1 {
            // Reveals the give up button
            buttonGiveUp.isHidden = false
            // Run the runMatch function with a sender of the sending button
            runMatch(sender: sender)
        }
        // Else if gameMode is equal to 2
        else if gameMode == 2 {
            // Reveal the give up button
            buttonGiveUp.isHidden = false
            // If playerTurn is equal to true
            if playerTurn == true {
                // If checkIfAnotherImage is equal to false
                if checkIfAnotherImage == false {
                    // Set firstButton to the sending button
                    firstButton = sender
                    // Transition the sending button to its corresponding image
                    UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        sender.setImage(self.pictureDictionary[sender], for: .normal)
                    })
                    // Set checkIfAnotherImage to true
                    checkIfAnotherImage = true
                    // User disable the first button
                    firstButton.isUserInteractionEnabled = false
                }
                // Else if checkIfAnotherImage is equal to true
                else if checkIfAnotherImage == true {
                    // Set the second button to the sending button
                    secondButton = sender
                    // Transition the sending button to its corresponding image
                    UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        sender.setImage(self.pictureDictionary[sender], for: .normal)
                    })
                    // User disable the second button
                    secondButton.isUserInteractionEnabled = false
                    // If the first button's current image is equal to the second button's current image
                    if firstButton.currentImage == secondButton.currentImage {
                        // Set the player1Points to the player1Points plus 2 to the power of how many the first player got in a row
                        player1Points = player1Points + pow(2, Double(inARow))
                        // Update the first player's point label
                        labelPlayer1Points.text = "\(player1Name) Points: \(Int(player1Points))"
                        // Add one to inARow
                        inARow += 1
                        // User disable all the matchingButtons
                        disableEnableThings(disableThem: false)
                       // Delay the following code by 0.5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // Disable the first button
                            self.firstButton.isEnabled = false
                            // Disable the second button
                            self.secondButton.isEnabled = false
                           // User enable all the matchingButtons
                            self.disableEnableThings(disableThem: true)
                        }
                        // Run the checkIfFinished function
                        checkIfFinished()
                    }
                    // Else if the first button's image is not equal to the second button's image
                    else if firstButton.currentImage != secondButton.currentImage {
                        // Set playerTurn to false
                        playerTurn = false
                        // User enable the first button
                        firstButton.isUserInteractionEnabled = true
                        // User enable the second button
                        secondButton.isUserInteractionEnabled = true
                        // Set inARow to 0
                        inARow = 0
                        // User disable all the matching buttons
                        disableEnableThings(disableThem: false)
                       // Delay the following code by 0.5 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // Transition the first button with the logo image
                            UIView.transition(with: self.firstButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                self.firstButton.setImage(UIImage(named: "logo"), for: .normal)
                            })
                            // Transition the second button with the logo image
                            UIView.transition(with: self.secondButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                self.secondButton.setImage(UIImage(named: "logo"), for: .normal)
                               // User enable all the buttons
                                self.disableEnableThings(disableThem: true)
                            })
                            // Update the turn label to says that it is now the second player's turn
                            self.labelPlayersTurn.text = "\(self.player2Name)'s Turn"
                        }
                    }
                    // Set checkIfAnotherImage to false
                    checkIfAnotherImage = false
                }
            } else if playerTurn == false {
                if checkIfAnotherImage == false {
                    firstButton = sender
                    UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        sender.setImage(self.pictureDictionary[sender], for: .normal)
                    })
                    checkIfAnotherImage = true
                    firstButton.isUserInteractionEnabled = false
                } else if checkIfAnotherImage == true {
                    secondButton = sender
                    UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        sender.setImage(self.pictureDictionary[sender], for: .normal)
                    })
                    secondButton.isUserInteractionEnabled = false
                    if firstButton.currentImage == secondButton.currentImage {
                        player2Points = player2Points + pow(2, Double(inARow))
                        labelPlayer2Points.text = "\(player2Name) Points: \(Int(player2Points))"
                        inARow += 1
                        disableEnableThings(disableThem: false)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.firstButton.isEnabled = false
                            self.secondButton.isEnabled = false
                            self.disableEnableThings(disableThem: true)
                        }
                        checkIfFinished()
                    } else if firstButton.currentImage != secondButton.currentImage {
                        playerTurn = true
                        firstButton.isUserInteractionEnabled = true
                        secondButton.isUserInteractionEnabled = true
                        inARow = 0
                        disableEnableThings(disableThem: false)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            UIView.transition(with: self.firstButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                self.firstButton.setImage(UIImage(named: "logo"), for: .normal)
                            })
                            UIView.transition(with: self.secondButton, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                self.secondButton.setImage(UIImage(named: "logo"), for: .normal)
                                self.disableEnableThings(disableThem: true)
                            })
                            self.labelPlayersTurn.text = "\(self.player1Name)'s Turn"
                        }
                    }
                    checkIfAnotherImage = false
                }
            }
        } else if gameMode == 3 {
            // Reveals the give up button
            buttonGiveUp.isHidden = false
            runMatch(sender: sender)
        }
    }
}
