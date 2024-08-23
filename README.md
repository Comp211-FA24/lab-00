<!-- omit in toc -->
# Lab 0

In this lab, you'll set up the COMP 211 Linux (Ubuntu) environment on your computer, learn how to use the command-line interface (CLI) and vim, and code a simple "Hello world" program in C.

<details open>
    <summary>Contents</summary>

- [Background reading](#background-reading)
- [Setup](#setup)
    - [Install Docker container](#install-docker-container)
    - [Enter container](#enter-container)
- [Learn the CLI](#learn-the-cli)
    - [Mounted directory /mnt/learncli](#mounted-directory-mntlearncli)
    - [Learn vim](#learn-vim)
        - [Vim demos](#vim-demos)
        - [Vim tutorial](#vim-tutorial)
        - [Relative line numbering](#relative-line-numbering)
        - [Vim customization](#vim-customization)
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
2. Optional but highly recommended: [The Missing Semester of Your CS Education](https://missing.csail.mit.edu/). In particular, their [vim lesson](https://missing.csail.mit.edu/2020/editors/).
    - Read the vim lesson after or during [Learn vim](#learn-vim).
    - Lessons 1-6 (excluding 4, which is Data Wrangling) are highly relevant for COMP 211.
        - Some content from lesson 1 will be used in the next lab.
    - These lessons are highly recommended because they will be useful for the entire semester and beyond, in future classes and your career.
    - The COMP 211 labs (especially this one) will cover some of the same topics, such as the shell, CLI, vim, git, and gdb, but you are encouraged to learn more via this resource. Consider referring to it throughout the semester. <!-- TODO: delete resources under 3? -->
3. Optional resources from Kris Jordan
    - [vim Tutorial - A beginner's guide to vim, a powerful text editor with a grammar.](https://www.youtube.com/playlist?list=PLKUb7MEve0Tj3MLYDIyYpIZtnJehmlR0s)
    - [What is a version control system? What is git?](https://www.youtube.com/watch?v=h2xylPqXO8M&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=4)
    - [git Fundamentals - add, commit, branch, checkout, merge](https://www.youtube.com/watch?v=R8E29zB8tMc&list=PLKUb7MEve0TjHQSKUWChAWyJPCpYMRovO&index=5)

## Setup

### Install Docker container

To complete the labs for this course, you need to use a Linux environment. If you haven't already, carefully follow the instructions on the [Linux Programming Environment](https://uncch.instructure.com/courses/48862/pages/linux-programming-environment) page to install Docker and the COMP 211 Docker container on your computer.

To summarize Docker's functionality and why we're using it, a common problem for programmers is that code can work on one computer but not another. Docker solves this problem by "shipping your computer." More accurately, you will pull the COMP 211 Docker image that contains instructions for building our container, and this container will be built within your host OS.

The container contains all the tools you'll need and works the same on everyone's computer (regardless of OS type, files, or settings on your host OS) because everyone will use the same image.

### Enter container

After completing the setup instructions, these are the steps that need to be done each time you want to enter the container.

1. Start Docker Desktop if it's not already running. You should see the blue Docker icon in your taskbar (Windows and macOS). If not, check Task Manager/Activity Monitor.
2. Open a terminal.
3. Run `cd learncli211`.
    - If you cloned the repo to a different path, `cd` into wherever your `learncli211` repo is located. If you don't know what this means (yet), ignore this.
4. Run `./learncli.ps1` (Windows) or `./learncli.sh` (macOS).
5. Verify that you are in the container (Linux) by checking that your command-line prompt is `learncli$ `. Otherwise, you are in your host OS (likely Windows or macOS).

Exit the container by running `exit` or by pressing `Ctrl+D`.

## Learn the CLI

In [Background reading](#background-reading), read *Learn a Command-line Interface* by Kris Jordan.

### Mounted directory /mnt/learncli

As mentioned in [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) (2.6), the container's filesystem is isolated from that of your host OS. Thus, any changes to files you make in the container's filesystem will be reverted when you exit and re-enter the container.

However, `/mnt/learncli` is different. This directory belongs to your host computer and is "**m**ou**nt**ed into" the container when you enter the container. Thus, you need to use this directory to share files between your host OS and the container. So when you're coding in the container, all code files need to be in `/mnt/learncli/workdir`.

You can prove this to yourself by running `ls -a /mnt/learncli` in the container to list **a**ll files (including hidden ones) in `/mnt/learncli`.

Then exit the container, and you'll be in your host OS's `learncli211` directory. Run `ls -a`, and you'll see that the files in the two directories are the same (because they're the same directory). Additionally, in this shared directory, you can add a new file in the container and see it in your host OS and vice versa.

### Learn vim

Vim is a customizable, modal text editor that is included in most Linux systems. It is designed to make editing text very efficient. Vim has a very high skill ceiling (much higher than normal editing controls) but a high skill floor (you will need to take some time to get used to it).

For example, here are two vim demos that show useful capabilities you cannot get out of normal text editing controls. Notice how the text is navigated/edited using only a few keystrokes compared to normal editing controls.

#### Vim demos

<p align="center">
    <img src="https://i.imgur.com/sDvPDR3.gif">
</p>

<p align="center"><em>Instantly jump cursor to any 2-letter sequence (here, <code><strong>su</strong>m</code>, either occurrence), then jump to starting line</em></p>

<p align="center">
    <img src="https://i.imgur.com/91nOisx.gif">
</p>

<p align="center"><em>Remove 2 parameters from <code>sum</code> by deleting until <code>)</code> and clear inside <code>main</code>'s <code>{ }</code></em></p>

#### Vim tutorial

[Enter your Linux container](#enter-container), and run the command `vimtutor`. This will use vim to open a tutorial document that explains how to use it. It will be black-and-white and not have line numbers - this is normal.

For vim, we recommend having your right hand in home row position (index finger on `J`, middle finger on `K`, ring finger on `L`, and pinky on `;`), the same position that is used for touch-typing.

Most likely, you will not remember everything from the tutorial. For now, we recommend you just learn enough to be comfortable enough to complete this lab assignment. Later, you can learn as you go by reviewing `vimtutor` or searching for guides. We strongly recommend the vim lesson given in [Background reading](#background-reading). In general, whenever something seems inefficient or you think "there must be a better way", there probably is, and you should try Googling it.

As you begin to learn vim, you will edit slower than normal, of course. It should take a few weeks to a month for your vim editing speed to catch up to your normal editing speed. This may seem like a while, but after that point, you will only improve, and you will eventually be able to edit at the speed at which you think.

Beyond improving editing speed, you will need to use vim in later courses and in your career (especially when in the domain of systems development) when you run into situations in which an IDE is not available but vim is, such as in this Docker container.

#### Relative line numbering

In the above [demos](#vim-demos), you may have noticed a weird line numbering system. This is called relative line numbering, which is the default setting in the container because, as you saw in `vimtutor` (2.5), many operators accept a count, such as `2dd` to delete two lines. Although omitted in the tutorial, another useful application is something like `4j` to move down 4 lines (i.e., you can instantly move to anywhere on the screen). For these operators, the numbers are relative to the current line and are not absolute line numbers. So, relative line numbering is useful for these operations (see the demos).

For example, consider that with absolute line numbers (only), if the current line is 897 and you wish to move down to line 912, you would have to compute `{912-897}j` = `15j`. With relative line numbers, you would simply see line 912 labeled as 15.

We encourage you to stick with this setting for a bit. Note that the absolute line number of the current line is still shown. If you dislike this setting, you can turn it off.

#### Vim customization

As mentioned, vim is highly customizable. Specifically, vim looks for settings in `~/.vimrc`. That file contains the line `set relativenumber`, which enables relative line numbering.

To turn it off, simply comment that line out. However, recall from [earlier](#mounted-directory-mntlearncli) that in the container, changes to `~/.vimrc` won't persist. So, you must instead edit `/mnt/learncli/.vimrc`. When the container is entered, it automatically copies that file to `~/.vimrc`.

#### File tree and EasyMotion

The bottom of `.vimrc` explains how to open a file tree (via the plugin [NERDTree](https://github.com/preservim/nerdtree)), open tabs/windows, and how to use [EasyMotion](https://github.com/easymotion/vim-easymotion) (first [vim demo](#vim-demos)).

<p align="center">
    <img src="https://i.imgur.com/KohWEi3.png">
</p>

<p align="center"><em>NERDTree and window splits</em></p>

## Final setup

This section is separate from [Setup](#setup) above because if you do any of the steps below improperly, you now have knowledge of CLI and vim to detect and fix any issues.

### SSH authentication

Reading/writing to GitHub requires authentication, which needs to be set up in the container. Previously, you may have cloned URL's that begin with `https`, which requires a username/password, personal access token (PAT), or your web browser. This is insecure and inconvenient (i.e., will probably cause problems later).

Instead, we will use SSH authentication, a standard procedure that needs to be done only once. After this one-time procedure, every time you clone with `git clone <SSH_url.git>`, it will simply work, and you will not be prompted for a username/password or PAT.

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
4. In the "Key" section, paste what you copied earlier in [step 5](#generate-ssh-keys) (the SSH public key).
5. In the "Title" section, write any title, and click "Add SSH Key".

#### Verify that SSH authentication works

1. [Enter your container](#enter-container), if you are not already in it.
2. Clone your Lab 0 GitHub repository.
    1. Go to [https://github.com/orgs/Comp211-FA24/repositories](https://github.com/orgs/Comp211-FA24/repositories).
    2. Click your Lab 0 repository.
        - You must be logged in to see it.
    3. Click the green <span style="color:#1cb139">Code</span> button.
    4. Select "SSH" (**not** HTTPS).
    5. Copy the URL, which should look like `git@github.com:Comp211-FA24/lab-00-your_GH_username.git`.
        - Prefix is not `https`.
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

Normally, we would follow the suggestion and run `git config --global user.email "you@example.com"`, but this change would be cleared once you start another Docker session. Instead, edit the environment variables created when the container starts as follows:

1. [Enter your container](#enter-container), if you are not already in it.
2. Run `vim /mnt/learncli/.bash_profile`.
3. Change the following lines from

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

4. Save the file.
5. Restart the container.

## Hello world

The following steps involve [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) 2.1-2.5 and 2.7. If you have trouble with any of the following instructions (though they should be straightforward), refer to those sections.

First, we will set up our directory structure. The goal is to make it look like this:

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

1. `cd` into `lab-00-your_GH_username`.
2. Use `mkdir` to create a directory named `hello_world`.
3. `cd` into `hello_world`.
4. To verify that 1-3 were done correctly, you can use `pwd` to verify that your working directory is indeed `/mnt/learncli/workdir/lab-00-your_GH_username/hello_world`.
    - You can also view the entire directory structure with the `tree` command shown above, e.g., `tree ../..` (relative path).
5. To create and edit the `hello.c` file at the path shown above, run `vim hello.c` (relative path).
    - If the file does not already exist, vim will create it; otherwise, vim will edit it.

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

The `main` function must be defined with a return type of `int`, a signed integer value. It should return `EXIT_SUCCESS`. To return `EXIT_SUCCESS`, you need to import `stdlib.h`, the header file which defines this constant.

### Compile and execute

Compile and execute your program with the following commands:

```sh
gcc hello.c
./a.out
```

[`gcc`](https://gcc.gnu.org/) is the GNU Compiler Collection. Here, we are using it to compile the C program into an executable file that is named `a.out` by default. Then, we use `./a.out` to run the executable.

More details about `gcc` and the syntax for running executables will be discussed in future labs.

Verify that your program compiles without errors and that its output matches the expected output above before moving on.

### Format your code

Nothing is more contentious in programming than coding style. As you become a more senior programmer, others will expect you to follow good coding style. Your code should be neatly formatted (i.e., easy to read) and well-documented so that others can maintain code you wrote.

Fortunately, there are tools you can use to automatically format your code. One popular tool is [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html), which we'll use and is installed in the container.

We will use our custom `clang-format-all` command that formats all C files in a directory.

Running this command with `-h` or `--help` prints the following syntax: `clang-format-all [-h] DIR...`. This command's expected argument(s) is a directory or directories, not individual file(s).

If your working directory is still `hello_world`, you can run `clang-format-all ..` to format all files in your repository. Alternatively, you can use the absolute path anywhere, regardless of your working directory, i.e. `clang-format-all /mnt/learncli/workdir/lab-00-your_GH_username`. As mentioned in [Directories, Files, and Paths](https://uncch.instructure.com/users/9947/files/4534607?verifier=Ay7tjnpmx7Cdhg7TzNXg7zfPD6wbBhBJOy8NqWXK&wrap=1) (2.9), if there is no output, then the command was successful.

If this is not done (for this and future lab assignments), there will be a small deduction in points. The points are essentially free, so this is just to remind you that code style is important. We emphasize that formatting is a relatively small (and the most easily fixable) facet of code style but important nonetheless. You may read COMP 530's [Lab Style Guide](https://www.cs.unc.edu/~porter/courses/comp530/f24/style.html) for more facets of code style and examples of C code with good and bad style.

## Submit your assignment

Assignment submissions will be made through [Gradescope](https://www.gradescope.com).

You should already be enrolled in the COMP 211 course on Gradescope. If you are not, self-enroll with the entry code given on the Canvas home page. If you're unable to self-enroll, contact your cohort leader(s), and we'll manually add you.

To submit your assignment, you must commit your work using git, then push to GitHub.

1. `cd` to the base of your repository, which is `lab-00-your_GH_username`.
2. (Optional) Run `git status` to display the state of the working directory and staging area.
    - Some useful information here: files that have been staged (with `git add`) and are ready to be committed, untracked files, and files that have been modified but not staged.
3. Run `git add -A`.
    - `git add` adds modified files to the staging area.
    - `-A` makes it add all files in the git repository, regardless of your working directory.
4. Run `git commit -m "Your Message Here"`.
    - This creates a new commit based on the files in the staging area and associates the commit with a message.
    - Instead of Your Message Here, you should write a meaningful but concise message about what changes you have made. Here are three good general rules:
        1. You can actually have a subject line and, optionally, a body. For example, see [here](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html). Separate the subject and body with a blank line.
        2. Limit the subject line to 50 characters.
        3. Use the body to explain **what** and **why**, not **how**.
            - Other developers (and you, once enough time has passed) can read the code changes to figure out "how". Additionally, for expressing code logic, English is often imprecise (i.e., can contradict the actual code logic).
            - Whoever is reading the commit message is probably much more interested in what was changed and why rather than how it was done (implementation details).
    - If this command fails with the error message `Author identity unknown... fatal: unable to auto-detect email address... `, redo [Git configure name and email](#git-configure-name-and-email).
5. Run `git push`.
    - This uploads commits made locally on your machine to the remote repository (on GitHub).
    - After this is run, when you view this repository on GitHub, you should be able to see the changes you've made.
6. Go to the COMP 211 course in Gradescope, and click on the assignment named **Lab 0**.
7. Click on the option to **Submit Assignment**, and choose GitHub as the submission method.
    - You may be prompted to sign in to your GitHub account to grant access to Gradescope. If this occurs, grant access to the Comp211-FA24 organization.
8. You should see a list of your public repositories. Select the one named **lab-00-your_GH_username**, and submit it.
9. Your assignment should be autograded within a few seconds, and you will receive feedback.
10. If you receive all the points, then you have completed this lab! Otherwise, you are free to resubmit for regrading until the lab deadline.
