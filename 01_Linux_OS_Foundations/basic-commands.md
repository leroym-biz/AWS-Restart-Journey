\# 🐧 Linux Command Line Basics



> \*\*Getting comfortable with the terminal—the foundation of everything you do in cloud and DevOps.\*\*



---



\## 📋 What's Inside



\- \[What I Learned Here](#what-i-learned-here)

\- \[Lab Overview](#lab-overview)

\- \[Core Tasks \& Commands](#core-tasks--commands)

\- \[Key Takeaways](#key-takeaways)

\- \[What This Means for Cloud Work](#what-this-means-for-cloud-work)



---



\## What I Learned Here



This lab wasn't about memorizing commands—it was about getting comfortable working in a Linux environment without a GUI. 



The reality is, when you're managing cloud infrastructure, you're almost always SSH'd into a remote server. No mouse. No desktop. Just you and the terminal.



I focused on:  

✅ \*\*Navigating the file system\*\* like it's second nature  

✅ \*\*Managing files and directories\*\* efficiently  

✅ \*\*Understanding Linux users and permissions\*\* (this stuff matters for security)  

✅ \*\*Searching through files\*\* to find what you need fast  

✅ \*\*Using bash history\*\* to speed up repetitive tasks



\*\*Environment:\*\* Amazon Linux EC2 instance via AWS Management Console



---



\## Lab Overview



\### Objectives



The goal was simple: learn the essential commands that every cloud engineer uses daily.



This includes understanding:

\- How to move around the file system without getting lost

\- How to create, modify, and delete files safely

\- How permissions work (and why they're critical)

\- How to search through content efficiently



---



\## Core Tasks \& Commands



\### Task 1: Connect to an Amazon Linux EC2 Instance



First step: get into the server.



\*\*Using EC2 Instance Connect\*\* (browser-based SSH):

1\. Navigate to the EC2 Console

2\. Select the running instance

3\. Click \*\*Connect\*\* → \*\*EC2 Instance Connect\*\*

4\. Opens a terminal session directly in the browser



No key pairs needed for this lab, but in production, you'd use SSH keys for secure access.



\*\*Verify the connection:\*\*

```bash

whoami

\# Output: ec2-user (the default user on Amazon Linux)



pwd

\# Output: /home/ec2-user (your home directory)

```



---



\### Task 2: Navigate the File System



Linux organizes everything as files and directories. Getting comfortable moving around is essential.



\#### Basic Navigation Commands



```bash

\# Show current directory

pwd



\# List files in current directory

ls



\# List files with details (permissions, owner, size, date)

ls -l



\# List all files including hidden ones

ls -a



\# Change directory

cd /var/log



\# Go back to home directory

cd ~



\# Go up one level

cd ..

```



\#### Important Directories to Know



| Directory | What Lives Here |

|-----------|-----------------|

| `/home/ec2-user` | Your user's home directory |

| `/var/log` | System and application logs |

| `/etc` | Configuration files |

| `/tmp` | Temporary files |

| `/usr/bin` | Most user commands and executables |



\*\*Pro tip:\*\* Use `Tab` for autocomplete. Type `cd /var/l` then hit Tab—it'll finish the path for you.



---



\### Task 3: Work with Files and Directories



Creating, moving, copying, and deleting files. Basic but critical.



\#### File Operations



```bash

\# Create a new directory

mkdir my-project



\# Create nested directories

mkdir -p projects/web-app/src



\# Create an empty file

touch README.md



\# Create a file with content

echo "Hello from Linux" > hello.txt



\# View file content

cat hello.txt



\# Copy a file

cp hello.txt backup.txt



\# Move or rename a file

mv hello.txt greeting.txt



\# Delete a file

rm greeting.txt



\# Delete a directory (must be empty)

rmdir my-project



\# Delete a directory and all contents (use carefully!)

rm -r projects

```



\*\*Important:\*\* There's no "recycle bin" in Linux. When you delete something, it's gone.



---



\### Task 4: Understand Linux Users and Permissions



This is where security starts to matter.



\#### Check User Information



```bash

\# Who am I?

whoami



\# Current user details

id



\# List logged-in users

who

```



\#### File Permissions Breakdown



When you run `ls -l`, you see something like:

```

-rw-r--r-- 1 ec2-user ec2-user 1024 Nov 10 14:32 example.txt

```



Let's break it down:



| Part | Meaning |

|------|---------|

| `-` | File type (- = file, d = directory) |

| `rw-` | Owner permissions (read, write) |

| `r--` | Group permissions (read only) |

| `r--` | Others permissions (read only) |

| `ec2-user` | File owner |

| `ec2-user` | Group owner |



\#### Permission Values



\- \*\*r\*\* = Read (4)

\- \*\*w\*\* = Write (2)

\- \*\*x\*\* = Execute (1)



```bash

\# Make a file readable and writable by owner only

chmod 600 secret.txt



\# Make a script executable

chmod +x deploy.sh



\# Common permission patterns

chmod 644 file.txt  # Owner: rw, Group: r, Others: r

chmod 755 script.sh # Owner: rwx, Group: rx, Others: rx

```



\*\*Why this matters:\*\* Misconfigured permissions are a common security vulnerability. You need to know who can access what.



---



\### Task 5: Search Through Files (History and Grep)



When you're troubleshooting or looking for specific config, you need to search efficiently.



\#### Using Command History



```bash

\# Show command history

history



\# Search your command history

history | grep ssh



\# Re-run the last command

!!



\# Re-run command #42 from history

!42



\# Search history interactively (most useful)

\# Press Ctrl+R, then start typing

```



\*\*Pro tip:\*\* `Ctrl+R` is your best friend. Start typing any part of a previous command and it'll find it instantly.



\#### Searching File Content with Grep



```bash

\# Search for a word in a file

grep "error" /var/log/messages



\# Case-insensitive search

grep -i "warning" /var/log/messages



\# Search recursively through directories

grep -r "TODO" ~/projects/



\# Show line numbers in results

grep -n "function" script.sh



\# Search for lines that DON'T contain a pattern

grep -v "debug" app.log

```



\*\*Real-world use case:\*\* Finding errors in massive log files. Instead of scrolling through thousands of lines, `grep` finds exactly what you need in seconds.



---



\## Key Takeaways



\### Technical Skills I Practiced



🛠️ \*\*Command Line Proficiency\*\*

\- Navigating Linux file systems without hesitation

\- Understanding the directory structure and where things live

\- Using shortcuts and autocomplete for efficiency



🛠️ \*\*File Management\*\*

\- Creating, copying, moving, and deleting files safely

\- Understanding when to use different commands

\- Avoiding common mistakes that could break things



🛠️ \*\*Security Fundamentals\*\*

\- Reading and setting file permissions correctly

\- Understanding user, group, and other access levels

\- Knowing why proper permissions matter for cloud security



🛠️ \*\*Productivity Tools\*\*

\- Using command history to speed up repetitive tasks

\- Searching through files and logs efficiently with grep

\- Building muscle memory for the most common operations



\### The Real Takeaway



Honestly, the command line felt intimidating at first. But once you get comfortable with it, you realize it's way faster than clicking through GUIs.



This is the foundation for everything else in cloud:

\- SSH-ing into EC2 instances

\- Managing Docker containers

\- Deploying applications

\- Troubleshooting production issues



You can't avoid the terminal in this field, so might as well get good at it.



---



\## What This Means for Cloud Work



\### Why These Skills Matter



\*\*When you're managing AWS infrastructure:\*\*

\- You'll SSH into EC2 instances regularly

\- You'll need to read log files to troubleshoot issues

\- You'll write scripts to automate deployments

\- You'll modify config files in `/etc`



\*\*When you're doing DevOps:\*\*

\- CI/CD pipelines run shell commands

\- Infrastructure as Code tools (Terraform, CloudFormation) generate files you need to inspect

\- Container images are built using shell scripts



\*\*When you're securing systems:\*\*

\- File permissions control who can access sensitive data

\- User management prevents unauthorized access

\- Log analysis helps detect security incidents



This lab wasn't flashy, but it's the foundation everything else is built on.



---



\## 📝 Project Status



This is part of my \*\*AWS Restart Journey\*\*, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.



I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.



---



\## 🤝 Let's Connect



Building cloud skills one command at a time. If you're looking for someone who's serious about learning the fundamentals the right way, let's talk.



<p align="center">

&nbsp; <a href="https://www.linkedin.com/in/leroym-biz" target="\_blank">

&nbsp;   <img src="https://img.shields.io/badge/Connect%20on%20LinkedIn-blue?style=for-the-badge\&logo=linkedin" />

&nbsp; </a>

&nbsp; <a href="mailto:leroym.biz@gmail.com">

&nbsp;   <img src="https://img.shields.io/badge/Email%20Me-grey?style=for-the-badge\&logo=gmail" />

&nbsp; </a>

&nbsp; <a href="https://github.com/leroym-biz/AWS-restart-journey" target="\_blank">

&nbsp;   <img src="https://img.shields.io/badge/View%20Repository-black?style=for-the-badge\&logo=github" />

&nbsp; </a>

</p>



---



<p align="center">

&nbsp; <img src="https://img.shields.io/badge/Status-Completed-success?style=flat-square" />

&nbsp; <img src="https://img.shields.io/badge/Focus-Linux%20Fundamentals-orange?style=flat-square" />

</p>



<h4 align="center">🐧 Built with Linux • Bash • AWS EC2 • Hands-On Practice 🐧</h4>

