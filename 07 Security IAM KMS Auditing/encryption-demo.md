# 🛡️ Data Protection with AWS KMS and Encryption CLI

> **Implementing cryptographic encryption and decryption—the kind of stuff that keeps sensitive data secure in production.**

---

## 📜 What's Inside

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
💠 **AWS KMS key creation** with proper IAM permissions  
💠 **Encryption CLI configuration** for automated encryption workflows  
💠 **Plaintext to ciphertext conversion** using symmetric encryption  
💠 **Decryption validation** to verify data integrity

**Tech Stack:** AWS KMS, AWS Encryption CLI, EC2, IAM, Python3, Session Manager

---

## Architecture Overview

### How It's Built

Cryptography is the conversion of communicated information into secret code that keeps the information confidential and private. The central function is **encryption**, which transforms data into an unreadable form, ensuring privacy by keeping information hidden from unauthorized parties.

**The Key Components:**
- **AWS KMS:** Centralized key management service using FIPS 140-2 validated HSMs
- **Symmetric Keys:** Same key encrypts and decrypts data (fast and efficient)
- **Encryption Context:** Additional authenticated data for security best practices
- **Hardware-Backed Security:** KMS uses FIPS-validated HSMs—your keys never leave AWS in plaintext
- **IAM Role-Based Access:** Secure, credential-less authentication to encryption keys

<p align="center">
  <img src="assets/screenshots/symmetric_keys_and_algorithms.png" alt="Symmetric Encryption Architecture" width="80%"/>
</p>

*Symmetric key encryption flow—same key for both encryption and decryption, optimized for speed and efficiency*

**Why Symmetric Encryption?**  
Symmetric encryption uses the same key to encrypt and decrypt data, making it fast and efficient. For encrypting files, databases, or S3 objects, symmetric keys are the right choice. Asymmetric encryption (public/private key pairs) is used for key exchange, digital signatures, and SSL/TLS.

**Why This Architecture Matters:**
- **Centralized Key Management:** One place to control, rotate, and audit all encryption keys
- **Hardware-Backed Security:** KMS uses FIPS-validated HSMs—your keys never leave AWS in plaintext
- **Automated Key Rotation:** Built-in support for annual key rotation without re-encrypting data
- **Audit Trail:** Every key usage is logged in CloudTrail for compliance

Honestly, understanding symmetric vs. asymmetric encryption is half the battle. Symmetric encryption (what we're using here) is fast and efficient because the same key handles both operations. Asymmetric encryption uses public/private key pairs—more secure for key exchange, but slower.

---

## KMS Key Creation

### Task 1: Creating the Encryption Key

With AWS KMS, you can create and manage cryptographic keys and control their use across a wide range of AWS services and in your applications. AWS KMS uses hardware security modules (HSMs) that have been validated under FIPS Publication 140-2 to protect your keys.

#### Key Configuration

| Component | Configuration | Why It Makes Sense |
|-----------|---------------|-------------------|
| **Key Type** | Symmetric | Fast encryption/decryption using the same key—ideal for data at rest. Asymmetric is for different use cases like digital signatures. |
| **Alias** | MyKMSKey | Human-readable name for easy reference in scripts and CloudFormation. |
| **Description** | Key used to encrypt and decrypt data files | Clear documentation of key purpose for auditing and compliance. |
| **Key Administrators** | voclabs IAM role | Least privilege—only designated roles can manage the key lifecycle. Who can delete, update permissions. |
| **Key Users** | voclabs IAM role | Separation of duties—administrators aren't automatically users. Who can use the key to encrypt/decrypt data. |

**Security Best Practices Applied:**
- 🔑 Symmetric encryption for performance (data at rest use case)
- 🔑 IAM role-based access control (principle of least privilege)
- 🔑 Key administrators separated from key users
- 🔑 ARN documented for programmatic access

**Key Policy Design:**  
The key policy is resource-based and defines who can use the key and for what operations. This follows the principle of **least privilege**—only the voclabs role has administrative and usage permissions.

---

## Encryption CLI Setup

### Task 2: Configuring the File Server

Before encrypting data, I needed to set up the AWS Encryption CLI on an EC2 instance. This involved configuring AWS credentials and installing the encryption tooling.

#### AWS Credentials Configuration

Connected to the **File Server** EC2 instance via **Session Manager** (no SSH keys needed—IAM role handles authentication).

Instead of hardcoding access keys (which is a security anti-pattern), I configured the EC2 instance with temporary credentials from AWS Systems Manager Session Manager. This follows the principle of **credential-less authentication**.

**Steps Completed:**

```bash
# Navigate to home directory
cd

# Initialize AWS CLI configuration
aws configure
# Placeholders entered: Access Key ID: 1, Secret Access Key: 1
# Region: (copied from Vocareum AWS Details)
# Output format: (default)

# Edit credentials file with actual session tokens
vi ~/.aws/credentials
# Paste temporary credentials from Vocareum AWS Details
# (includes aws_access_key_id, aws_secret_access_key, aws_session_token)
```

**What's Happening Here:**
- The `aws configure` command creates the basic configuration structure
- Temporary session tokens (including `aws_session_token`) provide time-limited access
- No long-lived credentials are stored on disk—they expire automatically
- IAM role attached to the instance grants KMS permissions

**Why This Matters:**  
In production, you'd use IAM roles attached to EC2 instances or Lambda functions—no hardcoded credentials. For this lab, I configured credentials manually to understand the authentication flow, but the pattern is the same: temporary credentials with automatic expiration.

#### AWS Encryption CLI Installation

```bash
# Install AWS Encryption SDK CLI via pip
pip3 install aws-encryption-sdk-cli

# Add CLI to system PATH for easy access
export PATH=$PATH:/home/ssm-user/.local/bin
```

**Why the AWS Encryption CLI?**
- **Standardized Tooling:** Same commands work across Linux, macOS, and Windows
- **Best Practice Defaults:** Built-in key commitment, encryption context support
- **Integration-Ready:** Easily scriptable for automation pipelines
- **Open Source:** Built on the AWS Encryption SDK—fully auditable code

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

# Create output directory for encrypted files
mkdir output
```

#### The Encryption Command

```bash
# Store KMS key ARN in a variable for reuse
keyArn=arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012

# Encrypt the plaintext file
aws-encryption-cli --encrypt \
  --input secret1.txt \
  --wrapping-keys key=$keyArn \
  --metadata-output ~/metadata \
  --encryption-context purpose=test \
  --commitment-policy require-encrypt-require-decrypt \
  --output ~/output/
```

**Breaking Down the Command:**
- `--encrypt` — Specifies the encryption operation mode
- `--input secret1.txt` — Source file containing plaintext data
- `--wrapping-keys key=$keyArn` — The KMS key used to encrypt the data encryption key (DEK)
- `--metadata-output ~/metadata` — Logs metadata about the operation for auditing
- `--encryption-context purpose=test` — Additional authenticated data (AAD) for context validation
- `--commitment-policy require-encrypt-require-decrypt` — Enforces key commitment for additional security
- `--output ~/output/` — Destination directory for the encrypted file

**Encryption Context: The Unsung Hero**  
This is a best practice. Encryption context is additional authenticated data (AAD) that's cryptographically bound to the ciphertext. It's like a label that says "this data was encrypted for X purpose." If someone tries to decrypt the data in a different context, it fails. This prevents certain types of cryptographic attacks.

#### Viewing the Encrypted Data

```bash
# Check for successful encryption
echo $?
# Output: 0 (success)

# Locate the encrypted file
ls output
# Output: secret1.txt.encrypted

# Attempt to view encrypted contents
cat secret1.txt.encrypted
# Output: Binary gibberish—unreadable ciphertext
```

**What We're Seeing:**  
The plaintext "TOP SECRET 1!!!" has been transformed into ciphertext. The encrypted file is now **ciphertext**—computationally infeasible to read without the decryption key. Even if someone gains access to the file system, they can't read the data without KMS permissions.

---

### Decrypting Ciphertext

Now the reverse process—converting ciphertext back to readable plaintext.

#### The Decryption Command

```bash
# Navigate to output directory
cd output

# Decrypt the ciphertext
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

**Decryption Parameters Explained:**
- `--decrypt` — Specifies decryption mode
- `--input secret1.txt.encrypted` — The ciphertext file to decrypt
- `--wrapping-keys key=$keyArn` — Same KMS key used for encryption
- `--encryption-context purpose=test` — Must match the encryption context used during encryption
- `--max-encrypted-data-keys 1` — Limits the number of encrypted data keys processed (security best practice)
- `--buffer` — Uses buffering for better performance with larger files
- `--output .` — Writes decrypted file to current directory

<p align="center">
  <img src="assets/screenshots/decrypt_the_ciphertext.png" alt="Decryption Process" width="80%"/>
</p>

*Decrypting ciphertext back into readable plaintext using the KMS key—data is restored to its original form*

#### Verification

```bash
# Check for decrypted file
ls
# Output: secret1.txt.encrypted  secret1.txt.encrypted.decrypted

# View decrypted contents
cat secret1.txt.encrypted.decrypted
# Output: TOP SECRET 1!!!
```

**Success!**  
After successful decryption, you can now see the original, readable contents. The decrypted file contains the original plaintext: "TOP SECRET 1!!!" This proves the encryption/decryption workflow is functioning correctly.

Success. The data is back in plaintext form, but only because we had the proper IAM permissions to use the KMS key for decryption.

---

## What I Learned

### Technical Skills I Practiced

🔧 **Cryptography Fundamentals**
- Understanding symmetric vs. asymmetric encryption use cases
- Implementing encryption context for additional security
- Using key commitment to prevent key substitution attacks
- Managing encryption metadata for audit trails

🔧 **AWS Key Management Service**
- Creating and configuring KMS keys with proper IAM permissions
- Setting up key policies with separation of administrative and usage permissions
- Understanding FIPS 140-2 validated HSMs and hardware-backed security
- Using KMS ARNs for programmatic key access

🔧 **Encryption CLI Operations**
- Installing and configuring AWS Encryption SDK CLI
- Running encrypt/decrypt commands with proper parameters
- Validating encryption success with exit codes
- Managing encrypted data keys and commitment policies

🔧 **Security Engineering**
- Implementing defense-in-depth strategies
- Using IAM roles instead of long-lived credentials
- Applying least privilege access control
- Building audit trails with metadata logging

### The Real Takeaway

Honestly, encryption was one of those topics I thought would be overly complex—lots of math, confusing terminology, hard to implement. But AWS KMS makes it surprisingly straightforward.

The more I worked through this lab, the more I realized encryption is **non-negotiable** for any production system:

- 💡 **Compliance requirements** — HIPAA, PCI-DSS, GDPR all mandate encryption at rest
- 💡 **Data breach protection** — Even if an attacker steals encrypted files, they're useless without the key
- 💡 **Encryption context matters** — That extra layer of AAD prevents key substitution attacks
- 💡 **KMS handles the hard stuff** — No need to manage HSMs or key rotation manually

**Real-World Applications:**

This exact pattern applies to:
- **Database Encryption:** Encrypting RDS snapshots before cross-region replication
- **S3 Bucket Protection:** Use KMS keys for server-side encryption (SSE-KMS)
- **EBS Volume Security:** Attach encrypted volumes to EC2 instances
- **Lambda Environment Variables:** Store secrets encrypted with KMS
- **Backup Security:** Protecting S3-stored backups with KMS
- **Compliance Requirements:** Meeting HIPAA, PCI-DSS, and GDPR encryption mandates

**Questions I Can Now Answer:**
- When should I use symmetric vs. asymmetric encryption?
- How do I implement encryption context for additional security?
- What's the difference between key administrators and key users?
- How do I audit encryption operations for compliance?

Once you understand the encrypt/decrypt workflow, integrating encryption into your AWS architecture becomes second nature. And when compliance auditors ask "Is your data encrypted at rest?"—you can confidently say yes.

**The Most Valuable Lesson:**  
Encryption is useless without proper key management. You can have the strongest cipher in the world, but if your keys are compromised, your data is compromised. KMS solves this problem by centralizing key management and enforcing strict access controls.

---

## 📈 Project Status

This is part of my **AWS Restart Journey**, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.

I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.

---

## 👥 Let's Connect

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

<h4 align="center">🏰 Built with AWS KMS • Encryption CLI • IAM • Cryptography Best Practices 🔑</h4>