---
sidebar_position: 2
---

# Installation

You are recommended to download visual studio code, rojo and github desktop to install it easily.

**Step 0: Requirements:**

1. Github account.
2. Github account that has been invited to the [TSWU Development group](https://github.com/TheStarWarsUniverse).
3. Visual Studio Code.
4. Github CLI.
5. [Rojo](https://rojo.space) for both **Visual Studio Code** extension and **Roblox Studio** plugin.
6. More than 10 braincells.

**Step 1: Github repository:**

1. Go to [**Github**](https://github.com/).
2. Click **new**.
3. Select **TheStarWarsUniverse** for owner.
4. Change the repository name to the project name.
5. Add Description (optional).
6. Private the repository.
7. Create repository.

**Step 2: Visual Studio Code Setup:**

1. Click **Set up in Desktop.** (Make sure you have the github desktop app installed)
2. Select your local path.
3. Clone the repository.
4. Click **Open in Visual Studio Code**.
5. Open the command bar.

**Step 3: Command Bar Setup:**

1. Run ``git remote add echo https://github.com/TheStarWarsUniverse/EchoFramework.git`` to add the Echo as a remote.
2. Run ``git fetch --all``. This will download all commits from the Echo repo.
3. Run ``git switch main``. This will create the main branch.
4. Run ``git switch dev``. This will create the dev branch.
5. Run ``git push -u origin main``. This will push your changes and set your primary remote correctly.
6. Run ``git push -u origin dev``. This will push your changes and set your primary remote correctly.

# Echo Update

You are required to update the template if you see any merges from #echo-framework channel in development server.

* Open the command bar.
* Run `git merge echo/main`.
* Run `git push`.