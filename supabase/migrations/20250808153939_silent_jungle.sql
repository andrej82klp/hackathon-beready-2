/*
  # Create feedback table

  1. New Tables
    - `feedback`
      - `id` (uuid, primary key)
      - `type` (text, feedback type: general, bug, feature)
      - `subject` (text, feedback subject)
      - `message` (text, feedback content)
      - `rating` (integer, 1-5 rating for general feedback)
      - `name` (text, optional user name)
      - `email` (text, optional user email)
      - `user_id` (uuid, optional reference to authenticated user)
      - `allow_follow_up` (boolean, permission to contact)
      - `anonymous` (boolean, anonymous submission flag)
      - `status` (text, processing status)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `feedback` table
    - Add policy for anyone to submit feedback
    - Add policy for users to read their own feedback
*/

CREATE TABLE IF NOT EXISTS feedback (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type text NOT NULL DEFAULT 'general',
  subject text NOT NULL,
  message text NOT NULL,
  rating integer,
  name text,
  email text,
  user_id uuid,
  allow_follow_up boolean DEFAULT false,
  anonymous boolean DEFAULT false,
  status text DEFAULT 'pending',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Add constraints
ALTER TABLE feedback ADD CONSTRAINT feedback_type_check 
  CHECK (type IN ('general', 'bug', 'feature'));

ALTER TABLE feedback ADD CONSTRAINT feedback_rating_check 
  CHECK (rating IS NULL OR (rating >= 1 AND rating <= 5));

ALTER TABLE feedback ADD CONSTRAINT feedback_status_check 
  CHECK (status IN ('pending', 'reviewed', 'resolved', 'closed'));

-- Add foreign key constraint for user_id
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'users') THEN
    ALTER TABLE feedback ADD CONSTRAINT feedback_user_id_fkey 
      FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE SET NULL;
  END IF;
END $$;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_feedback_type ON feedback(type);
CREATE INDEX IF NOT EXISTS idx_feedback_status ON feedback(status);
CREATE INDEX IF NOT EXISTS idx_feedback_user_id ON feedback(user_id);
CREATE INDEX IF NOT EXISTS idx_feedback_created_at ON feedback(created_at DESC);

-- Enable Row Level Security
ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Anyone can submit feedback"
  ON feedback
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Users can read their own feedback"
  ON feedback
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Create trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.triggers 
    WHERE trigger_name = 'update_feedback_updated_at'
  ) THEN
    CREATE TRIGGER update_feedback_updated_at
      BEFORE UPDATE ON feedback
      FOR EACH ROW
      EXECUTE FUNCTION update_updated_at_column();
  END IF;
END $$;