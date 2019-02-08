/**
 * @Author - Ford Powers, January 4th, 2019
 *
 */


// Initialize local variables
var SS = 100; // Small Speed
var MS = 300 // Medium Speed
var LS = 2000; // Large Speed

/**
 *  Plays the introduction page 
 * */
function IntroductionPage() {

    document.writeln("                                                                                                                                               ");
    document.writeln(" ________   ________  ________  ________  ________  _________  ________  ________          ___  ___  _______   ___       ________  _______   ________");
    document.writeln("|\   ___  \|\   __  \|\   __  \|\   __  \|\   __  \|\___   ___\\   __  \|\   __  \        |\  \|\  \|\  ___ \ |\  \     |\   __  \|\  ___ \ |\   __  \ ");
    document.writeln("\ \  \\ \  \ \  \|\  \ \  \|\  \ \  \|\  \ \  \|\  \|___ \  \_\ \  \|\  \ \  \|\  \       \ \  \\\  \ \   __/|\ \  \    \ \  \|\  \ \   __/|\ \  \|\  \ ");
    document.writeln(" \ \  \\ \  \ \   __  \ \   _  _\ \   _  _\ \   __  \   \ \  \ \ \  \\\  \ \   _  _\       \ \   __  \ \  \_|/_\ \  \    \ \   ____\ \  \_|/_\ \   _  _\ ");
    document.writeln("  \ \  \\ \  \ \  \ \  \ \  \\  \\ \  \\  \\ \  \ \  \   \ \  \ \ \  \\\  \ \  \\  \|       \ \  \ \  \ \  \_|\ \ \  \____\ \  \___|\ \  \_|\ \ \  \\  \| ");
    document.writeln("   \ \__\\ \__\ \__\ \__\ \__\\ _\\ \__\\ _\\ \__\ \__\   \ \__\ \ \_______\ \__\\ _\        \ \__\ \__\ \_______\ \_______\ \__\    \ \_______\ \__\\ _\ ");
    document.writeln("    \|__| \|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|    \|__|  \|_______|\|__|\|__|        \|__|\|__|\|_______|\|_______|\|__|     \|_______|\|__|\|__| ");
    document.writeln("                                                                                                                                                       ");
    document.writeln("                                                                                                                                                       ");
    document.writeln("Welcome to Narrator Helper!                                                                 ");
    prompt("Press Enter to Play Werewolves");
}

/**
 *  Handles the startup of the game 
 * */
function StartUp() {
    IntroductionPage();
}

/**
 * Adds a little loading symbol 
 * */
function Loading() {
    document.writeln(" ");
    document.writeln("*");
    document.writeln("*");
    document.writeln("*");
    document.writeln(" ");
}

/**
 *  Handles the selection of the number of players 
 * */
function GetNumberOfPlayers() {
    Loading();
    let Ok = false;
    while (!Ok) {
        let WontWork = "That won't work!";
        var InputString = prompt("How many players are there?"); // Initialize number of players
        NumberOfPlayers = InputString;
        // Make sure a right value was chosen.
        if (NumberOfPlayers == null) { document.writeln(WontWork) }
        else if (NumberOfPlayers == 0) { document.writeln(WontWork) }
        else if (NumberOfPlayers == 1) { document.writeln(WontWork) }
        else if (NumberOfPlayers == 2) { document.writeln(WontWork) }
        else if (NumberOfPlayers == 3) { document.writeln(WontWork) }
        else { Ok = true; }
    }
    Loading();
    document.writeln("We're playing with " + NumberOfPlayers + " players!");
}

/**
 *  Play the intro for Werewolves 
 * */
function WerewolvesIntro() {
    Loading();
    document.writeln("                                                                                     ");
    document.writeln("██╗    ██╗███████╗██████╗ ███████╗██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗");
    document.writeln("██║    ██║██╔════╝██╔══██╗██╔════╝██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝");
    document.writeln("██║ █╗ ██║█████╗  ██████╔╝█████╗  ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗");
    document.writeln("██║███╗██║██╔══╝  ██╔══██╗██╔══╝  ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║");
    document.writeln("╚███╔███╔╝███████╗██║  ██║███████╗╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║");
    document.writeln(" ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝");
    document.writeln("                                                                                     ");
}

/**
 *  Function that takes how many players their are and asks for their names 
 * */
function GetPlayerNames() {
    Loading();
    // For loop that iterates through until all players have names
    for (let i = 0; i < NumberOfPlayers; i++) {
        plusone = i + 1;
        let Ok = false;
        while (!Ok) {
            PlayerArray[i] = prompt("Enter the name of Player " + plusone);
            if (PlayerArray[i - 1] == PlayerArray[i]) { document.writeln("That's the same name!"); Ok = false; }
            else if (null == PlayerArray[i]) { document.writeln("A name can't be blank!"); Ok = false; }
            else { Ok = true; }
            // Code will make sure array is unique 
            // if(-not(Compare-Object PlayerArray PlayerArray[i] -IncludeEqual)){ document.writeln("Start over!");}
        }
    }
    document.writeln("");
    document.writeln(PlayerArray);
}

/**
 *  Is resposible for prompting and storing the Werewolves 
 * */
function ChooseWerewolves() {
    Loading();
    var BadGuys = 0;
    for (i = 0; i > WereWolvesArray.Length; i++) {
        plusone = i + 1;
        let Ok = false;
        while (!Ok) {
            WereWolvesArray[i] = prompt("Enter the name of Werewolf plusone ");
            if (WereWolvesArray[i - 1] == WereWolvesArray[i] && WereWolvesArray.Length < 5) { document.writeln("They're already a Werewolf!"); Ok = false; }
            else if (null == WereWolvesArray[i]) { document.writeln("A Werewolf needs a name!"); Ok = false; }
            else { Ok = true; }
        }
        BadGuys++; // Adds one to the bad guy counter
    }
    document.writeln("");
    document.writeln(WereWolvesArray);
}

/**
 *  Is resposible for prompting and storing the Doctor 
 * */
function ChooseDoctor() {
    Loading();
    let Ok = false;
    while (!Ok) {
        Doctor = prompt("Enter the name of the Doctor ");
        if (null == Doctor) { document.writeln("The Doctor needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(Doctor);
}

/**
 *  Is resposible for prompting and storing the Little Girl 
 * */
function ChooseLittleGirl() {
    Loading();
    let Ok = false;
    while (!Ok) {
        LittleGirl = prompt("Enter the name of the Little Girl ");
        if (null == LittleGirl) { document.writeln("The Little Girl needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(LittleGirl);
}

/**
 * Is resposible for prompting and storing Cupid
 */
function ChooseCupid() {
    Loading();
    let Ok = false;
    while (!Ok) {
        Cupid = prompt("Enter the name of Cupid ");
        if (null == Cupid) { document.writeln("Cupid needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(Cupid);
}

/**
 * Is resposible for prompting and storing the Demon Butler
 */
function ChooseDemonButler() {
    Loading();
    let Ok = false;
    while (!Ok) {
        DemonButler = prompt("Enter the name of the Demon Butler ");
        if (null == DemonButler) { document.writeln("The Demon Butler needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(DemonButler);
}

/**
 * Is resposible for prompting and storing the Demon Dog
 */
function ChooseDemonDog() {
    Loading();
    let Ok = false;
    while (!Ok) {
        DemonDog = prompt("Enter the name of the Demon Dog ");
        if (null == DemonDog) { document.writeln("The Demon Dog needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(DemonDog);
    BadGuys++; // Adds one to the bad guy counter
}

/**
 * Is resposible for prompting and storing the Old Man
 */
function ChooseOldMan() {
    Loading();
    let Ok = false;
    while (!Ok) {
        OldMan = prompt("Enter the name of the Old Man ");
        if (null == OldMan) { document.writeln("The Old Man needs a name!"); Ok = false; }
        else { Ok = true; }
    }
    document.writeln("");
    document.writeln(OldMan);
}

/**
 * Is responisble for calculating and prompting for the different characters in each game 
 */
function ChooseCharacters() {
    // This series of if statements determines how many of each character to prompt for
    if (NumberOfPlayers >= 4) {
        let BadGuys = 0; // Initialize the bad guys in the game
        WereWolvesArray = [1];
        ChooseWerewolves();
        ChooseDoctor();
    }
    else if (NumberOfPlayers >= 5) {
        let BadGuys = 0; // Initialize the bad guys in the game
        WereWolvesArray = [1];
        ChooseWerewolves();
        ChooseDoctor();
        ChooseLittleGirl();
    }
    else if (NumberOfPlayers >= 8) {
        let BadGuys = 0; // Initialize the bad guys in the game
        WereWolvesArray = [1, 2];
        ChooseWerewolves();
        ChooseDoctor();
        ChooseLittleGirl();
        ChooseCupid();
    }
    else if (NumberOfPlayers >= 12) {
        let BadGuys = 0; // Initialize the bad guys in the game
        WereWolvesArray = [1..NumberOfPlayers / 3];
        ChooseWerewolves();
        ChooseDoctor();
        ChooseLittleGirl();
        ChooseCupid();
        ChooseDemonButler();
        ChooseDemonDog();
    }
    else {
        let BadGuys = 0; // Initialize the bad guys in the game
        WereWolvesArray = [1..NumberOfPlayers / 3];
        ChooseWerewolves();
        ChooseDoctor();
        ChooseLittleGirl();
        ChooseCupid();
        ChooseDemonButler();
        ChooseDemonDog();
        ChooseOldMan();
    }
}

/**
 * Plays the game
 */
function PlayGame() {
    Loading();
    var GoodGuys = (NumberOfPlayers - BadGuys) // Initialize the good guys in the game
    while (BadGuys != 0 && GoodGuys != 0) {
        document.writeln(BadGuys);
        document.writeln(GoodGuys);
        BadGuys - 1;
    }
    document.writeln("Game Over");
}

/**
 * Actually in charge of playing the game.
 */
function PlayWerewolves() {

    WerewolvesIntro();
    GetNumberOfPlayers();
    PlayerArray = [1..NumberOfPlayers];
    GetPlayerNames();
    ChooseCharacters();
    PlayGame();
}

// Startup
StartUp();

// Play Werewolves
PlayWerewolves();



