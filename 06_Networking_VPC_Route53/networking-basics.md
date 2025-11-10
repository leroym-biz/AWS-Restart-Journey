\# 🌐 AWS Networking Basics: VPC, Subnets, and IP Addressing



> \*\*Understanding how networks work in AWS—the invisible infrastructure that makes everything connect.\*\*



---



\## 📋 What's Inside



\- \[What I Built Here](#what-i-built-here)

\- \[Architecture Overview](#architecture-overview)

\- \[Core Networking Concepts](#core-networking-concepts)

\- \[What I Learned](#what-i-learned)



---



\## What I Built Here



These labs covered the fundamentals of AWS networking—how IP addresses work, the difference between public and private networks, and how to configure VPCs and subnets.



This stuff might seem dry at first, but it's critical. If you don't understand networking, you can't secure your infrastructure properly.



I focused on:  

✅ \*\*Understanding public vs. private IP addresses\*\* and when to use each  

✅ \*\*Configuring VPCs and subnets\*\* for network isolation  

✅ \*\*Working with static and dynamic IP assignment\*\* (Elastic IPs)  

✅ \*\*Setting up Internet Gateways\*\* for public connectivity  

✅ \*\*Using Route Tables\*\* to control traffic flow



\*\*Tech Stack:\*\* AWS VPC, EC2, Internet Gateway, Route 53, Elastic IPs



---



\## Architecture Overview



\### How AWS Networking Works



AWS networking is built on the concept of \*\*Virtual Private Clouds (VPCs)\*\*—your own isolated network environment in the cloud.



Inside a VPC, you create \*\*subnets\*\* (smaller network segments) that can be either:

\- \*\*Public subnets\*\* — Connected to the internet via an Internet Gateway

\- \*\*Private subnets\*\* — Isolated from the internet for security



\*\*The Key Pieces:\*\*

\- \*\*VPC (Virtual Private Cloud)\*\* — Your isolated network space

\- \*\*Subnets\*\* — Network segments within your VPC (public or private)

\- \*\*Internet Gateway\*\* — Connects your VPC to the public internet

\- \*\*Route Tables\*\* — Define where network traffic goes

\- \*\*Security Groups\*\* — Virtual firewalls controlling access



This architecture is the foundation for everything you build in AWS. Get this wrong and nothing else works.



---



\## Core Networking Concepts



\### 1️⃣ Public vs. Private IP Addresses



Understanding the difference between public and private IPs is essential for designing secure architectures.



| IP Type | Purpose | Example Range | Use Case |

|---------|---------|---------------|----------|

| \*\*Private IP\*\* | Internal communication within VPC | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` | Database servers, application servers that don't need direct internet access |

| \*\*Public IP\*\* | Internet-facing resources | Any non-private IP | Web servers, load balancers, NAT gateways |



\*\*Private IP Ranges (RFC 1918):\*\*

```

10.0.0.0 - 10.255.255.255     (10.0.0.0/8)

172.16.0.0 - 172.31.255.255   (172.16.0.0/12)

192.168.0.0 - 192.168.255.255 (192.168.0.0/16)

```



\*\*Key Principle:\*\* Private IPs can't be routed over the internet. They're for internal communication only.



\#### Real-World Example



\*\*Bad Architecture:\*\*

\- Database server with a public IP directly exposed to the internet ❌



\*\*Good Architecture:\*\*

\- Database server with private IP only, accessed via application servers in public subnet ✅



---



\### 2️⃣ Static vs. Dynamic IP Assignment



AWS gives you two options for IP assignment:



| Assignment Type | How It Works | When to Use |

|----------------|--------------|-------------|

| \*\*Dynamic (Default)\*\* | AWS assigns IP from available pool when instance starts | Most EC2 instances, development environments |

| \*\*Static (Elastic IP)\*\* | You allocate a fixed IP that persists across restarts | Web servers, DNS records, production resources |



\#### Working with Elastic IPs



```bash

\# Elastic IPs remain associated with your account until you release them

\# Even if the EC2 instance is stopped or terminated



\# Key characteristics:

\- Persistent across instance stops/starts

\- Can be reassigned to different instances

\- Charged when NOT associated with a running instance (to prevent waste)

```



\*\*Use Case:\*\* You're running a web server at `52.10.45.78`. Without an Elastic IP, that address changes every time you stop/start the instance. With an Elastic IP, it stays the same.



---



\### 3️⃣ VPC and Subnet Configuration



A VPC is your isolated network in AWS. You define the IP address range using \*\*CIDR notation\*\*.



\#### CIDR Block Examples



| CIDR Block | Total IPs | Usable IPs | Use Case |

|------------|-----------|------------|----------|

| `10.0.0.0/16` | 65,536 | 65,531 | Large VPC for enterprise applications |

| `10.0.1.0/24` | 256 | 251 | Standard subnet for a single tier |

| `10.0.2.0/28` | 16 | 11 | Small subnet for NAT gateways or bastion hosts |



\*\*Note:\*\* AWS reserves 5 IPs in every subnet:

\- First IP (network address)

\- Second IP (VPC router)

\- Third IP (DNS server)

\- Fourth IP (reserved for future use)

\- Last IP (broadcast address)



\#### Creating Subnets



When you create a subnet, you need to decide:



1\. \*\*CIDR block\*\* — What range of IPs does this subnet use?

2\. \*\*Availability Zone\*\* — Which AZ does this subnet live in?

3\. \*\*Public or Private\*\* — Does it need internet access?



\*\*Example Subnet Design:\*\*

```

VPC: 10.0.0.0/16



Public Subnet (Web Tier):

\- CIDR: 10.0.1.0/24

\- AZ: us-east-1a

\- Route: 0.0.0.0/0 → Internet Gateway



Private Subnet (Database Tier):

\- CIDR: 10.0.2.0/24

\- AZ: us-east-1a

\- Route: No direct internet access

```



---



\### 4️⃣ Internet Gateway and Route Tables



An \*\*Internet Gateway (IGW)\*\* is what connects your VPC to the public internet.



\#### How It Works



1\. \*\*Attach IGW to VPC\*\* — Creates the connection point

2\. \*\*Update Route Table\*\* — Add route `0.0.0.0/0` pointing to IGW

3\. \*\*Assign Public IP\*\* — EC2 instances need public IPs to communicate outbound



\#### Route Table Configuration



Route tables control where network traffic goes.



\*\*Public Subnet Route Table:\*\*

| Destination | Target | Purpose |

|-------------|--------|---------|

| `10.0.0.0/16` | local | Internal VPC traffic stays inside VPC |

| `0.0.0.0/0` | igw-xxxxx | Everything else goes to the internet |



\*\*Private Subnet Route Table:\*\*

| Destination | Target | Purpose |

|-------------|--------|---------|

| `10.0.0.0/16` | local | Internal VPC traffic only |



\*\*Key Point:\*\* Private subnets don't have a route to the Internet Gateway. That's what makes them private.



---



\### 5️⃣ Security Groups



Security Groups act as virtual firewalls for your EC2 instances.



\#### Inbound Rules Example (Web Server)



| Type | Protocol | Port | Source | Description |

|------|----------|------|--------|-------------|

| HTTP | TCP | 80 | 0.0.0.0/0 | Allow public web traffic |

| HTTPS | TCP | 443 | 0.0.0.0/0 | Allow secure web traffic |

| SSH | TCP | 22 | My IP | Admin access only |



\#### Outbound Rules (Default)



| Type | Protocol | Port | Destination | Description |

|------|----------|------|-------------|-------------|

| All traffic | All | All | 0.0.0.0/0 | Allow all outbound |



\*\*Security Groups are stateful:\*\* If you allow inbound traffic, the response is automatically allowed back out.



---



\## What I Learned



\### Technical Skills I Practiced



🛠️ \*\*Network Design\*\*

\- Understanding VPC architecture and subnet design

\- Knowing when to use public vs. private subnets

\- Planning IP address ranges using CIDR notation



🛠️ \*\*IP Address Management\*\*

\- Working with private and public IPs

\- Allocating and managing Elastic IPs

\- Understanding the difference between static and dynamic assignment



🛠️ \*\*Routing and Connectivity\*\*

\- Configuring Internet Gateways for public access

\- Setting up Route Tables to control traffic flow

\- Understanding how AWS routes traffic between subnets



🛠️ \*\*Security Best Practices\*\*

\- Using private subnets for sensitive resources

\- Implementing Security Groups as virtual firewalls

\- Following the principle of least privilege for network access



\### The Real Takeaway



Networking was honestly one of the harder concepts to wrap my head around at first. It's not flashy—there's no UI to look at, no visible output.



But once it clicked, I realized this is the foundation everything else is built on:



\- 🎯 \*\*Security depends on network isolation\*\* — private subnets protect databases

\- 🎯 \*\*High availability requires multi-AZ design\*\* — subnets in different zones

\- 🎯 \*\*Cost optimization starts with architecture\*\* — NAT gateways vs. public IPs

\- 🎯 \*\*Troubleshooting becomes easier\*\* — understanding traffic flow helps debug issues



You can't just spin up EC2 instances and hope they work together. You need to understand how they communicate.



---



\## 📝 Project Status



This is part of my \*\*AWS Restart Journey\*\*, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.



I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.



---



\## 🤝 Let's Connect



If you're looking for someone who's serious about learning AWS the right way—hands-on, documented, and grounded in real-world architecture—let's talk.



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

&nbsp; <img src="https://img.shields.io/badge/Status-Active%20Learning-success?style=flat-square" />

&nbsp; <img src="https://img.shields.io/badge/Commitment-Hands%20On%20Every%20Week-brightgreen?style=flat-square" />

</p>



<h4 align="center">🌐 Built with AWS VPC • Route 53 • Internet Gateway • Real-World Scenarios 🌐</h4>

