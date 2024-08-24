DROP TABLE IF EXISTS Roles
DROP TABLE IF EXISTS Users
DROP TABLE IF EXISTS Society
DROP TABLE IF EXISTS President
DROP TABLE IF EXISTS Mentor
DROP TABLE IF EXISTS Admin
DROP TABLE IF EXISTS Member
DROP TABLE IF EXISTS EventLog
DROP TABLE IF EXISTS Budget
DROP TABLE IF EXISTS ScheduleEvent
DROP TABLE IF EXISTS Notification
DROP TABLE IF EXISTS Feedback
DROP TABLE IF EXISTS SocietyLogtable


-- Create Roles table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(255)
);

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Password VARCHAR(255),
    Email VARCHAR(255),
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Create Society table
CREATE TABLE Society (
    SocietyID INT PRIMARY KEY,
    SocietyName VARCHAR(255),
    Description TEXT,
    ContactDetails VARCHAR(255),
    ProfilePicture VARCHAR(255),
    PresidentID INT
);

-- Create President table
CREATE TABLE President (
    PresidentID INT PRIMARY KEY,
    UserID INT,
    SocietyID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SocietyID) REFERENCES Society (SocietyID)
);

-- Create Mentor table
CREATE TABLE Mentor (
    MentorID INT PRIMARY KEY,
    UserID INT,
	SocietyID INT,
    FOREIGN KEY (SocietyID) REFERENCES Society(SocietyID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create Admin table
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create Member table
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    SocietyID INT,
    Name VARCHAR(255),
    FOREIGN KEY (SocietyID) REFERENCES Society(SocietyID)
);

-- Create EventLog table
CREATE TABLE EventLog (
    EventLogID INT PRIMARY KEY,
    PresidentID INT,
    EventDate DATE,
    Venue VARCHAR(255),
    Description VARCHAR(255),
    AdminID INT,
    ApprovedByAdmin BIT,
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID),
    FOREIGN KEY (PresidentID) REFERENCES President(PresidentID)
);

-- Create Budget table
CREATE TABLE Budget (
    BudgetID INT PRIMARY KEY,
    EventLogID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (EventLogID) REFERENCES EventLog(EventLogID)
);

-- Create ScheduleEvent table
CREATE TABLE ScheduleEvent (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255),
    EventDate DATE,
    StartTime TIME,
    EndTime TIME,
    Description TEXT,
    SocietyID INT,
    EventLogID INT,
    AdminID INT,
    ApprovedByPresident BIT,
    ApprovedByAdmin BIT,
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID),
    FOREIGN KEY (EventLogID) REFERENCES EventLog(EventLogID)
);

-- Create Notification table
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    AdminID INT,
    Notification_Description VARCHAR(255),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);

-- Inserting roles
INSERT INTO Roles (RoleID, RoleName) VALUES
(1, 'President'),
(2, 'Mentor'),
(3, 'Admin');

-- Inserting users
INSERT INTO Users (UserID, Username, Password, Email, RoleID) VALUES
(1, 'saim', 'saim123', 'saim@gmail.com', 1),
(2, 'Marium ANJUM', 'mariyumanjum123', 'marium@gmail.com', 2),
(3, 'laraib', 'laraib123', 'laraib@gmail.com', 1),
(4, 'affan', 'affan345', 'affan@gmail.com', 1),
(5, 'HAMMAD', 'Hammad789', 'hammad@gmail.com', 3),
(6, 'BILAL khalid', 'bilal khalid345', 'bilalkhalid@gmail.com', 2),
(7, 'hira naveed', 'hira123', 'hira@gmail.com', 2),
(8, 'arsalan arshad', 'arsalan123', 'arsalan@gmail.com', 2),
(9, 'bashir monin', 'bashir123', 'bashir@gmail.com', 2),
(10, 'ibrahim saqib', 'ibrahim123', 'ibrahim@gmail.com', 2),
(11, 'zanaib', 'zanaib345', 'zanaib@gmail.com', 1),
(12, 'rao', 'rao345', 'rao@gmail.com', 1),
(13, 'ansari', 'ansari345', 'ansari@gmail.com', 1);

-- Inserting societies
INSERT INTO Society (SocietyID, SocietyName, Description, ContactDetails, ProfilePicture, PresidentID) VALUES
(1, 'Music Society', 'Engaging in diverse musical expressions and rhythms.', '+92 3175295585', 'society_a.jpg', 1),
(2, 'Computing Society', 'Performing coding competitions.', '+92 3175236585', 'society_b.jpg', 2),
(3, 'Quran and Sunnah Society', 'Spreading and living by Islamic teachings.', '+92 3685295585', 'society_c.jpg', 3),
(4, 'Content Creators Society', 'Sharing creative content across digital platforms.', '+92 3173255585', 'society_d.jpg', 4),
(5, 'Community Service Society', 'Responding to societal needs through volunteerism.', '+92 317585585', 'society_e.jpg', 5),
(6, 'Adventure Society', 'Rapid spontaneity and thrill.', '+92 31753455585', 'society_f.jpg', 6);

-- Inserting presidents
INSERT INTO President (PresidentID, UserID, SocietyID) VALUES
(1, 1, 1),
(2, 3, 3),
(3, 4, 4),
(4, 13, 5),
(5, 12, 6),
(6, 13, 2);

-- Inserting mentors
INSERT INTO Mentor (MentorID, UserID, SocietyID) VALUES
(1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 4),
(5, 6, 5),
(6, 6, 6);

-- Inserting admins
INSERT INTO Admin (AdminID, UserID) VALUES
(1, 5);

-- Inserting members
INSERT INTO Member (MemberID, Name, SocietyID) VALUES
(1, 'Ali Jaffery', 1),
(2, 'Ali Shayan', 1),
(3, 'Huma', 3),
(4, 'Tuba', 3),
(5, 'Laraib', 4),
(6, 'Maham', 4),
(7, 'Taha', 5),
(8, 'Ansari', 6),
(9, 'Silah', 6);
-- Inserting event logs
INSERT INTO EventLog (EventLogID, PresidentID, EventDate, Venue, Description, AdminID, ApprovedByAdmin) VALUES
(1, 1, '2024-03-21', 'Auditorium', 'Some band will perform.', 1, 0),
(2, 3, '2024-03-22', 'Karakorum Lab', 'Programming competition.', 1, 1),
(3, 4, '2024-03-23', 'Block C, First Floor', 'Speech on Islam.', 1, 1),
(4, 2, '2024-03-24', 'Auditorium', 'Rope climbing.', 1, 0),
(5, 2, '2024-03-25', 'Block B', 'Hide and seek.', 1, 0);


-- Inserting budgets
INSERT INTO Budget (BudgetID, EventLogID, Amount) VALUES
(1, 2, 1000.00),
(2, 3, 750.00);

--

-- Inserting schedule events
INSERT INTO ScheduleEvent (EventID, EventName, EventDate, StartTime, EndTime, Description, SocietyID, EventLogID, AdminID, ApprovedByPresident, ApprovedByAdmin) VALUES
(1, 'battle of coding', '2024-03-21', '10:00:00', '12:00:00', 'different student from different cities are gonna perform', 3, 2, 1, 3, 1),
(2, 'importance of religion ', '2024-03-22', '14:00:00', '16:00:00', 'why do we need religion', 4, 3, 1, 4, 1);


INSERT INTO Notification (NotificationID, AdminID, Notification_Description) VALUES
(1, 1, 'Meeting scheduled for next week.'),
(2, 1, 'Reminder: Submit monthly reports by Friday.'),
(3, 1, 'Upcoming maintenance on server.'),
(4, 1, 'Emergency security update.'),
(5, 1, 'Training session for new software update.');

CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    Feedback TEXT,
    Rating INT,
    SocietyID INT,
    FOREIGN KEY (SocietyID) REFERENCES Society(SocietyID)
);



INSERT INTO Feedback (Feedback, Rating, SocietyID)
VALUES
('The event was fantastic! Great job organizing it.', 5, 1),
('I enjoyed the event, but I think there is room for improvement in terms of scheduling.', 4, 1),
('The speaker was very knowledgeable and engaging.', 5, 2),
('I liked the event, but the venue was too crowded.', 3, 1);
select *from Feedback

CREATE TABLE SocietyLogtable (
    SocietyID INT PRIMARY KEY,
    SocietyName VARCHAR(255),
    Description TEXT,
    ContactDetails VARCHAR(255),
    ProfilePicture VARCHAR(255),
    PresidentID INT,
    AdminID INT,
    ApprovedByAdmin BIT,
    FOREIGN KEY (PresidentID) REFERENCES President(PresidentID),
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);


INSERT INTO SocietyLogtable (SocietyID, SocietyName, Description, ContactDetails, ProfilePicture, PresidentID, AdminID, ApprovedByAdmin) VALUES
(1, 'Art Society', 'Promoting artistic expression through various mediums.', '+92 3171234567', 'art_society.jpg', 1, 1, 1);

select * from SocietyLog