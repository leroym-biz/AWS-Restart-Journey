# 🎖️ AWS Training & Certifications

<p align="center">
  <img src="assets/screenshots/aws-cloud-quest-cloud-practitioner-training-badge.png" alt="AWS Cloud Quest Badge" width="200">
</p>

> **Proof of hands-on learning—not just exam prep, but practical cloud skills built through interactive simulations, labs, and real-world scenarios.**

---

## 📜 What's Inside

- [About This Certification Journey](#about-this-certification-journey)
- [AWS Official Certifications](#aws-official-certifications)
- [SimuLearn Training Completions](#simulearn-training-completions)
- [Praesignis Training Programs](#praesignis-training-programs)
- [Skills Matrix](#skills-matrix)
- [Why These Certifications Matter](#why-these-certifications-matter)

---

## About This Certification Journey

These aren't just badges to collect. Each certification represents **hands-on practice, technical knowledge, and real-world application** of AWS services. From foundational cloud concepts to advanced generative AI strategies, this learning path demonstrates progression from theory to practical implementation.

The goal isn't certification for certification's sake—it's building the knowledge base to **architect, secure, and optimize** AWS infrastructure in production environments.

**Current Status:** AWS Cloud Practitioner pathway in progress, supplemented by hands-on SimuLearn training and specialized AI/ML learning programs.

---

## AWS Official Certifications

### 🎮 AWS Cloud Quest: Cloud Practitioner - TRAINED

<p align="left">
  <img src="assets/screenshots/aws-cloud-quest-cloud-practitioner-training-badge.png" alt="AWS Cloud Quest Badge" width="150">
</p>

**Status:** 🏁 Completed  
**Completed:** December 2025  
**Platform:** AWS Cloud Quest (Game-Based Learning)

**What This Is:**

AWS Cloud Quest is a role-playing game that teaches cloud skills through 12 solution-building simulations. Unlike traditional courses, this is **hands-on learning disguised as a game**—you solve actual business problems using AWS services in a simulated environment.

**What I Learned:**

- **Core AWS Services:** EC2, S3, Lambda, RDS, VPC, IAM—the foundational building blocks
- **Solution Building:** Not just "what is S3" but "when to use S3 vs. EFS vs. EBS for specific use cases"
- **Practical Decision-Making:** Choosing the right service for performance, cost, and scalability trade-offs
- **Hands-On Labs:** Built solutions in a real AWS console environment, not just watched videos

**Real-World Application:**

This training directly informed the architecture decisions in my portfolio projects—understanding when to use CloudFront for content delivery (Ember & Co), how to architect multi-tier applications (Pet Shore), and why certain services solve specific problems.

The AWS Certified Cloud Practitioner validates foundational, high-level understanding of AWS Cloud, services, and terminology, and Cloud Quest provided the interactive practice to make that knowledge stick.

**Key Takeaway:** This wasn't passive learning. Cloud Quest forced me to make architecture decisions in scenarios where wrong choices had consequences—exactly like real projects.

---

## SimuLearn Training Completions

AWS SimuLearn uses realistic simulated scenarios powered by Amazon Bedrock generative AI to teach technical skills through interactive customer conversations and hands-on labs.

### 🗂️ File Systems in the Cloud

**Status:** 🏁 Completed  
**Completed:** December 2, 2025  
**Certificate:** <img src="assets/screenshots/AWS%20File%20Systems%20in%20the%20Cloud.png" alt="AWS File Systems in the Cloud Certificate" width="150">

**What This Training Covered:**

- **Amazon EFS (Elastic File System)** for shared file storage across multiple EC2 instances
- **Amazon FSx** for Windows File Server and Lustre for high-performance computing
- **S3 as object storage** vs. block storage (EBS) vs. file storage (EFS)
- **When to use which:** Performance requirements, cost optimization, and use-case matching

**Why This Matters:**

File storage isn't just "upload files to S3 and call it a day." Different applications need different storage architectures. Web apps need EFS for shared configuration files, data science workflows need FSx for Lustre, Windows workloads need FSx for Windows.

Understanding these distinctions means architecting solutions that actually work, not just "it technically runs."

**Hands-On Components:**

- Configured EFS mount targets across multiple availability zones
- Set up lifecycle policies to transition data to cheaper storage classes
- Compared throughput modes (bursting vs. provisioned) for cost optimization

---

### 🕸️ Networking Concepts

**Status:** 🏁 Completed  
**Completed:** December 2, 2025  
**Certificate:** <img src="assets/screenshots/AWS%20Networking%20Concepts.png" alt="AWS Networking Concepts Certificate" width="150">

**What This Training Covered:**

- **VPC (Virtual Private Cloud) design:** Subnets, route tables, internet gateways
- **Security Groups vs. NACLs:** Stateful vs. stateless firewalls and when to use each
- **Load Balancers (ALB, NLB, CLB):** Traffic distribution and health checks
- **VPC Peering and Transit Gateway:** Connecting multiple VPCs securely

**Why This Matters:**

Networking is the foundation of cloud security. A misconfigured security group can expose your entire database to the internet. Understanding CIDR blocks, routing, and network isolation isn't optional—it's survival.

The Pet Shore architecture project relied heavily on this knowledge: isolating databases in private subnets, routing traffic through load balancers, configuring security groups to allow only necessary traffic.

**Hands-On Components:**

- Built multi-tier VPC architectures with public and private subnets
- Configured Application Load Balancers with target groups
- Implemented security group rules following least-privilege principles

---

### 🔑 Introduction to AWS Identity and Access Management (IAM)

**Status:** 🏁 Completed  
**Completed:** November 12, 2025  
**Certificate:** <img src="assets/screenshots/Introduction%20to%20AWS%20Identity%20and%20Access%20Management%20(IAM).png" alt="IAM Certificate" width="150">

**What This Training Covered:**

- **IAM Users, Groups, and Roles:** Who or what can access AWS resources
- **Policies and Permissions:** JSON policy documents and principle of least privilege
- **Service Roles and Assume Role:** How EC2 instances and Lambda functions access other services
- **Multi-Factor Authentication (MFA):** Adding an extra layer of security

**Why This Matters:**

IAM is the gatekeeper of AWS security. Every resource, every service, every user needs proper permissions—too broad and you're vulnerable, too restrictive and nothing works.

In the Ember & Co project, I implemented a CloudFront-only S3 access policy using Service Principals with SourceArn conditions. That's not basic stuff—it's production-grade security architecture, and IAM training made it possible.

**Hands-On Components:**

- Created custom IAM policies for specific use cases
- Configured cross-account access using IAM roles
- Implemented MFA for root account protection

**Key Takeaway:** Security isn't a feature you add at the end—it's baked into every architecture decision from day one.

---

## Praesignis Training Programs

Praesignis is the leading AWS re/Start partner in South Africa, delivering specialized training in cloud computing and AI/ML technologies.

### 🧠 AI Practitioner Learning Plan

**Status:** 🏁 Completed  
**Completed:** September 16, 2025  
**Certificate:** <img src="assets/screenshots/AI%20Practitioner%20Learning%20Plan.png" alt="AI Practitioner Certificate" width="150">

**What This Program Covered:**

- **Generative AI Fundamentals:** Large Language Models (LLMs), diffusion models, and how they're trained
- **Amazon Bedrock:** Building generative AI applications with foundational models
- **Prompt Engineering:** Crafting effective prompts for AI-powered solutions
- **AI Ethics and Responsible Use:** Bias, fairness, and governance in AI systems

**Why This Matters:**

AI isn't just the future—it's already transforming cloud architectures. Knowing how to integrate AI services like Bedrock, SageMaker, and Amazon Q into solutions is becoming a baseline expectation for cloud engineers.

This training provided the foundation to understand not just what AI services exist, but when and how to use them responsibly in business contexts.

**Real-World Application:**

Understanding AI/ML services means I can architect solutions that go beyond basic CRUD applications—chatbots for customer service, recommendation engines for e-commerce, automated content generation for marketing.

---

### 📊 Generative AI for Decision Makers

**Status:** 🏁 Completed  
**Completed:** September 13, 2025  
**Certificate:** <img src="assets/screenshots/Generative%20AI%20for%20Decision%20Makers.png" alt="Generative AI for Decision Makers Certificate" width="150">

**What This Program Covered:**

This learning plan is designed to introduce generative AI to business and technical decision makers, focusing on:

- **Business Strategy:** How generative AI addresses business challenges and drives growth
- **Project Planning:** Approaching generative AI projects with realistic timelines and ROI expectations
- **Organizational Readiness:** Building a generative AI-ready culture and infrastructure
- **Use Cases:** Practical applications across industries (customer service, content creation, data analysis)

**Why This Matters:**

Technical skills without business context are useless. This program taught me to **translate AI capabilities into business value**—the same skill that made the Ember & Co presentation successful.

Stakeholders don't care about "Amazon Bedrock with Claude integration." They care about "reducing customer service costs by 40% through AI-powered chatbots."

**Key Takeaway:** The best cloud engineers can speak two languages—technical and business. This certification bridges that gap.

---

## Skills Matrix

### 🧰 Technical Skills Acquired

| Certification | Core Services Learned | Key Concepts Mastered |
|--------------|----------------------|----------------------|
| **Cloud Quest** | EC2, S3, Lambda, RDS, VPC, CloudFront, IAM | Solution architecture, service selection, cost optimization |
| **File Systems** | EFS, FSx, S3, EBS | Storage performance tuning, lifecycle policies, use-case matching |
| **Networking** | VPC, Security Groups, ALB/NLB, Route 53 | Network isolation, traffic routing, security best practices |
| **IAM** | Users, Roles, Policies, MFA | Least-privilege access, cross-account permissions, security hardening |
| **AI Practitioner** | Bedrock, SageMaker, Amazon Q | Generative AI applications, prompt engineering, model selection |
| **AI for Decision Makers** | Business strategy, ROI analysis | AI project planning, organizational change management |

### ⚓ Practical Applications

**From Training to Production:**

- **Ember & Co (Project 01):** Used IAM and networking knowledge to implement CloudFront-only S3 access with Service Principal policies
- **Pet Shore (Project 02):** Applied VPC design principles to create multi-tier architecture with private subnets and security groups
- **Future Projects:** AI/ML training prepares me for building intelligent applications with Bedrock and SageMaker

---

## Why These Certifications Matter

### 1. Hands-On Learning, Not Just Theory

Every certification here involved **building something**—not just answering multiple-choice questions. SimuLearn simulations, Cloud Quest labs, and practical exercises mean I can actually implement these services.

### 2. Comprehensive Coverage

From foundational cloud concepts to advanced AI/ML strategies, these certifications cover the full stack of modern cloud engineering:

- **Infrastructure:** Compute, storage, networking, databases
- **Security:** IAM, encryption, compliance, access control
- **Emerging Tech:** Generative AI, machine learning, serverless architectures

### 3. Business Communication

The AI for Decision Makers and Cloud Practitioner training emphasized translating technical solutions into business value—critical for client-facing roles and stakeholder presentations.

### 4. Continuous Learning

Cloud technology evolves fast. These certifications represent **active, ongoing learning**—not a one-time credential that sits on a shelf.

---

## 📅 Certification Roadmap

**Completed:**
- 🏁 AWS Cloud Quest: Cloud Practitioner - TRAINED
- 🏁 AWS SimuLearn: File Systems in the Cloud
- 🏁 AWS SimuLearn: Networking Concepts
- 🏁 AWS SimuLearn: Introduction to IAM
- 🏁 Praesignis: AI Practitioner Learning Plan
- 🏁 Praesignis: Generative AI for Decision Makers

**In Progress:**
- 🧪 AWS Certified Cloud Practitioner (CLF-C02) exam preparation

**Planned:**
- 📅 AWS Certified Solutions Architect - Associate
- 📅 AWS Certified Developer - Associate
- 📅 AWS Certified AI Practitioner

Each certification builds on the previous, creating a comprehensive knowledge base that spans architecture, security, development, and AI/ML.

---

## 📝 Verification

All certificates are legitimate and can be verified through the respective platforms. Certificates are stored in this repository and available for review by potential employers or collaborators.

**Issuing Organizations:**
- **AWS Training and Certification** (Official AWS SimuLearn completions)
- **Praesignis** (AWS re/Start partner and authorized training provider)

---

## 🤝 Let's Connect

If you're looking for someone who has **proven cloud knowledge through hands-on training**, not just exam prep courses—let's talk.

<p align="center">
  <a href="mailto:leroym.biz@gmail.com">
    <img src="https://img.shields.io/badge/EMAIL-LEROYM.BIZ@GMAIL.COM-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email">
  </a>
  <a href="https://api.whatsapp.com/send/?phone=27605665116&text=Hi%20Leroy,%20saw%20your%20GitHub!" target="_blank">
    <img src="https://img.shields.io/badge/WHATSAPP-%2B27%2060%20566%205116-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="WhatsApp">
  </a>
</p>

<p align="center">
  <a href="https://github.com/leroym-biz/AWS-Restart-Journey" target="_blank">
    <img src="https://img.shields.io/badge/VIEW%20REPOSITORY-black?style=for-the-badge&logo=github&logoColor=white" alt="View Repository">
  </a>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Certifications-6%20Completed-success?style=flat-square">
  <img src="https://img.shields.io/badge/Status-Active%20Learning-brightgreen?style=flat-square">
  <img src="https://img.shields.io/badge/Focus-Hands--On%20Cloud%20Skills-blue?style=flat-square">
</p>

<p align="center">🏵️ <strong>AWS Trained • Hands-On Labs • Real-World Application • Continuous Learning</strong> 🏵️</p>