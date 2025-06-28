/*
  # Create achievements/badges table

  1. New Tables
    - `achievements`
      - `id` (uuid, primary key)
      - `user_id` (uuid, foreign key to auth.users)
      - `badge_name` (text)
      - `module_id` (uuid, foreign key to modules, nullable)
      - `earned_at` (timestamp)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on `achievements` table
    - Add policy for users to read their own achievements
    - Add policy for users to insert their own achievements

  3. Indexes
    - Add indexes for efficient querying by user_id and badge_name
*/

CREATE TABLE IF NOT EXISTS achievements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  badge_name text NOT NULL,
  module_id uuid REFERENCES modules(id) ON DELETE SET NULL,
  earned_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;

-- Users can read their own achievements
CREATE POLICY "Users can read own achievements"
  ON achievements
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Users can insert their own achievements
CREATE POLICY "Users can insert own achievements"
  ON achievements
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_achievements_user_id ON achievements(user_id);
CREATE INDEX IF NOT EXISTS idx_achievements_badge_name ON achievements(badge_name);
CREATE INDEX IF NOT EXISTS idx_achievements_earned_at ON achievements(earned_at DESC);

-- Prevent duplicate badges for the same user and module
CREATE UNIQUE INDEX IF NOT EXISTS idx_achievements_user_module_unique 
  ON achievements(user_id, module_id) 
  WHERE module_id IS NOT NULL;