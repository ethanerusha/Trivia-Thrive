-- Season 7 rollover migration
-- Run once against the production (Neon) database before deploying the Season 7 code.
-- Safe to re-run: all statements are idempotent.

-- 1. Season columns (existing rows become Season 6)
ALTER TABLE weeks ADD COLUMN IF NOT EXISTS season integer NOT NULL DEFAULT 6;
ALTER TABLE teams ADD COLUMN IF NOT EXISTS season integer NOT NULL DEFAULT 6;
ALTER TABLE champions ADD COLUMN IF NOT EXISTS photo_url text;

-- 2. Future inserts default to Season 7 (code sets season explicitly, this is a safety net)
ALTER TABLE weeks ALTER COLUMN season SET DEFAULT 7;
ALTER TABLE teams ALTER COLUMN season SET DEFAULT 7;

-- 3. Uniqueness is now per-season (team names and week numbers can repeat across seasons)
ALTER TABLE weeks DROP CONSTRAINT IF EXISTS weeks_week_number_unique;
ALTER TABLE teams DROP CONSTRAINT IF EXISTS teams_name_unique;
CREATE UNIQUE INDEX IF NOT EXISTS weeks_season_week_number_idx ON weeks (season, week_number);
CREATE UNIQUE INDEX IF NOT EXISTS teams_season_name_idx ON teams (season, name);

-- 4. Close out Season 6: nothing active, everything published into the archives
UPDATE weeks SET is_active = false, is_published = true WHERE season = 6;

-- 5. Season 6 champion -> Hall of Fame (photo ships with the app at /champions/season6-team-croniq.jpg)
INSERT INTO champions (year, season, team_name, winning_score, photo_url)
SELECT 2026, 'Season 6', 'Team Croniq (+ Rachel)', 0, '/champions/season6-team-croniq.jpg'
WHERE NOT EXISTS (SELECT 1 FROM champions WHERE season = 'Season 6');
UPDATE champions SET photo_url = '/champions/season6-team-croniq.jpg' WHERE season = 'Season 6' AND photo_url IS NULL;

-- 6. Season 7 Week 1 (draft placeholder; add questions in the admin portal)
INSERT INTO weeks (week_number, season, title, intro_text, is_active, is_graded, is_published)
SELECT 1, 7, 'S7W1: Season 7 Kickoff Trivia',
       'Welcome to Season 7 of Tuesday Trivia! Form your team (maximum size 4) and get ready for Week 1.',
       true, false, false
WHERE NOT EXISTS (SELECT 1 FROM weeks WHERE season = 7 AND week_number = 1);
