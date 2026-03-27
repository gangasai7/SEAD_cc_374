Research Portfolio Automation Tool
🚀 Overview

The Research Portfolio Automation Tool is a full-stack web application that automates the process of collecting, organizing, and presenting research publications. It fetches real-time data from ORCID and OpenAlex APIs, displays it through an interactive dashboard, and allows users to download structured reports in PDF format.

🎯 Features
🔍 Search publications using ORCID ID and Author Name
🌐 Fetch real-time data from ORCID and OpenAlex APIs
📊 Display results in a dynamic dashboard
🧹 Remove duplicate and irrelevant data
📄 Download research data as PDF reports
⚡ Fast and responsive UI
🛠️ Tech Stack
Frontend
React.js
HTML, CSS
Vite
Backend
Python
Flask
APIs
ORCID API
OpenAlex API
Libraries
requests (Python)
jsPDF
jspdf-autotable
📁 Project Structure
research-portfolio-automation/
│
├── research-frontend/
│   ├── src/
│   │   ├── components/
│   │   │   ├── SearchBar.jsx
│   │   │   ├── PublicationTable.jsx
│   │   ├── pages/
│   │   │   ├── Dashboard.jsx
│   │   ├── App.jsx
│   │   ├── App.css
│
├── research-backend/
│   ├── app.py
│
└── README.md
