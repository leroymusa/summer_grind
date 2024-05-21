#!/bin/bash

# Check if the problem name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <Problem_Name>"
  exit 1
fi

# Prompt for the problem link
echo "Enter the link to the problem:"
read -r PROBLEM_LINK

# Prompt for the difficulty level
echo "Choose the difficulty level:"
echo "1. Easy"
echo "2. Medium"
echo "3. Hard"
read -r DIFFICULTY_CHOICE

case $DIFFICULTY_CHOICE in
  1)
    DIFFICULTY="Easy"
    ;;
  2)
    DIFFICULTY="Medium"
    ;;
  3)
    DIFFICULTY="Hard"
    ;;
  *)
    echo "Invalid difficulty choice."
    exit 1
    ;;
esac

# Prompt for the category
echo "Choose the category of the problem:"
echo "1. Arrays"
echo "2. Linked Lists"
echo "3. Stacks and Queues"
echo "4. Trees and Graphs"
echo "5. Hash Tables"
echo "6. Sorting and Searching"
echo "7. Dynamic Programming"
echo "8. Bit Manipulation"
read -r CATEGORY_CHOICE

case $CATEGORY_CHOICE in
  1)
    CATEGORY_NAME="Arrays"
    ;;
  2)
    CATEGORY_NAME="Linked Lists"
    ;;
  3)
    CATEGORY_NAME="Stacks and Queues"
    ;;
  4)
    CATEGORY_NAME="Trees and Graphs"
    ;;
  5)
    CATEGORY_NAME="Hash Tables"
    ;;
  6)
    CATEGORY_NAME="Sorting and Searching"
    ;;
  7)
    CATEGORY_NAME="Dynamic Programming"
    ;;
  8)
    CATEGORY_NAME="Bit Manipulation"
    ;;
  *)
    echo "Invalid category choice."
    exit 1
    ;;
esac

# Variables
PROBLEM_NAME=$1
BASE_DIR=~/summer_grind/data_structures_algorithms
PROBLEM_DIR="$BASE_DIR/$CATEGORY_NAME/$DIFFICULTY/$PROBLEM_NAME"

# Create directories and files
mkdir -p "$PROBLEM_DIR"
echo "$PROBLEM_LINK" > "$PROBLEM_DIR/q.txt"

# Create solution files with the determined extensions
touch "$PROBLEM_DIR/MySol.java"
touch "$PROBLEM_DIR/MySol.py"
touch "$PROBLEM_DIR/MySol.cpp"
touch "$PROBLEM_DIR/MySol.c"
touch "$PROBLEM_DIR/MySol.js"
touch "$PROBLEM_DIR/MySol.rb"
touch "$PROBLEM_DIR/MySol.swift"

echo "Directory and files created for problem: $PROBLEM_NAME in category: $CATEGORY_NAME with difficulty: $DIFFICULTY"
echo "Problem link added to q.txt"

# Git commands
cd ~/summer_grind || exit
git add .
git commit -m "Added problem $PROBLEM_NAME in category $CATEGORY_NAME with difficulty $DIFFICULTY"
git push origin master

echo "Changes committed and pushed to GitHub."

# Open the problem directory in VS Code
code "$PROBLEM_DIR"