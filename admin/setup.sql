DROP DATABASE IF EXISTS Troglodytes;
CREATE DATABASE Troglodytes;
USE Troglodytes;

CREATE TABLE Members (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    picURL VARCHAR(255),
    profileText VARCHAR(10000)
);

CREATE TABLE Logins (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    memberID INT,
    FOREIGN KEY (memberID) REFERENCES Members(id)
);

INSERT INTO Logins (username) VALUES ('admin');

CREATE TABLE Jobs (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO Jobs (title, description) VALUES
('Test Job', 'This is a job only used for testing.'), -- 1
('Webmaster', ''), -- 2
('Front-end Developer', ''), -- 3
('Back-end Developer', ''), -- 4
('Content Specialist', ''), -- 5
('Tech Support', ''), -- 6
('QA Specialist', ''), -- 7
('Site Architect', ''), -- 8
('Publicist', ''), -- 9
('Event Planner', ''), -- 10
('Facilitator', ''), -- 11
('Decorator', ''), -- 12
('Entertainer', ''), -- 13
('Coordinator', ''); -- 14

CREATE TABLE MembersJobs (
	memberID INT,
    jobID INT,
    FOREIGN KEY (memberID) REFERENCES Members(id),
    FOREIGN KEY (jobID) REFERENCES Jobs(id)
);

CREATE TABLE Skills (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE Permissions(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO Permissions (title, description) VALUES
('TEST_PERMISSION', 'This is a permission used only for testing.'), -- 1
('ADMINISTRATOR', 'Grants full permissions.'), -- 2
('ADD_MEMBERS', 'Allows members to create profiles for new members.'), -- 3
('REMOVE_MEMBERS', "Allows members to delete a member's profile."), -- 4
('VIEW_LOGS', 'Allows members to view the logs.'), -- 5
('EDIT_PROFILES', 'Allows members to edit the profiles of other members.'), -- 6
('DELETE_ACCOUNTS', 'Allows members to delete accounts of other people.'), -- 7
('RESET_DATABASE', 'Allows members to reset the database.'), -- 8
('LINK_ACCOUNTS', 'Allows members to link or unlink accounts to members.'), -- 9
('MANAGE_JOBS', 'Allows members to manage who has what job, and the permissions that each job has.'); -- 10

CREATE TABLE JobsPermissions (
	jobID INT,
    permissionID INT,
    FOREIGN KEY (jobID) REFERENCES Jobs(id),
    FOREIGN KEY (permissionID) REFERENCES Permissions(id)
);

INSERT INTO JobsPermissions (jobID, permissionID) VALUES (2, 2), (4, 2), (6, 5);

CREATE TABLE Actions (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO Actions (title, description) VALUES
('TEST_ACTION', 'This is only used for testing.'), -- 1
('OTHER', 'Some other action not specified.'), -- 2
('ACCOUNT_REGISTERED', 'A new account was registered.'), -- 3
('ACCOUNT_UPDATED', "An account's information was updated."), -- 4
('ACCOUNT_DELETED', 'An account was deleted.'), -- 5
('MEMBER_ADDED', 'A member was added to the database.'), -- 6
('MEMBER_UPDATED', "A member's information was updated."), -- 7
('MEMBER_REMOVED', 'A member was removed from the database.'), -- 8
('LOGGED_IN', 'An account logged in.'), -- 9
('LOGGED_OUT', 'An account logged out.'), -- 10
('ACCOUNT_LINKED', 'An account was linked to a member.'), -- 11
('ACCOUNT_UNLINKED', 'An account was unlinked from a member.'); -- 12

CREATE TABLE Logs (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    memberID INT,
    affectedMemberID INT,
    actionID INT NOT NULL,
    description VARCHAR(10000),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (memberID) REFERENCES Members(id),
    FOREIGN KEY (affectedMemberID) REFERENCES Members(id),
    FOREIGN KEY (actionID) REFERENCES Actions(id)
);

CREATE TABLE Projects (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    startDate DATETIME,
    endDate DATETIME
);

INSERT INTO Logs (actionID, description) VALUES (2, 'Completed setup.');