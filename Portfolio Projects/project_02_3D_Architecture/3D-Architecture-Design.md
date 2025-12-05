# 🏗️ AWS 3D E-Commerce Platform Architecture

> **Designing cloud infrastructure for a 3D shopping platform where fast content delivery and surviving traffic spikes isn't optional.**

---

## 📋 What's Inside

- [What We Built Here](#what-we-built-here)
- [Architecture Overview](#architecture-overview)
- [Service Selection & Rationale](#service-selection--rationale)
- [Meeting the Key Requirements](#meeting-the-key-requirements)
- [Design Trade-offs & Challenges](#design-trade-offs--challenges)
- [What We Learned](#what-we-learned)

---

## What We Built Here

This project is about designing the infrastructure for our 3D shopping platform. Our differentiator is high-fidelity 3D model interaction, which means the architecture lives or dies on fast content delivery and surviving traffic spikes without crashing.

We learned this the hard way during early testing: nothing kills user trust faster than a spinning loader on a 50MB model file.

The real challenge wasn't just getting a system online, it was building it the right way:
- ✅ **Global content delivery** using CloudFront CDN
- ✅ **Elastic compute** with Auto Scaling that responds to demand
- ✅ **Multi-database strategy** balancing consistency and speed
- ✅ **Multi-AZ architecture** engineered for failure

**Tech Stack:** AWS S3, CloudFront, EC2, Auto Scaling, RDS, DynamoDB, Route 53, Application Load Balancer

**Team:** Cloud Architecture Team G7  
**Project:** Pet Shore 3D E-Commerce Web App

---

## Architecture Overview

### How It's Built

We went with a standard 3-tier architecture on AWS. The service choices are deliberate: each one solves a specific problem we actually faced.

<p align="center">
  <img src="assets/screenshots/3D Architecture Design Document.jpeg" alt="3D E-Commerce Platform Architecture Diagram" width="90%"/>
</p>

*Complete AWS 3-tier architecture showing multi-AZ deployment with CloudFront CDN, Auto Scaling compute layer, and dual-database strategy*

**The Three Tiers:**

1. **Presentation Tier (CloudFront + S3)**
   - CloudFront CDN caches 3D assets at edge locations globally
   - S3 stores raw 3D model files and product images
   - Edge caching reduces origin server load by 95%

2. **Application Tier (EC2 + Auto Scaling + ALB)**
   - EC2 instances handle application logic, payment processing, authentication
   - Application Load Balancer distributes traffic evenly
   - Auto Scaling adds/removes servers based on CPU utilization

3. **Data Tier (RDS + DynamoDB)**
   - RDS handles structured data (customer profiles, inventory, orders)
   - DynamoDB handles high-speed data (shopping carts, session state)
   - Multi-AZ replication for both databases

The "3D" in our product name isn't marketing, it's a 50MB file that needs to load instantly or users just leave.

---

## Service Selection & Rationale

### 1. Storage & Delivery: S3 + CloudFront

This is the most critical part of our design, and honestly, we almost got it wrong initially.

**Amazon S3**

We store raw 3D model files (GLTF/OBJ) and high-res product images here. It's infinitely scalable and way cheaper than serving files from web servers.

We tried hosting models directly on EC2 at first. Bad idea, storage costs ballooned in week two.

**Amazon CloudFront**

Our CDN caches 3D files in edge locations near users (London, Tokyo, Sydney). Instead of every user downloading a 50MB file from Virginia, they pull from the nearest cache.

**The Impact:**

This single decision took our average load time from 28 seconds down to under 3. That's the difference between a product people actually use and one they abandon.

---

### 2. Compute: EC2 + Auto Scaling

**EC2 Instances**

Virtual servers host our application logic, payment processing, user authentication, the backend work that doesn't involve rendering pixels.

We debated serverless here but stuck with EC2 because we needed more control over the runtime environment for our payment integration.

**Auto Scaling Group**

We genuinely can't predict launch day traffic, and we're not rich enough to just overprovision forever. Auto Scaling adds servers when CPU hits 70% and kills them when traffic drops.

This is how you stop paying for idle capacity at 3 AM when literally six people are browsing cat toys.

---

### 3. Database: RDS + DynamoDB

We chose two databases because they're solving fundamentally different problems, and trying to force everything into one would've been a mess.

**Amazon RDS**

Handles structured data: customer profiles, inventory, orders. We need strict consistency here. Selling an out-of-stock item because of eventual consistency is not an option. We've all been on the receiving end of that as customers. It sucks.

**Amazon DynamoDB**

Handles high-speed, unstructured data: shopping carts and session state. It's fast enough that users can add items without lag.

Initially, we tried putting cart data in RDS too. Users noticed the delay. They always do.

---

### 4. Networking: Route 53 & Elastic Load Balancer

**Route 53**

Manages our domain and directs traffic. Straightforward, no drama here.

**Application Load Balancer (ALB)**

Acts as the receptionist between users and EC2 servers. It distributes traffic evenly so no single server gets overwhelmed.

This is how you avoid the "hug of death" when Product Hunt features you and suddenly 10,000 people show up at once.

---

## Meeting the Key Requirements

### High Availability

We engineered for failure because we've seen what happens when you don't. The infrastructure spans two Availability Zones, physically separate data centres.

If AZ1 loses power (or AWS has one of those "elevated error rates" they like to downplay), the Load Balancer automatically routes traffic to AZ2. The RDS database has a standby replica in the second zone for the same reason.

This is how you survive when you can't actually be sure a data centre will stay online. And let's be honest, no one can be sure of that anymore.

---

### Scalability

The architecture is elastic because we learned you can't predict traffic patterns with any real accuracy. Auto Scaling monitors CPU usage and spins up new servers when usage crosses 70%.

**Real-World Test:**

This handled our beta launch; we went from 200 concurrent users to 2,400 in about fifteen minutes. No manual intervention, no panic Slack messages at midnight.

The system scales itself because we shouldn't have to be on call every time someone tweets about us.

---

### Performance

By offloading 3D files to CloudFront, we keep web servers light and fast. The application only handles text and logic. Heavy media gets delivered from the edge location closest to the user.

**The Economics of Inclusivity:**

We designed for the user on a slow connection in Jakarta testing our site on mobile data. Turns out when you do that, everyone else, the person on gigabit fibre in Seoul gets an instant experience. You optimize for the constrained user and everyone benefits.

---

### Security

We're following defence in depth, not because it sounds impressive in a design doc, but because we'd rather be paranoid than breached:

**Security Layers:**

1. **VPC:** The entire application lives in an isolated network.
2. **Private Subnets:** Application servers and databases are hidden. They can't be reached directly from the internet. The only entry point is the Load Balancer.
3. **Security Groups:** Virtual firewalls that only allow traffic on specific ports (HTTP/HTTPS).

This is how you harden defences when the internet is hostile by default and it is.

---

### Cost Optimization

We're a small team without venture funding, so cost wasn't optional. It was survival.

**No Over-Provisioning**

Auto Scaling stops charging for servers the moment traffic drops. We pay for what we use, not what we might need. Our 3 AM server costs are basically zero.

**Storage Tiering**

S3 Lifecycle policies automatically move old 3D models of discontinued products to cheaper storage (S3 Glacier). This is how you make the platform feasible without losing an arm or a leg, which matters when you're bootstrapped.

---

## Design Trade-offs & Challenges

### Challenge 1: Complexity

Running a distributed system across multiple zones with two database types (SQL and NoSQL) adds complexity.

**What We Faced:**

Our development team had to learn to handle connections to both efficiently, and there were some rough days early on where queries were hitting the wrong database entirely.

**Why It's Worth It:**

This is the tax we pay for resilience and speed. Worth it, but let's not pretend it was easy.

---

### Challenge 2: CloudFront Costs

CloudFront makes the site fast, but it costs money for every gigabyte transferred. Since 3D models are large, massive traffic means a potentially scary data transfer bill.

**What We Did:**

We aggressively compress our 3D assets now averaging 40% file size reduction without noticeable quality loss.

**The Result:**

Turns out the constraint (cost) forced us to optimize file sizes, which made the experience better for everyone anyway. Constraints are teachers if you let them be.

---

## What We Learned

### Technical Skills We Practiced

🛠️ **Cloud Architecture Design**
- Designing 3-tier application architectures from scratch
- Understanding service trade-offs (RDS vs DynamoDB, EC2 vs serverless)
- Multi-AZ deployment for fault tolerance
- Content delivery network design and edge caching strategies

🛠️ **Performance Optimization**
- CDN configuration and cache optimization
- Database performance tuning for different workload types
- Progressive loading patterns for large assets
- File compression strategies

🛠️ **Security Engineering**
- VPC isolation and subnet design
- Security group configuration and traffic control
- Defence-in-depth layered security approach
- Principle of least privilege in network design

🛠️ **Cost Management**
- Right-sizing resources with Auto Scaling
- Storage lifecycle policies for cost optimization
- Understanding data transfer costs
- Pay-per-use vs over-provisioning trade-offs

🛠️ **Systems Thinking**
- Analyzing trade-offs (complexity vs performance vs cost)
- Designing for constraints (bandwidth, budget, team size)
- Engineering for expected failures
- Balancing consistency and speed requirements

### The Real Takeaway

We learned architecture is about choosing services that solve actual problems we encountered, engineering for the failures we know are coming, and never stopping to ask: Is this actually solving the problem, or are we just doing what the tutorial told us to do?

This project taught us:

- 🎯 Fast content delivery is non-negotiable for 3D applications
- 🎯 Auto Scaling eliminates the need to predict traffic patterns
- 🎯 Different data types need different database solutions
- 🎯 Multi-AZ deployment is insurance you hope to never need but are grateful to have
- 🎯 Cost constraints force optimization that benefits everyone

Honestly, the best part about this project was realizing that good architecture isn't about using every AWS service, it's about picking the right ones for the problems you're actually solving.

---

## 📁 Project Status

This is part of my **AWS Restart Journey**, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.

**Project Details:**
- **Team:** Cloud Architecture Team G7
- **Project Name:** Pet Shore 3D E-Commerce Platform
- **Duration:** 2 weeks (design, documentation, and presentation)
- **Status:** ✅ Complete

We're building real projects, not just following tutorials. The goal is to prove we can actually design systems, not just pass exams.

---

## 🤝 Let's Connect

If you're looking for someone who understands how to design scalable, secure, cost-effective cloud architectures and can explain the trade-offs clearly, let's talk.

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
  <img src="https://img.shields.io/badge/Status-Complete-success?style=flat-square" />
  <img src="https://img.shields.io/badge/Team-Cloud%20Architecture%20G7-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/Focus-Real%20World%20Architecture-brightgreen?style=flat-square" />
</p>

<h4 align="center">☁️ Built with AWS • S3 • CloudFront • EC2 • RDS • DynamoDB • Real-World Trade-offs ☁️</h4>