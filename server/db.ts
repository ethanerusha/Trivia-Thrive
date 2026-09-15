import { drizzle } from "drizzle-orm/node-postgres";
import pg from "pg";
import * as schema from "@shared/schema";

const { Pool } = pg;

if (!process.env.DATABASE_URL) {
  throw new Error(
    "DATABASE_URL must be set. Did you forget to provision a database?",
  );
}

export const pool = new Pool({ connectionString: process.env.DATABASE_URL });
export const db = drizzle(pool, { schema });

/**
 * Create any tables the app needs that may not exist yet, at boot.
 *
 * This runs on every start and is deliberately idempotent (IF NOT EXISTS),
 * so a deploy is the only step needed to roll out a new table — no separate
 * trip to the database console. It only ever adds; it never drops or alters
 * an existing table, so it can't damage live data.
 */
export async function ensureSchema(): Promise<void> {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS uploaded_images (
      id             VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
      filename       TEXT,
      mime_type      TEXT NOT NULL,
      byte_size      INTEGER NOT NULL,
      data           BYTEA NOT NULL,
      uploaded_by_id VARCHAR REFERENCES users(id),
      created_at     TIMESTAMP NOT NULL DEFAULT NOW()
    );
  `);
  await pool.query(`
    CREATE INDEX IF NOT EXISTS uploaded_images_created_at_idx
      ON uploaded_images (created_at DESC);
  `);
}
