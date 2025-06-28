/*
  # Create user stories table

  1. New Tables
    - `stories`
      - `id` (uuid, primary key)
      - `name` (text)
      - `email` (text)
      - `story` (text)
      - `location` (text, nullable)
      - `approved` (boolean, default false)
      - `featured` (boolean, default false)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `stories` table
    - Add policy for public read access to approved stories
    - Add policy for authenticated users to submit stories

  3. Indexes
    - Add indexes for efficient querying by approval status and featured status
*/

CREATE TABLE IF NOT EXISTS stories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  story text NOT NULL,
  location text,
  approved boolean DEFAULT false,
  featured boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE stories ENABLE ROW LEVEL SECURITY;

-- Public can read approved stories
CREATE POLICY "Anyone can read approved stories"
  ON stories
  FOR SELECT
  TO public
  USING (approved = true);

-- Authenticated users can read approved stories
CREATE POLICY "Authenticated users can read approved stories"
  ON stories
  FOR SELECT
  TO authenticated
  USING (approved = true);

-- Anyone can submit stories (they need approval)
CREATE POLICY "Anyone can submit stories"
  ON stories
  FOR INSERT
  TO public
  WITH CHECK (approved = false);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_stories_approved ON stories(approved);
CREATE INDEX IF NOT EXISTS idx_stories_featured ON stories(featured);
CREATE INDEX IF NOT EXISTS idx_stories_created_at ON stories(created_at DESC);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_stories_updated_at 
    BEFORE UPDATE ON stories 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample approved stories
INSERT INTO stories (name, email, story, location, approved, featured) VALUES
(
  'Sarah M.',
  'sarah.m@example.com',
  'When my neighbor collapsed in his driveway, I knew exactly what to do. The CPR training I got from BeReady gave me the confidence to act immediately. I started chest compressions and called 911. The paramedics said my quick action likely saved his life. He made a full recovery and we''re closer friends than ever.',
  'Portland, OR',
  true,
  true
),
(
  'Marcus T.',
  'marcus.t@example.com',
  'My 4-year-old daughter started choking on a piece of apple at dinner. Instead of panicking, I remembered the Heimlich maneuver steps from BeReady. I stayed calm, positioned her correctly, and gave the abdominal thrusts. The apple piece came out within seconds. My wife was amazed at how composed I was - the training really works.',
  'Austin, TX',
  true,
  true
),
(
  'Jennifer L.',
  'jennifer.l@example.com',
  'A coworker had a severe allergic reaction during lunch. She was struggling to breathe and her EpiPen was in her purse. I helped her use it correctly and kept her calm while we waited for the ambulance. The BeReady training taught me to recognize the signs and act quickly. She''s doing great now and always thanks me.',
  'Boston, MA',
  true,
  false
);