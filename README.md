<!-- omit in toc -->
# Lab 0

In this lab, you'll set up the COMP 211 Linux (Ubuntu) environment on your computer, learn how to use the command-line interface (CLI) and Vim, and code a simple "Hello world" program in C.

<details open>
    <summary>Contents</summary>

- [Background reading](#background-reading)
- [Setup](#setup)
    - [Install Docker and COMP 211 container](#install-docker-and-comp-211-container)
    - [Start container](#start-container)
- [Learn the CLI](#learn-the-cli)
    - [Mounted directory /mnt/learncli](#mounted-directory-mntlearncli)
    - [Learn Vim](#learn-vim)
        - [Demos](#demos)
        - [Tutorial](#tutorial)
        - [Relative line numbering](#relative-line-numbering)
        - [Customization](#customization)
        - [File tree and EasyMotion](#file-tree-and-easymotion)
- [Final setup](#final-setup)
    - [SSH authentication](#ssh-authentication)
        - [Generate SSH keys](#generate-ssh-keys)
        - [Add SSH public key to GitHub](#add-ssh-public-key-to-github)
        - [Verify that SSH authentication works](#verify-that-ssh-authentication-works)
    - [Git configure name and email](#git-configure-name-and-email)
- [Hello world](#hello-world)
    - [hello.c requirements](#helloc-requirements)
    - [Compile and execute](#compile-and-execute)
    - [Format your code](#format-your-code)
- [Submit your assignment](#submit-your-assignment)

</details>

## Background reading

1. Required: *Learn a Command-line Interface* by Kris Jordan
    - Read **after** [Setup](#setup).
    - [The Sorcerer's Shell](https://uncch.instructure.com/users/9947/files/4534606?verifier=OtzqqS8AJ9vtBgYkQDnjzhdQCkb6fk4YT47bMMXA&wrap=1)
    - [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1)
    - In particular, in this lab, we will use content from the following sections: 1.1-1.2, 1.5, 1.11, 2.1-2.7, 2.9-2.13.
        - All sections are useful, and some will be required knowledge for future labs, but the given sections are necessary to complete this lab.
        - In addition to reading, you should also practice running the commands in your new Linux environment! The shell will be your playground for the entire semester, so gain familiarity with it.
2. Optional but highly recommended: [Vim lesson](https://missing.csail.mit.edu/2020/editors/) from MIT's [The Missing Semester of Your CS Education](https://missing.csail.mit.edu/) (notes and videos).
    - Read/watch the Vim lesson **after** [Learn Vim](#learn-vim).
    - In addition to the Vim lesson, the entire resource is highly recommended because its content will be useful for the entire semester and beyond, in future classes and your career.
        - In general, lessons 1-6 (excluding 4, which is Data Wrangling) of The Missing Semester are highly relevant for COMP 211.
        - The COMP 211 labs cover important parts of some of the same topics, such as the shell, CLI, Vim, git, and gdb, but you are encouraged to learn more in-depth via this resource. Consider referring to it throughout the semester. <!-- TODO: delete resources under 3? -->
3. Optional resources from Kris Jordan
    - [vim Tutorial - A beginner's guide to vim, a powerful text editor with a grammar.](https://www.youtube.com/playlist?list=PLKUb7MEve0Tj3MLYDIyYpIZtnJehmlR0s)
    - [What is a version control system? What is git?](https://www.youtube.com/watch?v=h2xylPqXO8M&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=4)
    - [git Fundamentals - add, commit, branch, checkout, merge](https://www.youtube.com/watch?v=R8E29zB8tMc&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=5)

## Setup

### Install Docker and COMP 211 container

To complete the labs for this course, you need to use a Linux environment. If you haven't already, carefully follow the instructions on the Linux Programming Environment page ([section 1](https://uncch.instructure.com/courses/65069/pages/linux-programming-environment), [section 2](https://uncch.instructure.com/courses/65074/pages/linux-programming-environment)) to install Docker and the COMP 211 Docker container on your computer.

To summarize Docker's functionality and why we're using it, a common problem with code is that code can work on one computer but not another. Docker solves this problem by "shipping your computer." More accurately, you will pull the COMP 211 Docker image, which contains instructions for building our container, and this container will be built within your host OS (likely Windows or macOS).

The container contains all the tools you'll need this semester and works exactly the same on everyone's computer (regardless of OS type, files, or settings on your host OS) because everyone will use the same image.

### Start container

After completing the setup instructions, note that there are a few steps that must be done each time you want to start the container.

In the above page, search (Ctrl + F or Cmd + F) for the text "start the container".

## Learn the CLI

In [Background reading](#background-reading), read at least the given sections of *Learn a Command-line Interface* by Kris Jordan.

### Mounted directory /mnt/learncli

To reiterate an important part of [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) (2.6) that we'll use soon, the container's filesystem is isolated from that of your host OS. Thus, any changes to files you make in the container's filesystem will be reverted when you restart the container. Although this may sound annoying, one benefit of containers is that if you break something in the environment, you can simply restart the container to start fresh.

However, `/mnt/learncli` is different. This directory belongs to your host computer and is "**m**ou**nt**ed into" the container when you start the container. Thus, you need to use this directory to share files between your host OS and the container.

So, when you're coding in the container, all code files need to be in `/mnt/learncli`, or they'll be deleted. The good news is that when you start the container, your working directory will always initially be `/mnt/learncli/workdir`, and you should put your code files there.

If you want to prove to yourself that `/mnt/learncli` in the container and `learncli211` in your host OS are the same, you can run `ls -a /mnt/learncli` in the container to list **a**ll files (including hidden ones) in `/mnt/learncli`.

Then exit the container by pressing Ctrl + D, and you'll be in your host OS's `learncli211` directory. Run `ls -a` (macOS) or `ls -Force` (Windows PowerShell, not Command Prompt), and you'll see that the files in the two directories are the same (because they're the same directory).

### Learn Vim

Vim is a customizable, modal text editor that is included in most Linux systems. It is designed to make editing text very efficient. Vim has an exceptionally high skill ceiling (infinitely higher than normal editing controls) but a high skill floor (you will need to take some time to get used to it).

For example, here are two Vim demos that show useful capabilities you cannot get out of normal text editing controls. The captions explain what is happening in the demos. Notice how the text is navigated/edited using only a few keystrokes compared to normal editing controls.

#### Demos

<p align="center">
    <img src="https://i.imgur.com/sDvPDR3.gif">
</p>

<p align="center"><em>Instantly jump cursor to any 2-letter sequence (here, <code><strong>su</strong>m</code>, either occurrence), then jump to starting line</em></p>

<p align="center">
    <img src="https://i.imgur.com/91nOisx.gif">
</p>

<p align="center"><em>Remove 2 parameters from <code>sum</code> by deleting until <code>)</code> (displayed as Shift + 0) and clear inside <code>main</code>'s <code>{ }</code></em></p>

There are many more features we could show, but we hope these two demos have piqued your interest.

#### Tutorial

If the container is not already running, [start the container](#start-container), and run the command `vimtutor`. This will use Vim to open a tutorial document that explains how to use it. It is normal for it to be black-and-white and not have line numbers, unlike the demos above.

For Vim, we recommend having your right hand in home row position (index finger on `J`, middle finger on `K`, ring finger on `L`, and pinky on `;`), the same position that is used for touch-typing.

Most likely, you will not remember everything from the tutorial. For now, we recommend you learn enough to be comfortable enough to complete this lab assignment. Later, you can learn as you go by reviewing `vimtutor` or searching for guides. For example, we strongly recommend the Vim lesson given in [Background reading](#background-reading). In general, whenever something seems inefficient or you think "there must be a better way", there probably is, and you should try Googling it.

As you begin to learn Vim, you will edit slower than normal, of course. It will probably take a month or two of regular usage (i.e., using Vim for the labs in this course should suffice) for your Vim editing speed to match your normal editing speed. This may seem like a while, but after that point, you will only improve, and you will eventually be able to edit at the speed at which you think.

Beyond improving editing speed, you will need to use Vim in later courses and in your career when you run into situations in which an IDE is not available but Vim is, such as in this Docker container or in the domain of systems development. There are plenty of other such situations.

#### Relative line numbering

In the above [demos](#demos), you may have noticed a weird line numbering system. This is called relative line numbering, which is the default setting in the container because, as you saw in `vimtutor` (2.5), many operators accept a count, such as `2dd` (delete two lines). Although omitted in the tutorial, another useful application is something like `4j` to move the cursor down 4 lines (i.e., you can instantly jump the cursor to any line on the screen). In these examples, 2 and 4 are relative to the current line.

There are many common operators for which the number is relative to the current line, and relative line numbering is useful for these operators.

For example, consider that with absolute line numbers (only), if the current line is 897 and you want to move down to line 912, you would type `{912-897}j` = `15j`. With relative line numbers, you would see line 912 labeled as 15, so you would simply type `15j`. For visual examples, see the demos (where `4j` is typed).

Note that the absolute line number of the current line is still shown, and you can still jump to any absolute line using `{line}G` [^relative].

[^relative]: `{line}G` can be used to jump with absolute line numbering, but this uses more keystrokes. Also, when jumping, you usually want to jump to a line close to the current line.

We encourage you to stick with this setting for a bit, but if you dislike it, you can turn it off.

#### Customization

As mentioned, Vim is highly customizable. Specifically, Vim looks for settings in `~/.vimrc` (`~` is your home directory). You can edit this file by running `vim ~/.vimrc`.

The file contains the line `set relativenumber`, which enables relative line numbering. To turn it off, simply comment that line out.

However, recall from [earlier](#mounted-directory-mntlearncli) that in the container, changes to `~/.vimrc` will be reverted when you restart the container. See the comments at the top of `~/.vimrc` for how to make changes permanent.

#### File tree and EasyMotion

The bottom of `~/.vimrc` explains how to open a file tree (via the plugin [NERDTree](https://github.com/preservim/nerdtree)), open tabs/windows, and how to use [EasyMotion](https://github.com/easymotion/vim-easymotion) (first [Vim demo](#demos)).

<p align="center">
    <img src="https://i.imgur.com/KohWEi3.png">
</p>

<p align="center"><em>NERDTree and window splits</em></p>

## Final setup

This section is separate from [Setup](#setup) above because if you do any of the steps below improperly, you now have enough knowledge of CLI and Vim to detect and fix any issues.

### SSH authentication

Reading/writing to GitHub requires authentication, which needs to be set up in the container. Previously, you may have cloned URL's that begin with `https`, which requires a username/password, personal access token (PAT), or your web browser. This is insecure and inconvenient (i.e., will probably cause problems later).

Instead, we will use SSH authentication, a standard procedure that needs to be done only once. After this one-time procedure, every time you clone with `git clone <SSH_url.git>`, it will simply work, and you will not be prompted for a username/password or PAT.

#### Generate SSH keys

1. If the container is not already running, [start the container](#start-container). These steps should be done **in the container**.
2. Run `cd /mnt/learncli`.
3. Run `ssh-keygen`. Then **type** `.ssh/id_rsa` **as the location to save the key**. Then press enter twice for no passphrase.

```text
learncli$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): .ssh/id_rsa
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in .ssh/id_rsa
Your public key has been saved in .ssh/id_rsa.pub
The key fingerprint is:
SHA256:O6RZZK526gtjhEEwc+wVuBUAhbFdXKGSlZyc2NWhl08 root@8de59c21d591
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

4. Run `source ~/.bashrc`. You should now see the UNC CS logo again and something like `Identity added: /root/.ssh/id_rsa (root@8de59c21d591)`.
    - This output indicates that the new SSH keys were successfully copied to `~/.ssh`.
    - If you do not see that output, you did something incorrectly. Redo steps 1-3.
5. Print your SSH public key by running `cat ~/.ssh/id_rsa.pub`. Copy the outputted text, which begins with `ssh-rsa` and ends with something like `root@8de59c21d591`.
    - To copy text in Windows Terminal or macOS Terminal, highlight the text and press Ctrl+C or Cmd+C, respectively.

#### Add SSH public key to GitHub

1. In your web browser, navigate to [GitHub](https://github.com).
    - If you are somehow not signed in, sign in.
2. Click your profile picture in the top right corner.
3. Click Settings > SSH and GPG keys > New SSH Key.
4. In the "Key" section, paste what you copied [earlier](#generate-ssh-keys) (the SSH public key, which begins with `ssh-rsa` and ends with something like `root@8de59c21d591`).
5. In the "Title" section, write any title, and click "Add SSH Key".

#### Verify that SSH authentication works

1. **In the container**, run `cd /mnt/learncli/workdir`.
2. Clone your Lab 0 GitHub repository.
    1. Go to [https://github.com/orgs/Comp211-FA24/repositories](https://github.com/orgs/Comp211-FA24/repositories).
    2. Click your Lab 0 repository.
    3. Click the green <span style="color:#1cb139">Code</span> button.
    4. Select "SSH" (**not** HTTPS).
    5. Copy the URL, which should look like `git@github.com:Comp211-FA24/lab-00-your_GH_username.git`.
        - Prefix is **not** `https`.
    6. In the container, run `git clone <url>`, where `<url>` is the URL you just copied.
    7. If you are prompted with "Are you sure you want to continue connecting (yes/no/[fingerprint])?", type `yes` and press Enter.

If you get an error that looks like the following, then the [SSH authentication](#ssh-authentication) steps were not done correctly. Redo them.

```text
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

Otherwise, it was successful, and you can confirm by running `ls`. The output should include `lab-00-your_GH_username`.

### Git configure name and email

Git has certain configuration values it relies on, e.g. your name and email, which are transcribed in git commit logs. If these are not set up, you will get an error message when you commit:

```text
Author identity unknown

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'root@07a5f55598d3.(none)')
```

Normally, we would follow the suggestion to `git config --global user.email "you@example.com"`, but this change would be cleared when you restart the container. Instead, edit the environment variables created when the container starts as follows:

1. **In the container**, run `vim /mnt/learncli/.bash_profile`.
2. Change the following lines from

```text
#export GIT_AUTHOR_NAME=""
#export GIT_COMMITTER_NAME=""
#export GIT_AUTHOR_EMAIL=""
#export GIT_COMMITTER_EMAIL=""
```

to

```text
export GIT_AUTHOR_NAME="Ram Zees"
export GIT_COMMITTER_NAME="Ram Zees"
export GIT_AUTHOR_EMAIL="ramzs@live.unc.edu"
export GIT_COMMITTER_EMAIL="ramzs@live.unc.edu"
```

but with your own name and email, of course.

3. Save the file.
4. [Restart the container](#start-container).

## Hello world

The following steps involve [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) 2.1-2.5 and 2.7. If you have trouble with any of the following instructions (though they should be straightforward), refer to those sections.

First, we will set up our directory structure. The goal is the following:

```text
learncli$ pwd
/mnt/learncli/workdir
learncli$ tree .
.
`-- lab-00-your_GH_username
    `-- hello_world
        `-- hello.c

2 directories, 1 file
```

To do so,

1. Assuming your working directory is `/mnt/learncli/workdir`, `cd` into `lab-00-your_GH_username`.
2. Use `mkdir` to make a directory named `hello_world`.
3. `cd` into `hello_world`.
4. To verify that 1-3 were done correctly, you can use `pwd` to verify that your working directory is indeed `/mnt/learncli/workdir/lab-00-your_GH_username/hello_world`.
    - You can also view the structure of the entire repository with the `tree` command shown above, e.g., `tree ../..`
5. To create and edit the `hello.c` file at the path shown above, run `vim hello.c`.
    - If the file does not already exist, Vim will create it; otherwise, Vim will edit it.

### hello.c requirements

A simple "Hello world" C program is given on [*The C Programming Language*](https://uncch.instructure.com/users/9947/files/4526296?verifier=bzWbUsKclOVAAJ7MfuwOyS5v8DDILep0R7HtGh7t&wrap=1) pg. 9. We'll slightly extend it.

Your implementation should print `Hello, world.` on one line and `Welcome to C!` on another line. There should be a trailing newline at the end of the latter line as well. This is case, punctuation, and whitespace-sensitive.

The program should work like so:

```text
learncli$ ./a.out
Hello, world.
Welcome to C!
learncli$
```

The `main` function declaration must have a return type of `int`, a signed integer value. The function must return `EXIT_SUCCESS`. To return `EXIT_SUCCESS`, you need to import `stdlib.h`, the header file which defines this constant.

### Compile and execute

Compile and execute your program with the following commands:

```sh
gcc hello.c
./a.out
```

[`gcc`](https://gcc.gnu.org/) is the GNU Compiler Collection. Here, we use it to compile the C program into an executable file that is named `a.out` by default. Then, we use `./a.out` to run the executable.

More details about `gcc` and the syntax for running executables will be discussed in future labs.

Verify that your program compiles without errors and that its output matches the expected output above before moving on.

### Format your code

Nothing is more contentious in programming than coding style. As you become a more senior programmer, others will expect you to follow good coding style. Your code should be neatly formatted (i.e., easy to read) and well-documented so that others can maintain code you wrote.

Fortunately, there are tools you can use to automatically format your code. One popular tool is [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html), which we'll use and is installed in the container.

We will use our custom `clang-format-all` command that formats all C files in a directory.

Running this command with `-h` or `--help` prints its expected syntax: `clang-format-all [-h] DIR...`. This command's expected argument(s) is a directory or directories, not individual file(s).

For example, assuming your working directory is still `hello_world`, `clang-format-all .` would format all C files in `.` (current directory), which is just `hello.c`. `clang-format-all ..` would format all C files in your repository. Of course, absolute paths can also be used.

As mentioned in [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) (2.9), if there is no output, then the command was successful.

If this is not done (for this and future lab assignments), there will be a small deduction in points. The points are essentially free, so this is just to remind you that code style is important. We emphasize that formatting is a relatively small (and the most easily fixable) facet of code style but important nonetheless. You may read COMP 530's [Lab Style Guide](https://www.cs.unc.edu/~porter/courses/comp530/f24/style.html) for more facets of code style and examples of C code with good and bad style.

## Submit your assignment

Assignment submissions will be made through [Gradescope](https://www.gradescope.com).

You should already be enrolled in the COMP 211 course on Gradescope. If you are not, self-enroll with the entry code given on the Canvas home page. If you're unable to self-enroll, contact your cohort leader(s), and we'll manually add you.

To submit your assignment, you must commit your work using git, then push to GitHub.

1. `cd` to the base of your repository, which is `lab-00-your_GH_username`.
2. (Optional) Run `git status` to confirm that our next commit will have the files we expect.
    - `git status` displays the state of the working directory and the staging area.
    - Some useful information here: files that have been staged (with `git add`) and are ready to be committed, untracked files, and files that have been modified but not staged.
3. Run `git add -A`.
    - `git add` adds modified files to the staging area.
    - `-A` makes it add all files in the git repository, regardless of your working directory.
4. Run `git commit -m "Your Message Here"`.
    - This creates a new commit based on the files in the staging area and associates the commit with a message.
    - Instead of Your Message Here, you should write a meaningful but concise message about what changes you have made. A good general rule is to use the body to explain **what** and **why**, not **how**.
        - Other developers (and you, once enough time has passed) can read the code changes to figure out "how". Additionally, for expressing code logic, English is often imprecise (i.e., can contradict the actual code logic).
        - Whoever is reading the commit message is probably much more interested in what was changed and why rather than how it was done (implementation details).
    - If this command fails with the error message `Author identity unknown... fatal: unable to auto-detect email address... `, do [Git configure name and email](#git-configure-name-and-email), and remember to restart the container.
5. Run `git push`.
    - This uploads commits made locally on your machine to the remote repository (on GitHub).
    - After this is run, when you view this repository on GitHub, you should be able to see the changes you've made.
6. Go to the COMP 211 course in Gradescope, and click on the assignment named **Lab 0**.
7. Click on the option to **Submit Assignment**, and choose GitHub as the submission method.
    - You may be prompted to sign in to your GitHub account to grant access to Gradescope. If this occurs, grant access to the Comp211-FA24 organization.
8. You should see a list of your public repositories. Select the one named **lab-00-your_GH_username**, and submit it.
9. Your assignment should be autograded within a few seconds, and you will receive feedback.
10. If you receive all the points, then you have completed this lab! Otherwise, you are free to resubmit for regrading until the lab deadline.
