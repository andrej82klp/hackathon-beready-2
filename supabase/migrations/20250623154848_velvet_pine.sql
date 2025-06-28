/*
  # Fix RLS policy for stories table

  1. Security Changes
    - Drop existing INSERT policy that may be causing issues
    - Create new INSERT policy that properly allows anonymous users to submit stories
    - Ensure the policy correctly enforces approved = false for new submissions

  2. Notes
    - Stories table should allow public submissions with approved defaulting to false
    - Only approved stories should be readable by the public
    - This maintains the moderation workflow while allowing submissions
*/

-- Drop the existing INSERT policy if it exists
DROP POLICY IF EXISTS "Anyone can submit stories" ON stories;

-- Create a new INSERT policy that allows anonymous users to submit stories
-- with approved = false (which is the default)
CREATE POLICY "Allow anonymous story submissions"
  ON stories
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (approved = false);

-- Ensure the SELECT policy is correct for reading approved stories
DROP POLICY IF EXISTS "Anyone can read approved stories" ON stories;

CREATE POLICY "Anyone can read approved stories"
  ON stories
  FOR SELECT
  TO anon, authenticated
  USING (approved = true);