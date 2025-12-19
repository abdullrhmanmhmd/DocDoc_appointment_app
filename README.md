# 🏥 Docdoc — Doctor Appointment App


<img width="3200" height="1928" alt="Doc_github" src="https://github.com/user-attachments/assets/055b54e3-1659-4c68-9ea5-727ae1debf11" />


## 📖 Overview

**Docdoc** is a Flutter-based mobile application developed as a collaborative project by a team of students:  
**Abdelrhman Mohamed Mahmoud**, **Haydi Mostafa**, **Lina Ashraf Sediq**, and **AlaaAllah Arafa**.  

The app focuses on building essential mobile development skills using Flutter and Dart — featuring user login, profile editing, and smooth navigation between screens.  
It showcases modern UI design principles, responsive layouts, and clean, maintainable code structure.


---

## 🚀 Features

- 🔐 **User Login & Authentication** — Secure sign-in flow with email and password validation.  
- 👤 **Edit User Profile** — Update personal details such as name, email, and profile picture in real time.  
- 🧭 **Smooth Navigation** — Seamless transition between login, home, and profile edit screens.  
- 💾 **Form Validation** — Smart form handling with real-time error messages and input validation.   
- 📅 **Appointment Booking** — Select a date, time, and type (in-person or virtual).  
- 🎨 **Modern UI** — Clean, responsive, and user-friendly Flutter interface.  

---

## Participants

| Name | ID |
|-----------|--------|
| **Abdelrhman Mohamed Mahmoud** | 231000262 |
| **Haydi Mostafa** | 231000076|
| **Lina Ashraf Sediq** | 231001820 |
| **AlaaAllah Arafa** |231000568 |


---

# Team Tasks Distribution

| # | Team Member | Responsibilities |
|---|-------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1 | **Abdelrahman Mohamed Mahmoud** | **Authentication & Intro Screens** <br> • Splash Screen <br> • Onboarding Screen <br> • Login Screen – email + password fields <br> • Signup Screen – name, email, password, confirm password <br>• Forgot Password Screen (email verification and reset flow) |
| 2 | **Lina Ashraf Sediq** | **Doctor Listing & Details Screens** <br> • Home Screen – show list of doctors <br> • Doctor Card Widget – doctor’s name, specialty, rating, image <br> • Doctor Details Screen – doctor’s info, biography, hospital, contact <br> • Search / Filter Screen – search by name or specialty |
| 3 | **AlaaAllah Arafa** | **Appointment Booking Screens** <br> • Appointment Form Screen – choose doctor, date, time, notes <br> • Appointment Confirmation Screen – booking success + summary <br> • My Appointments Screen – list user’s upcoming/past appointments <br> • Cancel Appointment Dialog / Popup |
| 4 | **Haydi Mostafa** | **Profile ** <br> • Profile Screen – show user name, photo, email <br> • Edit Profile Screen – allow user to update info/photo <br> 

Test Cases – DocDoc Doctor Appointment App

🧪 AUTHENTICATION TEST CASES
 | ID | Feature | Description | Input | Expected Result |
|----|---------|-------------|-------|-----------------|
| TC-01 | Signup | Create new user with valid data | Name, Email, Password | Account created successfully |
| TC-02 | Signup | Signup with empty fields | Empty form | Error message shown |
| TC-03 | Signup | Password mismatch | Password ≠ Confirm Password | Validation error |
| TC-04 | Login | Login with valid credentials | Correct email & password | Redirect to Home screen |
| TC-05 | Login | Login with wrong password | Incorrect password | Error message shown |
| TC-06 | Logout | User logs out | Logout button | User returned to login screen |


🧪 DOCTOR LISTING & SEARCH
 | ID | Feature | Description | Input | Expected Result |
|----|---------|-------------|-------|-----------------|
| TC-07 | Home | Load doctors from Firestore | App launch | Doctor list displayed |
| TC-08 | Doctor Card | Display doctor info | Doctor data | Name, specialty, rating visible |
| TC-09 | Search | Search by doctor name | "Sarah" | Matching doctors shown |
| TC-10 | Search | Search by specialty | "Cardio" | Filtered list shown |
| TC-11 | Search | No results found | Random text | "No doctors found" message |


🧪 DOCTOR DETAILS
 | ID | Feature | Description | Input | Expected Result |
|----|---------|-------------|-------|-----------------|
| TC-12 | Doctor Details | Open doctor details | Tap doctor card | Full doctor info shown |
| TC-13 | Doctor Details | View biography | Doctor selected | Biography displayed |
| TC-14 | Doctor Details | View hospital & contact | Doctor selected | Hospital & contact visible |


🧪 APPOINTMENT BOOKING
 | ID | Feature | Description | Input | Expected Result |
|----|---------|-------------|-------|-----------------|
| TC-15 | Booking | Book appointment | Date, Time, Notes | Appointment saved |
| TC-16 | Booking | Missing date or time | Empty fields | Validation error |
| TC-17 | Confirmation | Confirm booking | Valid appointment | Confirmation screen shown |
| TC-18 | My Appointments | View appointments | Logged-in user | Appointments list displayed |
| TC-19 | Cancel Appointment | Cancel appointment | Cancel button | Appointment removed |


🧪 FIREBASE & DATA HANDLING
 | ID | Feature | Description | Input | Expected Result |
|----|---------|-------------|-------|-----------------|
| TC-20 | Firestore | Fetch doctors | Firestore data | Doctors displayed |
| TC-21 | Firestore | Empty collection | No doctors | "No doctors found" |
| TC-22 | Error Handling | Network failure | Offline mode | Error message shown |



