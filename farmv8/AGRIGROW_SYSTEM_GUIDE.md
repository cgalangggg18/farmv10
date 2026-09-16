# AgriGrow System Management & Usage Guide
**Version:** 1.0  
**Database:** Cloud PostgreSQL (via Firebase Data Connect)  
**Region:** Singapore (asia-southeast1)

---

## 👩‍💻 FOR DEVELOPERS: Development & Backend Management

### 1. Local Project Setup
To set up your local development environment to connect to the production cloud database:
1.  **Clone the Repository:** Ensure you have the latest code from the repository.
2.  **Install Dependencies:** Run `flutter pub get` in the root directory.
3.  **Authentication Key (CRITICAL):** Obtain the `google-services.json` file from the Project Owner.
    *   **Placement:** Place the file in `D:/Android studio/farmv8/android/app/`.
    *   *Note:* This file is excluded from version control for security.
4.  **Flutter SDK:** Ensure you are using Flutter 3.10+ to support the Firebase Data Connect SDK.

### 2. Architecture Overview
The system uses a cloud-native SQL approach:
*   **`RegistrationService` (lib/services/):** The UI-facing service that handles user input and logic.
*   **`FirebaseSqlService` (lib/services/):** The bridge that communicates with Firebase Data Connect.
*   **Data Connect SDK:** Automatically handles PostgreSQL connections, connection pooling, and SSL encryption.

### 3. Schema Management
The database schema is defined in GraphQL and automatically mapped to PostgreSQL.
*   To update tables: Go to **Firebase Console > Data Connect > Schema**.
*   Deploy changes using the **Deploy** button to automatically run migrations in the cloud.

---

## 👤 FOR USERS & MANAGERS: Data Management & Administration

### 1. Accessing the Admin Dashboard
All data management is handled through the **Firebase Console**:
1.  Go to [console.firebase.google.com](https://console.firebase.google.com/).
2.  Select the **AgriGrow** project.
3.  On the left sidebar, click **SQL Connect** (or Data Connect).

### 2. Viewing and Editing Records
Use the **Data** tab to interact with live production data:
*   **Tables:** Switch between `User`, `FarmerProfile`, `LogisticsProfile`, and `Address` using the tabs.
*   **Search:** Use the search bar to filter by email, username, or phone number.
*   **Edit:** Click directly on a cell to update a record (e.g., manually verifying a user).
*   **Manual Entry:** Use the **"Add Data"** button to manually register a user if needed.

### 3. Running SQL Reports
For advanced data analysis, use the **Query Editor** (Top right of the Data Connect screen):
*   **Example Query (Count Users by Role):**
    ```sql
    SELECT role, count(*) FROM users GROUP BY role;
    ```
*   **Example Query (Find Farmers in a Region):**
    ```sql
    SELECT f.first_name, f.last_name, a.municipality 
    FROM farmers f 
    JOIN addresses a ON f.personal_address_id = a.id 
    WHERE a.province = 'Pampanga';
    ```

---

## 🛡️ SYSTEM SECURITY & MAINTENANCE

### 1. User Permissions
To allow a new team member to manage the database:
1.  Go to **Project Settings (⚙️) > Users and permissions**.
2.  Click **Add member** and enter their email.
3.  Assign the role of **Editor** or **Viewer**.

### 2. Monitoring
*   Use the **Monitoring** tab in Data Connect to see database performance and active connections.
*   **Billing:** Monitor the "No-cost trial" status at the top of the console. Link a billing account before the trial expires to ensure zero downtime.
