# 🛸 Portfolio Projects: Real-World AWS Solutions

<p align="center">
  <img src="../Lab Assets/screenshots/Project_folder_header.png" alt="AWS Portfolio Projects Header" width="100%">
</p>

> **Building production-grade AWS solutions—the kind of projects that demonstrate real cloud architecture skills.**

---

## 📜 What's Inside

- [About This Portfolio](#about-this-portfolio)
- [Featured Projects](#featured-projects)
- [Project Structure](#project-structure)
- [Skills Demonstrated](#skills-demonstrated)
- [What Makes These Projects Different](#what-makes-these-projects-different)

---

## About This Portfolio

This folder contains **real-world AWS projects** that go beyond basic tutorials. Each project solves an actual business problem, implements production-ready architecture, and demonstrates the kind of cloud engineering work you'd do on the job.

I'm not just spinning up resources and calling it a day. I'm designing solutions, documenting decisions, and building infrastructure that scales. These projects prove I can:
- Architect multi-tier AWS solutions
- Implement security best practices from day one
- Automate deployments and configurations
- Present technical solutions to non-technical stakeholders
- Document everything for future reference

**The Goal:** Build a portfolio that shows I can actually build things, not just pass certification exams.

---

## Featured Projects

### Project 01: Ember & Co - Static Website Hosting

  <img src="https://img.shields.io/badge/Status-Complete-success?style=flat-square">
  <img src="https://img.shields.io/badge/AWS-S3%20%7C%20CloudFront%20%7C%20Route53-orange?style=flat-square">
  <img src="https://img.shields.io/badge/Focus-Serverless%20Web%20Hosting-blue?style=flat-square">

**The Problem:** A Melville restaurant with 100+ daily customers suffering from manual booking chaos—double-bookings, lost reservations, frustrated staff, and revenue loss.

**The Solution:** Built a fully functional static website with:
- **S3 + CloudFront** architecture for lightning-fast global delivery
- **Production security** with CloudFront-only S3 access policies
- **Professional presentation** with business case and ROI analysis
- **7-week migration roadmap** costing less than two meals

**Business Impact:**
- 99.999999999% data durability vs. manual paper records
- Sub-100ms global load times via CloudFront edge locations
- $14/month vs. thousands in lost revenue from booking errors
- 60% cost reduction compared to traditional hosting

**Tech Stack:** Amazon S3, CloudFront, Route 53, IAM, HTML/CSS/JS

**Key Takeaway:** This project proved I can translate technical architecture into business value. The restaurant owner doesn't care about IAM policies—they care about eliminating double-bookings and recovering lost revenue.

[📂 View Project Details](./project_01_Highly_Available_Static_Website/)

---

### Project 02: Pet Shore - 3D E-Commerce Platform Architecture

  <img src="https://img.shields.io/badge/Status-Complete-success?style=flat-square">
  <img src="https://img.shields.io/badge/AWS-S3%20%7C%20CloudFront%20%7C%20EC2%20%7C%20RDS%20%7C%20DynamoDB-orange?style=flat-square">
  <img src="https://img.shields.io/badge/Focus-Multi--Tier%20Architecture-blue?style=flat-square">

**The Problem:** Designing cloud infrastructure for a 3D shopping platform where fast content delivery and surviving traffic spikes isn't optional—it's survival.

**The Solution:** Architected a production-grade 3-tier AWS application:
- **Content Delivery (CloudFront + S3)** for global 3D model caching at edge locations
- **Elastic Compute (EC2 + Auto Scaling + ALB)** that responds to demand automatically
- **Dual-Database Strategy (RDS + DynamoDB)** balancing consistency and speed
- **Multi-AZ architecture** engineered for failure scenarios

**Technical Impact:**
- 95% reduction in origin server load through edge caching
- 28 seconds to 3 seconds average load time for 50MB 3D models
- Auto Scaling eliminates 3 AM idle capacity costs
- Multi-AZ deployment survives entire data center failures

**Tech Stack:** Amazon S3, CloudFront, EC2, Auto Scaling, Application Load Balancer, RDS, DynamoDB, Route 53, VPC

**Key Takeaway:** Fast content delivery is non-negotiable for 3D applications. This project taught me how to design systems that handle unpredictable traffic, engineer for expected failures, and balance complexity vs. performance vs. cost.

[📂 View Project Details](./project_02_3D_Architecture/)

---

### Project 03: AWS Lex Bot (TBD)

  <img src="https://img.shields.io/badge/Status-In%20Development-yellow?style=flat-square">
  <img src="https://img.shields.io/badge/AWS-Lex%20%7C%20Lambda-orange?style=flat-square">
  <img src="https://img.shields.io/badge/Focus-Conversational%20AI-blue?style=flat-square">

**Status:** In Development

Building conversational AI solutions with AWS Lex. More details coming soon as the project progresses.

[📂 Project Folder](./project_03_AWS_Lex_Bot_(TBD)/)

---

## Project Structure

Each project follows a consistent structure for easy navigation:

```
Portfolio_Projects/
├── project_01_Highly_Available_Static_Website/
│   ├── assets/
│   │   └── screenshots/          # Visual documentation
│   ├── EMBERS-CO-presentation.pdf # Business case presentation
│   └── readme.md                  # Full project documentation
├── project_02_3D_Architecture/
│   ├── assets/
│   │   └── screenshots/          # Architecture diagrams
│   └── 3D-Architecture-Design.md # Design document
├── project_03_AWS_Lex_Bot_(TBD)/
│   └── [In Development]
└── README.md                      # This file
```

**Why This Structure Matters:**
- **Consistency** — Every project documented the same way
- **Professionalism** — Easy for hiring managers to navigate
- **Completeness** — Code, screenshots, presentations, and explanations
- **Real-world proof** — Not just code dumps, but full project lifecycle

---

## Skills Demonstrated

### 💎 Cloud Architecture

**What I'm Building:**
- Multi-tier AWS architectures with proper separation of concerns
- Serverless solutions that scale automatically
- High-availability patterns across multiple availability zones
- Cost-optimized infrastructure using the right service for each use case

**Projects Showcasing This:**
- **Ember & Co:** Serverless S3 + CloudFront architecture with zero server management
- **Pet Shore:** 3-tier architecture spanning presentation, application, and data layers
- **Coming:** Lambda-based serverless APIs and event-driven architectures

---

### 🏰 Security Engineering

**What I'm Implementing:**
- Zero-trust security models (S3 buckets locked to CloudFront only)
- IAM policies following principle of least privilege
- Defense-in-depth strategies with multiple security layers
- VPC isolation and network access control

**Projects Showcasing This:**
- **Ember & Co:** CloudFront Service Principal with SourceArn conditions
- **Pet Shore:** VPC isolation, private subnets, security groups for traffic control
- **Coming:** KMS encryption, WAF integration, secrets management

---

### 🗠 Systems Design & Trade-offs

**What I'm Analyzing:**
- Right-sizing resources to balance performance and cost
- Choosing appropriate database technologies (SQL vs. NoSQL)
- Understanding service trade-offs (complexity vs. performance vs. cost)
- Designing for constraints (bandwidth, budget, team size)

**Projects Showcasing This:**
- **Ember & Co:** S3 static hosting vs. EC2 web servers—storage cost optimization
- **Pet Shore:** RDS for consistency vs. DynamoDB for speed—dual-database rationale
- **Coming:** Lambda vs. EC2, Step Functions vs. custom orchestration

---

### 🎖️ Business Communication

**What I'm Delivering:**
- Technical solutions presented in business language
- ROI analysis and cost-benefit breakdowns
- Migration roadmaps with realistic timelines
- PowerPoint presentations for stakeholder buy-in

**Projects Showcasing This:**
- **Ember & Co:** Complete business case presentation with 7-week migration roadmap
- **Pet Shore:** Architecture decision records explaining trade-offs to non-technical stakeholders
- **Coming:** Technical proposals, architecture decision documents

---

### 🗲 Performance Optimization

**What I'm Optimizing:**
- Content delivery network configuration and edge caching strategies
- Database query performance tuning
- Auto Scaling policies for elastic workloads
- File compression and progressive loading patterns

**Projects Showcasing This:**
- **Ember & Co:** CloudFront edge caching for sub-100ms global load times
- **Pet Shore:** 28s to 3s load time improvement through CDN optimization and file compression
- **Coming:** Lambda cold start optimization, database indexing strategies

---

### 🏛️ High Availability & Disaster Recovery

**What I'm Engineering:**
- Multi-AZ deployments for fault tolerance
- Automatic failover configurations
- Data replication strategies
- Backup and recovery procedures

**Projects Showcasing This:**
- **Ember & Co:** S3 versioning for rollback capability
- **Pet Shore:** Multi-AZ architecture surviving entire data center failures
- **Coming:** Cross-region replication, disaster recovery runbooks

---

## What Makes These Projects Different

### 1. Real Business Problems

I'm not building "Deploy a static website to S3" tutorials. I'm solving actual business problems:
- Restaurant losing revenue from double-bookings
- E-commerce platform needing to handle 50MB 3D models without losing customers
- Organizations requiring secure, scalable infrastructure

### 2. Production-Ready Architecture

Every project follows AWS best practices:
- Security by design, not as an afterthought
- High availability and disaster recovery planning
- Cost optimization from day one
- Proper IAM permissions and encryption

### 3. Complete Documentation

Each project includes:
- Business problem definition
- Architecture diagrams and explanations
- Implementation steps with screenshots
- Security considerations and trade-off analysis
- What I learned and why it matters

### 4. Stakeholder Presentations

Technical skills alone don't land jobs. I'm proving I can:
- Present solutions to non-technical stakeholders
- Translate AWS services into business value
- Create professional presentations and proposals
- Document decisions for future teams

---

## The Bigger Picture

This portfolio is part of my **AWS Restart Journey**—a three-month focused program documenting my path to AWS Cloud Practitioner certification and beyond.

But I'm not just chasing a cert. I'm building **proof of work**:
- Hands-on projects demonstrating real cloud skills
- Architecture decisions explained in detail
- Business communication and presentation skills
- A portfolio that stands out from tutorial-following competitors

**The Questions These Projects Answer:**

For hiring managers:
- Can you architect AWS solutions? ✅ Yes, here's the 3-tier Pet Shore architecture
- Can you implement security? ✅ Yes, here's the CloudFront-only access policy
- Can you optimize for performance? ✅ Yes, here's the 28s to 3s load time improvement
- Can you present to stakeholders? ✅ Yes, here's the PowerPoint deck
- Can you document your work? ✅ Yes, here's the complete README with trade-off analysis

For me:
- Do I understand AWS services deeply? ✅ Yes, I can explain trade-offs
- Can I solve real business problems? ✅ Yes, here's the ROI analysis
- Am I ready for cloud engineering roles? ✅ Yes, here's the proof

---

## 🎗️ Project Roadmap

**Completed:**
- 💎 Ember & Co Static Website (S3, CloudFront, Route 53, IAM)
- 💎 Pet Shore 3D E-Commerce Architecture (Multi-tier design, Auto Scaling, Multi-AZ)

**In Progress:**
- 🔄 Project 03: AWS Lex Bot (Conversational AI)

**Planned:**
- 📃 Serverless API (Lambda, API Gateway, DynamoDB)
- 📃 Data pipeline (S3, Lambda, Glue, Athena)
- 📃 CI/CD pipeline (CodePipeline, CodeBuild, CodeDeploy)

Each project will demonstrate different AWS services and solve different business problems. The goal is a portfolio showcasing the full range of cloud engineering skills.

---

## 📜 Project Status

This is an **active learning portfolio**—projects are added as I complete them. Check back regularly for new AWS solutions.

**Current Focus:** Building hands-on projects that demonstrate production-ready AWS architecture skills, from serverless hosting to multi-tier applications to conversational AI.

**Commitment:** Hands-on work every week. Not just watching videos—actually building infrastructure, writing documentation, and solving real problems.

---

## 🤲 Let's Connect

If you're looking for someone who can build AWS infrastructure **and** explain why it matters to the business—let's talk.

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
  <img src="https://img.shields.io/badge/Portfolio-Active%20Development-success?style=flat-square">
  <img src="https://img.shields.io/badge/Projects-3%20Active-brightgreen?style=flat-square">
  <img src="https://img.shields.io/badge/Focus-Production%20Ready%20Solutions-blue?style=flat-square">
</p>

<p align="center">🛸 <strong>Built with AWS • Real Business Problems • Professional Documentation</strong> 🛸</p>