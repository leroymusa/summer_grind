#!/bin/bash

# Check if the problem name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <Problem_Name>"
  exit 1
fi

# Prompt for the problem link
echo "Enter the link to the LeetCode problem:"
read -r PROBLEM_LINK

# Prompt for the difficulty level
echo "Enter the difficulty level (easy, medium, hard):"
read -r DIFFICULTY

# Validate difficulty level
if [[ "$DIFFICULTY" != "easy" && "$DIFFICULTY" != "medium" && "$DIFFICULTY" != "hard" ]]; then
  echo "Invalid difficulty level. Please enter one of: easy, medium, hard."
  exit 1
fi

# Prompt for the language of the solution
echo "Enter the language of your solution:"
echo "Supported languages: java, python, cpp, c, javascript, ruby, swift"
read -r LANGUAGE

# Validate language and determine file extension
case "$LANGUAGE" in
  java)
    FILE_EXT="java"
    ;;
  python)
    FILE_EXT="py"
    ;;
  cpp)
    FILE_EXT="cpp"
    ;;
  c)
    FILE_EXT="c"
    ;;
  javascript)
    FILE_EXT="js"
    ;;
  ruby)
    FILE_EXT="rb"
    ;;
  swift)
    FILE_EXT="swift"
    ;;
  *)
    echo "Unsupported language. Please add support for this language in the script."
    exit 1
    ;;
esac

# Variables
PROBLEM_NAME=$1
BASE_DIR=~/summer_grind/leetcode
PROBLEM_DIR="$BASE_DIR/$DIFFICULTY/$PROBLEM_NAME"

# Create directories and files
mkdir -p "$PROBLEM_DIR"
echo "$PROBLEM_LINK" > "$PROBLEM_DIR/q.txt"
touch "$PROBLEM_DIR/MySol.$FILE_EXT"

echo "Directory and files created for problem: $PROBLEM_NAME"
echo "Problem link added to q.txt"

# Git commands
cd ~/summer_grind || exit
git add .
git commit -m "Added problem $PROBLEM_NAME with difficulty $DIFFICULTY"
git push origin leetcode

echo "Changes committed and pushed to GitHub."

# Open the problem directory in VS Code
code "$PROBLEM_DIR"
