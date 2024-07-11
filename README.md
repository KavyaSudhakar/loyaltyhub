Loyalty Hub Application

Current Status

1. Devise for Authentication

Login and Signup Process: Implemented Devise for user authentication, including user registration, login, and password recovery.

Features:
User registration with email and password
User login/logout
Password recovery and reset

2. Transactions

Transaction Management: Implemented a system to track user transactions.

Features:
Recording points earned from transactions
Calculating total points for users

3. Rewards and Reward Types

Rewards System: Developed the reward system where users can claim rewards based on their points and achievements.

Features:
Different types of rewards (RewardType model)
Users can claim rewards (Reward model)
Display available and claimed rewards
background jobs for few rewards to perfom on time 

4. Points System

Points Management: Set up a system to handle points earned from transactions and reward issuance.

Features:
Accumulate points from transactions
Track total points for each user
Displayed in user profile 

5. Loyalty Tiers

Loyalty Program Tiers: Implemented loyalty tiers that offer different rewards and benefits based on the user’s points.

Features:
Defined loyalty tiers (LoyaltyTier model)
Users are assigned to a tier based on their points
Automatic tier updates based on points

6. Profile and Settings

User Profiles and Settings: Added features for managing user profiles and account settings.

Features:
View and update profile information
Manage account settings

Future Enhancements and pending task

1.Points expire every year

2.Loyalty tiers are calculated on the highest points in the last 2 cycles

3.Tracking and updating live location for country while making transaction

## Setup Instructions

To get started with the application:

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/your-repository.git
   cd your-repository

2. Install dependencies:

   bundle install

3. Set up the database:

   rails db:create
   rails db:migrate
   rails db:seed

4. Start the Rails server:

   rails s

5. Open http://localhost:3000 in your web browser.

