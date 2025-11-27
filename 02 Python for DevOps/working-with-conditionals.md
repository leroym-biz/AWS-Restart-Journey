# 🐍 Working with Conditionals in Python

> **Mastering decision-making logic—the foundation of intelligent automation and dynamic program flow.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Lab Environment Setup](#lab-environment-setup)
- [Core Conditional Concepts](#core-conditional-concepts)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab covered Python's conditional statements—the building blocks that let programs make decisions and take different paths based on user input or system state.

The real point here wasn't just writing if/else statements—it was understanding how to build intelligent, responsive programs:  
✅ **if statements** for single-condition decision making  
✅ **else statements** for handling alternative paths  
✅ **elif statements** for multiple conditional branches  
✅ **Real-world application** building an interactive package shipping service

**Tech Stack:** Python 3, AWS Cloud9 IDE, Bash

---

## Lab Environment Setup

### Accessing AWS Cloud9 IDE

**Starting the environment:**
1. Navigate to AWS Management Console
2. Choose **Services** → **Cloud9**
3. Locate **reStart-python-cloud9** card
4. Click **Open IDE**

<p align="center">
  <img src="assets/screenshots/working with conditionals/cloud9_open.png" alt="AWS Cloud9 IDE Environment" width="80%"/>
</p>

*AWS Cloud9 IDE ready for Python development*

### Creating the Python File

**File setup:**
```bash
# In Cloud9 IDE
File → New From Template → Python File

# Save as: conditionals.py
# Location: /home/ec2-user/environment
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/conditionals.py file created.png" alt="Conditionals Python File Created" width="80%"/>
</p>

*Python exercise file created in Cloud9 workspace*

### Terminal Session

**Verify working directory:**
```bash
pwd
# Output: /home/ec2-user/environment
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/open_terminal.png" alt="Terminal Session" width="80%"/>
</p>

*Terminal session confirming working directory*

---

## Core Conditional Concepts

### 1️⃣ The if Statement: Single-Condition Logic

The `if` statement is your basic decision-making tool. It executes code only when a condition is true.

**Building the foundation:**
```python
userReply = input("Do you need to ship a package? (Enter yes or no) ")

if userReply == "yes":
    print("We can help you ship that package!")
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/running_if_statement.png" alt="Running if Statement" width="80%"/>
</p>

*Testing the if statement with user input*

**Key principle:** The `==` operator compares two values. The indented code block only runs when the condition evaluates to `True`.

**What happens here:**
- User enters "yes" → Message prints
- User enters anything else → Program exits silently

This is functional, but not great UX. Let's fix that.

---

### 2️⃣ The else Statement: Handling Alternatives

The `else` statement provides a fallback path when the `if` condition isn't met.

**Improving user experience:**
```python
userReply = input("Do you need to ship a package? (Enter yes or no) ")

if userReply == "yes":
    print("We can help you ship that package!")
else:
    print("Please come back when you need to ship a package. Thank you.")
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/running_else_statement.png" alt="Running else Statement" width="80%"/>
</p>

*Testing the else statement—now we handle both paths*

**Why this matters:** Every user interaction should get a response. The `else` statement ensures no input falls through the cracks.

---

### 3️⃣ The elif Statement: Multiple Conditions

When you have more than two possible paths, use `elif` (short for "else-if") to chain multiple conditions.

**Building a complete service menu:**
```python
userReply = input("Would you like to buy stamps, buy an envelope, or make a copy? (Enter stamps, envelope, or copy) ")

if userReply == "stamps":
    print("We have many stamp designs to choose from.")
elif userReply == "envelope":
    print("We have many envelope sizes to choose from.")
elif userReply == "copy":
    copies = input("How many copies would you like? (Enter a number) ")
    print("Here are {} copies.".format(copies))
else:
    print("Thank you, please come again.")
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/running_elif_statement.png" alt="Running elif Statement" width="80%"/>
</p>

*Testing the elif statement chain with multiple options*

**How it works:**
1. Python checks the `if` condition first
2. If false, it moves to the first `elif`
3. If still false, it continues to the next `elif`
4. If all conditions are false, the `else` block runs
5. **Critical:** Only ONE block ever executes—Python stops checking after finding the first true condition

---

### Running the Complete Script

**Execution:**
```bash
# In Cloud9 terminal
python3 conditionals.py
```

<p align="center">
  <img src="assets/screenshots/working with conditionals/python_version.png" alt="Python Version Check" width="80%"/>
</p>

*Verifying Python version before running the script*

<p align="center">
  <img src="assets/screenshots/working with conditionals/selecting_python.png" alt="Selecting Python Interpreter" width="80%"/>
</p>

*Cloud9 Python interpreter selection*

### Testing All Paths

**Test Case 1: Stamps option**
```bash
Would you like to buy stamps, buy an envelope, or make a copy? stamps
# Output: We have many stamp designs to choose from.
```

**Test Case 2: Envelope option**
```bash
Would you like to buy stamps, buy an envelope, or make a copy? envelope
# Output: We have many envelope sizes to choose from.
```

**Test Case 3: Copy option (with nested input)**
```bash
Would you like to buy stamps, buy an envelope, or make a copy? copy
How many copies would you like? 2
# Output: Here are 2 copies.
```

**Test Case 4: Invalid input (else clause)**
```bash
Would you like to buy stamps, buy an envelope, or make a copy? no
# Output: Thank you, please come again.
```

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Conditional Logic**
- Understanding comparison operators (`==`, `!=`, `>`, `<`, etc.)
- Building single-path decisions with `if` statements
- Creating alternative paths with `else` statements
- Chaining multiple conditions with `elif` statements

🛠️ **Python Fundamentals**
- Working with user input via `input()` function
- String comparison and matching
- Code block indentation (Python's way of defining scope)
- String formatting with `.format()` method

🛠️ **Program Flow Control**
- Understanding execution order in conditional chains
- Knowing when to use `if`, `elif`, and `else`
- Building responsive, user-driven applications
- Handling edge cases and invalid input

🛠️ **AWS Cloud9 Development**
- Creating and testing Python scripts in a cloud IDE
- Using integrated terminals for script execution
- Iterative development and testing workflows

### The Real Takeaway

Honestly, conditionals seem basic at first—just if/else logic. But once you start building interactive programs, you realize they're everywhere:

- 🎯 **User authentication** — If credentials match, grant access; else deny
- 🎯 **API error handling** — If status code is 200, process data; elif 404, log error; else retry
- 🎯 **AWS automation** — If instance state is "running", continue; elif "stopped", start it; else alert
- 🎯 **Data validation** — If input is valid, proceed; else prompt again

The key insight: **conditionals turn static scripts into intelligent, adaptive programs**.

**Real-world examples:**
- **Infrastructure monitoring:** `if cpu_usage > 80: send_alert()`
- **Deployment automation:** `if environment == "production": use_strict_checks()`
- **User input validation:** `if age >= 18: grant_access() else: deny_access()`

This lab proved that mastering conditionals is essential for writing any real automation—whether you're validating data, handling errors, or building interactive tools.

**The power of elif:** One of the biggest "aha" moments was understanding that `elif` chains stop at the first true condition. This makes them perfect for priority-based decision making—check the most important conditions first.

---

## 📊 Project Status

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

<h4 align="center">🐍 Built with Python • AWS Cloud9 • Conditional Logic • Real-World Scenarios 🚀</h4>