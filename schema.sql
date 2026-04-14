-- =============================================
-- Ahmar Mahmood Portfolio - Blog Schema
-- Run this in Supabase SQL Editor (one paste)
-- =============================================

-- 1. Create posts table
CREATE TABLE IF NOT EXISTS posts (
  id               UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  title            TEXT        NOT NULL,
  slug             TEXT        UNIQUE NOT NULL,
  content          TEXT        NOT NULL DEFAULT '',
  excerpt          TEXT        DEFAULT '',
  cover_image_url  TEXT        DEFAULT '',
  is_published     BOOLEAN     DEFAULT false,
  published_at     TIMESTAMPTZ,
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- 3. Public can read published posts only
CREATE POLICY "Public read published posts"
  ON posts FOR SELECT
  USING (is_published = true);

-- 4. Authenticated (admin) can do everything
CREATE POLICY "Authenticated manage all posts"
  ON posts FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- 5. Auto-update updated_at on every change
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER posts_updated_at
  BEFORE UPDATE ON posts
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- =============================================
-- DONE. Now create your admin account:
-- Supabase Dashboard → Authentication → Users
-- → "Add user" → enter your email + password
-- =============================================
