CREATE TABLE
  IF NOT EXISTS activities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    location TEXT NOT NULL,
    date TEXT NOT NULL, -- ISO 8601 format (yyyy-MM-dd)
    start_time TEXT, -- Optional
    end_time TEXT, -- Optional
    type TEXT NOT NULL, -- e.g., "Hiking", "Food Tour", "Museum Visit"
    group_size INTEGER,
    capacity INTEGER,
    popularity_score INTEGER, -- to mark "popular"
    is_ending_soon INTEGER DEFAULT 0, -- 0 = false, 1 = true
    is_saved INTEGER DEFAULT 0, -- 0 = false, 1 = true (user can save offline)
    is_joined INTEGER DEFAULT 0 -- 0 = false, 1 = true (user joined activity)
  );

CREATE TABLE
  IF NOT EXISTS activity_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
  );

CREATE TABLE
  IF NOT EXISTS user_actions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    activity_id INTEGER NOT NULL,
    is_saved INTEGER DEFAULT 0,
    is_joined INTEGER DEFAULT 0,
    FOREIGN KEY (activity_id) REFERENCES activities (id)
  );