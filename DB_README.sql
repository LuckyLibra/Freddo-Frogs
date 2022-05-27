-- *************************************** --
-- ************ Database README ********** --
-- *************************************** --
------------------------------------------------------------------------
-- Example Queries / Information / TO DO's etc...
-- Some ( hopefully ) helpful queries to make sense of how to use the database

-- ( => Also I've added some of these to DB already as default data for reference :) )
--


-- Database Name: evently
USE evently ;

-- Tables
-- +-------------------+
-- | Tables_in_evently |
-- +-------------------+
-- | Attending         | - fkey_to: User, Event
-- | Calendar_Events   | - fkey_to: Google_Calendar, Events
-- | Date_Time         | date_time_ID :: Stores event start, end dates, and duration - fkey_to: Event
-- | Event_Address     | address_ID :: Stores street #, name, city, etc - fkey_to: Event_Location
-- | Event_Location    | location_ID :: Stores address and venue name - fkey_to: Events, Address
-- | Events            | events_ID :: Stores event info - fkey_to: Attending, Calendar_Events, Event_Location, Date_Time
-- | Google_Calendar   | calendar_ID :: Stores users calendar - fkey_to: User, Events
-- | Permission        | permission_ID :: Stores permissions static
-- | Preference        | preference_ID :: Stores users preferences, bool darkmode, bool email noti ==> 1=ON, 0=OFF
-- | Role              | role_ID :: Stores Roles static ( 1:Admin or 2:User )
-- | Role_Permissions  | - fkey_to: Role, Permission ( Admin have permission 1,2,3,4 --- User have permission 1 )
-- | User              | user_ID :: Stores username and password => fkey_to: User_Profile, Attending, Google_Calendar
-- | User_Preferences  | user_preference_ID - fkey_to: User_Profile, Preference
-- | User_Profile      | user_profile_ID :: Stores full name, email, profile pic etc => fkey_to: User_Role, User_Preferences
-- | User_Role         | - fkey_to: User_Profile, Role
-- +-------------------+



--------------
--- INSERT ---
--------------

-- Add User
--
INSERT INTO User ( username, password )
VALUES ( 'bob1', 'password' ) ;

INSERT INTO User ( username, password )
VALUES ( 'Alice2', '12345' ) ;


-- Add Profile
--
INSERT INTO User_Profile ( user_ID, first_name, last_name, email, image_url )
VALUES ( 1, 'Bob', 'Smith', 'bob@gmail.com', '/puppy.jpg' ) ;

INSERT INTO User_Profile ( user_ID, first_name, last_name, email, image_url )
VALUES ( 1, 'Alice', 'Dawson', 'alice@gmail.com', '/kitty.jpg' ) ;


-------------
--- Roles ---
-------------

-- Add Role - Admin ( => SHOULD ONLY HAVE TO DO THIS ONCE )
--
INSERT INTO Role ( role_name )
VALUES ( 'admin' ) ;


-- Add Role - User ( => SHOULD ONLY HAVE TO DO THIS ONCE )
--
INSERT INTO Role ( role_name )
VALUES ( 'user' ) ;
---


--------------------------
--- Update Admins/User ---
--------------------------

-- Make New User 'Bob' Admin
--
INSERT INTO User_Role ( role_ID, profile_ID )
VALUES ( 1, 1 ) ;


-- Make New User 'Alice' User
--
INSERT INTO User_Role ( role_ID, profile_ID )
VALUES ( 2, 2 ) ;
---

-- UPDATE TO ADMIN
--
UPDATE User_Role
SET User_Role.role_ID = 1
WHERE User_Role.profile_ID = 2 ; -- Alice to admin


-- DOWNGRADE TO USER
--
UPDATE User_Role
SET User_Role.role_ID = 2
WHERE User_Role.profile_ID = 2 ; -- Alice to user


------------------
--- FIND ROLES ---
------------------

-- Find Admins
--
SELECT * FROM User u
INNER JOIN User_Profile up
    ON u.user_ID = up.user_ID
INNER JOIN User_Role ur
    ON up.profile_ID = ur.profile_ID
INNER JOIN Role r
    ON ur.role_ID = r.role_ID
    AND r.role_name = 'admin' ;

-- Find Users
--
SELECT * FROM User u
INNER JOIN User_Profile up
    ON u.user_ID = up.user_ID
INNER JOIN User_Role ur
    ON up.profile_ID = ur.profile_ID
INNER JOIN Role r
    ON ur.role_ID = r.role_ID
    AND r.role_name = 'user' ;

-- Display All
--
SELECT username, role_name FROM User u
INNER JOIN User_Profile up
    ON u.user_ID = up.user_ID
INNER JOIN User_Role ur
    ON up.profile_ID = ur.profile_ID
INNER JOIN Role r
    ON ur.role_ID = r.role_ID ;


-- Select All Roles
--
SELECT * FROM User u
INNER JOIN User_Profile up
    ON u.user_ID = up.user_ID
INNER JOIN User_Role ur
    ON up.profile_ID = ur.profile_ID
INNER JOIN Role r
    ON ur.role_ID = r.role_ID ;


---------------------------------
--- Permissions & Preferences ---
---------------------------------

-- Add Permission
--
-- INSERT INTO Permission ( permission_name, active )
-- VALUES ( 'Name', 1 ) ; -- 1=TRUE : 0=FALSE
--
-- 1    ‘manage_user_info'
INSERT INTO Permission ( permission_name, active )
VALUES ( 'manage_user_info', 1 ) ;

-- 2    ‘manage_users’
INSERT INTO Permission ( permission_name, active )
VALUES ( 'manage_users', 0 ) ;

-- 3    ‘manage_events’
INSERT INTO Permission ( permission_name, active )
VALUES ( 'manage_events', 0 ) ;

-- 4    ‘signup_admin'
INSERT INTO Permission ( permission_name, active )
VALUES ( 'signup_admin', 0 ) ;


---------------------------------------
--- SETS ADMIN AND USER PERMISSIONS ---
---------------------------------------

--
---- So the way I've got it set up is, Admin and User already have these permissions enabled
---- 1. manage_user_info
---- 2. manage_users
---- 3. manage_events
---- 4. signup_admin
----
---- ADMIN has 1,2,3,4 === AND === USER only has 1
----
---- To enable Admin privalages, a user simply has to have there role changed to Admin
----
--

-- Set 1,2,3,4 permissions for admin
--
INSERT INTO Role_Permissions ( role_ID, permission_ID )
VALUES ( 1, 1 ) ;

-- Set 1 permissions for user
--
INSERT INTO Role_Permissions ( role_ID, permission_ID )
VALUES ( 2, 1 ) ;



-- DELETE PERMISSION FROM USER
--
DELETE FROM Role_Permissions
WHERE role_ID = 2
AND permission_ID = 2;



-- UPDATE table1
-- INNER JOIN table2 ON table1.field1 = table2.field2
-- SET table1.field3 = table2.field4
-- WHERE ...... ;


-- VIEW PERMISSIONS
--
SELECT * FROM User_Role ur
LEFT JOIN Role r
    ON r.role_ID = ur.role_ID
LEFT JOIN Role_Permissions rp
    ON rp.role_ID = r.role_ID
LEFT JOIN Permission p
    ON rp.permission_ID = p.permission_ID ;


-- Selects all active User permissions
--
SELECT active
FROM Permission WHERE
permission_ID in (
    SELECT permission_ID FROM Role_Permissions
    WHERE role_ID = 2
) ;


-- Updates all Admin roles to 1
--
UPDATE Permission
SET active=1
WHERE
permission_ID IN (
    SELECT permission_ID FROM Role_Permissions WHERE role_ID IN (
        SELECT role_ID FROM Role
        WHERE Role_Permissions.role_ID = 1
    )
) ;


-- Prints active and role_ID
--
SELECT Permission.active, Role.role_ID FROM Permission, Role WHERE
permission_ID IN (
    SELECT permission_ID FROM Role_Permissions WHERE role_ID IN (
        SELECT role_ID FROM Role
        WHERE Role_Permissions.role_ID = 2
    )
) ;




-- VIEW ALL TABLES
--
SELECT * FROM User u
LEFT JOIN User_Profile up
    ON u.user_ID = up.user_ID
LEFT JOIN User_Role ur
    ON up.profile_ID = ur.profile_ID
LEFT JOIN Role r
    ON ur.role_ID = r.role_ID
LEFT JOIN Role_Permissions rp
    ON rp.role_ID = r.role_ID
LEFT JOIN Permission p
    ON rp.permission_ID = p.permission_ID ;


-------------------
--- Preferences ---
-------------------


--
--
SELECT * FROM User_Preferences ;

INSERT INTO User_Preferences ( user_preference_ID, preference_ID, profile_ID )
VALUE ( 1, 1, 1 ) ;

INSERT INTO User_Preferences ( user_preference_ID, preference_ID, profile_ID )
VALUE ( 2, 2, 2 ) ;

INSERT INTO User_Preferences ( preference_ID )
VALUE ( 2 ) ;

DELETE FROM User_Preferences
WHERE profile_ID = 2 ;

DELETE FROM Preference
WHERE preference_ID = 1 ;


-- Set Dark Mode
--
UPDATE Preference
SET dark_mode = 1
WHERE
preference_ID IN (
    SELECT preference_ID FROM User_Preferences WHERE profile_ID IN (
        SELECT profile_ID FROM User_Profile
        WHERE profile_ID = 1
    )
) ;


-- Set Email Notifications
--
UPDATE Preference
SET email_notifications = 1
WHERE
preference_ID IN (
    SELECT preference_ID FROM User_Preferences WHERE profile_ID IN (
        SELECT profile_ID FROM User_Profile
        WHERE profile_ID = 1
    )
) ;



-- Print USERs Preferences
--
SELECT * FROM User_Preferences up
LEFT JOIN Preference p
    ON p.preference_ID = up.preference_ID ;


SELECT u.username, p.dark_mode, p.email_notifications FROM User u, User_Profile upr, User_Preferences up, Preference p
WHERE p.preference_ID = up.preference_ID AND u.user_ID = upr.user_ID;




----------------------------------
--- Calendar & Calendar EVENTS ---
----------------------------------

-- Add calendar
--

-- NEED OAUTH TOKEN MAYBE
--
-- ! Still need to work out what we need to connect


--------------------------
--- EVENTS & ATTENDING ---
--------------------------

-- Add Date
--
INSERT INTO Date_Time ( start_date_time, end_date_time )
VALUES ( '2022-08-18 10:00:00', '2022-08-19 11:00:00' ) ;

INSERT INTO Date_Time ( start_date_time, end_date_time )
VALUES ( '2022-08-20 11:00:00', '2022-08-20 12:00:00' ) ;


-- Event Duration in days
--
-- ! May need a seperate js function to calculate duration
--
--
SELECT date_time_ID as id,
DATEDIFF ( Date_Time.end_date_time, Date_Time.start_date_time ) as duration
FROM Date_Time
WHERE Date_Time.date_time_ID = 1 ;



-- Add Address
--
-- ! NOTE ! => SHOULD CHECK FIRST WHETHER ADDRESS EXISTS, ELSE ADD
--
--
INSERT INTO Event_Address ( street_number, street_name, city, postcode, country )
VALUES ( 4, 'Test st', 'Adelaide', 5000, 'AU' ) ;

-- Add Location
--
INSERT INTO Event_Location ( address_ID, event_venue )
VALUES ( 1, 'Town Hall' ) ;

-- SELECT JOIN Location
--
SELECT * FROM Event_Location el
LEFT JOIN Event_Address ea
ON el.address_ID = ea.address_ID ;


--  `event_ID` int NOT NULL AUTO_INCREMENT,
--   `date_time_ID` int DEFAULT NULL,
--   `location_ID` int DEFAULT NULL,
--   `event_name` varchar(255) DEFAULT NULL,
--   `event_description` text,
--   `event_image_url` varchar(255) DEFAULT NULL,
--   `event_author` varchar(255) DEFAULT NULL,
--   `num_attending` int DEFAULT NULL,
--   PRIMARY KEY (`event_ID`),
--   KEY `date_time_ID` (`date_time_ID`),
--   KEY `location_ID` (`location_ID`),

INSERT INTO Events ( date_time_ID, location_ID, event_name, event_description, event_image_url, event_author, num_attending )
VALUES ( 1, 1, 'Event 1', 'This is an event...', NULL, 'Bob1', 100 ) ;

-----------------
--- Attending ---
-----------------

INSERT INTO Attending ( user_ID, event_ID, attendance_type )
VALUES ( 1, 1, 'Author' ) ;

INSERT INTO Attending ( user_ID, event_ID, attendance_type )
VALUES ( 2, 1, 'Attending' ) ;

-- Users attending events
--
SELECT * FROM User u
INNER JOIN Attending a
    ON u.user_ID = a.user_ID
INNER JOIN Events e
    ON a.event_ID = e.event_ID ;





-- BACKUP
mysqldump --host=127.0.0.1 --databases evently > evently.sql

-- RESTORE
mysql --host=127.0.0.1 < evently.sql






