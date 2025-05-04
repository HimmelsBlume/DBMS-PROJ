-- Query 1: Add a new user (fixed single quotes for string)
INSERT into [User](Name, Login_id, Password, Email, Phone_no, Gender, Age, Ticket_no)
VALUES ('Nisha Patel', 11, 'ohwg', 'nisha@gmail.com', 9839210210, 'F', 23, 211);
SELECT * FROM [User];

-- Query 2: Update email (fixed single quotes)
UPDATE [User]
SET Email = 'Mahek123@gmail.com'
WHERE Login_id = 3;
SELECT * FROM [User];

-- Query 3: Update amount in payment to add taxes (correct arithmetic)
UPDATE Payment 
SET Amount = Amount + (0.15 * Amount);
SELECT * FROM Payment;

-- Query 4: Add 10% festive discount (used alias for calculated field)
SELECT *,
       Price - (Price * 0.1) AS Discounted_Price
FROM Booking;

-- Query 5: Find details of a customer whose name contains "Ag" (case insensitive LIKE)
SELECT *
FROM [User]
WHERE Name LIKE '%Ag%';

-- Query 6: Calculate the total earning from the site
SELECT SUM(Price) AS Total_Earning
FROM Booking;

-- Query 7: Count of male and female managers
SELECT M_Gender AS Gender,
       COUNT(*) AS Total_Managers
FROM Manager
GROUP BY M_Gender;

-- Query 8: Order movies by ratings in descending order
SELECT Movie_id, Movie_Name, Genre, Language, Movie_Rating
FROM Movie
ORDER BY Movie_Rating DESC;

-- Query 9: Delete an account from User table
DELETE FROM [User]
WHERE Login_id = 11;
SELECT * FROM [User];

-- Query 10: Search movies by genre and language
SELECT *
FROM Movie
WHERE Genre = 'Comedy'
  AND Language = 'Hindi';

-- Query 11: Display movie details with show timings
SELECT *
FROM Movie_Show ms
JOIN Movie m ON ms.Movie_id = m.Movie_id;

-- Query 12: Search for a manager in a particular theater
SELECT *
FROM Manager
WHERE Theatre_id = 101;

-- Query 13: Details of users under age 30 (corrected logic to <= 30)
SELECT *
FROM [User]
WHERE Age <= 30;

-- Query 14: Count total seats by type, order by count in descending order
SELECT Seat_Type,
       COUNT(*) AS Seat_Count
FROM Seat
GROUP BY Seat_Type
ORDER BY Seat_Count DESC;

-- Query 15: Managers overseeing theaters with >=5 screens
SELECT M_Name, M_Age
FROM Manager
WHERE Theatre_id IN (
    SELECT Theatre_id
    FROM Theater
    WHERE Screen >= 5
);

-- Query 16: Retrieve movie names and show dates for March 27, 2024
SELECT m.Movie_Name, ms.Show_Date
FROM Movie_Show ms
JOIN Movie m ON ms.Movie_id = m.Movie_id
WHERE ms.Show_Date = '2024-03-27';

-- Query 17: View showing total amount spent by each user
GO
CREATE VIEW TotalAmountSpent AS
SELECT Login_id, SUM(Price) AS Total_Amount_Spent
FROM Booking
GROUP BY Login_id;
GO
SELECT * FROM TotalAmountSpent;

-- Query 18: Add column Salary in Manager table and update values
ALTER TABLE Manager ADD Salary NUMERIC(10, 2);

UPDATE Manager
SET Salary = CASE Theatre_id
    WHEN 101 THEN 50000.00
    WHEN 102 THEN 60000.00
    WHEN 103 THEN 70000.00
    WHEN 104 THEN 80000.00
    WHEN 105 THEN 90000.00
    WHEN 106 THEN 100000.00
    WHEN 107 THEN 110000.00
    WHEN 108 THEN 120000.00
    WHEN 109 THEN 130000.00
    WHEN 110 THEN 140000.00
END;
SELECT * FROM Manager;

-- Query 19: Managers with salary between 50000 and 70000
SELECT M_Name, Salary
FROM Manager
WHERE Salary BETWEEN 50000.00 AND 70000.00;

-- Query 20: Apply discount to tickets for Women's Day
UPDATE Ticket
SET Price = Price * 0.9
WHERE Show_Date = '2024-03-28'
  AND Ticket_no IN (
      SELECT Ticket_no
      FROM [User]
      WHERE Gender = 'F'
  );
SELECT * FROM Ticket;
