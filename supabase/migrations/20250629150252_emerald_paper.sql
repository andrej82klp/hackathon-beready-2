/*
  # Add live field to modules table

  1. Schema Changes
    - Add `live` column to `modules` table
    - Set default value to FALSE
    - Add index for efficient querying

  2. Data Updates
    - Update existing modules to be live (optional - can be done manually)

  3. Notes
    - Only modules with live = TRUE will be displayed on the site
    - Default is FALSE for new modules
*/

-- Add live column to modules table
ALTER TABLE modules 
ADD COLUMN IF NOT EXISTS live boolean DEFAULT false;

-- Add index for efficient querying of live modules
CREATE INDEX IF NOT EXISTS idx_modules_live ON modules(live);

-- Optional: Update existing modules to be live
-- Uncomment the following line if you want all existing modules to be visible immediately
-- UPDATE modules SET live = true WHERE live IS NULL OR live = false;