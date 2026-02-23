-- ═══════════════════════════════════════════════════════════
--  SWOT Studio — Setup Database Supabase
--  Incolla questo script in: Supabase → SQL Editor → New query
-- ═══════════════════════════════════════════════════════════

-- 1. Tabella segnalazioni
CREATE TABLE IF NOT EXISTS entries (
  id          bigserial PRIMARY KEY,
  created_at  timestamptz NOT NULL DEFAULT now(),
  strengths   text[]      NOT NULL DEFAULT '{}',
  weaknesses  text[]      NOT NULL DEFAULT '{}',
  note        text                 DEFAULT ''
);

-- 2. Abilita Row Level Security
ALTER TABLE entries ENABLE ROW LEVEL SECURITY;

-- 3. Policy: chiunque può INSERIRE (operatori non loggati)
CREATE POLICY "anon_insert" ON entries
  FOR INSERT TO anon
  WITH CHECK (true);

-- 4. Policy: solo utenti autenticati (admin) possono LEGGERE
CREATE POLICY "auth_select" ON entries
  FOR SELECT TO authenticated
  USING (true);

-- 5. Policy: solo admin può ELIMINARE
CREATE POLICY "auth_delete" ON entries
  FOR DELETE TO authenticated
  USING (true);
