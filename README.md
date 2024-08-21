<!-- omit in toc -->
# Lab 0

<details open>
    <summary>Contents</summary>

- [Setup](#setup)
    - [Set up Docker container](#set-up-docker-container)
        - [Enter container](#enter-container)
    - [Learn the CLI](#learn-the-cli)
    - [Learn vim](#learn-vim)
        - [Vim demos](#vim-demos)
        - [Vim tutorial](#vim-tutorial)
    - [Mounted directory /mnt/learncli](#mounted-directory-mntlearncli)
    - [Set up SSH authentication](#set-up-ssh-authentication)
        - [Generate SSH keys](#generate-ssh-keys)
        - [Add SSH public key to GitHub](#add-ssh-public-key-to-github)
        - [Verify that SSH authentication works](#verify-that-ssh-authentication-works)
- [Hello World](#hello-world)
    - [`hello.c` requirements](#helloc-requirements)
    - [Compiling and executing](#compiling-and-executing)
- [Submit your assignment](#submit-your-assignment)
- [Check your understanding](#check-your-understanding)

</details>

## Setup

### Set up Docker container

To complete the labs for this course, you need to use a Linux environment. If you haven't already, carefully follow the instructions on the [Linux Programming Environment](https://uncch.instructure.com/courses/48862/pages/linux-programming-environment) page on Canvas to install Docker and the COMP 211 Docker container on your computer.

To summarize Docker's functionality and why we're using it, a common problem for programmers is that code can work on one computer but not another. Docker avoids this by "shipping your computer."

The COMP 211 container contains all tools needed for the course and works the same on everyone's computer (regardless of OS, files, or settings on your host computer). There won't be any bugs like the above because Docker ensures that everyone uses the same "machine" (container).

#### Enter container

To reiterate part of the Canvas instructions, to enter the container, first ensure that Docker Desktop is running. You should see the blue Docker icon in your taskbar. Then open a terminal, run `cd learncli211`, and run `./learncli.ps1` (Windows) or `./learncli.sh` (macOS).

You are in the container (Linux) if your command-line prompt is `learncli$ `. Otherwise, you are in your host OS (likely Windows or macOS).

Exit the container by running the command `exit` or by pressing `Ctrl+D`.

### Learn the CLI

Read Chapters 1 and 2 of *Learn a Command-line Interface* by Kris Jordan: [The Sorcerer's Shell](https://uncch.instructure.com/users/9947/files/4534606?verifier=OtzqqS8AJ9vtBgYkQDnjzhdQCkb6fk4YT47bMMXA&wrap=1) and [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1). In particular, in this lab, we will use content from the following sections: 1.1, 1.11, 2.1-2.7, 2.10, 2.12-2.13. This is not to say that the other sections are unimportant (they will be used in future labs), but the given sections are the bare minimum necessary to complete this lab.

These readings will teach you everything you need to know about running commands and navigating directories in your Linux environment. Please practice running the commands in your new Linux environment! The shell will be your playground for the semester, so gain familiarity with it.

### Learn vim

Vim is a customizable text-editor program that is included in most Linux systems. It is designed to make editing text text very efficient, though it may not seem so at first. In part, this is because nearly all vim controls use the keyboard, and you do not have to use your mouse at all. Vim has a very high skill ceiling (much higher than normal editing controls) but a high skill floor (you will need to take some time to get used to it).

For example, here are two vim demos showing useful capabilities that you cannot get out of normal text editing controls. You aren't expected to understand how to do the actions shown, but you should be able to see how the code is navigated/edited using only a few keystrokes compared to normal editing controls.

#### Vim demos

![](https://i.imgur.com/sDvPDR3.gif)

<p align="center"><em>Instantly jump cursor to any 2-letter sequence (here, <code><strong>su</strong>m</code>), then jump to starting line</em></p>

![](https://i.imgur.com/91nOisx.gif)

<p align="center"><em>Remove 2 parameters from <code>sum</code>, clear everything inside <code>main</code>'s <code>{ }</code>, and modify function bodies</code></em></p>

#### Vim tutorial

[Enter your Linux container](#enter-container), and run the command `vimtutor`. This will use vim to open a tutorial document that explains how to use it.

For vim, we recommend having your right hand in home row position (index finger on `J`, middle finger on `K`, ring finger on `L`, and pinky on `;`), the same position that is used for touch-typing.

Most likely, you will not remember everything from the tutorial. We recommend you just learn enough to be comfortable enough to complete Part 1 of the assignment in vim, then later you can go back to `vimtutor` or look at/search for guides to learn more as you go. For example, we strongly recommend this [vim lesson](https://missing.csail.mit.edu/2020/editors/) from MIT's [The Missing Semester](https://missing.csail.mit.edu/) course.

As you begin to learn vim, you will edit slower than normal, of course. It should take a few weeks to a month for your vim editing speed to catch up to your normal editing speed. After that point, you will only improve, and you will eventually be able to edit at the speed at which you think.

Beyond improving editing speed, you will need to use vim in later courses and in your career (especially in the domain of systems development) because you will run into situations in which an IDE is not available but vim is (such as in this Docker container).

<!-- TODO: maybe edit vimrc, document vimrc with instructions -->

The vim in your Docker image has been customized for the C programming language and may look different from vim on your home computer. Specifically, to view the customizations, run `vim ~/.vimrc` in your container. The commands in this file are automatically run every time the container is started. The `rc` at the end of the file name stands for "run commands". Another example of such a file is `~/.bashrc`, which contains, on lines 101-112, the `echo` commands that display the "UNC CS" ASCII art on startup.

### Mounted directory /mnt/learncli

As mentioned in the reading (2.6), the container's filesystem is isolated from that of your host OS. Thus, any changes to files you make in the container's filesystem will be reverted when you exit and re-enter the container.

However, the `/mnt/learncli` directory is different. This directory belongs to your host computer and is "**m**ou**nt**ed into" the container when you enter the container. Thus, you need to use this directory to share files between your host OS and the container. So when you're coding in the container, all code files need to be in `/mnt/learncli/workdir`.

You can prove this to yourself by running `ls -a /mnt/learncli` in the container to list **a**ll files (including hidden ones) in `/mnt/learncli`.

Then exit the container, and you'll be in your host OS's `learncli211` directory. Run `ls -a`, and you'll see that the files in the two directories are the same (because they're the same directory).

### Set up SSH authentication

Reading/writing to GitHub requires authentication, which needs to be set up in the container. Previously, you may have cloned URL's that begin with `https`, which requires a username/password, personal access token, or your web browser. This is insecure and inconvenient. We will use SSH authentication, a standard procedure that needs to be done only once.

There is a [YouTube video](https://www.youtube.com/watch?v=1fR0BHzzgOI) created by a former 211 LA that walks through the steps below.

#### Generate SSH keys

1. In your **host OS** (Windows/macOS, **not** Linux container), open a terminal.
    - If you are unsure whether or not you are in the container, review [this](#enter-container).
2. `cd` to your `learncli211` directory that you cloned earlier.
3. Run `ssh-keygen`. Then type `.ssh/id_rsa` as the location to save the key. Then press enter twice for no passphrase.

```text
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/root/.ssh/id_rsa): .ssh/id_rsa
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in .ssh/id_rsa.
Your public key has been saved in .ssh/id_rsa.pub.
The key fingerprint is:
SHA256:4yheFb7P2rzq/fJ71+AKPssyEQq7+bI0YcnK8+rzfr8 ceclia@topkek
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|                 |
|        .        |
|   ... ...       |
|    =o .S.       |
| . o...+.o    .  |
|  + +oo o..  . ..|
|  .=++. oOo.  o o|
| .o=*=.oE*@B=+ . |
+----[SHA256]-----+
```

<!-- todo confirm -->
3. Inside your `learncli211` directory, confirm that the directory `.ssh` exists. Recall from the reading (2.10) that files beginning with `.` (such as `.ssh`) are hidden. On Windows, run `dir /a` to list all files, including hidden ones. On macOS, run `ls -a`.
<!-- todo confirm -->
4. To print your SSH public key's contents, run `cat .ssh/id_rsa.pub`. Copy the text. To do so, in the macOS terminal, highlight the text and press CMD+C. In Windows Terminal, highlight the text and press Ctrl+C.
    - Your SSH private key is in `.ssh/id_rsa`. You may share your public key with anyone, but **never share your private key**.

#### Add SSH public key to GitHub

1. In your web browser, navigate to [GitHub](https://github.com).
2. Click your profile picture in the top right corner.
3. Click Settings > SSH and GPG keys > New SSH Key.
4. In the "Key" section, paste the public key that you copied earlier.
5. In the "Title" section, write any title, and click "Add SSH Key".

#### Verify that SSH authentication works

1. Enter your container.
    - If you forgot how to do so, review [this](#enter-container).
2. 

## Hello World

After SSH authentication is set up, return to the container environment by using `./learncli.ps1` on Windows or `./learncli.sh` on Mac. Then, clone this Git repository within your container with the command `git clone <repository>`. In place of where `<repository>` is, you should enter the SSH-based URL of your repository; e.g. `git clone git@github.com:Comp211-SP24/lab-00-username.git`. You can get this URL by going to the GitHub page and clicking Code -> SSH.

In your repository, use `mkdir` to make a new directory named `0-hello-world`. Use `cd` to change your working directory to be this subdirectory. For reference on how to carry out either of these tasks, please refer to Chapter 2: [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1).

Next, you’ll want to edit a new file named `hello.c`. To begin editing this file in vim, simply run the command:

```sh
vim hello.c
```

Each source file in COMP 211 will begin with the standard header comment below. The format of this header is checked by the autograder for an exact match. To avoid having the autograder fail, please ensure you:

- format your PID as a single 9-digit number with no spaces nor dashes, and
- your capitalization and punctuation of the honor code pledge are correct.

```c
// PID: 9DigitPidNoSpacesOrDashes
// I pledge the COMP 211 honor code.
```

Now refer to section 1.1 of *C Programming Language* to complete the rest of the assignment.

### `hello.c` requirements

The purpose of `hello.c` is to slightly extend the book's (*C Programming Language*) implementation of the same program on Page 9. Your implementation should print `Hello, world.` on one line and `Welcome to C!` on another line. This is case and punctuation-sensitive. It should then return `EXIT_SUCCESS`. To return `EXIT_SUCCESS`, you will need to import `stdlib.h`, the header file which defines this constant. When `main` returns `EXIT_SUCCESS`, it indicates the program completed successfully via a success exit status. We will explore the idea of exit statuses later this semester. Additionally, we expect all function return types to be defined, and `main` should return an `int`, a signed integer value.

### Compiling and executing

Compile and execute your program with the following shell commands:

```sh
gcc -Wall hello.c
./a.out
```

The `-Wall` flag tells `gcc` to print out all warnings.

Once your program compiles without warnings and meets the requirements, you should submit your assignment.

## Submit your assignment

Assignment submissions will be made through [Gradescope](https://www.gradescope.com).

You should already be enrolled in the COMP 211 course on Gradescope. If you are not, please self-enroll with entry code listed on the Canvas home page. If you're unable to self-enroll, please contact your cohort leader and we'll manually add you.

To submit your assignment, you must commit and push your work to this repository using git.

1. Navigate to the base folder of the repository within your container. Enter the command `ls` to confirm that it contains the directory named `0-hello-world`, and ensure that your `hello.c` file is in the `0-hello-world` directory.
2. Type `git status`. You should see a list of changes that have been made to the repository.
3. Type `git add -A`. This signals that you want to place all modified/new files on the "stage" so that their changes can take effect.
4. Type `git commit -m "Your Message Here"`. This shows that you are "committing" the changes you put on the stage. Instead of Your Message Here, you should write a meaningful message about what changes you have made.
5. Type `git push`. This takes the commit that was made locally on your machine and "pushes" it to GitHub. Now, when you view this repository on GitHub, you should be able to see the changes you've made.
6. Go to the COMP 211 course in Gradescope, and click on the assignment called **Lab 0**.
7. Click on the option to **Submit Assignment**, and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to Gradescope. If this occurs, **make sure to grant access to the Comp211-SP24 organization**.
8. You should see a list of your public repositories. Select the one named **lab-00-yourname** and submit it.
9. Your assignment should be autograded within a few seconds and you will receive feedback.
10. If you receive all the points, then you have completed this preliminary lab! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.

## Check your understanding

The purpose of this lab is to make sure you have some basic familiarity with the tools of this course: your Ubuntu environment, vim, and git. You will earn full credit for this lab simply by submitting the short `hello.c` program, but it would be a good idea for you to spend some extra time learning the shell commands, vim keystrokes and understanding git. If you would like to learn more beyond what was included in the lab writeup, here are some additional resources created by Kris Jordan:

* [vim Tutorial - A beginner's guide to vim, a powerful text editor with a grammar.](https://www.youtube.com/playlist?list=PLKUb7MEve0Tj3MLYDIyYpIZtnJehmlR0s)
* [What is a version control system? What is git?](https://www.youtube.com/watch?v=h2xylPqXO8M&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=4)
* [git Fundamentals - add, commit, branch, checkout, merge](https://www.youtube.com/watch?v=R8E29zB8tMc&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=5)
