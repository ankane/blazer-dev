/*

 Creates Secondary Database Schema to test the use of non standard public schemas 

*/

-- ----------------------------
-- Create schema
-- ----------------------------
CREATE SCHEMA "secondary" ;
SET search_path TO "secondary";

-- ----------------------------
--  Sequence structure for "example_data_id_seq"
-- ----------------------------
DROP SEQUENCE IF EXISTS "example_data_id_seq";
CREATE SEQUENCE "example_data_id_seq" INCREMENT 1 START 3 MAXVALUE 9223372036854775807 MINVALUE 1 CACHE 1;
ALTER TABLE "example_data_id_seq" OWNER TO "postgres";

-- ----------------------------
--  Table structure for "example_data"
-- ----------------------------
DROP TABLE IF EXISTS "example_data";
CREATE TABLE "example_data" (
	"id" int4 NOT NULL DEFAULT nextval('example_data_id_seq'::regclass),
	"name" varchar NOT NULL,
	"when_it_happened" timestamp(6) NOT NULL,
	"what_happened" text NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "example_data" OWNER TO "postgres";

-- ----------------------------
--  Records of "example_data"
-- ----------------------------
BEGIN;
INSERT INTO "example_data" VALUES ('3', 'Birthday', '1979-09-25 00:00:00', 'I was born');
INSERT INTO "example_data" VALUES ('2', 'Floods', '2015-12-02 00:00:00', 'People got wet');
INSERT INTO "example_data" VALUES ('1', 'Apocalypse', '2025-12-20 13:17:47', 'Everyone died');
COMMIT;


-- ----------------------------
--  Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "example_data_id_seq" OWNED BY "example_data"."id";
-- ----------------------------
--  Primary key structure for table "example_data"
-- ----------------------------
ALTER TABLE "example_data" ADD CONSTRAINT "example_data_pkey" PRIMARY KEY ("id") NOT DEFERRABLE INITIALLY IMMEDIATE;

