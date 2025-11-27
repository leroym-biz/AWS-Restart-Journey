# 🐧 Linux Command Line Basics

> **Getting comfortable with the terminal—the foundation of everything you do in cloud and DevOps.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Lab Environment](#lab-environment)
- [Core Commands & Operations](#core-commands--operations)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab is all about getting comfortable in a Linux environment without a GUI. No mouse, no desktop—just the terminal.

The reality is, when you're managing cloud infrastructure, you're almost always SSH'd into a remote server. This is where the real work happens.

I focused on:  
✅ **Navigating the file system** efficiently  
✅ **Managing files and directories** safely  
✅ **Understanding Linux permissions** (critical for security)  
✅ **Searching through files and logs** to find what you need fast  
✅ **Using bash history** to speed up repetitive tasks

**Tech Stack:** Amazon Linux 2023, AWS EC2, Bash

---

## Lab Environment

### Connection Method

**Using EC2 Instance Connect** (browser-based SSH):
1. Navigate to the EC2 Console
2. Select the running instance
3. Click **Connect** → **EC2 Instance Connect**
4. Terminal session opens directly in the browser

No key pairs needed for this lab, but in production, you'd use SSH keys for secure access.

**Verify the connection:**
```bash
whoami
# Output: ec2-user

pwd
# Output: /home/ec2-user
```

### Terminal Access Confirmed

Once connected, you'll see the Amazon Linux welcome screen confirming your session:

<p align="center">
  <img src="assets/screenshots/amazon-linux-terminal.png" alt="Amazon Linux 2023 Terminal Session" width="80%"/>
</p>

*Amazon Linux 2023 terminal showing successful EC2 Instance Connect session*

---

## Core Commands & Operations

### 1️⃣ File System Navigation

Linux organizes everything as files and directories. Getting comfortable moving around is essential.

| Command | What It Does | Example |
|---------|--------------|---------|
| `pwd` | Show current directory | `pwd` → `/home/ec2-user` |
| `ls` | List files | `ls -l` (detailed), `ls -a` (include hidden) |
| `cd` | Change directory | `cd /var/log`, `cd ~` (home), `cd ..` (up one level) |

#### Important Directories

| Directory | What Lives Here |
|-----------|-----------------|
| `/home/ec2-user` | Your user's home directory |
| `/var/log` | System and application logs |
| `/etc` | Configuration files |
| `/tmp` | Temporary files |
| `/usr/bin` | Most user commands and executables |

**Pro tip:** Use `Tab` for autocomplete. Type `cd /var/l` then hit Tab—it'll finish the path for you.

---

### 2️⃣ File and Directory Management

Creating, moving, copying, and deleting files. Basic but critical.

```bash
# Create a new directory
mkdir my-project

# Create nested directories
mkdir -p projects/web-app/src

# Create an empty file
touch README.md

# Create a file with content
echo "Hello from Linux" > hello.txt

# View file content
cat hello.txt

# Copy a file
cp hello.txt backup.txt

# Move or rename a file
mv hello.txt greeting.txt

# Delete a file
rm greeting.txt

# Delete a directory and all contents (use carefully!)
rm -r projects
```

**Important:** There's no "recycle bin" in Linux. When you delete something, it's gone.

---

### 3️⃣ Users and Permissions

This is where security starts to matter.

#### Understanding File Permissions

When you run `ls -l`, you see something like:
```
-rw-r--r-- 1 ec2-user ec2-user 1024 Nov 10 14:32 example.txt
```

| Part | Meaning |
|------|---------|
| `-` | File type (- = file, d = directory) |
| `rw-` | Owner permissions (read, write) |
| `r--` | Group permissions (read only) |
| `r--` | Others permissions (read only) |
| `ec2-user` | File owner |
| `ec2-user` | Group owner |

#### Permission Commands

```bash
# Make a file readable and writable by owner only
chmod 600 secret.txt

# Make a script executable
chmod +x deploy.sh

# Common permission patterns
chmod 644 file.txt  # Owner: rw, Group: r, Others: r
chmod 755 script.sh # Owner: rwx, Group: rx, Others: rx
```

**Permission Values:**
- **r** = Read (4)
- **w** = Write (2)
- **x** = Execute (1)

**Why this matters:** Misconfigured permissions are a common security vulnerability. You need to know who can access what.

---

### 4️⃣ Searching and Productivity

When you're troubleshooting or looking for specific config, you need to search efficiently.

#### Command History

```bash
# Show command history
history

# Search your command history
history | grep ssh

# Re-run the last command
!!

# Search history interactively (press Ctrl+R, then start typing)
```

**Pro tip:** `Ctrl+R` is your best friend. Start typing any part of a previous command and it'll find it instantly.

#### Searching with Grep

```bash
# Search for a word in a file
grep "error" /var/log/messages

# Case-insensitive search
grep -i "warning" /var/log/messages

# Search recursively through directories
grep -r "TODO" ~/projects/

# Show line numbers in results
grep -n "function" script.sh

# Search for lines that DON'T contain a pattern
grep -v "debug" app.log
```

**Real-world use case:** Finding errors in massive log files. Instead of scrolling through thousands of lines, `grep` finds exactly what you need in seconds.

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Command Line Proficiency**
- Navigating Linux file systems without hesitation
- Understanding the directory structure and where things live
- Using shortcuts and autocomplete for efficiency

🛠️ **File Management**
- Creating, copying, moving, and deleting files safely
- Understanding when to use different commands
- Avoiding common mistakes that could break things

🛠️ **Security Fundamentals**
- Reading and setting file permissions correctly
- Understanding user, group, and other access levels
- Knowing why proper permissions matter for cloud security

🛠️ **Productivity Tools**
- Using command history to speed up repetitive tasks
- Searching through files and logs efficiently with grep
- Building muscle memory for the most common operations

### The Real Takeaway

Honestly, the command line felt intimidating at first. But once you get comfortable with it, you realize it's way faster than clicking through GUIs.

This is the foundation for everything else in cloud:

- 🎯 SSH-ing into EC2 instances for server management
- 🎯 Managing Docker containers
- 🎯 Deploying applications via command line
- 🎯 Troubleshooting production issues by reading logs
- 🎯 Writing scripts to automate repetitive tasks
- 🎯 Modifying configuration files in production environments

You can't avoid the terminal in this field, so might as well get good at it.

---

## 📝 Project Status

This is part of my **AWS Restart Journey**, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.

I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.

---

## 🤝 Let's Connect

If you're looking for someone who's serious about learning AWS the right way—hands-on, documented, and grounded in real-world architecture—let's talk.

<p align="center">
  <a href="mailto:leroym.biz@gmail.com">
    <img src="https://img.shields.io/badge/Email-leroym.biz@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email" />
  </a>
  <a href="https://api.whatsapp.com/send/?phone=27605665116&text=Hi%20Leroy,%20saw%20your%20GitHub!" target="_blank">
    <img src="https://img.shields.io/badge/WhatsApp-%2B27%2060%20566%205116-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="WhatsApp" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/leroym-biz/AWS-restart-journey" target="_blank">
    <img src="https://img.shields.io/badge/View%20Repository-black?style=for-the-badge&logo=github" />
  </a>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active%20Learning-success?style=flat-square" />
  <img src="https://img.shields.io/badge/Commitment-Hands%20On%20Every%20Week-brightgreen?style=flat-square" />
</p>

<h4 align="center">🐧 Built with Linux • Bash • AWS EC2 • Hands-On Practice 🐧</h4>