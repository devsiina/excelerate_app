# BRAINLIT EXCELERATE MOBILE APPLICATION

**📘 Excelerate Learning & Experience App Overview**

BRAINLIT App is a Flutter-based mobile platform that connects learners to internships, workshops, job opportunities, and online courses. The app empowers students and professionals to gain real-world experience while providing admins and organizations with tools to manage, verify, and track opportunities efficiently.

## 🆕 Recent Updates (October 23, 2025)

### New Features
- **Real Data Integration**: Programs now load from JSON data source
- **Feedback System**: Added comprehensive feedback form with validation
- **Settings**: New settings page with theme and language controls
- **Enhanced UI**: Modern floating navigation and animated search
-
### Technical Improvements
- Implemented state management with Provider
- Added mock API service with error handling
- Enhanced loading states and error messaging
- Improved form validation and user feedback

[View full changelog](CHANGELOG.md)

This project is inspired by experiential learning platforms like Udemy, edX, and Coursera, but with a stronger focus on hands-on projects and industry collaboration.

**🎯 Purpose**

To bridge the gap between academic learning and professional experience by providing a unified, accessible platform for learners to gain skills and exposure through structured programs and internships.

**👥 Target Users:**
**Learners:** Browse, apply, and participate in virtual internships, workshops, and short courses. 
**Admins / Institutions:** Manage programs, verify opportunities, track learner progress, and issue certificates.

**⚙️ Key Features** 
**🔐 User Authentication** — Secure login/signup with role-based access (learner/admin). 
**🏠 Dashboard** — Personalized home screen showing opportunities, deadlines, and achievements. 
**🎓 Courses & Internships** — Browse, filter, and enroll in experiential learning programs. 
**🧠 Interactive Learning **— Video modules, readings, quizzes, and assignments. 
**📂 Project Management** — Submit tasks, receive mentor feedback, and track progress. 
**🏅 Certificates & Badges** — Auto-generated credentials for completed activities. 
**💬 Messaging & Notifications** — Real-time updates and in-app communication. 
**🧾 Admin Panel **— Content, user, and analytics management tools. 
**💰 Payment & Scholarship Integration** — Paystack / Flutterwave for course payments and scholarships. 


**🧭 User Journey Examples**

**Learner Flow:**
A learner signs up, lands on a personalized dashboard (built using Flutter’s Scaffold), and browses current internships. After enrolling in a workshop, their progress is tracked in Firebase Firestore. They complete video lessons, submit tasks, and receive a digital certificate upon completion — all directly in-app.

**Admin Flow:**
An admin logs in to a secure dashboard connected via REST API. They post new opportunities, review applications, verify organizations, and track analytics using interactive charts. Notifications are pushed to all eligible learners in real time.

**🛠️ Tech Stack **
**Frontend:** Flutter (Dart) 
**Backend:** Firebase / Node.js (REST API)
**Database:** Firestore or PostgreSQL
**Authentication:** Firebase Auth / OAuth 
**Payments:** Paystack / Flutterwave Integration 
**Hosting:** Firebase Hosting / Render 🚀 Future Plans AI-powered recommendation system for courses and internships. Offline mode for course videos. Social learning features (peer groups, discussions, leaderboards).
