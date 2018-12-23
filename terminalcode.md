Last login: Fri Dec 21 18:41:37 on console

gimjieun-ui-MacBook-Pro:~ gimjieun$ mkdir Swift_iOS1

gimjieun-ui-MacBook-Pro:~ gimjieun$ cd Swift_iOS1

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git init

Initialized empty Git repository in /Users/gimjieun/Swift_iOS1/.git/

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git add myfile.txt

fatal: pathspec 'myfile.txt' did not match any files

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git branch gitstudy

fatal: Not a valid object name: 'master'.

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git status

On branch master



No commits yet



Untracked files:

  (use "git add <file>..." to include in what will be committed)



​	gitstudy.md



nothing added to commit but untracked files present (use "git add" to track)

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git branch gitStudy

fatal: Not a valid object name: 'master'.

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git branch start

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git checkout gitStudy

error: pathspec 'gitStudy' did not match any file(s) known to git.

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git add gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git commit -m "fist commit"

[master (root-commit) 14f0aba] fist commit

 1 file changed, 122 insertions(+)

 create mode 100644 gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git branch start1

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git branch

\* master

  start1

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git checkout start1

Switched to branch 'start1'

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git add gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ git commit -m "add 설명을 추가"

On branch start1

nothing to commit, working tree clean

gimjieun-ui-MacBook-Pro:Swift_iOS1 gimjieun$ cd ..

gimjieun-ui-MacBook-Pro:~ gimjieun$ cd

gimjieun-ui-MacBook-Pro:~ gimjieun$ cd

gimjieun-ui-MacBook-Pro:~ gimjieun$ ls

Applications			Music

Desktop				Pictures

Documents			Public

Downloads			PycharmProjects

Git				Swift_iOS1

Library				Untitled Folder

Movies				inflearn_ios_basic_yagom

gimjieun-ui-MacBook-Pro:~ gimjieun$ cd

gimjieun-ui-MacBook-Pro:~ gimjieun$ mkdir Swift_iOS

gimjieun-ui-MacBook-Pro:~ gimjieun$ cd Swift_iOS

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git clone https://github.com/zieunv/Swift_iOS.git

Cloning into 'Swift_iOS'...

remote: Enumerating objects: 3, done.

remote: Counting objects: 100% (3/3), done.

remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0

Unpacking objects: 100% (3/3), done.

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ vi aa.txt

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git status

fatal: not a git repository (or any of the parent directories): .git

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git init 

Initialized empty Git repository in /Users/gimjieun/Swift_iOS/.git/

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git status

On branch master



No commits yet



Untracked files:

  (use "git add <file>..." to include in what will be committed)



​	Swift_iOS/

​	aa.txt



nothing added to commit but untracked files present (use "git add" to track)

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

Swift_iOS	aa.txt

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ cd Swift_iOS

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md	gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git add gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git commit -m "github 공부자료"

[master 59df336] github 공부자료

 1 file changed, 122 insertions(+)

 create mode 100644 gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git status

On branch master

Your branch is ahead of 'origin/master' by 1 commit.

  (use "git push" to publish your local commits)



nothing to commit, working tree clean

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git push origin master

Counting objects: 3, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (3/3), done.

Writing objects: 100% (3/3), 1.65 KiB | 1.65 MiB/s, done.

Total 3 (delta 0), reused 0 (delta 0)

To https://github.com/zieunv/Swift_iOS.git

   8a02526..59df336  master -> master

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git status

On branch master

Your branch is up to date with 'origin/master'.



nothing to commit, working tree clean

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git branch study0

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git status

On branch master

Your branch is up to date with 'origin/master'.



nothing to commit, working tree clean

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git checkout study0

Switched to branch 'study0'

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ vi example.txt

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ add example.txt

-bash: add: command not found

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git add example.txt

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git commit -m "새로운 브랜치 확인"

[study0 1bc4f90] 새로운 브랜치 확인

 1 file changed, 1 insertion(+)

 create mode 100644 example.txt

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git push origin study0

Counting objects: 3, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (2/2), done.

Writing objects: 100% (3/3), 356 bytes | 356.00 KiB/s, done.

Total 3 (delta 0), reused 0 (delta 0)

remote: 

remote: Create a pull request for 'study0' on GitHub by visiting:

remote:      https://github.com/zieunv/Swift_iOS/pull/new/study0

remote: 

To https://github.com/zieunv/Swift_iOS.git

 \* [new branch]      study0 -> study0

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md	example.txt	gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md	example.txt	gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git push origin study0

Everything up-to-date

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md	example.txt	gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ vi gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git add gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git commit -m "rebase까지 정리"

[study0 63300fb] rebase까지 정리

 1 file changed, 26 insertions(+), 67 deletions(-)

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git push origin study0

Counting objects: 3, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (3/3), done.

Writing objects: 100% (3/3), 1.39 KiB | 1.39 MiB/s, done.

Total 3 (delta 2), reused 0 (delta 0)

remote: Resolving deltas: 100% (2/2), completed with 2 local objects.

To https://github.com/zieunv/Swift_iOS.git

   1bc4f90..63300fb  study0 -> study0

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git add git study.md

fatal: pathspec 'git' did not match any files

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ ls

README.md	example.txt	gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git add gitstudy.md

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git commit -m "정리 완료"

[study0 46303c2] 정리 완료

 1 file changed, 13 insertions(+), 27 deletions(-)

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ git push origin study0

Counting objects: 3, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (3/3), done.

Writing objects: 100% (3/3), 755 bytes | 755.00 KiB/s, done.

Total 3 (delta 2), reused 0 (delta 0)

remote: Resolving deltas: 100% (2/2), completed with 2 local objects.

To https://github.com/zieunv/Swift_iOS.git

   63300fb..46303c2  study0 -> study0

gimjieun-ui-MacBook-Pro:Swift_iOS gimjieun$ 