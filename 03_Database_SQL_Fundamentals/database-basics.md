\# 🗄️ AWS Database Fundamentals: SQL and NoSQL Services



> \*\*Understanding databases in AWS—from relational to NoSQL, and when to use each one.\*\*



---



\## 📋 What's Inside



\- \[What I Built Here](#what-i-built-here)

\- \[Database Types Overview](#database-types-overview)

\- \[AWS Database Services](#aws-database-services)

\- \[What I Learned](#what-i-learned)



---



\## What I Built Here



This lab covered the fundamentals of databases—what they are, how they're structured, and which AWS service to use for different use cases.



Databases aren't the flashiest part of cloud architecture, but they're arguably the most important. Get your database choice wrong and you'll pay for it in performance, cost, or both.



The real point here wasn't just memorizing service names—it was understanding the trade-offs:  

✅ \*\*SQL vs. NoSQL\*\* and when to use each  

✅ \*\*AWS database services\*\* and their specific use cases  

✅ \*\*Matching workload requirements\*\* to the right database type  

✅ \*\*Understanding cost and performance implications\*\* of each choice



\*\*Tech Stack:\*\* AWS RDS, DynamoDB, Redshift, ElastiCache



---



\## Database Types Overview



\### SQL vs. NoSQL



| Database Type | Structure | Best For | Example Use Case |

|---------------|-----------|----------|------------------|

| \*\*Relational (SQL)\*\* | Structured tables with rows and columns | Traditional apps, complex queries, transactions | E-commerce orders, customer data, financial records |

| \*\*Non-Relational (NoSQL)\*\* | Flexible schema, semi-structured data | High-scale apps, real-time data, IoT | Session data, user profiles, IoT sensor readings |



\*\*Key insight:\*\* When someone says "database," they usually mean a relational (SQL) database. But NoSQL databases solve specific problems that SQL can't handle efficiently at scale.



\### Database Categories



| Type | What It Stores | AWS Service | When To Use |

|------|----------------|-------------|-------------|

| \*\*Relational\*\* | Structured data in tables | RDS, Aurora | Complex queries, relationships, ACID compliance |

| \*\*Key-Value\*\* | Simple key-value pairs | DynamoDB | Massive scale, fast lookups, session data |

| \*\*Document\*\* | JSON-like documents | DocumentDB | Flexible schema, nested data structures |

| \*\*Data Warehouse\*\* | Column-oriented analytics | Redshift | Business intelligence, reporting, aggregations |

| \*\*In-Memory Cache\*\* | Cached data in memory | ElastiCache | Performance boost, reduce database load |



---



\## AWS Database Services



\### 1️⃣ Amazon RDS (Relational Database Service)



\*\*What it is:\*\*  

Managed relational database service supporting multiple SQL engines. This is the most commonly used database type among tech companies.



\#### Supported Engines



| Engine | Description | When To Use |

|--------|-------------|-------------|

| \*\*MySQL\*\* | Popular open-source SQL database | General-purpose web applications |

| \*\*PostgreSQL\*\* | Developer-favorite open-source SQL | Complex queries, rich features |

| \*\*MariaDB\*\* | MySQL fork with open-source licensing | Drop-in MySQL replacement |

| \*\*Oracle\*\* | Enterprise SQL database | Large enterprises (requires license) |

| \*\*SQL Server\*\* | Microsoft's SQL database | Windows/.NET environments (requires license) |

| \*\*Aurora\*\* | AWS-optimized (5x faster MySQL, 3x faster PostgreSQL) | High availability, performance, scalability |



\*\*Aurora Serverless:\*\*  

On-demand version of Aurora that handles cold-starts and scales automatically. Best for infrequent or unpredictable workloads.



\*\*When to use RDS:\*\*

```

✓ You need ACID compliance (data integrity)

✓ You have structured data with relationships

✓ You need complex queries with JOINs

✓ You're running traditional applications

```



---



\### 2️⃣ Amazon DynamoDB (NoSQL Key-Value Store)



\*\*What it is:\*\*  

Serverless NoSQL database designed to scale to billions of records with guaranteed sub-second data retrieval.



\*\*Key characteristics:\*\*

\- No infrastructure management (fully serverless)

\- Automatically scales to handle massive workloads

\- Single-digit millisecond latency

\- No sharding or capacity planning needed



\*\*Real-world proof:\*\*  

In 2019, Amazon migrated 7,500 Oracle databases (75 petabytes) to DynamoDB. Result: \*\*60% cost reduction\*\* and \*\*40% latency improvement\*\*.



\*\*When to use DynamoDB:\*\*

```

✓ You need massive scalability (millions/billions of records)

✓ You need consistent, fast performance

✓ Your data model is simple (key-value pairs)

✓ You want serverless architecture

```



\*\*Trade-off:\*\* DynamoDB is fast and scalable but lacks the query flexibility of SQL. No complex JOINs or aggregations.



---



\### 3️⃣ Amazon Redshift (Data Warehouse)



\*\*What it is:\*\*  

Petabyte-scale data warehouse designed for analytics and business intelligence workloads.



\*\*Key characteristics:\*\*

\- Column-oriented storage (optimized for analytics)

\- Handles terabytes of data for reporting

\- Performs aggregations (SUM, AVG, GROUP BY) very fast

\- Not for real-time queries (accessed once or twice daily/weekly)



\*\*When to use Redshift:\*\*

```

✓ You need to generate analytics from large datasets

✓ You're running business intelligence (BI) tools

✓ You need fast aggregations on millions of rows

✓ You're consolidating data from multiple sources

```



\*\*Trade-off:\*\* Redshift is powerful for analytics but overkill for transactional workloads. Use RDS or DynamoDB for transactions.



---



\### 4️⃣ Amazon ElastiCache (In-Memory Cache)



\*\*What it is:\*\*  

Managed in-memory caching using Redis or Memcached.



\*\*When to use ElastiCache:\*\*

```

✓ You need to improve application performance

✓ You want to reduce database load

✓ You're caching frequently accessed data

✓ You need sub-millisecond response times

```



\*\*Common pattern:\*\* Place ElastiCache in front of your database. Check cache first; if data isn't there, query the database and cache the result.



---



\### 5️⃣ Other AWS Database Services



| Service | Type | Use Case |

|---------|------|----------|

| \*\*DocumentDB\*\* | Document store | MongoDB-compatible, JSON-like documents |

| \*\*Neptune\*\* | Graph database | Social networks, fraud detection, recommendation engines |

| \*\*Timestreams\*\* | Time-series | IoT data, metrics, logs that change over time |

| \*\*Keyspaces\*\* | Wide-column | Apache Cassandra workloads |



---



\## What I Learned



\### Technical Skills I Practiced



🛠️ \*\*Database Selection\*\*

\- Understanding when to use SQL vs. NoSQL

\- Matching database type to workload requirements

\- Recognizing performance vs. flexibility trade-offs



🛠️ \*\*AWS Service Knowledge\*\*

\- Knowing the core database services (RDS, DynamoDB, Redshift)

\- Understanding managed vs. serverless options

\- Choosing the right engine for specific use cases



🛠️ \*\*Cost and Performance Optimization\*\*

\- Using caching layers to reduce database load

\- Selecting cost-effective database options

\- Understanding scalability implications of each choice



\### The Real Takeaway



Honestly, databases were one of those topics I thought would be straightforward—just pick RDS and move on, right? Wrong.



The more I learned, the more I realized there's no one-size-fits-all database:



\- 🎯 \*\*RDS is great for traditional apps\*\* — but it doesn't scale like DynamoDB

\- 🎯 \*\*DynamoDB is fast and scalable\*\* — but it lacks SQL query flexibility

\- 🎯 \*\*Redshift is perfect for analytics\*\* — but it's overkill for transactional data

\- 🎯 \*\*ElastiCache speeds things up\*\* — but it's not a primary data store



The key is understanding your workload first, then picking the database:



\*\*Questions to ask yourself:\*\*

\- Is my data structured (SQL) or flexible (NoSQL)?

\- Do I need complex queries or just fast lookups?

\- Am I running transactions or analytics?

\- Do I need to scale to millions of records?

\- What's my performance requirement?



Once you match the database to the use case, everything else falls into place.



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



<h4 align="center">🗄️ Built with AWS RDS • DynamoDB • Redshift • Real-World Use Cases 🗄️</h4>

