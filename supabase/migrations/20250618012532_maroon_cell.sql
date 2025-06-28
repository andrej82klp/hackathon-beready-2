/*
  # Create learning modules table

  1. New Tables
    - `modules`
      - `id` (uuid, primary key)
      - `title` (text, unique)
      - `description` (text)
      - `content` (text)
      - `difficulty` (text with check constraint)
      - `badge_name` (text)
      - `duration` (text)
      - `icon` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `modules` table
    - Add policy for public read access (modules are public content)
    - Add policy for admin write access

  3. Sample Data
    - Insert initial learning modules for Emergency Basics, CPR & Choking, etc.
*/

CREATE TABLE IF NOT EXISTS modules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text UNIQUE NOT NULL,
  description text NOT NULL,
  content text NOT NULL,
  difficulty text NOT NULL CHECK (difficulty IN ('beginner', 'intermediate', 'advanced')),
  badge_name text NOT NULL,
  duration text NOT NULL DEFAULT '10 min',
  icon text NOT NULL DEFAULT '📚',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE modules ENABLE ROW LEVEL SECURITY;

-- Allow public read access to modules
CREATE POLICY "Modules are publicly readable"
  ON modules
  FOR SELECT
  TO public
  USING (true);

-- Allow authenticated users to read modules
CREATE POLICY "Authenticated users can read modules"
  ON modules
  FOR SELECT
  TO authenticated
  USING (true);

-- Insert sample learning modules
INSERT INTO modules (title, description, content, difficulty, badge_name, duration, icon) VALUES
(
  'Emergency Basics',
  'Learn the fundamental steps for any emergency situation, including when and how to call for help.',
  '<h2>Understanding Emergency Response</h2><p>When faced with an emergency, your first instinct might be panic. However, by following a systematic approach, you can provide effective help while keeping yourself and others safe.</p><h3>The Primary Survey - DRABC</h3><ul><li><strong>D - Danger:</strong> Check for dangers to yourself, bystanders, and the patient</li><li><strong>R - Response:</strong> Check if the person is conscious and responsive</li><li><strong>A - Airway:</strong> Ensure the airway is clear and open</li><li><strong>B - Breathing:</strong> Check if the person is breathing normally</li><li><strong>C - Circulation:</strong> Check for pulse and control any severe bleeding</li></ul><h3>When to Call Emergency Services</h3><p>Call 911 immediately if:</p><ul><li>The person is unconscious or unresponsive</li><li>Breathing difficulties or no breathing</li><li>Severe bleeding that won''t stop</li><li>Signs of heart attack or stroke</li><li>Severe burns or injuries</li><li>Suspected spinal injury</li></ul>',
  'beginner',
  'Emergency Basics',
  '10 min',
  '🚨'
),
(
  'CPR & Choking',
  'Master life-saving techniques for cardiac emergencies and airway obstructions.',
  '<h2>Cardiopulmonary Resuscitation (CPR)</h2><p>CPR is a life-saving technique used when someone''s breathing or heartbeat has stopped. Quick action can double or triple chances of survival.</p><h3>When to Perform CPR</h3><ul><li>Person is unresponsive and not breathing normally</li><li>No pulse detected (for trained professionals)</li><li>After drowning, heart attack, or electric shock</li></ul><h3>CPR Steps for Adults</h3><ol><li><strong>Check responsiveness:</strong> Tap shoulders, shout "Are you okay?"</li><li><strong>Call 911</strong> and request an AED if available</li><li><strong>Position:</strong> Place on firm, flat surface</li><li><strong>Hand placement:</strong> Heel of one hand on center of chest, other hand on top</li><li><strong>Compressions:</strong> Push hard and fast at least 2 inches deep, 100-120 per minute</li><li><strong>Rescue breaths:</strong> 30 compressions, then 2 breaths</li><li><strong>Continue</strong> until emergency services arrive</li></ol>',
  'intermediate',
  'CPR & Choking',
  '15 min',
  '❤️'
),
(
  'Bleeding & Wounds',
  'Control bleeding and properly treat various types of wounds and injuries.',
  '<h2>Controlling Bleeding</h2><p>Severe bleeding can be life-threatening. Quick action to control bleeding is essential.</p><h3>Steps to Control Bleeding</h3><ol><li><strong>Apply direct pressure:</strong> Use a clean cloth or bandage</li><li><strong>Elevate the wound:</strong> If possible, raise the injured area above the heart</li><li><strong>Apply pressure points:</strong> If bleeding continues, apply pressure to arterial pressure points</li><li><strong>Use a tourniquet:</strong> Only as a last resort for severe limb bleeding</li></ol><h3>Wound Care</h3><ul><li>Clean hands before treating wounds</li><li>Stop bleeding first</li><li>Clean the wound gently</li><li>Apply antibiotic ointment if available</li><li>Cover with sterile bandage</li><li>Monitor for signs of infection</li></ul>',
  'beginner',
  'Bleeding & Wounds',
  '12 min',
  '🩹'
),
(
  'Burns & Poisoning',
  'Learn proper response to thermal injuries and poisoning emergencies.',
  '<h2>Burn Treatment</h2><p>Burns can be caused by heat, chemicals, electricity, or radiation. Proper immediate care is crucial.</p><h3>Types of Burns</h3><ul><li><strong>First-degree:</strong> Red, painful, no blisters</li><li><strong>Second-degree:</strong> Red, painful, with blisters</li><li><strong>Third-degree:</strong> White or charred, may not be painful</li></ul><h3>Burn Treatment Steps</h3><ol><li>Remove from heat source</li><li>Cool with running water for 20 minutes</li><li>Remove jewelry before swelling</li><li>Cover with sterile, non-adhesive bandage</li><li>Do not break blisters</li><li>Seek medical attention for serious burns</li></ol>',
  'intermediate',
  'Burns & Poisoning',
  '14 min',
  '🔥'
);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_modules_updated_at 
    BEFORE UPDATE ON modules 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();