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
 
 * Git Packfiles

        git gc
        find .git/objects -type f
        git verify-pack -v .git/objects/pack/pack-6fd552eb8625bd7155787d8424fcd684d0817880.idx
