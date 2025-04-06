#!/bin/bash

# Check if repository path is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/repository" > ~/.config/nvim/git-auto-push.log
    exit 1
fi

REPO_PATH=$1

# Log file path
LOGFILE=~/.config/nvim/git-auto-push.log

# Create or clear the log file
echo "Running git-auto-push.sh at $(date)" > $LOGFILE

# Change directory to the repo
cd "$REPO_PATH" || { echo "Failed to change directory to $REPO_PATH"; exit 1; }

# Check if .git directory exists
if [ ! -d ".git" ]; then
    echo "Not a git repository (or any of the parent directories): .git not found" >> $LOGFILE
    exit 1
fi

# Check git status and log output
status=$(git status --porcelain)
echo "Git status output: $status" >> $LOGFILE

if [ -n "$status" ]; then
    echo "Changes detected. Committing and pushing..." >> $LOGFILE

    # Add all changes to staging, including untracked files
    git add -A >> $LOGFILE 2>&1

    # Generate a commit message from the short status
    commit_message=$(echo "$status" | head -n 1 | tr -d '\n')
    if [ -z "$commit_message" ]; then
        commit_message="Auto-commit from Neovim"
    else
        commit_message="Changes: $commit_message"
    fi

    # Commit changes with the generated message
    git commit -m "$commit_message" >> $LOGFILE 2>&1

    # Push changes
    git push >> $LOGFILE 2>&1

    echo "Changes pushed to GitHub" >> $LOGFILE
else
    echo "No changes to commit" >> $LOGFILE
fi

