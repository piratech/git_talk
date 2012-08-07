# Git Talk - Scriptum
# Was ist Versionskontrolle
 * Zentrale Versionskontrolle
 * Zentrale Versionskontrolle
 * Geschichte
 * Grundlage
  + Allgemeine Grundlagen
  + Plumbing vs. Porcelain
  + Erstellen eines Repositories
  
        $ git init
        Initialized empty Git repository in .git/

  + Git-Objekte und Git-Referenzen 
   * Blob erstellen

        $ ls -a
        .  ..  .git
        $ ls .git
        branches  config  description  HEAD  hooks  info  objects  refs
        $ find .git/objects
        .git/objects/
        .git/objects/pack
        .git/objects/info
        $ find .git/objects -type f
        $ echo 'test content' | git hash-object -w --stdin # -w = store object
        d670460b4b4aece5915caf5c68d12f560a9fe3e4
        $ find .git/objects/ -type f
        .git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4
        $ git cat-file -p d6704 # -p = pretty-print object's content
        test content
        $ git cat-file -t d6704 # -t = print object's type
        blob

   * Objektdatenbank verwaltet Inhalte, nicht Dateien
 
        $ echo 'test content' > test.txt
        $ git hash-object -w test.txt
        $ find .git/objects/ -type f

   * Tree erstellen:

        $ git update-index --add --cacheinfo 100644 \
            d670460b4b4aece5915caf5c68d12f560a9fe3e4 test.txt
        # only 100644 (normal), 100755 (exe) and 120000 (symlink) allowed
        $ ls .git
        branches  config  description  HEAD  hooks  index  info  objects  refs
        $ git write-tree
        80865964295ae2f11d27383e5f9c0b58a8ef21da
        $ git cat-file -p 8086
        100644 blob d670460b4b4aece5915caf5c68d12f560a9fe3e4	test.txt
        $ git cat-file -t 8086
        tree
        $ echo "test test" > foo.txt
        $ git update-index --add foo.txt
        $ git write-tree
        d9a564e5228b9e0f77a382af60a5a707ca2bcf46
        $ git cat-file -p d9a5
        100644 blob b33c5606734ea563dac93e08bbaae96c811b05b8    foo.txt
        100644 blob d670460b4b4aece5915caf5c68d12f560a9fe3e4    test.txt
        $ git read-tree --prefix=bar 80865964295ae2f11d27383e5f9c0b58a8ef21da
        $ git write-tree
        366207988367ac43c0ff93171224a3b7733e7b5b
        $ git cat-file -p 366207988367ac43c0ff93171224a3b7733e7b5b
        040000 tree 80865964295ae2f11d27383e5f9c0b58a8ef21da	bar
        100644 blob 637f0347d31dad180d6fc7f6720c187b05a8754c	foo.txt
        100644 blob d670460b4b4aece5915caf5c68d12f560a9fe3e4	test.txt

  * Commit erstellen:
        
        $ echo "first commit" | git commit-tree 8086
        c08329052811f02d90b7e43066ce023a13731446
        $ git cat-file -p c0832
        tree 80865964295ae2f11d27383e5f9c0b58a8ef21da
        author Martin Lenders <mail@martin-lenders.de> 1344353580 +0200
        committer Martin Lenders <mail@martin-lenders.de> 1344353580 +0200
        
        first commit
        $ git cat-file -t c0832
        commit
        $ echo "second commit" | git commit-tree 3662 -p c083
        f82ab5445a31e19e8ccbd35577b317d684b0ddb2
        $ git log --stat f82a
        commit f82ab5445a31e19e8ccbd35577b317d684b0ddb2
        Author: Martin Lenders <mail@martin-lenders.de>
        Date:   Tue Aug 7 17:34:45 2012 +0200
        
            second commit
        
         bar/test.txt |    1 +
         foo.txt      |    1 +
         2 files changed, 2 insertions(+)
        
        commit c08329052811f02d90b7e43066ce023a13731446
        Author: Martin Lenders <mail@martin-lenders.de>
        Date:   Tue Aug 7 17:33:00 2012 +0200
        
            first commit
        
         test.txt |    1 +
         1 file changed, 1 insertion(+)
 
  * Git-Referenzen:

        $ find .git/refs 
        .git/refs/
        .git/refs/heads
        .git/refs/tags
        $ find .git/refs -type f
        $ echo f82ab5445a31e19e8ccbd35577b317d684b0ddb2 > .git/refs/heads/master
        $ git log --pretty=oneline master
        f82ab5445a31e19e8ccbd35577b317d684b0ddb2 second commit
        c08329052811f02d90b7e43066ce023a13731446 first commit

  * Manuelles bearbeiten von Referenzdateien nicht empfohlen:

        $ git update-ref refs/heads/master f82a
        $ git checkout -f
        $ ls
        bar  foo.txt  test.txt
        $ git update-ref refs/heads/test f82a
        $ cat .git/refs/heads/test
        c08329052811f02d90b7e43066ce023a13731446
        $ git checkout test
        $ ls
        test.txt
        $ git checkout master
        $ ls
        bar  foo.txt  test.txt

  * HEAD:
       
        $ cat .git/HEAD
        ref: refs/heads/master
        $ git symbolic-ref HEAD
        refs/heads/master
        $ git log --pretty=oneline
        f82ab5445a31e19e8ccbd35577b317d684b0ddb2 second commit
        c08329052811f02d90b7e43066ce023a13731446 first commit
        $ git symbolic-ref HEAD refs/heads/test
        $ cat .git/HEAD
  
  * Tags
   ~ Lightweight tags

        $ git update-ref refs/tags/v1.0 c083 
        $ cat .git/refs/tags/v1.0
        c08329052811f02d90b7e43066ce023a13731446

   ~ Annotated tags
        
        $ git tag -a v1.1 f82a -m "test tag"
        $ cat .git/refs/tags/v1.1
        e294ee70c0e6d5651342f6b823c01e1eede3a810
        $ git cat-file -p e294ee70c0e6d5651342f6b823c01e1eede3a810
        object f82ab5445a31e19e8ccbd35577b317d684b0ddb2
        type commit
        tag v1.1
        tagger Martin Lenders <mail@martin-lenders.de> Tue Aug 7 18:34:12 2012 +0200
        
        test tag

  * Remotes

        $ git remote add origin git@github.com:schacon/simplegit-progit.git
        $ git fetch
        warning: no common commits
        remote: Counting objects: 13, done.
        remote: Compressing objects: 100% (8/8), done.
        remote: Total 13 (delta 3), reused 13 (delta 3)
        Unpacking objects: 100% (13/13), done.
        From github.com:schacon/simplegit-progit
         * [new branch]      master     -> origin/master
        $ find .git/refs/remotes/
        .git/refs/remotes/
        .git/refs/remotes/origin
        .git/refs/remotes/origin/master
        $ cat .git/refs/remotes/origin/master
        ca82a6dff817ec66f44342007202690a93763949
 
 + Git Packfiles
        
        $ git gc
        $ find .git/objects -type f
        $ git verify-pack -v \
             .git/objects/pack/pack-6fd552eb8625bd7155787d8424fcd684d0817880.idx
         
