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

    console.log("                                                                                                                                               "); 
    console.log(" ________   ________  ________  ________  ________  _________  ________  ________          ___  ___  _______   ___       ________  _______   ________"); 
    console.log("|\   ___  \|\   __  \|\   __  \|\   __  \|\   __  \|\___   ___\\   __  \|\   __  \        |\  \|\  \|\  ___ \ |\  \     |\   __  \|\  ___ \ |\   __  \ "); 
    console.log("\ \  \\ \  \ \  \|\  \ \  \|\  \ \  \|\  \ \  \|\  \|___ \  \_\ \  \|\  \ \  \|\  \       \ \  \\\  \ \   __/|\ \  \    \ \  \|\  \ \   __/|\ \  \|\  \ "); 
    console.log(" \ \  \\ \  \ \   __  \ \   _  _\ \   _  _\ \   __  \   \ \  \ \ \  \\\  \ \   _  _\       \ \   __  \ \  \_|/_\ \  \    \ \   ____\ \  \_|/_\ \   _  _\ "); 
    console.log("  \ \  \\ \  \ \  \ \  \ \  \\  \\ \  \\  \\ \  \ \  \   \ \  \ \ \  \\\  \ \  \\  \|       \ \  \ \  \ \  \_|\ \ \  \____\ \  \___|\ \  \_|\ \ \  \\  \| "); 
    console.log("   \ \__\\ \__\ \__\ \__\ \__\\ _\\ \__\\ _\\ \__\ \__\   \ \__\ \ \_______\ \__\\ _\        \ \__\ \__\ \_______\ \_______\ \__\    \ \_______\ \__\\ _\ "); 
    console.log("    \|__| \|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|    \|__|  \|_______|\|__|\|__|        \|__|\|__|\|_______|\|_______|\|__|     \|_______|\|__|\|__| "); 
    console.log("                                                                                                                                                       "); 
    console.log("                                                                                                                                                       ");
    console.log("Welcome to Narrator Helper!                                                                 ");
    Response = readline("Press Enter to Play Werewolves");
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
    console.log(" "); 
    console.log("*"); 
    console.log("*"); 
    console.log("*"); 
    console.log(" "); 
}

/**
 *  Handles the selection of the number of players 
 * */
function NumberOfPlayers() {
    Loading;
    do {
    let WontWork = "That won't work!";
    var InputString = readline("How many players are there?"); // Initialize number of players
    $global:NumberOfPlayers = $InputString -as [Int];
    // Make sure a right value was chosen.
    if($NULL -eq $global:NumberOfPlayers) {console.log($WontWork -ForegroundColor Red;}
    elseif($global:NumberOfPlayers -eq 0) {console.log($WontWork -ForegroundColor Red;}
    elseif($global:NumberOfPlayers -eq 1) {console.log($WontWork -ForegroundColor Red;}
    elseif($global:NumberOfPlayers -eq 2) {console.log($WontWork -ForegroundColor Red;}
    elseif($global:NumberOfPlayers -eq 3) {console.log($WontWork -ForegroundColor Red;}
    else {$Ok = $true;}
    }
    until($Ok)
    Loading;
    console.log("We're playing with $NumberOfPlayers players!"
}

/**
 *  Play the intro for Werewolves 
 * */
function WerewolvesIntro() {
    Loading;
    
    console.log("                                                                                     " -ForegroundColor DarkRed; 
    console.log("██╗    ██╗███████╗██████╗ ███████╗██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗" -ForegroundColor DarkRed; 
    console.log("██║    ██║██╔════╝██╔══██╗██╔════╝██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝" -ForegroundColor DarkRed; 
    console.log("██║ █╗ ██║█████╗  ██████╔╝█████╗  ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗" -ForegroundColor DarkRed; 
    console.log("██║███╗██║██╔══╝  ██╔══██╗██╔══╝  ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║" -ForegroundColor DarkRed; 
    console.log("╚███╔███╔╝███████╗██║  ██║███████╗╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║" -ForegroundColor DarkRed; 
    console.log(" ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝" -ForegroundColor DarkRed; 
    console.log("                                                                                     " -ForegroundColor DarkRed; 
}

/**
 *  Function that takes how many players their are and asks for their names 
 * */
function GetPlayerNames() {
    Loading;
    // For loop that iterates through until all players have names
    for($i=0; $i -lt $global:NumberOfPlayers; $i++){
        $plusone = $i + 1;
        do {
        $global:PlayerArray[$i] = Read-Host -Prompt "Enter the name of Player $plusone ");
        if($global:PlayerArray[$i - 1] -eq $global:PlayerArray[$i]){console.log(= "That's the same name!" -ForegroundColor Red; $Ok = $false;}
        elseif($null -eq $global:PlayerArray[$i]){console.log(= "A name can't be blank!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
        // Code will make sure array is unique 
        // if(-not(Compare-Object $global:PlayerArray $global:PlayerArray[$i] -IncludeEqual)){ console.log(= "Start over!");}
        }
        until($Ok)
    }
 console.log("");
    console.log("$global:PlayerArray");
}

/**
 *  Is resposible for prompting and storing the Werewolves 
 * */
function ChooseWerewolves() {
    Loading;
    for($i = 0; $i -lt $global:WereWolvesArray.Length; $i++) {
        $plusone = $i + 1;
        do {
            $global:WereWolvesArray[$i] = Read-Host -Prompt "Enter the name of Werewolf $plusone ");
            if($global:WereWolvesArray[$i - 1] -eq $global:WereWolvesArray[$i] -and $global:WereWolvesArray.Length -gt 5){console.log(= "They're already a Werewolf!" -ForegroundColor red; $Ok = $false;}
            elseif($null -eq $global:WereWolvesArray[$i]){console.log(= "A Werewolf needs a name!" -ForegroundColor Red; $Ok = $false;}
            else{$Ok = $true;}
        } 
        until($Ok)
        $global:BadGuys++; // Adds one to the bad guy counter
    }
 console.log("");
    console.log("$global:WereWolvesArray" -ForegroundColor White -BackgroundColor DarkRed;
}

/**
 *  Is resposible for prompting and storing the Doctor 
 * */
function ChooseDoctor() {
    Loading;
    do {
        $global:Doctor = Read-Host -Prompt "Enter the name of the Doctor ");
        if($null -eq $global:Doctor){console.log(= "The Doctor needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:Doctor" -ForegroundColor White -BackgroundColor DarkGreen;
}

/**
 *  Is resposible for prompting and storing the Little Girl 
 * */
function ChooseLittleGirl() {
    Loading;
    do {
        $global:LittleGirl = Read-Host -Prompt "Enter the name of the Little Girl ");
        if($null -eq $global:LittleGirl){console.log(= "The Little Girl needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:LittleGirl" -ForegroundColor White -BackgroundColor DarkGreen;
}

/**
 *  Is resposible for prompting and storing Cupid 
 * */
function ChooseCupid() {
    Loading;
    do {
        $global:Cupid = Read-Host -Prompt "Enter the name of Cupid ");
        if($null -eq $global:Cupid){console.log(= "Cupid needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:Cupid" -ForegroundColor White -BackgroundColor DarkGreen;
}

/**
 *  Is resposible for prompting and storing the Demon Butler 
 * */
function ChooseDemonButler() {
    Loading;
    do {
        $global:DemonButler = Read-Host -Prompt "Enter the name of the Demon Butler ");
        if($null -eq $global:DemonButler){console.log(= "The Demon Butler needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:DemonButler" -ForegroundColor White -BackgroundColor DarkGreen;
}

/**
 *  Is resposible for prompting and storing the Demon Dog 
 * */
function ChooseDemonDog() {
    Loading;
    do {
        $global:DemonDog = Read-Host -Prompt "Enter the name of the Demon Dog ");
        if($null -eq $global:DemonDog){console.log(= "The Demon Dog needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:DemonDog" -ForegroundColor White -BackgroundColor DarkRed;
    $global:BadGuys++; // Adds one to the bad guy counter
}

/**
 *  Is resposible for prompting and storing the Old Man 
 * */
function ChooseOldMan() {
    Loading;
    do {
        $global:OldMan = Read-Host -Prompt "Enter the name of the Old Man ");
        if($null -eq $global:OldMan){console.log(= "The Old Man needs a name!" -ForegroundColor Red; $Ok = $false;}
        else{$Ok = $true;}
    } 
    until($Ok)
 console.log("");
    console.log("$global:OldMan" -ForegroundColor White -BackgroundColor DarkGreen;
}

/**
 *  Is responisble for calculating and prompting for the different characters in each game 
 * */
function ChooseCharacters() {
    $global:BadGuys = 0; // Initialize the bad guys in the game
    // This series of if statements determines how many of each character to prompt for
    if($global:NumberOfPlayers -le 4){
        $global:WereWolvesArray = @(1);
        ChooseWerewolves;
        ChooseDoctor;
    }
    elseif($global:NumberOfPlayers -le 5){
        $global:WereWolvesArray = @(1);
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
    }
    elseif($global:NumberOfPlayers -le 8){
        $global:WereWolvesArray = 1,2;
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
    }
    elseif($global:NumberOfPlayers -le 12){
        $global:WereWolvesArray = (1..([int32]$global:NumberOfPlayers / 3));
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
        ChooseDemonButler;
        ChooseDemonDog;
    }
    else{
        $global:WereWolvesArray = (1..([int32]$global:NumberOfPlayers / 3));
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
        ChooseDemonButler;
        ChooseDemonDog;
        ChooseOldMan;
    }
    $global:GoodGuys = $global:NumberOfPlayers - $global:BadGuys // Initialize the good guys in the game
}

function PlayGame() {
    Loading;
    while($global:BadGuys -ne 0 , $global:GoodGuys -ne 0){
        console.log("$global:BadGuys");
        console.log("$global:GoodGuys");
        $global:BadGuys - 1;
    }
   console.log("Game Over");
}

/**
 *  The function that actually plays the game
   ***Important*
 
   */
function PlayWerewolves() {
 [CmdletBinding()]
 param()
    WerewolvesIntro;
    NumberOfPlayers;
    $global:PlayerArray = 1..$global:NumberOfPlayers;
    GetPlayerNames;
    ChooseCharacters;
    PlayGame;
}

// Startup
StartUp;

// Play Werewolves
PlayWerewolves;
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                          
