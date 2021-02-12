### Branches
```sh
git pull <remote> <branch>    # rebase
git pull origin master        # rebase example

git branch -a                 # list all branches

git checkout -b <name>        # create branch
git checkout master           # switch back to master

git diff master <new_branch>   # diff across branches
```

### Merges Locally
```sh
git checkout <branch_merge_into>    # switch to branch that is being merged into
git merge <brach_pulling_from>      # merging branch into branch_merge_into
git merge <brach_pulling_from> -no-ff   # no fast-forward (shows where came from)
```

### Deleting Branch
```sh
git branch                        # check branch you are on (master)
git branch -d <old_branch>        # deletes old branch you merged from
```

### Pushing Branch
You can also open Pull Requests between separate branches on GitHub. This often presents a good way for collaborating with people who have access to the same repository. You don't want to all be pushing to the `master` branch all the time. Instead, each person can create their own branch, work separately, and then open a pull request to merge that branch into `master`.

```sh
git branch                           # check branch you are on
git push -u origin <branch_name>    # push to github
```

**OR, INSTEAD OF UPSTREAM**
```sh
git pull origin master          # update local
git checkout -b <new_branch>    # create new branch
git add
git commit -m 'message'
git push origin <new_branch>

# Pull request > send pull request
```

**Output** if branch is up to date:
```sh
On branch <branch_name>
Your branch is up-to-date with 'origin/<branch_name>'.
nothing to commit, working tree clean
```

**THEN OPEN PULL REQUEST ONLINE**



### Other Commands
```sh
# commits
git commit --amend --reuse-message=HEAD # ammend commit to last commit
git commit -S -m                        # commit / sign / message

# various git logs (check them out)
git log -p
git log --oneline
git log --oneline --decorate --stat --graph
git log ORIG_HEAD.. --stat --no-merges
git log --pretty='format:%h %G? %aN  %s'
git log --show-signature
git log --pretty=format:"%h%Cred %ad%Cgreen | %s%C(yellow)%d%C(magenta) [%an%C(blue)]" --graph --date=short
git log --graph --pretty=format:'%Cred%h%Creset %Cblue%an%Creset: %s%Creset%C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative

# important commands
git rm --cached                         # remove file from git / not from local machine
git status -sb                          # status shorter / branch
git status                              # important command I run all the time

# need to learn about this
git stash
git stash pop

# files
git ls-tree -r master --name-only       # show tracked files in folder
git ls-files --other                    # show untracked files in folder

# git diff
git difftool --tool=vimdiff --no-prompt
git difftool --tool=vimdiff --no-prompt --cached
```
