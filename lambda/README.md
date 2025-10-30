# Terraform Security Group Remediation with AWS Lambda

## Overview

This project automates the remediation of insecure AWS Security Group (SG) rules using **Terraform** and **AWS Lambda**.  
It detects and removes ingress rules for **ports 22 (SSH) and 3389 (RDP)** that are open to the internet (`0.0.0.0/0`), ensuring your VPC is more secure.

The Lambda function runs **hourly** via CloudWatch Events, automatically scanning all SGs in the specified VPC.

---

## Features

- **Terraform-managed Lambda deployment**  
- **Automatic scanning of Security Groups** in a VPC  
- **Removes insecure ingress rules** for SSH/RDP  
- **CloudWatch logging** for audit and verification  
- Easily extensible for multiple VPCs or additional ports  

---

## Prerequisites

- AWS CLI configured with proper credentials  
- Terraform >= 1.5  
- Python 3.11 (for Lambda code)  

---

## Project Structure

