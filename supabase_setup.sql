-- ═══════════════════════════════════════════════════════════
--  POOL SPLITTER — Supabase Schema (v2)
--  Ejecuta en el SQL Editor de tu proyecto Supabase
-- ═══════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS gastos_sessions (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_code  TEXT NOT NULL DEFAULT '',
  session_date  TEXT NOT NULL,
  mesas         JSONB DEFAULT '[]',
  jugadores     JSONB DEFAULT '[]',
  created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE IF NOT EXISTS partidas_sessions (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_code  TEXT NOT NULL DEFAULT '',
  session_date  TEXT NOT NULL,
  partidas      JSONB DEFAULT '[]',
  clasificacion JSONB DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Índices para búsqueda rápida por código + fecha
CREATE INDEX IF NOT EXISTS idx_gastos_code_date   ON gastos_sessions(session_code, session_date);
CREATE INDEX IF NOT EXISTS idx_partidas_code_date ON partidas_sessions(session_code, session_date);

-- RLS
ALTER TABLE gastos_sessions   ENABLE ROW LEVEL SECURITY;
ALTER TABLE partidas_sessions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "allow_all_gastos"   ON gastos_sessions;
DROP POLICY IF EXISTS "allow_all_partidas" ON partidas_sessions;
CREATE POLICY "allow_all_gastos"   ON gastos_sessions   FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_partidas" ON partidas_sessions FOR ALL USING (true) WITH CHECK (true);

-- Si ya tienes la tabla sin session_code, añádelo:
-- ALTER TABLE gastos_sessions   ADD COLUMN IF NOT EXISTS session_code TEXT NOT NULL DEFAULT '';
-- ALTER TABLE partidas_sessions ADD COLUMN IF NOT EXISTS session_code TEXT NOT NULL DEFAULT '';
