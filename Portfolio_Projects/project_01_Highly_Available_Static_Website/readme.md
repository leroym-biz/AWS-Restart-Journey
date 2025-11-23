\# 🍽️ Embers \& Co: Crafting a Digital Experience with AWS



> \*\*From manual chaos to cloud precision—solving real business problems with AWS architecture.\*\*



---



\## 📋 What's Inside



\- \[What I Built Here](#what-i-built-here)

\- \[Architecture Overview](#architecture-overview)

\- \[Implementation Journey](#implementation-journey)

\- \[What I Learned](#what-i-learned)



---



\## What I Built Here



This project solved a \*\*real problem\*\* for \*\*Embers \& Co\*\*, a popular Melville restaurant with 100+ daily customers and a 25% profit margin. Their manual booking system was causing double-bookings, lost reservations, and frustrated staff.



The reality is, success creates chaos when your systems can't scale. Manual processes that worked for 20 customers break down at 100+.



I focused on:  

✅ \*\*Building a fully functional static website\*\* with booking capabilities  

✅ \*\*Architecting a serverless backend\*\* ready for dynamic processing  

✅ \*\*Securing AWS infrastructure\*\* with proper IAM policies  

✅ \*\*Presenting the business case\*\* to stakeholders in their language (ROI, not tech specs)



\*\*Tech Stack:\*\* Amazon S3, CloudFront, Route 53, IAM, Business Consulting



\*\*Live Website:\*\* \[https://ember-co.netlify.app/](https://ember-co.netlify.app/)



---



\## Architecture Overview



\### How It's Built



Rather than just "hosting a website," I architected a \*\*true serverless solution\*\* that could scale from day one. This isn't a hobby project—it's enterprise-grade infrastructure.



<p align="center">

&nbsp; <img src="assets/screenshots/01-s3-bucket-creation.png" alt="S3 Bucket Creation" width="80%"/>

</p>



\*The foundation: Provisioning the S3 bucket in us-east-1\*



\*\*The Key Pieces:\*\*

\- \*\*Static Content (S3 + CloudFront)\*\* — Lightning-fast menu display, 99.999999999% durability

\- \*\*Domain Management (Route 53)\*\* — Professional DNS configured and ready

\- \*\*Dynamic Logic (API Gateway + Lambda + DynamoDB + SES)\*\* — Zero-error booking engine architected

\- \*\*Data Security (IAM + Bucket Policies)\*\* — Enterprise-grade access control



Honestly, getting the security right was half the battle. Anyone can make a bucket public. The skill is locking it down while keeping it functional.



---



\## Implementation Journey



\### 1️⃣ Provisioning the Foundation



First step: create the S3 bucket in \*\*US East (N. Virginia)\*\* for optimal CloudFront integration.



```bash

\# Bucket Configuration

Name: ember-co

Region: us-east-1

Static Website Hosting: Enabled

```



<p align="center">

&nbsp; <img src="assets/screenshots/02-file-upload-complete.png" alt="File Upload Complete" width="80%"/>

</p>



\*Uploading 71 assets (34MB)—every menu image, CSS animation, and JavaScript interaction\*



\*\*Key decision:\*\* Organized files into logical folders (`/Images`, `/CSS`, `/JS`) for maintainability. This is how real projects are structured.



---



\### 2️⃣ Initial Public Access Policy (Development Phase)



For rapid development, I configured a temporary bucket policy granting public read access:



<p align="center">

&nbsp; <img src="assets/screenshots/03-bucket-policy-json.png" alt="Initial Bucket Policy" width="80%"/>

</p>



\*Development policy: Quick public access for testing\*



```json

{

&nbsp; "Version": "2012-10-17",

&nbsp; "Statement": \[

&nbsp;   {

&nbsp;     "Sid": "PublicReadGetObject",

&nbsp;     "Effect": "Allow",

&nbsp;     "Principal": "\*",

&nbsp;     "Action": "s3:GetObject",

&nbsp;     "Resource": "arn:aws:s3:::ember-co/\*"

&nbsp;   }

&nbsp; ]

}

```



\*\*This was temporary.\*\* Production required a more secure approach.



---



\### 3️⃣ Enabling Static Website Hosting



Once files were uploaded, I activated static website hosting and verified the endpoint:



<p align="center">

&nbsp; <img src="assets/screenshots/04-static-hosting-enabled.png" alt="Static Hosting Enabled" width="80%"/>

</p>



\*The S3 website endpoint goes live\*



\*\*Website Endpoint:\*\* `http://ember-co.s3-website-us-east-1.amazonaws.com`



---



\### 4️⃣ Creating the CloudFront Distribution



The real power comes from CloudFront. I created a distribution pulling from the S3 website endpoint:



<p align="center">

&nbsp; <img src="assets/screenshots/05-cloudfront-creation-1.png" alt="CloudFront Creation Start" width="45%"/>

&nbsp; <img src="assets/screenshots/06-cloudfront-s3-origin.png" alt="S3 Origin Selection" width="45%"/>

</p>



\*Step 1: Selecting the S3 origin (note the website endpoint recommendation)\*



<p align="center">

&nbsp; <img src="assets/screenshots/07-cloudfront-distribution-details.png" alt="Distribution Details" width="80%"/>

</p>



\*Distribution created: dbmubhcukpnv9.cloudfront.net\*



\*\*Distribution Domain:\*\* `dbmubhcukpnv9.cloudfront.net`  

\*\*ARN:\*\* `arn:aws:cloudfront::986341372302:distribution/E37FXO5EHONN63`  

\*\*Status:\*\* Deployed and active



---



\### 5️⃣ Securing CloudFront Access (Production-Ready)



Here's where architecture gets serious. Instead of leaving S3 public, I \*\*amended the bucket policy\*\* to only allow access from CloudFront:



<p align="center">

&nbsp; <img src="assets/screenshots/08-cloudfront-bucket-policy-amended.png" alt="CloudFront Bucket Policy" width="80%"/>

</p>



\*Production security: Only CloudFront can access S3 content\*



```json

{

&nbsp; "Version": "2012-10-17",

&nbsp; "Statement": \[

&nbsp;   {

&nbsp;     "Sid": "AllowCloudFrontServicePrincipal",

&nbsp;     "Effect": "Allow",

&nbsp;     "Principal": {

&nbsp;       "Service": "cloudfront.amazonaws.com"

&nbsp;     },

&nbsp;     "Action": "s3:GetObject",

&nbsp;     "Resource": "arn:aws:s3:::ember-co/\*",

&nbsp;     "Condition": {

&nbsp;       "StringEquals": {

&nbsp;         "AWS:SourceArn": "arn:aws:cloudfront::986341372302:distribution/E37FXO5EHONN63"

&nbsp;       }

&nbsp;     }

&nbsp;   }

&nbsp; ]

}

```



\*\*Why this matters:\*\* This is the difference between a hobby project and enterprise architecture. The S3 bucket is now \*\*locked down\*\*—no direct public access, only through CloudFront. This prevents bypassing the CDN and enables AWS Shield protection.



---



\### 6️⃣ Customer Experience Showcase



The homepage delivers immediate impact with clear call-to-action:



<p align="center">

&nbsp; <img src="assets/screenshots/09-hero-screenshot.png" alt="Hero Screenshot" width="80%"/>

</p>



\*The landing page: "NOW BOOKING" hero section\*



\### Interactive Menu System



The requirements demanded "images, videos, or animations to enhance design." We delivered with a tabbed menu and hover effects:



<p align="center">

&nbsp; <img src="assets/screenshots/10-menu-main-dish.png" alt="Main Menu" width="22%"/>

&nbsp; <img src="assets/screenshots/11-menu-starter-dish.png" alt="Starters" width="22%"/>

&nbsp; <img src="assets/screenshots/12-menu-dessert-dish.png" alt="Desserts" width="22%"/>

&nbsp; <img src="assets/screenshots/13-menu-drinks.png" alt="Drinks" width="22%"/>

</p>



\*Menu system: Tabbed navigation with professional food photography\*



\*\*Design choice:\*\* High-contrast text on food imagery while maintaining readability—exactly as the project required.



\### Seamless Booking Flow



The core problem was "order mix-ups and double-bookings." The solution starts with a clean, validated form:



<p align="center">

&nbsp; <img src="assets/screenshots/14-booking-form-screenshot.png" alt="Booking Form" width="80%"/>

</p>



\*Booking form: Captures all necessary details without overwhelming the user\*



<p align="center">

&nbsp; <img src="assets/screenshots/15-booking-confirmation-screenshot.png" alt="Booking Confirmation" width="80%"/>

</p>



\*Confirmation: Immediate feedback eliminates uncertainty\*



\### Mobile-First Responsiveness



With 60%+ of restaurant bookings coming from mobile, responsiveness wasn't optional:



<p align="center">

&nbsp; <img src="assets/screenshots/16-mobile-responsiveness.png" alt="Mobile Responsive" width="45%"/>

&nbsp; <img src="assets/screenshots/17-mobile-responsiveness-1.png" alt="Mobile Menu" width="45%"/>

</p>



\*Mobile experience: Hamburger menu collapses cleanly, all content accessible\*



\*\*Pro tip:\*\* Tested on actual devices, not just browser dev tools. The difference is night and day.



---



\## What I Learned



\### Technical Skills I Practiced



🛠️ \*\*AWS Resource Management\*\*

\- Creating and configuring S3 buckets with static website hosting

\- Understanding the difference between S3 website endpoints vs. bucket endpoints

\- Setting up CloudFront distributions with custom origins



🛠️ \*\*Security by Design\*\*

\- Implementing least-privilege access through IAM and bucket policies

\- Using CloudFront Service Principal with SourceArn conditions (production-grade)

\- Balancing security (locked-down S3) with functionality (public website via CDN)



🛠️ \*\*Real-World Architecture\*\*

\- Designing a solution that starts simple (static site) but scales infinitely

\- Mapping business problems (double-bookings) to technical solutions

\- Creating presentations that speak stakeholder language (ROI, not just tech specs)



🛠️ \*\*Business Communication\*\*

\- Translating technical architecture into revenue recovery

\- Presenting a 7-week migration roadmap costing less than two meals

\- Demonstrating enterprise-grade infrastructure at local business pricing



\### The Real Takeaway



Honestly, the biggest challenge wasn't technical—it was \*\*thinking like a consultant\*\*. The AWS Cloud Practitioner exam teaches services, but this project taught me to connect those services to revenue recovery, staff efficiency, and customer satisfaction.



When the restaurant owner sees "Lambda runs only when a customer clicks Reserve," they don't care about serverless architecture—they care about \*\*not paying for idle infrastructure\*\*. That's the mindset shift this project demanded.



Key insights:



\- 🎯 \*\*Security is non-negotiable\*\* — Even for a restaurant website, CloudFront + locked S3 is the right way

\- 🎯 \*\*Architecture decisions have business impact\*\* — $14/month vs. thousands in lost revenue from double-bookings

\- 🎯 \*\*Presentations matter as much as code\*\* — The PowerPoint deck closed the deal, not the S3 bucket

\- 🎯 \*\*Mobile-first isn't optional\*\* — Most bookings come from phones, not desktops



This project proved I can build AWS infrastructure and explain why it matters to people who've never heard of IAM policies.



---



\## 📝 Project Status



This is part of my \*\*AWS Restart Journey\*\*, a three-month focused portfolio documenting my path to the AWS Cloud Practitioner certification and beyond.



I'm building real projects, not just following tutorials. The goal is to prove I can actually build things, not just pass exams.



\*\*Project Deliverables:\*\*

\- ✅ Fully functional static website (live at ember-co.netlify.app)

\- ✅ AWS infrastructure (S3, CloudFront, IAM policies)

\- ✅ PowerPoint presentation (\[view deck](./EMBERS-CO-presentation.pdf))

\- ✅ 7-week migration roadmap



---



\## 🤝 Let's Connect



If you're looking for someone who understands both the `s3:GetObject` policy syntax AND the business impact of eliminating double-bookings—let's talk.



<p align="center">

&nbsp; <a href="mailto:leroym.biz@gmail.com">

&nbsp;   <img src="https://img.shields.io/badge/Email-leroym.biz@gmail.com-D14836?style=for-the-badge\&logo=gmail\&logoColor=white" alt="Email" />

&nbsp; </a>

&nbsp; <a href="https://api.whatsapp.com/send/?phone=27605665116\&text=Hi%20Leroy,%20saw%20your%20GitHub!" target="\_blank">

&nbsp;   <img src="https://img.shields.io/badge/WhatsApp-%2B27%2060%20566%205116-25D366?style=for-the-badge\&logo=whatsapp\&logoColor=white" alt="WhatsApp" />

&nbsp; </a>

</p>



<p align="center">

&nbsp; <a href="https://github.com/leroym-biz/AWS-Restart-Journey" target="\_blank">

&nbsp;   <img src="https://img.shields.io/badge/View%20Repository-black?style=for-the-badge\&logo=github" />

&nbsp; </a>

</p>



---



<p align="center">

&nbsp; <img src="https://img.shields.io/badge/Status-Project%20Complete-success?style=flat-square" />

&nbsp; <img src="https://img.shields.io/badge/Focus-Hands--On%20Consulting-brightgreen?style=flat-square" />

</p>



<h4 align="center">🍽️ Built with AWS S3 • CloudFront • IAM • PowerPoint • Business Acumen 🍽️</h4>

