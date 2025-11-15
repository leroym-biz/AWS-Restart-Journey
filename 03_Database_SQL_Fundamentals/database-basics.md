# 🗄️ AWS Database Fundamentals: SQL and NoSQL Services

> **Understanding databases in AWS—from relational to NoSQL, and when to use each one.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Database Types Overview](#database-types-overview)
- [AWS Database Services](#aws-database-services)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab covered the fundamentals of databases—what they are, how they're structured, and which AWS service to use for different use cases.

Databases aren't the flashiest part of cloud architecture, but they're arguably the most important. Get your database choice wrong and you'll pay for it in performance, cost, or both.

The real point here wasn't just memorizing service names—it was understanding the trade-offs:  
✅ **SQL vs. NoSQL** and when to use each  
✅ **AWS database services** and their specific use cases  
✅ **Matching workload requirements** to the right database type  
✅ **Understanding cost and performance implications** of each choice

**Tech Stack:** AWS RDS, DynamoDB, Redshift, ElastiCache

---

## Database Types Overview

### How It's Built

A database is a **data store that stores semi-structured and structured data**. It's more complex than a simple file system because it requires formal design and modeling techniques.

**The Key Pieces:**
- **Relational databases** — Structured data in tables (rows and columns)
- **Non-Relational databases** — Semi-structured data with flexible schema
- **Data warehouses** — Column-oriented storage for analytics
- **Caching layers** — In-memory storage for performance

Honestly, getting comfortable with when to use each type is half the battle when designing cloud architectures.

---

## AWS Database Services

### Database Configuration Comparison

| Database Type | Structure | AWS Service | Common Use Case |
|---------------|-----------|-------------|-----------------|
| **Relational (SQL)** | Structured tables | RDS, Aurora | E-commerce, financial systems, CRM |
| **Key-Value (NoSQL)** | Simple key-value pairs | DynamoDB | Session data, shopping carts, user profiles |
| **Document (NoSQL)** | JSON-like documents | DocumentDB | Content management, catalogs |
| **Data Warehouse** | Column-oriented | Redshift | Business intelligence, analytics, reporting |
| **In-Memory Cache** | Cached data | ElastiCache | Performance boost, reduce DB load |

### 1️⃣ Amazon RDS (Relational Database Service)

**What it is:**  
Managed relational database service supporting multiple SQL engines. This is the most commonly used database type among tech companies.

| Engine | Description | Rationale |
|--------|-------------|-----------|
| **MySQL** | Popular open-source SQL database | General-purpose web applications, cost-effective |
| **PostgreSQL** | Developer-favorite open-source SQL | Complex queries, rich features, JSON support |
| **MariaDB** | MySQL fork with open-source licensing | Drop-in MySQL replacement without Oracle licensing |
| **Aurora** | AWS-optimized (5x faster MySQL, 3x faster PostgreSQL) | High availability, performance, automatic scaling |
| **Oracle** | Enterprise SQL database | Large enterprises, legacy systems (requires license) |
| **SQL Server** | Microsoft's SQL database | Windows/.NET environments (requires license) |

**Aurora Serverless:**  
On-demand version of Aurora that handles cold-starts and scales automatically. Best for infrequent or unpredictable workloads.

**Security Best Practices Applied:**
- 🔒 Deploy in private subnets for database tier
- 🔒 Use Security Groups to restrict access to application tier only
- 🔒 Enable encryption at rest using KMS
- 🔒 Automated backups with point-in-time recovery

**When to use RDS:**
```bash
# Use RDS when you need:
✓ ACID compliance (data integrity)
✓ Structured data with relationships
✓ Complex queries with JOINs
✓ Traditional applications
```

The key principle: RDS is managed infrastructure—AWS handles patching, backups, and high availability, but you still choose instance types and storage.

---

### 2️⃣ Amazon DynamoDB (NoSQL Key-Value Store)

**What it is:**  
Serverless NoSQL database designed to scale to billions of records with guaranteed sub-second data retrieval.

| Feature | Configuration | Rationale |
|---------|---------------|-----------|
| **Scalability** | Automatic | Scales to billions of records without manual intervention |
| **Performance** | Single-digit millisecond latency | Consistent performance regardless of scale |
| **Management** | Fully serverless | No infrastructure to manage, no capacity planning |
| **Pricing** | Pay per request or provisioned capacity | Cost-effective for variable or massive workloads |

**Real-world proof:**  
In 2019, Amazon migrated 7,500 Oracle databases (75 petabytes) to DynamoDB. Result: **60% cost reduction** and **40% latency improvement**.

**Benefits:**
- ⚡ **Serverless** — No instances to manage
- ⚡ **Automatic scaling** — Handles traffic spikes without configuration
- ⚡ **Built-in security** — Encryption at rest, IAM integration
- ⚡ **Global tables** — Multi-region replication for low latency

**Trade-off:** DynamoDB is fast and scalable but lacks the query flexibility of SQL. No complex JOINs or aggregations. You need to design your data model carefully.

---

### 3️⃣ Amazon Redshift (Data Warehouse)

**What it is:**  
Petabyte-scale data warehouse designed for analytics and business intelligence workloads.

| Characteristic | Details | Purpose |
|----------------|---------|---------|
| **Storage Type** | Column-oriented | Optimized for analytics queries (aggregations) |
| **Data Volume** | Terabytes to petabytes | Handles massive datasets for reporting |
| **Query Pattern** | Infrequent, complex queries | Accessed once or twice daily/weekly for BI reports |
| **Performance** | Fast aggregations | Returns results quickly even on millions of rows |

**When to use Redshift:**
```bash
# Use Redshift when you need:
✓ Business intelligence and analytics
✓ Fast aggregations (SUM, AVG, GROUP BY)
✓ Consolidating data from multiple sources
✓ Historical data analysis and reporting
```

**Trade-off:** Redshift is powerful for analytics but overkill for transactional workloads. Use RDS or DynamoDB for day-to-day transactions.

---

### 4️⃣ Amazon ElastiCache (In-Memory Cache)

**What it is:**  
Managed in-memory caching using Redis or Memcached.

| Engine | Use Case | Rationale |
|--------|----------|-----------|
| **Redis** | Complex data structures, pub/sub, persistence | Advanced features, data durability |
| **Memcached** | Simple caching, distributed memory | Simple, fast, easy to scale horizontally |

**Common Architecture Pattern:**
```
User Request → Application Server → Check ElastiCache
                                    ↓
                              Cache Hit? Return data
                                    ↓
                              Cache Miss? Query Database → Cache result → Return data
```

**Benefits:**
- ⚡ **Sub-millisecond response times**
- ⚡ **Reduces database load** by 70-90% for read-heavy workloads
- ⚡ **Cost savings** by reducing database instance sizes

**When to use ElastiCache:**
```bash
# Use ElastiCache when you need:
✓ Improve application performance
✓ Reduce database load
✓ Cache frequently accessed data
✓ Session storage for stateless applications
```

---

### 5️⃣ Other Database Services

| Service | Type | When To Use |
|---------|------|-------------|
| **DocumentDB** | Document store (MongoDB-compatible) | JSON-like documents, flexible schema |
| **Neptune** | Graph database | Social networks, fraud detection, recommendations |
| **Timestreams** | Time-series | IoT data, metrics, logs over time |
| **Keyspaces** | Wide-column (Cassandra-compatible) | Apache Cassandra workloads |

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Database Selection**
- Understanding when to use SQL vs. NoSQL
- Matching database type to workload requirements
- Recognizing performance vs. flexibility trade-offs
- Designing for scalability and cost optimization

🛠️ **AWS Service Knowledge**
- Knowing the core database services and their strengths
- Understanding managed vs. serverless options
- Choosing the right engine for specific use cases
- Implementing caching layers for performance

🛠️ **Architecture Design**
- Using private subnets for database security
- Implementing multi-tier architectures
- Balancing cost, performance, and scalability
- Planning for high availability and disaster recovery

### The Real Takeaway

Honestly, databases were one of those topics I thought would be straightforward—just pick RDS and move on, right? Wrong.

The more I learned, the more I realized there's no one-size-fits-all database:

- 🎯 **RDS is great for traditional apps** — ACID compliance, complex queries, relationships
- 🎯 **DynamoDB is fast and scalable** — serverless, massive scale, but limited query flexibility
- 🎯 **Redshift is perfect for analytics** — powerful for BI, but not for real-time transactions
- 🎯 **ElastiCache speeds things up** — dramatic performance boost, but it's a cache, not primary storage

The key is understanding your workload first, then picking the database:

**Questions to ask:**
- Is my data structured (SQL) or flexible (NoSQL)?
- Do I need complex queries or just fast lookups?
- Am I running transactions or analytics?
- Do I need to scale to millions of records?
- What's my read vs. write pattern?

Once you match the database to the use case, everything else falls into place.

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

<h4 align="center">🗄️ Built with AWS RDS • DynamoDB • Redshift • Real-World Use Cases 🗄️</h4>
