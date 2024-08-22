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
- [Hello world](#hello-world)
    - [hello.c requirements](#helloc-requirements)
    - [Compile and execute](#compile-and-execute)
    - [Format your code](#format-your-code)
- [Submit your assignment](#submit-your-assignment)
- [Check your understanding](#check-your-understanding)

</details>

## Setup

### Set up Docker container

To complete the labs for this course, you need to use a Linux environment. If you haven't already, carefully follow the instructions on the [Linux Programming Environment](https://uncch.instructure.com/courses/48862/pages/linux-programming-environment) page on Canvas to install Docker and the COMP 211 Docker container on your computer.

To summarize Docker's functionality and why we're using it, a common problem for programmers is that code can work on one computer but not another. Docker avoids this by "shipping your computer."

The COMP 211 container contains all tools needed for the course and works the same on everyone's computer (regardless of OS, files, or settings on your host OS). There won't be any bugs like the above because Docker ensures that everyone uses the same "machine" (container).

#### Enter container

To reiterate part of the Canvas instructions, to enter the container, first ensure that Docker Desktop is running, and start it if not. You should see the blue Docker icon in your taskbar (Windows and macOS). If not, check Task Manager/Activity Monitor.

Then open a terminal, run `cd learncli211`, and run `./learncli.ps1` (Windows) or `./learncli.sh` (macOS).

You are in the container (Linux) if your command-line prompt is `learncli$ `. Otherwise, you are in your host OS (likely Windows or macOS).

Exit the container by running the command `exit` or by pressing `Ctrl+D`.

### Learn the CLI

Read Chapters 1 and 2 of *Learn a Command-line Interface* by Kris Jordan: [The Sorcerer's Shell](https://uncch.instructure.com/users/9947/files/4534606?verifier=OtzqqS8AJ9vtBgYkQDnjzhdQCkb6fk4YT47bMMXA&wrap=1) and [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1). In particular, in this lab, we will use content from the following sections: 1.1-1.2, 1.5, 1.11, 2.1-2.7, 2.9-2.13. This is not to say that the other sections are unimportant (all sections are useful, and some will be required knowledge for future labs), but the given sections are necessary to complete this lab.

These readings will teach you everything you need to know about running commands and navigating directories in your Linux environment. Please practice running the commands in your new Linux environment! The shell will be your playground for the semester, so gain familiarity with it.

### Learn vim

Vim is a customizable text-editor program that is included in most Linux systems. It is designed to make editing text text very efficient, though it may not seem so at first. In part, this is because nearly all vim controls use the keyboard, and you do not have to use your mouse at all. Vim has a very high skill ceiling (much higher than normal editing controls) but a high skill floor (you will need to take some time to get used to it).

For example, here are two vim demos showing useful capabilities that you cannot get out of normal text editing controls. You aren't expected to understand how to do the actions shown, but you should be able to see how the code is navigated/edited using only a few keystrokes compared to normal editing controls.

#### Vim demos

<p align="center">
    <img src="https://i.imgur.com/sDvPDR3.gif">
</p>

<p align="center"><em>Instantly jump cursor to any 2-letter sequence (here, <code><strong>su</strong>m</code>), then jump to starting line</em></p>

<p align="center">
    <img src="https://i.imgur.com/91nOisx.gif">
</p>

<p align="center"><em>Remove 2 parameters from <code>sum</code>, clear everything inside <code>main</code>'s <code>{ }</code>, and modify function bodies</code></em></p>

#### Vim tutorial

Enter your Linux container (review [this](#enter-container) if you forgot how to do so or are unsure whether you are in it), and run the command `vimtutor`. This will use vim to open a tutorial document that explains how to use it.

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

When you enter the container, your current working directory (cwd) will always initially be `/mnt/learncli/workdir`. Recall from the reading (2.3) that you can print your cwd with `pwd`.

### Set up SSH authentication

Reading/writing to GitHub requires authentication, which needs to be set up in the container. Previously, you may have cloned URL's that begin with `https`, which requires a username/password, personal access token, or your web browser. This is insecure and inconvenient. We will use SSH authentication, a standard procedure that needs to be done only once. After this one-time procedure, every time you clone, you will only need to run `git clone <url>` and will not be prompted for a username/password or PAT.

#### Generate SSH keys

1. [Enter your container](#enter-container).
2. Run `cd /mnt/learncli`.
3. Run `ssh-keygen`. Then type `.ssh/id_rsa` as the location to save the key. Then press enter twice for no passphrase.

```text
learncli$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): .ssh/id_rsa
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in .ssh/id_rsa
Your public key has been saved in .ssh/id_rsa.pub
The key fingerprint is:
SHA256:O6RZZK526gtjhEEwc+wVuBUAhbFdXKGSlZyc2NWhl08 root@712d7c13a534
The key's randomart image is:
+---[RSA 3072]----+
|*B=O=O+o..       |
|.B++@. ...       |
|..=+. . = E      |
|  o+   = o       |
|  . .   S .      |
|   .   * .       |
|    + = +        |
|   . + o .       |
|     .+.         |
+----[SHA256]-----+
```

4. Verify that the SSH keys were generated and named correctly by running `ls .ssh`. The output should include `id_rsa id_rsa.pub`.
5. Print your SSH public key by running `cat .ssh/id_rsa.pub`. Copy the outputted text. To do so in Windows Terminal or the macOS terminal, highlight the text and press Ctrl+C or Cmd+C, respectively.
    - Your SSH private key is in `.ssh/id_rsa`. You may share your public key with anyone, but **never** share your private key. Doing so will allow anyone to impersonate you (i.e., read/write/delete your private repositories, commit under your name, etc.).

#### Add SSH public key to GitHub

1. In your web browser, navigate to [GitHub](https://github.com).
2. Click your profile picture in the top right corner.
3. Click Settings > SSH and GPG keys > New SSH Key.
4. In the "Key" section, paste the public key that you copied earlier.
5. In the "Title" section, write any title, and click "Add SSH Key".

#### Verify that SSH authentication works

1. [Enter your container](#enter-container), if you are not already in it.
2. Clone this [GitHub repository]() (`lab-00-your_GH_username`).
    1. Go to [this repository].
    2. Click the green <span style="color:#1cb139">Code</span> button.
    3. Select "SSH" (**not** HTTPS).
    4. Copy the URL.
    5. In the container, run `git clone <url>`, where `<url>` is the URL you just copied that begins with `git@github.com`.
    6. If you are prompted with "Are you sure you want to continue connecting (yes/no/[fingerprint])?", type `yes` and press Enter.

If you get an error that looks like the following, then the [Set up SSH authentication](#set-up-ssh-authentication) steps were not done correctly.

```text
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Otherwise, if no errors, then it was successful, and you can confirm by running `ls`. The output should include `lab-00-your_GH_username`.

## Hello world

The following steps involve sections 2.1-2.5 and 2.7 of the reading. If you have trouble with any of the following instructions (though they should be straightforward), refer to those sections.

1. `cd` into `lab-00-your_GH_username`.
2. In your repository, use `mkdir` to create a directory named `hello_world`.
3. Use `cd` to change your working directory to be this new subdirectory. You can confirm with `pwd`.

In `hello_world`, we need to create a `hello.c` program that prints some text.

To create and edit this file in vim, run the command `vim hello.c`. If the file does not already exist, vim will create it; otherwise, vim will edit it.

### hello.c requirements

A simple "Hello world" C program is given on page 9 of [*The C Programming Language*](https://uncch.instructure.com/users/9947/files/4526296?verifier=bzWbUsKclOVAAJ7MfuwOyS5v8DDILep0R7HtGh7t&wrap=1). We will slightly extend it.

Your implementation should print `Hello, world.` on one line and `Welcome to C!` on another line. There should be a trailing newline at the end of the latter line as well. This is case, punctuation, and whitespace-sensitive.

The program should work like so:

```text
learncli$ ./a.out
Hello, world.
Welcome to C!
learncli$
```

The `main` function must be defined with a return type of `int`, a signed integer value. Specifically, it should return `EXIT_SUCCESS`. To return `EXIT_SUCCESS`, you will need to import `stdlib.h`, the header file which defines this constant.

### Compile and execute

Compile and execute your program with the following commands:

```sh
gcc hello.c
./a.out
```

[`gcc`](https://gcc.gnu.org/) is the GNU Compiler Collection. Here, we are using it to compile the C program into an executable file that is named `a.out` by default.

Then, we use `./a.out` to run the executable.

More details about `gcc` and the syntax for running executables will be discussed in future labs.

Confirm that your program compiles without errors and that its output matches the expected output above before moving on.

### Format your code

Nothing is more contentious in programming than coding style. As you become a more senior programmer, others will expect you to follow good coding style. Your code should be neatly formatted (i.e., easy to read) and well-documented so that others can maintain code you wrote.

Fortunately, there are tools you can use to automatically format your code. One popular tool is [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html), which we'll use and is installed in the container.

We will use our custom `clang-format-all` command that formats all C files in a directory.

## Submit your assignment

Assignment submissions will be made through [Gradescope](https://www.gradescope.com).

You should already be enrolled in the COMP 211 course on Gradescope. If you are not, please self-enroll with the entry code given on the Canvas home page. If you're unable to self-enroll, please contact your cohort leader(s), and we'll manually add you.

To submit your assignment, you must commit your work using git, then push to GitHub.

Before we do so, 

1. `cd` to the base of the repository, which is `lab-00-your_GH_username`. To confirm, you can run `pwd`, which should output `/mnt/learncli/workdir/lab-00-your_GH_username`.
2. Type `git add -A`. This signals that you want to place all modified/new files on the "stage" so that their changes can take effect.
3. Type `git commit -m "Your Message Here"`. This shows that you are "committing" the changes you put on the stage. Instead of Your Message Here, you should write a meaningful message about what changes you have made.
4. Type `git push`. This takes the commit that was made locally on your machine and "pushes" it to GitHub. Now, when you view this repository on GitHub, you should be able to see the changes you've made.
5. Go to the COMP 211 course in Gradescope, and click on the assignment called **Lab 0**.
6. Click on the option to **Submit Assignment**, and choose GitHub as the submission method. You may be prompted to sign in to your GitHub account to grant access to Gradescope. If this occurs, **make sure to grant access to the Comp211-SP24 organization**.
7. You should see a list of your public repositories. Select the one named **lab-00-yourname** and submit it.
8. Your assignment should be autograded within a few seconds and you will receive feedback.
9. If you receive all the points, then you have completed this preliminary lab! Otherwise, you are free to keep pushing commits to your GitHub repository and submit for regrading up until the deadline of the lab.

## Check your understanding

The purpose of this lab is to make sure you have some basic familiarity with the tools of this course: your Ubuntu environment, vim, and git. You will earn full credit for this lab simply by submitting the short `hello.c` program, but it would be a good idea for you to spend some extra time learning the shell commands, vim keystrokes and understanding git. If you would like to learn more beyond what was included in the lab writeup, here are some additional resources created by Kris Jordan:

* [vim Tutorial - A beginner's guide to vim, a powerful text editor with a grammar.](https://www.youtube.com/playlist?list=PLKUb7MEve0Tj3MLYDIyYpIZtnJehmlR0s)
* [What is a version control system? What is git?](https://www.youtube.com/watch?v=h2xylPqXO8M&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=4)
* [git Fundamentals - add, commit, branch, checkout, merge](https://www.youtube.com/watch?v=R8E29zB8tMc&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=5)
