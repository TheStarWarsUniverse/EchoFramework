---
sidebar_position: 2
---

# Getting Started

## Installation

You are recommend to download [Visual Studio Code](https://code.visualstudio.com/), [Rojo](https://rojo.space) and [Github Desktop](https://desktop.github.com/) to install it easily.

### Step 0: Requirements

1. Github account.
2. Github account that has been invited to the TSWU Development group.
3. Visual Studio Code.
4. Github CLI.
5. Rojo for both Visual Studio Code extension and Roblox Studio plugin.
6. More than 10 braincells.

### Step1: Github repository

1. Go to [Github](https://github.com/).
2. Click new.
3. Select **TheStarWarsUniverse** for owner.
4. Change the repository name to the project name.
5. Add Description (optional).
6. Private the repository.
7. Create repository.

### Step2: Visual Studio Code Setup

1. Click Set up in Desktop. (Make sure you have the github desktop app installed)
2. Select your local path.
3. Clone the repository.
4. Click Open in Visual Studio Code.
5. Open the command bar.

### Step 3: Command Bar Setup

1. Run `git remote add echo https://github.com/TheStarWarsUniverse/EchoFramework.git` to add the Echo as a remote.
2. Run `git fetch --all`. This will download all commits from the Echo repo.
3. Run `git switch main`. This will create the main branch.
4. Run `git switch dev`. This will create the dev branch.
5. Run `git push -u origin main`. This will push your changes and set your primary remote correctly.
6. Run `git push -u origin dev`. This will push your changes and set your primary remote correctly.

## Updating Echo framework

Remember to update the Echo framework once an update has been released!

1. Open the command bar.
2. Run `git merge echo/main`.
3. Run `git push`.