/*
  # Create tests and questions tables

  1. New Tables
    - `tests`
      - `id` (uuid, primary key)
      - `module_id` (uuid, foreign key to modules, unique)
      - `description` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)
    
    - `questions`
      - `id` (uuid, primary key)
      - `test_id` (uuid, foreign key to tests)
      - `question_text` (text)
      - `options` (jsonb, array of objects with text and is_correct)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on both tables
    - Add policies for public read access
    - Restrict write access to admins

  3. Sample Data
    - Insert First Aid Kit Essentials test and questions
*/

-- Create tests table
CREATE TABLE IF NOT EXISTS tests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id uuid REFERENCES modules(id) ON DELETE CASCADE NOT NULL UNIQUE,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create questions table
CREATE TABLE IF NOT EXISTS questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  test_id uuid REFERENCES tests(id) ON DELETE CASCADE NOT NULL,
  question_text text NOT NULL,
  options jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE tests ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;

-- Public read access policies
CREATE POLICY "Tests are publicly readable"
  ON tests
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Questions are publicly readable"
  ON questions
  FOR SELECT
  TO public
  USING (true);

-- Authenticated users can also read
CREATE POLICY "Authenticated users can read tests"
  ON tests
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can read questions"
  ON questions
  FOR SELECT
  TO authenticated
  USING (true);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_tests_module_id ON tests(module_id);
CREATE INDEX IF NOT EXISTS idx_questions_test_id ON questions(test_id);

-- Create triggers for updated_at
CREATE TRIGGER update_tests_updated_at 
    BEFORE UPDATE ON tests 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_questions_updated_at 
    BEFORE UPDATE ON questions 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample test for First Aid Kit Essentials module
DO $$
DECLARE
    kit_module_id uuid;
    test_id uuid;
BEGIN
    -- Get the First Aid Kit Essentials module ID
    SELECT id INTO kit_module_id 
    FROM modules 
    WHERE title = 'First Aid Kit Essentials';
    
    IF kit_module_id IS NOT NULL THEN
        -- Insert the test
        INSERT INTO tests (module_id, description)
        VALUES (kit_module_id, 'Test your knowledge of first aid kit essentials and proper maintenance.')
        RETURNING id INTO test_id;
        
        -- Insert questions
        INSERT INTO questions (test_id, question_text, options) VALUES
        (test_id, 'What is the primary purpose of a first aid kit?', '[
          {"text": "To replace professional medical care", "is_correct": false},
          {"text": "To provide immediate care until professional help arrives", "is_correct": true},
          {"text": "To treat only minor cuts and bruises", "is_correct": false},
          {"text": "To store medications permanently", "is_correct": false}
        ]'),
        
        (test_id, 'How often should you check your first aid kit for expired items?', '[
          {"text": "Once a year", "is_correct": false},
          {"text": "Every 6 months", "is_correct": false},
          {"text": "Monthly", "is_correct": true},
          {"text": "Only when items are used", "is_correct": false}
        ]'),
        
        (test_id, 'Which of these is NOT an essential item for a basic first aid kit?', '[
          {"text": "Disposable gloves", "is_correct": false},
          {"text": "Adhesive bandages", "is_correct": false},
          {"text": "Prescription medications for others", "is_correct": true},
          {"text": "Antiseptic wipes", "is_correct": false}
        ]'),
        
        (test_id, 'Where should you NOT store a first aid kit?', '[
          {"text": "Kitchen cabinet", "is_correct": false},
          {"text": "Car glove compartment", "is_correct": false},
          {"text": "Bathroom medicine cabinet", "is_correct": false},
          {"text": "Direct sunlight or extreme heat", "is_correct": true}
        ]'),
        
        (test_id, 'What should you do FIRST when using your first aid kit in an emergency?', '[
          {"text": "Start treating the injury immediately", "is_correct": false},
          {"text": "Assess the situation and ensure scene safety", "is_correct": true},
          {"text": "Call 911", "is_correct": false},
          {"text": "Put on gloves", "is_correct": false}
        ]');
    END IF;
END $$;

-- Insert tests for other existing modules
DO $$
DECLARE
    module_record RECORD;
    test_id uuid;
BEGIN
    -- Loop through existing modules and create tests
    FOR module_record IN 
        SELECT id, title FROM modules WHERE title != 'First Aid Kit Essentials'
    LOOP
        -- Insert test for each module
        INSERT INTO tests (module_id, description)
        VALUES (module_record.id, 'Test your knowledge of ' || module_record.title || ' techniques and procedures.')
        RETURNING id INTO test_id;
        
        -- Insert sample questions based on module
        IF module_record.title = 'Emergency Basics' THEN
            INSERT INTO questions (test_id, question_text, options) VALUES
            (test_id, 'What does the "D" in DRABC stand for?', '[
              {"text": "Diagnosis", "is_correct": false},
              {"text": "Danger", "is_correct": true},
              {"text": "Direction", "is_correct": false},
              {"text": "Documentation", "is_correct": false}
            ]'),
            (test_id, 'When should you call 911?', '[
              {"text": "Only for life-threatening emergencies", "is_correct": false},
              {"text": "When the person is unconscious or has severe injuries", "is_correct": true},
              {"text": "After you have treated the injury", "is_correct": false},
              {"text": "Only if you are trained in first aid", "is_correct": false}
            ]'),
            (test_id, 'What is the first step in any emergency response?', '[
              {"text": "Check for breathing", "is_correct": false},
              {"text": "Call for help", "is_correct": false},
              {"text": "Ensure scene safety", "is_correct": true},
              {"text": "Start CPR", "is_correct": false}
            ]');
            
        ELSIF module_record.title = 'CPR & Choking' THEN
            INSERT INTO questions (test_id, question_text, options) VALUES
            (test_id, 'What is the correct compression rate for CPR?', '[
              {"text": "60-80 compressions per minute", "is_correct": false},
              {"text": "100-120 compressions per minute", "is_correct": true},
              {"text": "140-160 compressions per minute", "is_correct": false},
              {"text": "80-100 compressions per minute", "is_correct": false}
            ]'),
            (test_id, 'How deep should chest compressions be for adults?', '[
              {"text": "At least 1 inch", "is_correct": false},
              {"text": "At least 2 inches", "is_correct": true},
              {"text": "At least 3 inches", "is_correct": false},
              {"text": "At least 1.5 inches", "is_correct": false}
            ]'),
            (test_id, 'What is the ratio of compressions to breaths in CPR?', '[
              {"text": "15:2", "is_correct": false},
              {"text": "30:2", "is_correct": true},
              {"text": "20:2", "is_correct": false},
              {"text": "25:2", "is_correct": false}
            ]');
            
        ELSIF module_record.title = 'Bleeding & Wounds' THEN
            INSERT INTO questions (test_id, question_text, options) VALUES
            (test_id, 'What is the first step to control bleeding?', '[
              {"text": "Apply a tourniquet", "is_correct": false},
              {"text": "Apply direct pressure", "is_correct": true},
              {"text": "Elevate the wound", "is_correct": false},
              {"text": "Clean the wound", "is_correct": false}
            ]'),
            (test_id, 'When should you use a tourniquet?', '[
              {"text": "For all bleeding wounds", "is_correct": false},
              {"text": "Only as a last resort for severe limb bleeding", "is_correct": true},
              {"text": "Before applying direct pressure", "is_correct": false},
              {"text": "For minor cuts", "is_correct": false}
            ]'),
            (test_id, 'What should you do before treating any wound?', '[
              {"text": "Take a photo", "is_correct": false},
              {"text": "Clean your hands and wear gloves", "is_correct": true},
              {"text": "Apply antibiotic ointment", "is_correct": false},
              {"text": "Call 911", "is_correct": false}
            ]');
            
        ELSIF module_record.title = 'Burns & Poisoning' THEN
            INSERT INTO questions (test_id, question_text, options) VALUES
            (test_id, 'How long should you cool a burn with running water?', '[
              {"text": "5 minutes", "is_correct": false},
              {"text": "10 minutes", "is_correct": false},
              {"text": "20 minutes", "is_correct": true},
              {"text": "30 minutes", "is_correct": false}
            ]'),
            (test_id, 'What should you NOT do for a burn?', '[
              {"text": "Cool with water", "is_correct": false},
              {"text": "Remove jewelry", "is_correct": false},
              {"text": "Break blisters", "is_correct": true},
              {"text": "Cover with sterile bandage", "is_correct": false}
            ]'),
            (test_id, 'What type of burn appears white or charred?', '[
              {"text": "First-degree", "is_correct": false},
              {"text": "Second-degree", "is_correct": false},
              {"text": "Third-degree", "is_correct": true},
              {"text": "Fourth-degree", "is_correct": false}
            ]');
        END IF;
    END LOOP;
END $$;