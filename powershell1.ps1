# @Author - Ford Powers, January 4th, 2019

# This code handles the window resizing
function ResizeWindow {
    $pshost = get-host; $pswindow = $pshost.ui.rawui;
    $newsize = $pswindow.buffersize; $newsize.height = 3000;
    $newsize.width = 158; $pswindow.buffersize = $newsize;
    $newsize = $pswindow.windowsize; $newsize.height = 50;
    $newsize.width = 158; $pswindow.windowsize = $newsize;
}

# Initialize global variables
$SS = 100; # Small Speed
$MS = 300 # Medium Speed
$LS = 2000; # Large Speed
$BGT = @{ForegroundColor = "White"; BackgroundColor = "DarkRed"}
$GGT = @{ForegroundColor = "White"; BackgroundColor = "DarkGreen"}

<# Plays the introduction page #>
function IntroductionPage {
    Start-Sleep -m $SS;
    Write-Host "  ________   ________  ________  ________  ________  _________  ________  ________          ___  ___  _______   ___       ________  _______   ________     "; Start-Sleep -m $SS;
    Write-Host " |\   ___  \|\   __  \|\   __  \|\   __  \|\   __  \|\___   ___\\   __  \|\   __  \        |\  \|\  \|\  ___ \ |\  \     |\   __  \|\  ___ \ |\   __  \    "; Start-Sleep -m $SS;
    Write-Host " \ \  \\ \  \ \  \|\  \ \  \|\  \ \  \|\  \ \  \|\  \|___ \  \_\ \  \|\  \ \  \|\  \       \ \  \\\  \ \   __/|\ \  \    \ \  \|\  \ \   __/|\ \  \|\  \   "; Start-Sleep -m $SS;
    Write-Host "  \ \  \\ \  \ \   __  \ \   _  _\ \   _  _\ \   __  \   \ \  \ \ \  \\\  \ \   _  _\       \ \   __  \ \  \_|/_\ \  \    \ \   ____\ \  \_|/_\ \   _  _\  "; Start-Sleep -m $SS;
    Write-Host "   \ \  \\ \  \ \  \ \  \ \  \\  \\ \  \\  \\ \  \ \  \   \ \  \ \ \  \\\  \ \  \\  \|       \ \  \ \  \ \  \_|\ \ \  \____\ \  \___|\ \  \_|\ \ \  \\  \| "; Start-Sleep -m $SS;
    Write-Host "    \ \__\\ \__\ \__\ \__\ \__\\ _\\ \__\\ _\\ \__\ \__\   \ \__\ \ \_______\ \__\\ _\        \ \__\ \__\ \_______\ \_______\ \__\    \ \_______\ \__\\ _\ "; Start-Sleep -m $SS;
    Write-Host "     \|__| \|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|\|__|    \|__|  \|_______|\|__|\|__|        \|__|\|__|\|_______|\|_______|\|__|     \|_______|\|__|\|__|"; Start-Sleep -m $SS;
    Write-Host "                                                                                                                                                           "; Start-Sleep -m $SS;
    Write-Host "Welcome to Narrator Helper!"; 
    Start-Sleep -m $SS;
    Read-Host -Prompt "Press Enter to Play Werewolves";
}

<# Handles the startup of the game #>
function StartUp {
    ResizeWindow;
    IntroductionPage;
}

<# Adds a little loading symbol #>
function Loading {
    Write-Host " "; Start-Sleep -m $SS;
    Write-Host "*"; Start-Sleep -m $SS;
    Write-Host "*"; Start-Sleep -m $SS;
    Write-Host "*"; Start-Sleep -m $SS;
    Write-Host " "; Start-Sleep -m $SS;
}

<# Handles the selection of the number of players #>
function NumberOfPlayers {
    Loading;
    do {
        $WontWork = "That won't work!";
        $InputString = Read-Host -Prompt "How many players are there?"; # Initialize number of players
        $global:NumberOfPlayers = $InputString -as [Int];
        # Make sure a right value was chosen.
        if ($NULL -eq $global:NumberOfPlayers) {Write-Host $WontWork -ForegroundColor Red; }
        elseif ($global:NumberOfPlayers -eq 0) {Write-Host $WontWork -ForegroundColor Red; }
        elseif ($global:NumberOfPlayers -eq 1) {Write-Host $WontWork -ForegroundColor Red; }
        elseif ($global:NumberOfPlayers -eq 2) {Write-Host $WontWork -ForegroundColor Red; }
        elseif ($global:NumberOfPlayers -eq 3) {Write-Host $WontWork -ForegroundColor Red; }
        else {$Ok = $true; }
    }
    until($Ok)
    Loading;
    Write-Host "We're playing with $NumberOfPlayers players!"
}

<# Play the intro for Werewolves #>
function WerewolvesIntro {
    Loading;
    Write-Host " ~ Werewolves ~ " -ForegroundColor Red -BackgroundColor Black;
}

<# Function that takes how many players their are and asks for their names #>
function GetPlayerNames {
    Loading;
    # For loop that iterates through until all players have names
    for ($i = 0; $i -lt $global:NumberOfPlayers; $i++) {
        $plusone = $i + 1;
        do {
            $currentPlayerName = Read-Host -Prompt "Enter the name of Player $plusone ";
            if ($global:PlayerArray[$i - 1] -eq $currentPlayerName) {
                Write-Host = "That's the same name!" -ForegroundColor Red; $Ok = $false; 
            }
            elseif ($null -eq $currentPlayerName) {
                Write-Host = "A name cannot be blank!" -ForegroundColor Red; $Ok = $false;
            }
            elseif ($currentPlayerName -in $global:PlayerArray) {
                Write-Host = "There's already someone called that!" -ForegroundColor Red; $Ok = $false;
            }
            else {
                $global:PlayerArray[$i] = $currentPlayerName;
                $Ok = $true;
            }
        }
        until($Ok)
    }
    Start-Sleep -m $MS;
    Write-Host "";
    Start-Sleep -m $MS;
    Write-Host "$global:PlayerArray";
}

<# Is resposible for prompting and storing the Werewolves #>
function ChooseWerewolves {
    Loading;
    for ($i = 0; $i -lt $global:WereWolvesArray.Length; $i++) {
        $plusone = $i + 1;
        do {
            $currentPlayerName = Read-Host -Prompt "Enter the name of Werewolf $plusone ";
            if($currentPlayerName -in $global:PlayerArray -eq $false) {
                Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
            }
            elseif ($null -eq $currentPlayerName) {
                Write-Host = "A Werewolf needs a name!" -ForegroundColor Red; $Ok = $false; 
            }
            elseif ($currentPlayerName -in $global:WereWolvesArray) {
                Write-Host = "There's already a werewolf called that!" -ForegroundColor Red; $Ok = $false;
            }
            else {
                $global:WereWolvesArray[$i] = $currentPlayerName;
                $Ok = $true; 
            }
        } 
        until($Ok)
        $global:BadGuys++; # Adds one to the bad guy counter
    }
    Start-Sleep -m $MS;
    Write-Host "";
    Start-Sleep -m $SS;
    Write-Host "$global:WereWolvesArray" @BGT;
}

<# Is resposible for prompting and storing the Doctor #>
function ChooseDoctor {
    Loading;
    do {
        $global:Doctor = Read-Host -Prompt "Enter the name of the Doctor ";
        if($global:Doctor -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:Doctor -in $global:WereWolvesArray) -or
        ($global:Doctor -eq $global:LittleGirl) -or
        ($global:Doctor -eq $global:Cupid) -or
        ($global:Doctor -eq $global:DemonButler) -or
        ($global:Doctor -eq $global:DemonDog) -or
        ($global:Doctor -eq $global:OldMan)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    } 
    until($Ok)
    Start-Sleep -m $SS; Write-Host ""; Start-Sleep -m $SS;
    Write-Host "$global:Doctor" @GGT;
}

<# Is resposible for prompting and storing the Little Girl #>
function ChooseLittleGirl {
    Loading;
    do {
        $global:LittleGirl = Read-Host -Prompt "Enter the name of the Little Girl ";
        if($global:LittleGirl -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:LittleGirl -in $global:WereWolvesArray) -or
        ($global:LittleGirl -eq $global:Doctor) -or
        ($global:LittleGirl -eq $global:Cupid) -or
        ($global:LittleGirl -eq $global:DemonButler) -or
        ($global:LittleGirl -eq $global:DemonDog) -or
        ($global:LittleGirl -eq $global:OldMan)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    } 
    until($Ok)
    Start-Sleep -m $MS; Write-Host ""; Start-Sleep -m $MS;
    Write-Host "$global:LittleGirl" @GGT;
}

<# Is resposible for prompting and storing Cupid #>
function ChooseCupid {
    Loading;
    do {
        $global:Cupid = Read-Host -Prompt "Enter the name of Cupid ";
        if($global:Cupid -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:Cupid -in $global:WereWolvesArray) -or
        ($global:Cupid -eq $global:Doctor) -or
        ($global:Cupid -eq $global:LittleGirl) -or
        ($global:Cupid -eq $global:DemonButler) -or
        ($global:Cupid -eq $global:DemonDog) -or
        ($global:Cupid -eq $global:OldMan)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    }
    until($Ok)
    Start-Sleep -m $MS; Write-Host ""; Start-Sleep -m $MS;
    Write-Host "$global:Cupid" @GGT;
}

<# Is resposible for prompting and storing the Demon Butler #>
function ChooseDemonButler {
    Loading;
    do {
        $global:DemonButler = Read-Host -Prompt "Enter the name of the Demon Butler ";
        if($global:DemonButler -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:DemonButler -in $global:WereWolvesArray) -or
        ($global:DemonButler -eq $global:Doctor) -or
        ($global:DemonButler -eq $global:LittleGirl) -or
        ($global:DemonButler -eq $global:Cupid) -or
        ($global:DemonButler -eq $global:DemonDog) -or
        ($global:DemonButler -eq $global:OldMan)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    } 
    until($Ok)
    Start-Sleep -m $MS; Write-Host ""; Start-Sleep -m $MS;
    Write-Host "$global:DemonButler" @GGT;
}

<# Is resposible for prompting and storing the Demon Dog #>
function ChooseDemonDog {
    Loading;
    do {
        $global:DemonDog = Read-Host -Prompt "Enter the name of the Demon Dog ";
        if($global:DemonDog -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:DemonDog -in $global:WereWolvesArray) -or
        ($global:DemonDog -eq $global:Doctor) -or
        ($global:DemonDog -eq $global:LittleGirl) -or
        ($global:DemonDog -eq $global:Cupid) -or
        ($global:DemonDog -eq $global:DemonButler) -or
        ($global:DemonDog -eq $global:OldMan)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    } 
    until($Ok)
    Start-Sleep -m $MS; Write-Host ""; Start-Sleep -m $MS;
    Write-Host "$global:DemonDog" @BGT ;
    $global:BadGuys++; # Adds one to the bad guy counter
}

<# Is resposible for prompting and storing the Old Man #>
function ChooseOldMan {
    Loading;
    do {
        $global:OldMan = Read-Host -Prompt "Enter the name of the Old Man ";
        if($global:OldMan -in $global:PlayerArray -eq $false) {
            Write-Host = "That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:OldMan -in $global:WereWolvesArray) -or
        ($global:OldMan -eq $global:Doctor) -or
        ($global:OldMan -eq $global:LittleGirl) -or
        ($global:OldMan -eq $global:Cupid) -or
        ($global:OldMan -eq $global:DemonButler) -or
        ($global:OldMan -eq $global:DemonDog)) {
            Write-Host = "They're already another character!" -ForegroundColor Red; $Ok = $false;
        }
        else {
            $Ok = $true; 
        }
    } 
    until($Ok)
    Start-Sleep -m $MS; Write-Host ""; Start-Sleep -m $MS;
    Write-Host "$global:OldMan" @GGT;
}

<# Is responisble for calculating and prompting for the different characters in each game #>
function ChooseCharacters {
    $global:BadGuys = 0; # Initialize the bad guys in the game
    # This series of if statements determines how many of each character to prompt for
    if ($global:NumberOfPlayers -le 4) {
        $global:WereWolvesArray = @(1);
        ChooseWerewolves;
        ChooseDoctor;
    }
    elseif ($global:NumberOfPlayers -le 5) {
        $global:WereWolvesArray = @(1);
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
    }
    elseif ($global:NumberOfPlayers -le 8) {
        $global:WereWolvesArray = 1, 2;
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
    }
    elseif ($global:NumberOfPlayers -le 12) {
        $global:WereWolvesArray = (1..([int32]$global:NumberOfPlayers / 3));
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
        ChooseDemonButler;
        ChooseDemonDog;
    }
    else {
        $global:WereWolvesArray = (1..([int32]$global:NumberOfPlayers / 3));
        ChooseWerewolves;
        ChooseDoctor;
        ChooseLittleGirl;
        ChooseCupid;
        ChooseDemonButler;
        ChooseDemonDog;
        ChooseOldMan;
    }
    $global:GoodGuys = $global:NumberOfPlayers - $global:BadGuys # Initialize the good guys in the game
}

function WhosWho {
    Loading;
    $isDead = "";
    Write-Host "Werewolves: $global:WereWolvesArray" @BGT; # Werewolves' Status


    if($global:Doctor -eq $null){$isDead = "...dead.";} # Doctor's Status
        Write-Host "Doctor: $global:Doctor $isDead" @GGT;

    if($global:LittleGirl -eq $null){$isDead = "...dead.";} # Little Girl's Status
        Write-Host "Little Girl: $global:LittleGirl $isDead" @GGT;

    if($global:Cupid -eq $null){$isDead = "...dead.";} # Cupid's Status
        Write-Host "Cupid: $global:Cupid $isDead" @GGT;

    if($global:DemonButler -eq $null){$isDead = "...dead.";} # Demon Butler's Status
        Write-Host "Demon Butler: $global:DemonButler $isDead" @GGT;

    if($global:DemonDog -eq $null){$isDead = "...dead.";} # Demon Dog's Status
        Write-Host "Demon Dog: $global:DemonDog $isDead" @BGT;

    if($global:OldMan -eq $null){$isDead = "...dead.";} # Old Man's Status
        Write-Host "Old Man: $global:OldMan $isDead" @GGT;

    Write-Host "";
    Write-Host "Number of Good Guys: $global:GoodGuys" @GGT;
    Write-Host "Number of Bad Guys: $global:BadGuys" @BGT;
}

<# Handles the WereWolves selecting who they want to kill #>
function PromptWereWolves {

}


<# Handles the act of playing the game until all of one side are dead. #>
function PlayGame {
    Loading;
    for ($i = 1; ($global:BadGuys -ne 0) -and ($global:GoodGuys -ne 0); $i++) {
        Write-Host "Night $i" -ForegroundColor Yellow;
        PromptWereWolves;
        PromptDoctor;
        if($i -eq 1) {
            PromptLittleGirl;
            PromptCupid;
        }
        PromptDemonButler;
        PromptDemonDog;
        PromptOldMan;
        WhosWho;
        $global:BadGuys = $global:BadGuys - 1;
    }
}
<# Handles the end game results being displayed and who won. #>
function GameOver {
    Loading
    WhosWho;
    Loading;
    if($global:BadGuys -eq 0) {Read-Host -Prompt "The villagers win!";}
    else{Read-Host -Prompt "The bad guys win!";}
}

<# Main function, handles the Intro for the game,
the number of players being entered, the entering
of the player names, the character choosing,
and actually playing the game until completion.
   ***Important*
#>
function PlayWerewolves {
    [CmdletBinding()]
    param()
    WerewolvesIntro;
    NumberOfPlayers;
    $global:PlayerArray = 1..$global:NumberOfPlayers;
    GetPlayerNames;
    ChooseCharacters;
    PlayGame;
}

# Startup
StartUp;

# Play Werewolves
PlayWerewolves;