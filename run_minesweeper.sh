#!/bin/bash
clear
error=0

echo Hi, welcome to my Ruby Minesweeper terminal app.
if ! [ -x "$(ruby -v)" ]; then
    echo "Ruby is installed!"; 
else
    echo "Ruby is NOT installed!";
    echo "please install Ruby and run this file again."
    exit 1
fi

if `gem list colorize -i`; then 
    echo "Checking colorize gem..."; 
else
    echo "colorize gem is NOT installed!";
    let "error+=1"
fi

if `gem list ruby-progressbar -i`; then 
    echo "Checking ruby-progressbar gem..."; 
else
    echo "ruby-progressbar gem is NOT installed!";
    let "error+=1"
fi


if `gem list simple-random -i`; then 
    echo "Checking simple-random gem..."; 
else
    echo "simple-random gem is NOT installed!";
    let "error+=1"
fi

if `gem list tty-font -i`; then 
    echo "Checking tty-font gem..."; 
else
    echo "tty-font gem is NOT installed!";
    let "error+=1"
fi

if test $error = 0; then
    echo "All gems are installed!"
    echo "What Minesweeper version would you like to play?"
    echo "1: Full Minesweeper"
    echo "2: Non gem Minesweeper"
    echo "H: Minesweeper help"
else
    echo "Not all gems are installed"
    echo "You can still play Minesweeper....would you like to play?"
    echo "1: Non gem Minesweeper"
    echo "H: Minesweeper help"
fi

read user_input_game

if test ${user_input_game^^} = "H"; then
    ruby play.rb -help
    exit 1
fi

echo "How many mines would you like? default is 10"

read user_input_mines

if test $error = 0; then
    if test $user_input_game = 1; then
        ruby play.rb $user_input_mines
    else
        ruby play_without_gems.rb $user_input_mines
    fi
else
    ruby play_without_gems.rb $user_input_mines
fi
