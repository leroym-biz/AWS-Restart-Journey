# 🌐 AWS Networking Basics: VPC, Subnets, and IP Addressing

> **Understanding how networks work in AWS—the invisible infrastructure that makes everything connect.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Architecture Overview](#architecture-overview)
- [Network Configuration Details](#network-configuration-details)
- [What I Learned](#what-i-learned)

---

## What I Built Here

These labs covered the fundamentals of AWS networking—how IP addresses work, the difference between public and private networks, and how to configure VPCs and subnets.

This stuff might seem dry at first, but it's critical. If you don't understand networking, you can't secure your infrastructure properly.

The real point here wasn't just learning definitions—it was understanding how to design secure, isolated networks:  
✅ **Public vs. private IP addressing** and when to use each  
✅ **Static vs. dynamic IP assignment** with Elastic IPs  
✅ **VPC and subnet design** for network isolation  
✅ **Internet Gateway configuration** for public connectivity  
✅ **Route Table management** to control traffic flow

**Tech Stack:** AWS VPC, EC2, Internet Gateway, Route 53, Elastic IPs

---

## Architecture Overview

### How It's Built

AWS networking is built on the concept of **Virtual Private Clouds (VPCs)**—your own isolated network environment in the cloud.

Inside a VPC, you create **subnets** (smaller network segments) that can be either public (internet-facing) or private (isolated). This setup follows the kind of defense-in-depth security patterns you see in production environments.

**The Key Pieces:**
- **VPC (Virtual Private Cloud)** — Your isolated network space in AWS
- **Subnets** — Network segments within your VPC (public or private)
- **Internet Gateway** — Connects your VPC to the public internet
- **Route Tables** — Define where network traffic goes
- **Security Groups** — Virtual firewalls controlling instance access

Honestly, getting comfortable with this architecture is half the battle when you're learning AWS networking.

---

## Network Configuration Details

### Instance Specifications

| Component | Configuration | Rationale |
|-----------|--------------|-----------|
| **VPC CIDR** | 10.0.0.0/16 | Provides 65,536 IP addresses for growth and flexibility |
| **Public Subnet** | 10.0.1.0/24 | 256 IPs for internet-facing resources (web servers, load balancers) |
| **Private Subnet** | 10.0.2.0/24 | 256 IPs for internal resources (databases, application servers) |
| **Availability Zone** | User-selected | Enables high availability and disaster recovery strategies |

**Note:** AWS reserves 5 IPs in every subnet (network address, VPC router, DNS, future use, broadcast).

### Public vs. Private IP Addresses

Understanding the difference between public and private IPs is essential for designing secure architectures.

| IP Type | Purpose | Example Range | Use Case |
|---------|---------|---------------|----------|
| **Private IP** | Internal VPC communication | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | Database servers, app servers without direct internet access |
| **Public IP** | Internet-facing resources | Any non-private IP | Web servers, load balancers, NAT gateways |

**Private IP Ranges (RFC 1918):**
```
10.0.0.0 - 10.255.255.255     (10.0.0.0/8)
172.16.0.0 - 172.31.255.255   (172.16.0.0/12)
192.168.0.0 - 192.168.255.255 (192.168.0.0/16)
```

**Security Best Practices Applied:**
- 🔒 Private subnets for sensitive resources (databases)
- 🔒 Public subnets only for resources that need internet access
- 🔒 No direct internet routes to private subnets
- 🔒 Security Groups controlling all inbound/outbound traffic

The key principle: private IPs can't be routed over the internet. They're for internal communication only.

---

### Static vs. Dynamic IP Assignment

AWS gives you two options for IP assignment:

| Assignment Type | How It Works | When to Use |
|----------------|--------------|-------------|
| **Dynamic (Default)** | AWS assigns IP from available pool when instance starts | Most EC2 instances, development environments |
| **Static (Elastic IP)** | You allocate a fixed IP that persists across restarts | Web servers, DNS records, production resources |

#### Working with Elastic IPs

```bash
# Elastic IPs remain associated with your account until you release them
# Even if the EC2 instance is stopped or terminated

# Key characteristics:
- Persistent across instance stops/starts
- Can be reassigned to different instances
- Charged when NOT associated with a running instance (to prevent waste)
- One Elastic IP per instance by default
```

**Benefits:**
- ⚡ **Persistent addressing** — Your server keeps the same IP
- ⚡ **Failover capability** — Quickly reassign to a standby instance
- ⚡ **DNS stability** — No need to update DNS records after restarts

**Use Case:** You're running a web server at `52.10.45.78`. Without an Elastic IP, that address changes every time you stop/start the instance. With an Elastic IP, it stays the same—your DNS records never break.

---

### Internet Gateway and Route Tables

An **Internet Gateway (IGW)** is what connects your VPC to the public internet.

#### Configuration Steps

1. **Attach IGW to VPC** — Creates the connection point
2. **Update Route Table** — Add route `0.0.0.0/0` pointing to IGW
3. **Assign Public IP** — EC2 instances need public IPs to communicate outbound

#### Route Table Configuration

Route tables control where network traffic goes. Get this wrong and nothing works.

**Public Subnet Route Table:**
| Destination | Target | Purpose |
|-------------|--------|---------|
| `10.0.0.0/16` | local | Internal VPC traffic stays inside VPC |
| `0.0.0.0/0` | igw-xxxxx | Everything else goes to the internet |

**Private Subnet Route Table:**
| Destination | Target | Purpose |
|-------------|--------|---------|
| `10.0.0.0/16` | local | Internal VPC traffic only—no internet route |

**Key Point:** Private subnets don't have a route to the Internet Gateway. That's what makes them private. This is how you protect databases and internal services from direct internet exposure.

---

### Security Group Configuration

Security Groups act as virtual firewalls for your EC2 instances.

#### Inbound Rules (Web Server Example)

| Type | Protocol | Port | Source | Description |
|------|----------|------|--------|-------------|
| HTTP | TCP | 80 | 0.0.0.0/0 | Allow public web traffic |
| HTTPS | TCP | 443 | 0.0.0.0/0 | Allow secure web traffic |
| SSH | TCP | 22 | My IP | Admin access only from known IP |

#### Outbound Rules (Default)

| Type | Protocol | Port | Destination | Description |
|------|----------|------|-------------|-------------|
| All traffic | All | All | 0.0.0.0/0 | Allow all outbound connections |

**Security Groups are stateful:** If you allow inbound traffic on port 80, the response is automatically allowed back out. You don't need to create a separate outbound rule.

---

### CIDR Block Examples

Understanding CIDR notation is essential for planning your network.

| CIDR Block | Total IPs | Usable IPs | Common Use Case |
|------------|-----------|------------|-----------------|
| `10.0.0.0/16` | 65,536 | 65,531 | Large VPC for enterprise applications |
| `10.0.1.0/24` | 256 | 251 | Standard subnet for a single tier (web/app/db) |
| `10.0.2.0/28` | 16 | 11 | Small subnet for NAT gateways or bastion hosts |

**Planning Tips:**
- Start with a large VPC CIDR (like /16) to allow for growth
- Use /24 subnets for most application tiers
- Reserve smaller subnets (/28, /29) for infrastructure components

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Network Design**
- Understanding VPC architecture and subnet design
- Knowing when to use public vs. private subnets
- Planning IP address ranges using CIDR notation
- Designing for high availability across multiple AZs

🛠️ **IP Address Management**
- Working with private and public IPs
- Allocating and managing Elastic IPs
- Understanding the difference between static and dynamic assignment
- Avoiding IP address conflicts

🛠️ **Routing and Connectivity**
- Configuring Internet Gateways for public access
- Setting up Route Tables to control traffic flow
- Understanding how AWS routes traffic between subnets
- Troubleshooting connectivity issues

🛠️ **Security Best Practices**
- Using private subnets for sensitive resources
- Implementing Security Groups as virtual firewalls
- Following the principle of least privilege for network access
- Preventing direct internet exposure for databases

### The Real Takeaway

Networking was honestly one of the harder concepts to wrap my head around at first. It's not flashy—there's no UI to look at, no visible output. Just IP addresses and routing rules.

But once it clicked, I realized this is the foundation everything else is built on:

- 🎯 **Security depends on network isolation** — private subnets protect databases from direct internet access
- 🎯 **High availability requires multi-AZ design** — subnets distributed across availability zones
- 🎯 **Cost optimization starts with architecture** — choosing between NAT gateways vs. public IPs
- 🎯 **Troubleshooting becomes easier** — understanding traffic flow helps you debug connection issues
- 🎯 **Compliance requirements need proper segmentation** — keeping PCI/HIPAA data in isolated subnets

You can't just spin up EC2 instances and hope they work together. You need to understand how they communicate, what can reach what, and why.

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
  <a href="https://github.com/leroym-biz/AWS-restart-journey" target="_blank">
    <img src="https://img.shields.io/badge/View%20Repository-black?style=for-the-badge&logo=github" />
  </a>
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Status-Active%20Learning-success?style=flat-square" />
  <img src="https://img.shields.io/badge/Commitment-Hands%20On%20Every%20Week-brightgreen?style=flat-square" />
</p>

<h4 align="center">🌐 Built with AWS VPC • Route 53 • Internet Gateway • Real-World Scenarios 🌐</h4>
