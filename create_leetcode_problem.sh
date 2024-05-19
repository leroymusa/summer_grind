#!/bin/bash

# Check if the problem name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <Problem_Name>"
  exit 1
fi

# Prompt for the problem link
echo "Enter the link to the LeetCode problem:"
read -r PROBLEM_LINK

# Variables
PROBLEM_NAME=$1
BASE_DIR=~/summer_grind/leetcode/easy
PROBLEM_DIR="$BASE_DIR/$PROBLEM_NAME"

# Create directories and files
mkdir -p "$PROBLEM_DIR"
echo "$PROBLEM_LINK" > "$PROBLEM_DIR/q.txt"
touch "$PROBLEM_DIR/MySol.java"

echo "Directory and files created for problem: $PROBLEM_NAME"
echo "Problem link added to q.txt"

# Git commands
cd ~/summer_grind || exit
git add .
git commit -m "Added problem $PROBLEM_NAME"
git push origin leetcode

echo "Changes committed and pushed to GitHub."

# Open the problem directory in VS Code
code "$PROBLEM_DIR"
