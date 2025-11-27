# 🐍 Working with Lists, Tuples, and Dictionaries

> **Mastering Python data collections—the foundation of data manipulation and automation.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Lab Environment Setup](#lab-environment-setup)
- [Core Python Collections](#core-python-collections)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab covered Python's three fundamental collection types: lists, tuples, and dictionaries. These aren't just data structures—they're the building blocks of every Python automation script you'll ever write.

The real point here wasn't just syntax memorization—it was understanding when to use each collection type:  
✅ **Lists** for mutable, ordered data that changes  
✅ **Tuples** for immutable, ordered data that stays fixed  
✅ **Dictionaries** for key-value pairs with named access  
✅ **Practical applications** in real-world automation scenarios

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
  <img src="assets/screenshots/lists,tuples and dictionaries/01_cloud9_open.png" alt="AWS Cloud9 IDE Environment" width="80%"/>
</p>

*AWS Cloud9 IDE ready for Python development*

### Creating the Python File

**File setup:**
```bash
# In Cloud9 IDE
File → New From Template → Python File

# Save as: collections.py
# Location: /home/ec2-user/environment
```

<p align="center">
  <img src="assets/screenshots/02_collections_file_created.png" alt="Python File Created" width="80%"/>
</p>

*Python exercise file created in Cloud9 workspace*

### Terminal Session

**Verify working directory:**
```bash
pwd
# Output: /home/ec2-user/environment
```

<p align="center">
  <img src="assets/screenshots/03_open_terminal.png" alt="Terminal Session" width="80%"/>
</p>

*Terminal session confirming working directory*

---

## Core Python Collections

### 1️⃣ Lists: Mutable Ordered Collections

Lists are Python's most versatile collection type—they hold ordered items that can be changed.

**Defining a list:**
```python
myFruitList = ["apple", "banana", "cherry"]
print(myFruitList)
print(type(myFruitList))
```

<p align="center">
  <img src="assets/screenshots/04_defining_a_list.png" alt="Defining a List" width="80%"/>
</p>

*Defining and printing a list with type verification*

**Output:**
```
['apple', 'banana', 'cherry']
<class 'list'>
```

#### Accessing Lists by Position

Python uses zero-based indexing—the first item is at position 0:

```python
print(myFruitList[0])  # Output: apple
print(myFruitList[1])  # Output: banana
print(myFruitList[2])  # Output: cherry
```

<p align="center">
  <img src="assets/screenshots/05_list_by_position.png" alt="Accessing List by Position" width="80%"/>
</p>

*Accessing individual list elements by index*

**Key principle:** Lists are mutable—you can change values after creation.

#### Changing List Values

```python
myFruitList[2] = "orange"
print(myFruitList)
# Output: ['apple', 'banana', 'orange']
```

<p align="center">
  <img src="assets/screenshots/06_changing_list_value.png" alt="Changing List Values" width="80%"/>
</p>

*Modifying a list element—cherry becomes orange*

**Why this matters:** Lists are perfect for data that changes during program execution (user inputs, API responses, dynamic configurations).

---

### 2️⃣ Tuples: Immutable Ordered Collections

Tuples are like lists, but they can't be changed after creation. They use parentheses `()` instead of brackets `[]`.

**Defining a tuple:**
```python
myFinalAnswerTuple = ("apple", "banana", "pineapple")
print(myFinalAnswerTuple)
print(type(myFinalAnswerTuple))
```

<p align="center">
  <img src="assets/screenshots/07_defining_a_tuple.png" alt="Defining a Tuple" width="80%"/>
</p>

*Defining an immutable tuple*

**Output:**
```
('apple', 'banana', 'pineapple')
<class 'tuple'>
```

#### Accessing Tuples by Position

```python
print(myFinalAnswerTuple[0])  # Output: apple
print(myFinalAnswerTuple[1])  # Output: banana
print(myFinalAnswerTuple[2])  # Output: pineapple
```

<p align="center">
  <img src="assets/screenshots/08_accessing_tuple_position.png" alt="Accessing Tuple by Position" width="80%"/>
</p>

*Accessing tuple elements by index*

**Key principle:** Tuples are immutable—attempting to change a value raises an error. Use tuples for data that should never change (configuration constants, database credentials, API keys).

---

### 3️⃣ Dictionaries: Key-Value Pairs

Dictionaries store data as key-value pairs, allowing named access instead of numeric indices.

**Defining a dictionary:**
```python
myFavoriteFruitDictionary = {
    "Akua": "apple",
    "Saanvi": "banana",
    "Paulo": "pineapple"
}
print(myFavoriteFruitDictionary)
print(type(myFavoriteFruitDictionary))
```

<p align="center">
  <img src="assets/screenshots/09_defining_a_dictionary.png" alt="Defining a Dictionary" width="80%"/>
</p>

*Defining a dictionary with named keys*

**Output:**
```
{'Akua': 'apple', 'Saanvi': 'banana', 'Paulo': 'pineapple'}
<class 'dict'>
```

#### Accessing Dictionaries by Name

```python
print(myFavoriteFruitDictionary["Akua"])     # Output: apple
print(myFavoriteFruitDictionary["Saanvi"])   # Output: banana
print(myFavoriteFruitDictionary["Paulo"])    # Output: pineapple
```

<p align="center">
  <img src="assets/screenshots/10_accessing_dictionary_by_key.png" alt="Accessing Dictionary by Key" width="80%"/>
</p>

*Accessing dictionary values using keys*

**Key principle:** Dictionaries are ideal for structured data with meaningful labels (user profiles, configuration settings, API responses).

---

### Running the Complete Script

**Execution:**
```bash
# In Cloud9 terminal
python3 collections.py
```

<p align="center">
  <img src="assets/screenshots/11_python_version.png" alt="Python Version Check" width="80%"/>
</p>

*Verifying Python version and executing the script*

<p align="center">
  <img src="assets/screenshots/12_running_collections_script.png" alt="Running Collections Script" width="80%"/>
</p>

*Complete script execution showing all collection types*

<p align="center">
  <img src="assets/screenshots/13_selecting_python_interpreter.png" alt="Selecting Python Interpreter" width="80%"/>
</p>

*Cloud9 Python interpreter selection*

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Python Data Structures**
- Understanding the difference between mutable and immutable collections
- Knowing when to use lists vs. tuples vs. dictionaries
- Mastering zero-based indexing and key-based access

🛠️ **AWS Cloud9 Development**
- Setting up Python development environments in the cloud
- Using integrated terminals for script execution
- Managing project files in a cloud-based IDE

🛠️ **Automation Foundations**
- Building blocks for data manipulation scripts
- Storing configuration data in appropriate structures
- Working with collections in real-world scenarios

🛠️ **Best Practices**
- Using immutable tuples for constants and fixed data
- Leveraging dictionaries for readable, self-documenting code
- Choosing the right collection type for performance and clarity

### The Real Takeaway

Honestly, these three collection types felt basic at first—just different ways to store data. But once I started thinking about automation scenarios, it clicked:

- 🎯 **Lists for dynamic data** — User inputs, API responses, log entries that grow over time
- 🎯 **Tuples for constants** — Configuration values, database credentials, AWS region codes that never change
- 🎯 **Dictionaries for structured data** — JSON responses, user profiles, system configurations with named fields

The key insight: **the collection type you choose affects both code readability and program behavior**.

**Real-world examples:**
- **List:** `server_ips = ["10.0.1.5", "10.0.1.6", "10.0.1.7"]` (can add/remove servers)
- **Tuple:** `aws_regions = ("us-east-1", "us-west-2", "eu-west-1")` (fixed list of regions)
- **Dictionary:** `user = {"name": "Leroy", "role": "admin", "access_level": 5}` (named attributes)

This lab proved that mastering Python collections is essential before writing any automation—whether you're parsing logs, calling APIs, or managing AWS resources.

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

<h4 align="center">🐍 Built with Python • AWS Cloud9 • Data Structures • Real-World Scenarios 🚀</h4>
