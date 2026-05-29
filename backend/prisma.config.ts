import "dotenv/config";
import { defineConfig } from "@prisma/config";

const databaseUrl = process.env.DATABASE_URL as string;

if (!databaseUrl) {
  throw new Error("DATABASE_URL is missing in .env file");
}

export default defineConfig({
  schema: "prisma/schema.prisma",
  migrations: {
    path: "prisma/migrations",
  },
  datasource: {
    url: databaseUrl,
  },
});