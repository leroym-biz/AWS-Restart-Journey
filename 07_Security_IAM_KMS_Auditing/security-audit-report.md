# 🔐 AWS Security, IAM, and KMS Auditing

> **Implementing logging, monitoring, and alerting—the kind of stuff that keeps production systems secure and compliant.**

---

## 📋 What's Inside

- [What I Built Here](#what-i-built-here)
- [Architecture Overview](#architecture-overview)
- [Implementation Details](#implementation-details)
- [Monitoring & Alerts](#monitoring--alerts)
- [Security & Verification](#security--verification)
- [What I Learned](#what-i-learned)

---

## What I Built Here

This lab covered the fundamentals of logging and monitoring in AWS—techniques that work together to ensure a system's performance baselines and security guidelines are always met.

Monitoring isn't the flashiest part of cloud architecture, but it's absolutely critical. Without proper logging and alerting, you're flying blind. By the time you notice something's wrong, it's already cost you money or worse—compromised security.

The real point here wasn't just setting up CloudWatch—it was building a complete security monitoring system:  
✅ **CloudWatch alarms** that trigger on specific thresholds  
✅ **SNS notifications** for real-time email alerts  
✅ **Stress testing** to validate alarm configurations  
✅ **Security monitoring** to detect unauthorized access and malicious activity

**Tech Stack:** Amazon CloudWatch, Amazon SNS, EC2, IAM, Stress Testing Tools

---

## Architecture Overview

### How It's Built

The monitoring architecture follows a **defense-in-depth strategy**: log everything, monitor actively, alert immediately. This setup simulates real-world scenarios where you need to detect and respond to security incidents in production environments.

<p align="center">
  <img src="assets/screenshots/Cloudwatch_dashboard_header.png" alt="CloudWatch Dashboard Overview" width="80%">
</p>

<p align="center"><em>CloudWatch Dashboard showing real-time metrics and alarm status</em></p>

**The Key Pieces:**
- **Logging Layer:** CloudWatch Logs capturing system and application events
- **Monitoring Layer:** CloudWatch Metrics tracking CPU, memory, disk, and network
- **Alerting Layer:** CloudWatch Alarms with SNS integration
- **Notification Layer:** Email alerts via Amazon SNS

**The Scenario:**  
This lab simulates a malicious actor gaining control of an EC2 instance and spiking the CPU to 100%. CPU spiking has various possible causes, one of which is malware. In production, this pattern could indicate:
- Cryptomining malware
- DDoS attack participation
- Compromised instance running unauthorized workloads
- Resource exhaustion attacks

Honestly, getting comfortable with monitoring patterns is half the battle when securing cloud infrastructure.

---

## Implementation Details

### Phase 1: CloudWatch Alarm Configuration

#### Alarm Specifications

| Component | Configuration | Why It Makes Sense |
|-----------|---------------|-------------------|
| **Metric** | CPUUtilization | Most common indicator of abnormal behavior or resource exhaustion |
| **Threshold** | Greater than 60% | Balance between sensitivity and false positives—60% is high enough to indicate issues but low enough to catch problems early |
| **Evaluation Period** | 2 consecutive periods of 1 minute each | Prevents alert fatigue from brief spikes while catching sustained issues |
| **Action** | SNS notification via email | Immediate notification to security/ops team |
| **Instance** | Target EC2 instance (Lab environment) | Monitored production workload |

<p align="center">
  <img src="assets/screenshots/CloudWatch_Alarm_Threshold_Configuration.png" alt="CloudWatch Alarm Configuration" width="80%">
</p>
<p align="center"><em>CloudWatch alarm configured with 60% CPU threshold over 2 consecutive 1-minute periods</em></p>

**Security Best Practices Applied:**
- 🔒 Threshold tuned to detect anomalies without excessive false positives
- 🔒 SNS topic restricted to authorized subscribers only
- 🔒 CloudWatch Logs encrypted at rest
- 🔒 IAM policies following least privilege principle

The threshold of 60% is intentional—high enough to avoid alerts during normal load spikes, but low enough to catch malicious activity before it impacts the entire system.

---

### Phase 2: SNS Notification Setup

#### Amazon SNS Configuration

Amazon Simple Notification Service (SNS) enables real-time email notifications when CloudWatch alarms trigger. This creates an immediate feedback loop between infrastructure and operations teams.

**SNS Topic Configuration:**
```bash
# SNS Topic: EC2-CPU-Alert
# Subscription Protocol: Email
# Endpoint: Security/Operations team email
# Delivery Policy: Immediate
```

**Why SNS Matters:**
- ⚡ **Real-time alerts** — Notification within seconds of alarm state change
- ⚡ **Multiple subscribers** — Email security team, ops team, and on-call engineers
- ⚡ **Integration ready** — Can trigger Lambda functions, SMS, or PagerDuty
- ⚡ **Audit trail** — All notifications logged for compliance

Once you set up SNS correctly, you'll get an email confirmation. After confirming the subscription, CloudWatch alarms automatically route alerts to your inbox.

---

## Monitoring & Alerts

### Phase 3: Stress Testing & Validation

#### Simulating Malicious Activity

This is where we validate the monitoring system works. I logged into the EC2 instance and ran a stress test command to spike CPU utilization to 100%, simulating a compromised instance.

<p align="center">
  <img src="assets/screenshots/Stress_Tool_Execution_via_Terminal.png" alt="Stress Test Execution" width="80%">
</p>

<p align="center"><em>Executing stress test via SSH to simulate CPU spike at 100%</em></p>

**Stress Test Command:**
```bash
# Stress test command - simulates CPU-intensive malware
stress --cpu 4 --timeout 300s

# This command:
# --cpu 4: Spawns 4 CPU-intensive workers
# --timeout 300s: Runs for 5 minutes (300 seconds)
```

**What This Simulates:**
- Cryptomining malware consuming CPU cycles
- Compromised instance participating in botnet activity
- Resource exhaustion attack
- Unauthorized workload execution

In production, you'd investigate immediately—check running processes, review IAM access logs, inspect network traffic, and potentially isolate the instance.

---

### Phase 4: Metric Visualization

#### CloudWatch Metrics Dashboard

<p align="center">
  <img src="assets/screenshots/Metric_Graph_with_60%_Alarm_Threshold.png" alt="CloudWatch Metric Graph" width="80%">
</p>

<p align="center"><em>CPU utilization metric showing spike above 60% threshold triggering the alarm</em></p>

**What We're Seeing:**
- **Baseline CPU:** ~5-10% under normal operation
- **Spike Event:** CPU jumps to 100% when stress test executes
- **Alarm Trigger:** Red line at 60% threshold is exceeded for 2 consecutive minutes
- **State Change:** Alarm transitions from "OK" to "ALARM" state

The graph clearly shows the moment the alarm threshold was breached. This is exactly what you want—immediate visual confirmation that monitoring is working.

---

### Phase 5: Targeted Instance Monitoring

#### Instance-Level Metrics

<p align="center">
  <img src="assets/screenshots/Targeted_Metric_Selection_by_Instance_ID.png" alt="Instance Selection" width="80%">
</p>

<p align="center"><em>CloudWatch metrics filtered by specific EC2 instance ID for granular monitoring</em></p>

**Why Instance-Level Monitoring Matters:**
- 🎯 **Granular visibility** — Monitor individual instances, not just aggregate metrics
- 🎯 **Faster troubleshooting** — Pinpoint exactly which instance is misbehaving
- 🎯 **Cost allocation** — Track resource usage per workload
- 🎯 **Capacity planning** — Identify instances that need scaling or rightsizing

When an alarm fires in production, you need to know **exactly** which instance is the problem. Aggregate metrics tell you something's wrong; instance-level metrics tell you **what** is wrong.

---

## Security & Verification

### Email Notification Confirmation

Once the CPU threshold was breached for 2 consecutive 1-minute periods, CloudWatch triggered the SNS notification. Within seconds, an email alert was delivered.

**Email Alert Contents:**
```
Subject: ALARM: EC2-CPU-Alert-High in us-east-1
Body:
- Alarm Name: EC2-CPU-Alert-High
- Instance ID: i-0abc123def456789
- Metric: CPUUtilization
- Threshold: 60%
- Current Value: 98.7%
- State Change: OK → ALARM
- Timestamp: [Time of breach]
```

**Why This Matters:**  
In production, this email goes to your security team. They can immediately:
1. **Assess the situation** — Is this expected load or an incident?
2. **Investigate the instance** — SSH in, check running processes
3. **Review IAM logs** — Who accessed this instance recently?
4. **Isolate if necessary** — Detach from production network
5. **Preserve evidence** — Take EBS snapshot for forensic analysis

Security isn't just about prevention—it's about **detection and response speed**.

---

### Defense-in-Depth Strategy

**Logging:**  
CloudWatch Logs record every system event. From a security standpoint, logging helps administrators identify red flags that are easily overlooked—like unauthorized SSH access, privilege escalation attempts, or suspicious API calls.

**Monitoring:**  
CloudWatch Metrics analyze and collect data to help ensure optimal performance. Monitoring helps detect unauthorized access and helps align your services' usage with organizational security policies.

**Security Architecture Layers:**
1. **IAM Policies** — Who can access EC2 instances
2. **Security Groups** — What traffic can reach instances
3. **CloudWatch Alarms** — Detect abnormal behavior
4. **SNS Notifications** — Alert security teams immediately
5. **CloudTrail Logs** — Audit trail of all API calls
6. **VPC Flow Logs** — Network traffic analysis

Security isn't one thing; it's layers. You want multiple checkpoints, not just one.

---

## What I Learned

### Technical Skills I Practiced

🛠️ **Monitoring & Observability**
- Setting up CloudWatch alarms with appropriate thresholds
- Configuring SNS topics for real-time notifications
- Building dashboards for metrics visualization
- Understanding alarm states and evaluation periods

🛠️ **Security Operations**
- Simulating security incidents for testing
- Detecting abnormal behavior patterns
- Implementing automated alerting systems
- Following incident response procedures

🛠️ **AWS Service Integration**
- Connecting CloudWatch, SNS, and EC2
- Understanding metric namespaces and dimensions
- Filtering metrics by instance ID
- Configuring alarm actions

🛠️ **Cost Optimization**
- Using CloudWatch efficiently to avoid excessive data ingestion costs
- Setting appropriate alarm evaluation periods
- Understanding SNS pricing (first 1,000 emails free per month)
- Balancing monitoring granularity with cost

### The Real Takeaway

Honestly, monitoring was one of those topics I thought would be straightforward—just set an alarm and move on, right? Wrong.

The more I learned, the more I realized monitoring is about **understanding your baseline** and **detecting anomalies quickly**:

- 🎯 **Thresholds matter** — Too low = alert fatigue. Too high = miss incidents.
- 🎯 **Evaluation periods are critical** — Brief spikes shouldn't wake up on-call engineers at 3 AM
- 🎯 **Real-time matters** — In production, every minute counts during a security incident
- 🎯 **Testing is non-negotiable** — If you don't test your alarms, you don't know if they work

This lab simulated a malicious actor gaining control of an EC2 instance and spiking the CPU. CPU spiking has various possible causes, one of which is malware. In real production environments:

**Questions to ask when an alarm fires:**
- Is this expected load (batch job, traffic spike) or unexpected?
- Which instance is affected? Can I isolate it?
- Who accessed this instance in the last 24 hours?
- Are there other instances showing similar patterns?
- Do I need to preserve evidence for forensic analysis?

Once you build monitoring that answers these questions automatically, you sleep better at night.

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

<p align="center">🔐 <strong>Built with CloudWatch • SNS • IAM • Security Best Practices</strong> 🔐</p>
