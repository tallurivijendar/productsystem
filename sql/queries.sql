

---

1. User Upcoming Events

```sql
SELECT u.full_name, e.title, e.city, e.start_date
FROM users u
JOIN registrations r ON u.user_id = r.user_id
JOIN events e ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
AND u.city = e.city
ORDER BY e.start_date;
```

---

2. Top Rated Events

```sql
SELECT e.title, AVG(f.rating) AS avg_rating
FROM events e
JOIN feedback f ON e.event_id = f.event_id
GROUP BY e.event_id
HAVING COUNT(f.feedback_id) >= 10
ORDER BY avg_rating DESC;
```

---

3. Inactive Users

```sql
SELECT u.user_id, u.full_name
FROM users u
LEFT JOIN registrations r ON u.user_id = r.user_id
GROUP BY u.user_id
HAVING MAX(r.registration_date) < CURDATE() - INTERVAL 90 DAY
OR MAX(r.registration_date) IS NULL;
```

---

4. Peak Session Hours

```sql
SELECT event_id, COUNT(*) AS session_count
FROM sessions
WHERE TIME(start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY event_id;
```

---

5. Most Active Cities

```sql
SELECT city, COUNT(DISTINCT user_id) AS users_count
FROM users
GROUP BY city
ORDER BY users_count DESC
LIMIT 5;
```

---

6. Event Resource Summary

```sql
SELECT event_id, COUNT(*) AS total_resources
FROM resources
GROUP BY event_id;
```

---

7. Low Feedback Alerts

```sql
SELECT u.full_name, e.title, f.rating, f.comments
FROM feedback f
JOIN users u ON f.user_id = u.user_id
JOIN events e ON f.event_id = e.event_id
WHERE f.rating < 3;
```

---

8. Sessions per Upcoming Event

```sql
SELECT e.title, COUNT(s.session_id) AS total_sessions
FROM events e
LEFT JOIN sessions s ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id;
```

---

9. Organizer Event Summary

```sql
SELECT organizer_id, status, COUNT(*) AS total_events
FROM events
GROUP BY organizer_id, status;
```

---

10. Feedback Gap

```sql
SELECT e.event_id, e.title
FROM events e
JOIN registrations r ON e.event_id = r.event_id
LEFT JOIN feedback f ON e.event_id = f.event_id
WHERE f.feedback_id IS NULL
GROUP BY e.event_id;
```

---

11. Daily New User Count

```sql
SELECT registration_date, COUNT(*) AS new_users
FROM users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date;
```

---

12. Event with Maximum Sessions

```sql
SELECT event_id, COUNT(*) AS total_sessions
FROM sessions
GROUP BY event_id
HAVING COUNT(*) = (
SELECT MAX(session_count)
FROM (
SELECT COUNT(*) AS session_count
FROM sessions
GROUP BY event_id
) t);
```

---

13. Average Rating per City

```sql
SELECT e.city, AVG(f.rating) AS average_rating
FROM feedback f
JOIN events e ON f.event_id = e.event_id
GROUP BY e.city;
```

---

14. Most Registered Events

```sql
SELECT e.title, COUNT(r.user_id) AS total_registrations
FROM registrations r
JOIN events e ON r.event_id = e.event_id
GROUP BY r.event_id
ORDER BY total_registrations DESC
LIMIT 3;
```

---

15. Event Session Time Conflict

```sql
SELECT s1.event_id, s1.session_id, s2.session_id
FROM sessions s1
JOIN sessions s2
ON s1.event_id = s2.event_id
AND s1.session_id < s2.session_id
AND s1.start_time < s2.end_time
AND s1.end_time > s2.start_time;
```

---

16. Unregistered Active Users

```sql
SELECT u.user_id, u.full_name
FROM users u
LEFT JOIN registrations r ON u.user_id = r.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
AND r.user_id IS NULL;
```

---

17. Multi-Session Speakers

```sql
SELECT speaker_name, COUNT(*) AS sessions_handled
FROM sessions
GROUP BY speaker_name
HAVING COUNT(*) > 1;
```

---

18. Resource Availability Check

```sql
SELECT e.event_id, e.title
FROM events e
LEFT JOIN resources r ON e.event_id = r.event_id
WHERE r.event_id IS NULL;
```

---

19. Completed Events with Feedback Summary

```sql
SELECT e.event_id,
COUNT(DISTINCT r.registration_id) AS total_registrations,
AVG(f.rating) AS avg_rating
FROM events e
JOIN registrations r ON e.event_id = r.event_id
LEFT JOIN feedback f ON e.event_id = f.event_id
WHERE e.status = 'complete'
GROUP BY e.event_id;
```

---

20. User Engagement Index

```sql
SELECT u.user_id, u.full_name,
COUNT(DISTINCT r.event_id) AS events_attended,
COUNT(DISTINCT f.feedback_id) AS feedbacks_submitted
FROM users u
LEFT JOIN registrations r ON u.user_id = r.user_id
LEFT JOIN feedback f ON u.user_id = f.user_id
GROUP BY u.user_id;
```

---

21. Top Feedback Providers

```sql
SELECT u.full_name, COUNT(f.feedback_id) AS total_feedbacks
FROM users u
JOIN feedback f ON u.user_id = f.user_id
GROUP BY u.user_id
ORDER BY total_feedbacks DESC
LIMIT 5;
```

---

22. Duplicate Registrations Check

```sql
SELECT user_id, event_id, COUNT(*) AS duplicate_count
FROM registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;
```

---

23. Registration Trends

```sql
SELECT MONTH(registration_date) AS month,
COUNT(*) AS total_registrations
FROM registrations
WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY MONTH(registration_date);
```

---

24. Average Session Duration per Event

```sql
SELECT event_id,
AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS avg_duration
FROM sessions
GROUP BY event_id;
```

---

25. Events Without Sessions

```sql
SELECT e.event_id, e.title
FROM events e
LEFT JOIN sessions s ON e.event_id = s.event_id
WHERE s.event_id IS NULL;
```
