-- ═══════════════════════════════════════════════════════════
--  SW STUDIO — Aggiungi tabella categorie
--  Incolla in: Supabase → SQL Editor → New query → Run
-- ═══════════════════════════════════════════════════════════

-- 1. Tabella categorie
CREATE TABLE IF NOT EXISTS categories (
  id         bigserial    PRIMARY KEY,
  type       text         NOT NULL CHECK (type IN ('strength', 'weakness')),
  label      text         NOT NULL,
  sort_order int          NOT NULL DEFAULT 0,
  created_at timestamptz  NOT NULL DEFAULT now()
);

-- 2. Abilita RLS
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- 3. Tutti possono leggere le categorie (operatori le vedono nel form)
CREATE POLICY "anon_select_categories" ON categories
  FOR SELECT TO anon USING (true);

-- 4. Solo admin può aggiungere / eliminare
CREATE POLICY "auth_all_categories" ON categories
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- 5. Categorie predefinite
INSERT INTO categories (type, label, sort_order) VALUES
  ('strength', 'Personale gentile e disponibile',         1),
  ('strength', 'Tempi di attesa brevi',                   2),
  ('strength', 'Studio pulito e igienico',                3),
  ('strength', 'Spiegazioni chiare e dettagliate',        4),
  ('strength', 'Prezzi accessibili',                      5),
  ('strength', 'Orari flessibili',                        6),
  ('strength', 'Ambiente accogliente',                    7),
  ('strength', 'Professionalità elevata',                 8),
  ('strength', 'Tecnologia moderna',                      9),
  ('strength', 'Facile accessibilità / parcheggio',      10),
  ('strength', 'Puntualità negli appuntamenti',          11),
  ('strength', 'Attenzione al paziente',                 12),
  ('weakness', 'Tempi di attesa lunghi',                  1),
  ('weakness', 'Prezzi elevati',                          2),
  ('weakness', 'Difficoltà nel prenotare appuntamenti',   3),
  ('weakness', 'Parcheggio difficile',                    4),
  ('weakness', 'Spiegazioni poco chiare',                 5),
  ('weakness', 'Orari limitati',                          6),
  ('weakness', 'Personale poco disponibile',              7),
  ('weakness', 'Sala d''attesa scomoda',                  8),
  ('weakness', 'Difficoltà nel raggiungere lo studio',    9),
  ('weakness', 'Comunicazione carente',                  10),
  ('weakness', 'Poca flessibilità sugli appuntamenti',   11),
  ('weakness', 'Attesa lunga tra un appuntamento e l''altro', 12);
