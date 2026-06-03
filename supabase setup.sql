-- ═══════════════════════════════════════════════════════════
--  POOL SPLITTER — Supabase Schema
--  Ejecuta esto en el SQL Editor de tu proyecto Supabase
-- ═══════════════════════════════════════════════════════════

-- Tabla para historial de GASTOS (billar.html)
CREATE TABLE IF NOT EXISTS gastos_sessions (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_date  TEXT NOT NULL,
  mesas         JSONB DEFAULT '[]',
  jugadores     JSONB DEFAULT '[]',
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Tabla para historial de PARTIDAS (partidas.html)
CREATE TABLE IF NOT EXISTS partidas_sessions (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_date  TEXT NOT NULL,
  partidas      JSONB DEFAULT '[]',
  clasificacion JSONB DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT now()
);

-- Permitir acceso público (anon key) — ajusta según tus necesidades de seguridad
ALTER TABLE gastos_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE partidas_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_gastos" ON gastos_sessions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_partidas" ON partidas_sessions FOR ALL USING (true) WITH CHECK (true);
