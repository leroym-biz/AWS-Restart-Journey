# 🔐 Data Protection with AWS KMS and Encryption CLI

> **Implementing cryptographic encryption and decryption—the kind of stuff that keeps sensitive data secure in production.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Architecture Overview](#architecture-overview)
- [KMS Key Creation](#kms-key-creation)
- [Encryption CLI Setup](#encryption-cli-setup)
- [Encryption & Decryption Process](#encryption--decryption-process)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab covered the fundamentals of cryptography in AWS—creating encryption keys, securing sensitive data, and implementing encryption/decryption workflows using AWS Key Management Service (KMS).

Encryption isn't optional anymore. Whether it's compliance requirements (HIPAA, PCI-DSS, GDPR) or just basic security hygiene, you need to encrypt data at rest and in transit. This lab showed me how to do it the AWS way.

The real point here wasn't just running encrypt/decrypt commands—it was understanding the complete cryptographic workflow:  
✅ **AWS KMS key creation** with proper IAM permissions  
✅ **Encryption CLI configuration** for automated encryption workflows  
✅ **Plaintext to ciphertext conversion** using symmetric encryption  
✅ **Decryption validation** to verify data integrity

**Tech Stack:** AWS KMS, AWS Encryption CLI, EC2, IAM, Python3, Session Manager

---

## Architecture Overview

### How It's Built

Cryptography is the conversion of communicated information into secret code that keeps the information confidential and private. The central function is **encryption**, which transforms data into an unreadable form, ensuring privacy by keeping information hidden from unauthorized parties.

<p align="center">
  <img src="assets/screenshots/encryption_algorithm.png" alt="Symmetric Encryption Process" width="70%">
</p>

<p align="center"><em>Symmetric encryption: Same key encrypts plaintext into ciphertext</em></p>

**The Key Pieces:**
- **AWS KMS:** Centralized key management service using FIPS 140-2 validated HSMs
- **Symmetric Keys:** Same key encrypts and decrypts data (fast and efficient)
- **Encryption Context:** Additional authenticated data for security best practices
- **Metadata Tracking:** Audit trail of all encryption operations

**Encryption Process:**  
Plaintext (readable data) → Encryption Algorithm + Symmetric Key → Ciphertext (unreadable data)

<p align="center">
  <img src="assets/screenshots/decryption_algorithm.png" alt="Symmetric Decryption Process" width="70%">
</p>

<p align="center"><em>Decryption: Same symmetric key converts ciphertext back to plaintext</em></p>

**Decryption Process:**  
Ciphertext (unreadable data) → Decryption Algorithm + Symmetric Key → Plaintext (readable data)

Honestly, understanding symmetric vs. asymmetric encryption is half the battle. Symmetric encryption (what we're using here) is fast and efficient because the same key handles both operations. Asymmetric encryption uses public/private key pairs—more secure for key exchange, but slower.

---

## KMS Key Creation

### Task 1: Creating the Encryption Key

With AWS KMS, you can create and manage cryptographic keys and control their use across a wide range of AWS services and in your applications. AWS KMS uses hardware security modules (HSMs) that have been validated under FIPS Publication 140-2 to protect your keys.

#### Key Configuration

| Component | Configuration | Why It Makes Sense |
|-----------|---------------|-------------------|
| **Key Type** | Symmetric | Fast encryption/decryption using the same key—ideal for data at rest |
| **Alias** | MyKMSKey | Human-readable name for the key (easier than remembering key IDs) |
| **Description** | Key used to encrypt and decrypt data files | Clear documentation of key purpose for auditing |
| **Key Administrators** | voclabs IAM role | Who can manage the key (delete, update permissions) |
| **Key Users** | voclabs IAM role | Who can use the key to encrypt/decrypt data |

<p align="center">
  <img src="assets/screenshots/kms_key_creation.png" alt="AWS KMS Key Creation" width="80%">
</p>

<p align="center"><em>Creating a symmetric KMS key in the AWS Console</em></p>

**Security Best Practices Applied:**
- 🔒 Symmetric encryption for performance (data at rest use case)
- 🔒 IAM role-based access control (principle of least privilege)
- 🔒 Key administrators separated from key users
- 🔒 ARN documented for programmatic access

**Why Symmetric Encryption?**  
Symmetric encryption uses the same key to encrypt and decrypt data, making it fast and efficient. For encrypting files, databases, or S3 objects, symmetric keys are the right choice. Asymmetric encryption (public/private key pairs) is used for key exchange, digital signatures, and SSL/TLS.

---

## Encryption CLI Setup

### Task 2: Configuring the File Server

Before encrypting data, I needed to set up the AWS Encryption CLI on an EC2 instance. This involved configuring AWS credentials and installing the encryption tooling.

#### AWS Credentials Configuration

Connected to the **File Server** EC2 instance via **Session Manager** (no SSH keys needed—IAM role handles authentication).

**Steps Completed:**
1. Configured AWS CLI credentials using `aws configure`
2. Updated `~/.aws/credentials` file with temporary session tokens
3. Installed AWS Encryption SDK CLI via pip3
4. Set PATH variable to access encryption commands

```bash
# Install AWS Encryption CLI
pip3 install aws-encryption-sdk-cli

# Add to PATH
export PATH=$PATH:/home/ssm-user/.local/bin
```

<p align="center">
  <img src="assets/screenshots/count_text&kms_g.png" alt="File Server Session" width="80%">
</p>

<p align="center"><em>File server terminal showing encrypted files and KMS key configuration</em></p>

**Why This Matters:**  
In production, you'd use IAM roles attached to EC2 instances or Lambda functions—no hardcoded credentials. For this lab, I configured credentials manually to understand the authentication flow.

---

## Encryption & Decryption Process

### Task 3: Encrypting Plaintext Data

This is where cryptography gets real. I created plaintext files containing "sensitive" data, encrypted them using the KMS key, and validated that the contents were unreadable.

#### Creating Test Files

```bash
# Create three text files
touch secret1.txt secret2.txt secret3.txt

# Add plaintext data
echo 'TOP SECRET 1!!!' > secret1.txt

# View plaintext contents
cat secret1.txt
# Output: TOP SECRET 1!!!
```

<p align="center">
  <img src="assets/screenshots/plaintext_secrets_textfiles.png" alt="Plaintext Files" width="80%">
</p>

<p align="center"><em>Three plaintext files before encryption—readable and vulnerable</em></p>

#### Encryption Command

```bash
# Set KMS key ARN variable
keyArn=arn:aws:kms:us-east-1:123456789012:key/abcd1234-5678-90ab-cdef-EXAMPLE11111

# Encrypt secret1.txt
aws-encryption-cli --encrypt \
--input secret1.txt \
--wrapping-keys key=$keyArn \
--metadata-output ~/metadata \
--encryption-context purpose=test \
--commitment-policy require-encrypt-require-decrypt \
--output ~/output/
```

**What This Command Does:**
- `--encrypt`: Specifies encryption operation
- `--input secret1.txt`: File to encrypt
- `--wrapping-keys key=$keyArn`: Uses the KMS key we created
- `--metadata-output ~/metadata`: Logs encryption metadata for auditing
- `--encryption-context purpose=test`: Additional authenticated data (AAD) for security
- `--commitment-policy`: Enforces key commitment (prevents key substitution attacks)
- `--output ~/output/`: Writes encrypted file to output directory

**Encryption Context:**  
This is a best practice. Encryption context is additional authenticated data (AAD) that's cryptographically bound to the ciphertext. It must match during decryption, adding an extra security layer.

#### Viewing Encrypted Data

```bash
# List encrypted files
ls output/
# Output: secret1.txt.encrypted

# Attempt to read encrypted file
cat output/secret1.txt.encrypted
# Output: Gibberish binary data—unreadable ciphertext
```

<p align="center">
  <img src="assets/screenshots/secrets_after_encrypting.png" alt="Encrypted Ciphertext" width="80%">
</p>

<p align="center"><em>Encrypted file showing unreadable ciphertext—data is now secure</em></p>

**What We're Seeing:**  
The plaintext "TOP SECRET 1!!!" has been transformed into ciphertext. Without the KMS key and proper decryption command, this data is useless to an attacker. Even if someone steals the encrypted file, they can't read it.

---

### Decrypting Ciphertext

Now the reverse process—converting ciphertext back to readable plaintext.

#### Decryption Command

```bash
# Navigate to encrypted files
cd output/

# Decrypt the file
aws-encryption-cli --decrypt \
--input secret1.txt.encrypted \
--wrapping-keys key=$keyArn \
--commitment-policy require-encrypt-require-decrypt \
--encryption-context purpose=test \
--metadata-output ~/metadata \
--max-encrypted-data-keys 1 \
--buffer \
--output .
```

**What This Command Does:**
- `--decrypt`: Specifies decryption operation
- `--input secret1.txt.encrypted`: The ciphertext file
- `--wrapping-keys key=$keyArn`: Same KMS key used for encryption
- `--encryption-context purpose=test`: Must match the encryption context used during encryption
- `--max-encrypted-data-keys 1`: Security control to limit key usage
- `--output .`: Writes decrypted file to current directory

#### Verification

```bash
# List decrypted files
ls
# Output: secret1.txt.encrypted  secret1.txt.encrypted.decrypted

# View decrypted contents
cat secret1.txt.encrypted.decrypted
# Output: TOP SECRET 1!!!
```

**Success!**  
The decrypted file contains the original plaintext: "TOP SECRET 1!!!"

After successful decryption, you can now see the original, readable contents. This proves the encryption/decryption workflow is functioning correctly.

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Cryptography Fundamentals**
- Understanding symmetric vs. asymmetric encryption
- Implementing encryption context for additional security
- Using key commitment to prevent key substitution attacks
- Managing encryption metadata for audit trails

🛠️ **AWS KMS Management**
- Creating and configuring KMS keys
- Setting up IAM permissions for key administrators vs. key users
- Using KMS ARNs for programmatic key access
- Understanding FIPS 140-2 validated HSMs

🛠️ **Encryption CLI Operations**
- Installing and configuring AWS Encryption SDK CLI
- Running encrypt/decrypt commands with proper parameters
- Validating encryption success with exit codes
- Managing encrypted data keys and commitment policies

🛠️ **Security Best Practices**
- Principle of least privilege for KMS key access
- Encryption context as additional authenticated data (AAD)
- Key commitment policy enforcement
- Metadata logging for compliance and auditing

### The Real Takeaway

Honestly, encryption was one of those topics I thought would be overly complex—lots of math, confusing terminology, hard to implement. But AWS KMS makes it surprisingly straightforward.

The more I worked through this lab, the more I realized encryption is **non-negotiable** for any production system:

- 🎯 **Compliance requirements** — HIPAA, PCI-DSS, GDPR all mandate encryption at rest
- 🎯 **Data breach protection** — Even if an attacker steals encrypted files, they're useless without the key
- 🎯 **Encryption context matters** — That extra layer of AAD prevents key substitution attacks
- 🎯 **KMS handles the hard stuff** — No need to manage HSMs or key rotation manually

**Real-World Scenarios:**
- **Encrypt S3 buckets:** Use KMS keys for server-side encryption (SSE-KMS)
- **Encrypt RDS databases:** Enable encryption at rest using KMS keys
- **Encrypt EBS volumes:** Attach encrypted volumes to EC2 instances
- **Encrypt Lambda environment variables:** Store secrets encrypted with KMS

**Questions I can now answer:**
- When should I use symmetric vs. asymmetric encryption?
- How do I implement encryption context for additional security?
- What's the difference between key administrators and key users?
- How do I audit encryption operations for compliance?

Once you understand the encrypt/decrypt workflow, integrating encryption into your AWS architecture becomes second nature. And when compliance auditors ask "Is your data encrypted at rest?"—you can confidently say yes.

---

## 📝 Project Status

This is part of my **AWS Restart Journey**, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.

I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.

---

## 🤝 Let's Connect

If you're looking for someone who's serious about learning AWS the right way—hands-on, documented, and grounded in real-world architecture—let's talk.

<p align="center">
  <a href="mailto:leroym.biz@gmail.com">
    <img src="https://img.shields.io/badge/Email-leroym.biz@gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email">
  </a>
  <a href="https://api.whatsapp.com/send/?phone=27605665116&text=Hi%20Leroy,%20saw%20your%20GitHub!" target="_blank">
    <img src="https://img.shields.io/badge/WhatsApp-%2B27%2060%20566%205116-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="WhatsApp">
  </a>
</p>

<p align="center">
  <a href="https://github.com/leroym-biz/AWS-restart-journey" target="_blank">
    <img src="https://img.shields.io/badge/View%20Repository-black?style=for-the-badge&logo=github&logoColor=white" alt="View Repository">
  </a>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active%20Learning-success?style=flat-square">
  <img src="https://img.shields.io/badge/Commitment-Hands%20On%20Every%20Week-brightgreen?style=flat-square">
</p>

<p align="center">🔐 <strong>Built with AWS KMS • Encryption CLI • IAM • Cryptography Best Practices</strong> 🔐</p>