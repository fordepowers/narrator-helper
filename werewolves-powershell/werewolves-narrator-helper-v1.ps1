# @Author - Ford Powers, January 4th, 2019

# This code handles the window resizing
function ResizeWindow {
    $pshost = get-host; $pswindow = $pshost.ui.rawui;
    $newsize = $pswindow.buffersize; $newsize.height = 3000;
    $newsize.width = 90; $pswindow.buffersize = $newsize;
    $newsize = $pswindow.windowsize; $newsize.height = 50;
    $newsize.width = 90; $pswindow.windowsize = $newsize;
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
    Write-Host "              _______ _______ _______         _______ _             _______ _______      " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     |\     /(  ____ (  ____ (  ____ |\     /(  ___  ( \   |\     /(  ____ (  ____ \     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     | )   ( | (    \| (    )| (    \| )   ( | (   ) | (   | )   ( | (    \| (    \/     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     | | _ | | (__   | (____)| (__   | | _ | | |   | | |   | |   | | (__   | (_____      " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     | |( )| |  __)  |     __|  __)  | |( )| | |   | | |   ( (   ) |  __)  (_____  )     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     | || || | (     | (\ (  | (     | || || | |   | | |    \ \_/ /| (           ) |     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     | () () | (____/| ) \ \_| (____/| () () | (___) | (____/\   / | (____//\____) |     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "     (_______(_______|/   \__(_______(_______(_______(_______/\_/  (_______\_______)     " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "                                                                                         " -ForegroundColor Red -BackgroundColor Black; Start-Sleep -m $SS;
    Write-Host "Welcome to werewolves-narrator-helper!";
    Start-Sleep -m $SS;
    Read-Host -Prompt "Press Enter to Play Werewolves";
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
    $global:PlayersHashTable = [ordered]@{};
    do {
        $WontWork = "That won't work!";
        $numberOfPlayersInputString = Read-Host -Prompt "How many players are there?"; # Initialize number of players
        $global:NumberOfPlayers = $numberOfPlayersInputString -as [Int];
        # Make sure a right value was chosen.
        if (($NULL -eq $global:NumberOfPlayers) -or
            ($global:NumberOfPlayers -eq 0) -or
            ($global:NumberOfPlayers -eq 1) -or
            ($global:NumberOfPlayers -eq 2) -or
            ($global:NumberOfPlayers -eq 3)) {
            Write-Host $WontWork -ForegroundColor Red; $Ok = $false;
        }
        else {$Ok = $true; }
    } until($Ok)
    # Populates the hash table for the players
    for ($i = 1; $i -le $global:NumberOfPlayers; $i++) {
        do {
            $inputString = Read-Host -Prompt "Enter the name of Player $i";
            if ("" -eq $inputString) {
                Write-Host $WontWork -ForegroundColor Red; $Ok = $false;
            }
            elseif ($global:PlayersHashTable.Contains($inputString)) {
                Write-Host "-There's already someone called that!" -ForegroundColor Red; $Ok = $false;
            }
            else {$Ok = $true; }
        } until ($Ok)
        $global:PlayersHashTable[$inputString] = "Villager $i";
    }
    Write-Host "";
    $global:PlayersHashTable;
}

<# Is resposible for prompting and storing the Werewolves #>
function ChooseWerewolves {
    for ($i = 0; $i -lt $global:WereWolvesArray.Length; $i++) {
        $plusone = $i + 1;
        do {
            Write-Host "";
            $currentPlayerName = Read-Host -Prompt "Enter the name of Werewolf $plusone ";
            if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
                Write-Host "-That's not a player!" -ForegroundColor Red;
                $Ok = $false;
            }
            elseif ($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") {
                Write-Host "-There's already a werewolf called that!" -ForegroundColor Red;
                $Ok = $false;
            }
            else {
                $global:PlayersHashTable.Set_Item($currentPlayerName, "Werewolf");
                $Ok = $true; 
            }
        } until($Ok)
        $global:BadGuys++; # Adds one to the bad guy counter
    }
}

<# Is resposible for prompting and storing the Doctor #>
function ChooseDoctor {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of the Doctor ";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red;
            $Ok = $false;
        }
        elseif ($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Doctor");
            $Ok = $true; 
        }
    } until($Ok)
}

<# Is resposible for prompting and storing the Little Girl #>
function ChooseLittleGirl {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of the Little Girl";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Doctor")) {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Little Girl");
            $Ok = $true; 
        }
    } until($Ok)
}

<# Is resposible for prompting and storing Cupid #>
function ChooseCupid {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of Cupid";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Doctor") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Little Girl")) {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Cupid");
            $Ok = $true; 
        }
    } until($Ok)
}

<# Is resposible for prompting and storing the Demon Butler #>
function ChooseDemonButler {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of the Demon Butler";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Doctor") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Little Girl") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Cupid")) {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Demon Butler");
            $Ok = $true; 
        }
    } until($Ok)
}

<# Is resposible for prompting and storing the Demon Dog #>
function ChooseDemonDog {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of the Demon Dog";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Doctor") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Little Girl") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Cupid") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Demon Butler")) {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Demon Dog");
            $Ok = $true; 
        }
    } until($Ok)
    $global:BadGuys++; # Adds one to the bad guy counter
}

<# Is resposible for prompting and storing the Old Man #>
function ChooseOldMan {
    Write-Host "";
    do {
        $currentPlayerName = Read-Host -Prompt "Enter the name of the Old Man";
        if ($global:PlayersHashTable.Contains($currentPlayerName) -eq $false) {
            Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false;
        }
        elseif (($global:PlayersHashTable.$currentPlayerName -eq "Werewolf") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Doctor") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Little Girl") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Cupid") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Demon Butler") -or
            ($global:PlayersHashTable.$currentPlayerName -eq "Demon Dog")) {
            Write-Host "-They're already another character!" -ForegroundColor Red;
            $Ok = $false;
        }
        else {
            $global:PlayersHashTable.Set_Item($currentPlayerName, "Old Man");
            $Ok = $true; 
        }
    } until($Ok)
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
        $global:WereWolvesArray = 1, 2;
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
    $global:PlayersHashTable;
}

function KillSomeone {
    Param # Define parameters to import the function
    (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $deadPerson,
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $WhoKilledThem
    )

    if ($deadPerson -ne $global:SavedPerson) {
        if ($global:PlayersHashTable.$deadPerson -eq "Doctor") {
            Write-Host "$deadPerson, the Doctor was killed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1; 
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Little Girl") {
            Write-Host "$deadPerson, the Little Girl was killed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Cupid") {
            Write-Host "$deadPerson, Cupid was killed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1; 
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Demon Butler") {
            Write-Host "$deadPerson, the Demon Butler was killed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Demon Dog") {
            Write-Host "$deadPerson, the Demon Dog was killed." -ForegroundColor Yellow;
            $global:BadGuys = $global:BadGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Old Man") {
            Write-Host "$deadPerson, the Old Man was killed." -ForegroundColor Yellow;
            $global:OldManRevenge = $true; $global:GoodGuys = $global:GoodGuys - 1;
        }
        else {
            Write-Host "$deadPerson, a villager was killed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "the $WhoKilledThem killed $deadPerson, "; # Add this event to the print out
        $global:PlayersHashTable.Remove($deadPerson);
    }
    else {
        Write-Host "$deadPerson was saved by the Doctor." -ForegroundColor Yellow; 
        $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "the $WhoKilledThem tried to kill $deadPerson, but they were saved by the Doctor, "; # Add this to the print out
    }
}

function WhosWho {
    Write-Host "";
    $global:PlayersHashTable;
    Write-Host "";
    Write-Host "Number of Good Guys: $global:GoodGuys" @GGT;
    Write-Host "Number of Bad Guys: $global:BadGuys" @BGT;
    Write-Host "";
}

<# Handles the WereWolves selecting who they want to kill #>
function PromptWereWolves {
    do {
        $deadPerson = Read-Host -Prompt "Who do the Werewolves want to kill?";
        if ($global:PlayersHashTable.Contains($deadPerson) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Werewolf") {Write-Host "-That's a fellow Werewolf!" -ForegroundColor Red; $Ok = $false; }
        else {$Ok = $true; }
    } until ($Ok)
    # Calls the KillSomeone function and passes the deadperson to it
    KillSomeone -deadPerson $deadPerson -WhoKilledThem "Werewolves";
}

<# Handles the Doctor selecting who they want to save #>
function PromptDoctor {
    do {
        $global:SavedPerson = Read-Host -Prompt "Who does the Doctor want to save?";
        if ($global:PlayersHashTable.Contains($global:SavedPerson) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
        else {$Ok = $true; }
    } until ($Ok)
    Write-Host "Saved from evil: $global:SavedPerson" -ForegroundColor Green;
    $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "the Doctor saved $global:SavedPerson, "; # Add the event to the print out
}

<# Handles the Little Girl recieving her instructions #>
function PromptLittleGirl {
    Read-Host -Prompt "Role: The Little Girl can open their eyes at any time and peek whenever they want. The downside to this is they might get caught. Press enter to continue";
}

<# Handles Cupid selecting who they want to love link #>
function PromptCupid {
    $global:LoveLinkHashTable = [ordered]@{};
    do {
        $loveLink1 = Read-Host -Prompt "Who do you want to love link first?";
        if ($global:PlayersHashTable.Contains($loveLink1) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
        else {$Ok = $true; }
    } until ($Ok)
    do {
        $loveLink2 = Read-Host -Prompt "Who do you want to love link second?";
        if ($global:PlayersHashTable.Contains($loveLink2) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
        elseif ($loveLink1 -eq $loveLink2) {Write-Host "-That's the same player!" -ForegroundColor Red; $Ok = $false; }
        else {$Ok = $true; }
    } until ($Ok)
    $global:LoveLinkHashTable[$loveLink1] = "$loveLink2";
    $global:LoveLinkHashTable[$loveLink2] = "$loveLink1";
    $global:LoveLinkHashTable;
    $global:LoversDeadAlready = $false;
}

<# Handles the Demon Butler deciding if they want to let the Demon Dog out #>
function PromptDemonButler {
    do {
        $global:DogIsOut = Read-Host -Prompt "Do you want to let your dog out for the night? Y/N";
        if ($global:DogIsOut -eq "Y") {$global:DogIsOut = $true; $Ok = $true; }
        elseif ($global:DogIsOut -eq "N") {$global:DogIsOut = $false; $Ok = $true; }
        else {Write-Host "-That's not a Y or N." -ForegroundColor Red; $Ok = $false; }
    } until ($Ok)
    if ($global:DogIsOut) {
        Write-Host "The Demon Dog has been released!" -ForegroundColor Yellow;
        $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "the Demon Butler let out his dog, "; # Add this event to the print out
    }
    else {
        Write-Host "The Demon Dog has been locked up." -ForegroundColor Yellow;
        $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "the Demon Butler locked up his dog, "; # Add this event to the print out
    }
}

<# Handles the Demon Dog selecting who they want to kill #>
function PromptDemonDog {
    do {
        $deadPerson = Read-Host -Prompt "Who does the Demon Dog want to kill?";
        if ($global:PlayersHashTable.Contains($deadPerson) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
        else {$Ok = $true; }
    } until ($Ok)
    if ($global:DogIsOut) {
        # Calls the KillSomeone function and passes the deadperson to it
        KillSomeone -deadPerson $deadPerson -WhoKilledThem "Demon Dog";
    }
    else {Write-Host "The Demon Dog was not released tonight." -ForegroundColor Yellow; }
}

<# Handles the OldMan selecting who they want to take with them #>
function PromptOldMan {
    if ($global:OldManRevenge) {
        do {
            $deadPerson = Read-Host -Prompt "Who does the Old Man want to take with him?";
            if ($global:PlayersHashTable.Contains($deadPerson) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
            else {$Ok = $true; }
        } until ($Ok)
        # Calls the KillSomeone function and passes the deadperson to it
        KillSomeone -deadPerson $deadPerson -WhoKilledThem "Old Man";
    }
    else {
        Write-Host "It's not the Old Man's night."
    }
}

<# Function checks to see if one of the lovers has died. If they have, kills the other lover. #>
function CheckLoveLink {
    if ($global:LoversDeadAlready -eq $false) {
        # Check to make sure this method hasn't already killed someone
        $loverThatIsDead = $global:LoveLinkHashTable.Keys | ? {$_ -notin $global:PlayersHashTable.Keys};
        if ($loverThatIsDead -ne $NULL) {
            $loverToKill = $global:LoveLinkHashTable.$loverThatIsDead;
            Write-Host "$loverThatIsDead was dead, so $loverToKill died of a broken heart.";
            # Calls the KillSomeone function and passes the deadperson to it
            KillSomeone -deadPerson $loverToKill -WhoKilledThem "Pain of a Broken Heart";
            $global:WhatHappenedLastNight = $global:WhatHappenedLastNight + "$loverThatIsDead died, and $loverToKill was love linked, so they died too"; # Add this event to the print out
            $global:LoversDeadAlready = $true; # Make sure this method doesn't run again
        }
        else {
            Write-Host "Both lovers are still alive.";
        }
    }
}


<# Function handles the trial during the day, and executing someone if it happens. #>
function DayTrial {
    if ($global:PlayersHashTable.Count -gt 2) { # If the player count is greater than 2, run the trial.
        do {
            $deadPerson = Read-Host -Prompt "Who will the villagers execute?";
            if ($global:PlayersHashTable.Contains($deadPerson) -eq $false) {Write-Host "-That's not a player!" -ForegroundColor Red; $Ok = $false; }
            else {$Ok = $true; }
        } until ($Ok)
        if ($global:PlayersHashTable.$deadPerson -eq "Doctor") {
            Write-Host "$deadPerson, the Doctor was executed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Little Girl") {
            Write-Host "$deadPerson, the Little Girl was executed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Cupid") {
            Write-Host "$deadPerson, Cupid was executed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Demon Butler") {
            Write-Host "$deadPerson, the Demon Butler was executed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Werewolf") {
            Write-Host "$deadPerson, a Werewolf was executed." -ForegroundColor Yellow;
            $global:BadGuys = $global:BadGuys - 1;
        }
        elseif ($global:PlayersHashTable.$deadPerson -eq "Demon Dog") {
            Write-Host "$deadPerson, the Demon Dog was executed." -ForegroundColor Yellow;
            $global:BadGuys = $global:BadGuys - 1;
        }
        else {
            Write-Host "$deadPerson, a villager was executed." -ForegroundColor Yellow;
            $global:GoodGuys = $global:GoodGuys - 1;
        }
        $global:PlayersHashTable.Remove($deadPerson);
    } else {
        Write-Host "There are not enough villagers for a trial..." -ForegroundColor Yellow;
    }
}


<# Handles the act of playing the game until all of one side are dead. #>
function PlayGame {
    for ($i = 1; ($global:BadGuys -ne 0) -and ($global:GoodGuys -ne 0); $i++) {
        $global:WhatHappenedLastNight = "Last night, "; # This is the string that prints out the events.
        Write-Host "";
        Write-Host "Night $i" -ForegroundColor Yellow; # Start of the night --- 
        Write-Host "";
        $global:SavedPerson = $null; # Reset the saved person
        if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Doctor"}) -ne $null) {PromptDoctor; } # Doctor goes first so that way he can save people
        if ($i -eq 1) {
            if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Little Girl"}) -ne $null) {PromptLittleGirl; }
            if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Cupid"}) -ne $null) {PromptCupid; }
        }
        if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Demon Butler"}) -ne $null) {PromptDemonButler; }
        if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Demon Dog"}) -ne $null) {PromptDemonDog; }
        if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Old Man"}) -ne $null) {PromptOldMan; }
        if ($global:PlayersHashTable.Keys.Where( {$global:PlayersHashTable[$_] -eq "Werewolf"}) -ne $null) {PromptWereWolves; } # Wolves go last so that way they don't kill the dog first
        # End of the Night
        CheckLoveLink;
        Write-Host "";
        Write-Host $global:WhatHappenedLastNight -ForegroundColor Yellow -BackgroundColor Black; # Print event list from the night
        Write-Host "";
        Write-Host "Day $i" -ForegroundColor Yellow; # Start of the day and trial ---
        Write-Host "";
        DayTrial;
        CheckLoveLink; # Check love link from trial
        WhosWho;
    }
}

<# Handles the end game results being displayed and who won. #>
function GameOver {
    Loading;
    if ($global:BadGuys -eq 0) {Write-Host "The villagers win!" -ForegroundColor Green; Read-Host; }
    else {Write-Host "The bad guys win!" -ForegroundColor Red; Read-Host; }
}

<# Main function, handles the Intro for the game,
the number of players being entered, the entering
of the player names, the character choosing,
and actually playing the game until completion.
   ***Important*
#>
function PlayWerewolves {
    ResizeWindow;
    IntroductionPage;
    NumberOfPlayers;
    ChooseCharacters;
    PlayGame;
    GameOver;
}

# Play Werewolves
PlayWerewolves;