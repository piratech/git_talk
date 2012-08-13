# Git Talk - Scriptum
## Was ist Versionskontrolle
 * Zentrale Versionskontrolle
 * Verteilte Versionskontrolle
## Geschichte
## Grundlage
 * Allgemeine Grundlagen
 * Plumbing vs. Porcelain
 * Erstellen eines Repositories
  
        git init

 * Git-Objekte und Git-Referenzen
    + Blob erstellen

            ls -a
            ls .git
            find .git/objects
            find .git/objects -type f
            echo 'test content' | git hash-object -w --stdin # -w = store object
            find .git/objects/ -type f
            git cat-file -p d6704 # -p = pretty-print object's content
            git cat-file -t d6704 # -t = print object's type

    + Objektdatenbank verwaltet Inhalte, nicht Dateien
 
            echo 'test content' > test.txt
            git hash-object -w test.txt
            find .git/objects/ -type f

    + Tree erstellen:

            git update-index --add --cacheinfo 100644 d670460b4b4aece5915caf5c68d12f560a9fe3e4 test.txt
            # only 100644 (normal), 100755 (exe) and 120000 (symlink) allowed
            ls .git
            git write-tree
            git cat-file -p 8086
            git cat-file -t 8086
            echo "test test" > foo.txt
            git update-index --add foo.txt
            git write-tree
            git cat-file -p d9a5
            git read-tree --prefix=bar 80865964295ae2f11d27383e5f9c0b58a8ef21da
            git write-tree
            git cat-file -p 366207988367ac43c0ff93171224a3b7733e7b5b

    + Commit erstellen:

            echo "first commit" | git commit-tree 8086
            git cat-file -p c0832
            git cat-file -t c0832
            echo "second commit" | git commit-tree 3662 -p c083
            git log --stat f82a

    + Git-Referenzen:

            find .git/refs
            find .git/refs -type f
            echo f82ab5445a31e19e8ccbd35577b317d684b0ddb2 > .git/refs/heads/master
            git log --pretty=oneline master

    + Manuelles bearbeiten von Referenzdateien nicht empfohlen:

            git update-ref refs/heads/master f82a
            git checkout -f
            ls
            git update-ref refs/heads/test f82a
            cat .git/refs/heads/test
            git checkout test
            ls
            git checkout master
            ls

    + HEAD:

            cat .git/HEAD
            git symbolic-ref HEAD
            git log --pretty=oneline
            git symbolic-ref HEAD refs/heads/test
            cat .git/HEAD
  
    + Tags
        - Lightweight tags

                git update-ref refs/tags/v1.0 c083
                cat .git/refs/tags/v1.0

        - Annotated tags

                git tag -a v1.1 f82a -m "test tag"
                cat .git/refs/tags/v1.1
                git cat-file -p e294ee70c0e6d5651342f6b823c01e1eede3a810

    + Remotes

            git remote add origin git@github.com:schacon/simplegit-progit.git
            git fetch
            find .git/refs/remotes/
            cat .git/refs/remotes/origin/master
            (git remote rm)
 
 * Git Packfiles

        git gc
        find .git/objects -type f
        git verify-pack -v .git/objects/pack/pack-6fd552eb8625bd7155787d8424fcd684d0817880.idx

## Git konfigurieren

    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com
    git config --global core.editor vim
    git config --global merge.tool meld
    git config --global color.ui true
    git config --global credential.helper 'cache --timeout=3600'
    git config --global core.whitespace trailing-space
    git config --global apply.whitespace fix
    git config --global alias.ci commit

 * Konfiguration zeigen:

        git config --list
        git config user.name

## Git-Repository
### Erstellen
### Existierendes runterladen

## Änderungen aufzeichnen

    git clone git://github.com/schacon/simplegit-progit.git
    cd simplegit-progit/
    git status
    touch LICENSE
    git status
    git add LICENSE
    git status
    vim README
    git status
    echo "*~" >> .gitignore # Folie wechseln
    git status
    git add .gitignore
    git add README
    git status
    vim README
    git status
    git help add
    vim README
    git add -p
    git status

    git diff
    git diff --cached

    git commit # commit message falsch schreiben, Folie wechseln
    git commit --amend
    git add -p
    git diff
    git reset HEAD README
    git add -p
    git diff
    git commit --amend
    git status
    git diff
    git add -i
    git commit -m "Add just an example"
    git commit -a -m "Add another example"

    rm LICENSE
    git status
    git checkout -f
    ls
    git status
    git rm LICENSE
    git status
    git commit -m "Remove the license"

    git mv README README.txt
    git status
    git commit -m "Rename README to README.txt"

## Commit-History betrachten

    git log
    git log -p
    git log --stat
    git log --pretty=oneline
    git log --pretty=format:"%h - %an, %ar : %s"
    git log --pretty=format:"%h %s" --graph
    git log --since=2.weeks --until=5.minute
    git log -1

## Arbeiten mit Remotes

    git remote
    git remote -v

    cd ..
    git clone git://github.com/schacon/ticgit.git
    cd ticgit
    git remote -v
    git remote add pb git://github.com/paulboone/ticgit.git
    git remote -v
    git fetch pb
    git push origin master
    git remote rename pb paul
    git remote
    git remote rm paul
    git remote

## Branching

    git branch
    git branch testing
    git branch
    git branch -v
    find .git/refs -type f
    cat .git/refs/heads/testing
    git log --pretty=format:"%H" -1
    git checkout testing
    git branch
    git symbolic-ref HEAD
    vim README.txt
    git commit -am "Made a change"
    git checkout master
    vim README.txt
    git commit -am "Made another change"
    git log --graph --branches --pretty=format:"%h %d"

    git checkout -b iss53
    git branch
    vim .gitignore
    git commit -am "Add *.exe to .gitignore"
    git checkout master
    git checkout -b hotfix
    vim .gitignore
    git commit -am "Add *~ to .gitignore"

    git checkout master
    git log --graph --branches --pretty=format:"%h %d"
    git merge hotfix
    git log --graph --branches --pretty=format:"%h %d"
    git branch -d hotfix
    git log --graph --branches --pretty=format:"%h %d"
    git merge iss53
    git status
    cat .gitignore
    git mergetool
    git status
    git commit
    git log --graph --branches --pretty=format:"%h %d"

    git branch -d testing
    git branch -D testing
    git log --graph --branches --pretty=format:"%h %d"
    git update-ref refs/heads/testing <hash>
    git log --graph --branches --pretty=format:"%h %d"

    git branch --merged
    git branch --no-merged
