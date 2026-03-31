--
-- PostgreSQL database dump
--

\restrict xTIj1AMTtl7XK4QDwOUbpfI3VDsJk3kfxE04V8gDfFHaTFWxlbHsoNspG4FL795

-- Dumped from database version 16.12 (0113957)
-- Dumped by pg_dump version 16.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: _system; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA _system;


ALTER SCHEMA _system OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: replit_database_migrations_v1; Type: TABLE; Schema: _system; Owner: neondb_owner
--

CREATE TABLE _system.replit_database_migrations_v1 (
    id bigint NOT NULL,
    build_id text NOT NULL,
    deployment_id text NOT NULL,
    statement_count bigint NOT NULL,
    applied_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE _system.replit_database_migrations_v1 OWNER TO neondb_owner;

--
-- Name: replit_database_migrations_v1_id_seq; Type: SEQUENCE; Schema: _system; Owner: neondb_owner
--

CREATE SEQUENCE _system.replit_database_migrations_v1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _system.replit_database_migrations_v1_id_seq OWNER TO neondb_owner;

--
-- Name: replit_database_migrations_v1_id_seq; Type: SEQUENCE OWNED BY; Schema: _system; Owner: neondb_owner
--

ALTER SEQUENCE _system.replit_database_migrations_v1_id_seq OWNED BY _system.replit_database_migrations_v1.id;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.answers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    submission_id character varying NOT NULL,
    question_id character varying NOT NULL,
    answer_text text NOT NULL,
    points_awarded numeric(2,1) DEFAULT '0'::numeric
);


ALTER TABLE public.answers OWNER TO neondb_owner;

--
-- Name: champions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.champions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    year integer NOT NULL,
    season text,
    team_name text NOT NULL,
    team_id character varying,
    winning_score numeric(6,1) DEFAULT '0'::numeric
);


ALTER TABLE public.champions OWNER TO neondb_owner;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.questions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    week_id character varying NOT NULL,
    question_number integer NOT NULL,
    question_text text NOT NULL,
    correct_answer text NOT NULL,
    max_points integer DEFAULT 1 NOT NULL,
    image_url text
);


ALTER TABLE public.questions OWNER TO neondb_owner;

--
-- Name: score_edits; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.score_edits (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    submission_id character varying NOT NULL,
    question_id character varying NOT NULL,
    old_points numeric(2,1) NOT NULL,
    new_points numeric(2,1) NOT NULL,
    reason text NOT NULL,
    edited_by_id character varying NOT NULL,
    edited_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.score_edits OWNER TO neondb_owner;

--
-- Name: submissions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.submissions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    team_id character varying NOT NULL,
    week_id character varying NOT NULL,
    submitted_at timestamp without time zone DEFAULT now() NOT NULL,
    is_graded boolean DEFAULT false NOT NULL,
    total_points numeric(4,1) DEFAULT '0'::numeric,
    submitted_by_id character varying
);


ALTER TABLE public.submissions OWNER TO neondb_owner;

--
-- Name: team_members; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.team_members (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    team_id character varying NOT NULL,
    user_id character varying NOT NULL,
    is_approved boolean DEFAULT false NOT NULL,
    is_lead boolean DEFAULT false NOT NULL
);


ALTER TABLE public.team_members OWNER TO neondb_owner;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.teams (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    lead_id character varying NOT NULL
);


ALTER TABLE public.teams OWNER TO neondb_owner;

--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    name text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    is_verified boolean DEFAULT true NOT NULL,
    verification_token text
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: weeks; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.weeks (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    week_number integer NOT NULL,
    title text NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    is_graded boolean DEFAULT false NOT NULL,
    is_published boolean DEFAULT false NOT NULL,
    intro_text text,
    deadline timestamp without time zone
);


ALTER TABLE public.weeks OWNER TO neondb_owner;

--
-- Name: replit_database_migrations_v1 id; Type: DEFAULT; Schema: _system; Owner: neondb_owner
--

ALTER TABLE ONLY _system.replit_database_migrations_v1 ALTER COLUMN id SET DEFAULT nextval('_system.replit_database_migrations_v1_id_seq'::regclass);


--
-- Data for Name: replit_database_migrations_v1; Type: TABLE DATA; Schema: _system; Owner: neondb_owner
--

COPY _system.replit_database_migrations_v1 (id, build_id, deployment_id, statement_count, applied_at) FROM stdin;
1	1d4e8d78-5b69-436e-bc95-dc3725b8add5	649600a4-dcad-404e-a275-29df530a2111	16	2026-01-27 05:41:46.123227+00
2	ad29d92a-7a19-4d4a-b722-da02abdc10d2	649600a4-dcad-404e-a275-29df530a2111	7	2026-03-02 17:58:27.249436+00
\.


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.answers (id, submission_id, question_id, answer_text, points_awarded) FROM stdin;
7a4ed54a-0cfd-4289-88e4-d687b54f6718	485310a0-f7df-4b1f-8390-c28d6f86b495	97d044fd-329c-4e54-a3e1-8a8374dae289	General Electric	0.0
fbfebdb5-6016-4946-a33e-055b424a7306	485310a0-f7df-4b1f-8390-c28d6f86b495	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
0c3bbd38-756a-4213-8385-a35d58e284a0	485310a0-f7df-4b1f-8390-c28d6f86b495	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow cone	1.0
67e97e64-a479-4213-aefd-87da2751c82a	485310a0-f7df-4b1f-8390-c28d6f86b495	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquis	1.0
d9885857-bcf5-4025-83e7-02dfba5fae53	485310a0-f7df-4b1f-8390-c28d6f86b495	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Tim Burton	0.0
4174f0fb-4968-40e2-abd6-61c0fa127534	485310a0-f7df-4b1f-8390-c28d6f86b495	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shae Jackson	1.0
62c1999f-38d6-41f3-9cc2-3b4696fb1c53	485310a0-f7df-4b1f-8390-c28d6f86b495	7251c912-433d-4305-b471-54f2b9877c98	-1000	0.0
6110d0d6-ef72-4ce6-b52a-1a667e621520	485310a0-f7df-4b1f-8390-c28d6f86b495	8444d762-c013-4470-a00d-f626a5494c3d	Copper	0.0
cb73211d-94aa-46e0-9f27-1e52c4670b26	485310a0-f7df-4b1f-8390-c28d6f86b495	0856b4f2-0098-4f16-82fe-15c492450e95	Edgar Allen Poe	0.0
fe8e8a23-9fae-4e39-a5f8-c2fc240d1040	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
7c73f169-789b-4f6a-b1b7-60e0db16352e	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	?	0.0
0835a9e5-69ba-43ac-b796-1539c8a7cd19	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	97d044fd-329c-4e54-a3e1-8a8374dae289	?	0.0
170b7ad0-8804-4649-8b33-dd4eb5b7b968	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow Cones	1.0
acbfa983-86a3-4b24-8c85-6e0d54d4489a	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
766495c9-6b73-4d08-8e58-83cd895eb16a	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	7251c912-433d-4305-b471-54f2b9877c98	-169	0.0
728c3a3d-4589-4094-81f8-52203a3f02b4	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Princess	0.0
27cad0af-014c-4af7-9668-8ef04462c004	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
1a0a9d1e-396f-43a1-8b91-237905cf21d2	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	0856b4f2-0098-4f16-82fe-15c492450e95	Keats	0.0
41faf22c-08c9-4753-82b4-e046c0281e02	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
467782d7-e520-47b9-840c-8c651a4e03d1	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	97d044fd-329c-4e54-a3e1-8a8374dae289	-	0.0
f7acd9b9-9736-4b34-a059-f96817306010	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	83642d04-c127-4ef0-b12a-33e397e3b898	-	0.0
4c3a25f1-8769-437e-a391-9e1ed892b271	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	0856b4f2-0098-4f16-82fe-15c492450e95	-	0.0
eab34e0d-b884-4a5a-90c3-af5329b51a8b	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow Cones	1.0
39e7066d-ef6a-41f6-88d2-3a0139ea2bec	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
e854da8f-a326-4668-9403-27df90f9b7c1	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
3a9eda79-565d-4e8c-b0c6-f7744fec03c2	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
4ba6cad7-f331-4464-a3bb-e7fa5fea6403	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
22bba795-822f-4b1f-9564-46230c939fd1	ad9457fa-42fe-4196-9beb-274849ff9f93	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
ad174200-a6c6-4de9-931c-3d4f0e08bcbe	ad9457fa-42fe-4196-9beb-274849ff9f93	0856b4f2-0098-4f16-82fe-15c492450e95	walt whitman	0.0
6a840d07-7b3b-45a2-8094-9b94704ffafa	ad9457fa-42fe-4196-9beb-274849ff9f93	83642d04-c127-4ef0-b12a-33e397e3b898	horned frog	0.0
ca644759-6975-46fe-b544-86a5679edfcd	ad9457fa-42fe-4196-9beb-274849ff9f93	97d044fd-329c-4e54-a3e1-8a8374dae289	radarama	0.0
77dce5a1-fb1f-4ca9-b113-1bf922d5f39f	ad9457fa-42fe-4196-9beb-274849ff9f93	63c24528-abc9-4a55-9764-1f412ac2f6de	joseph gordon-levitt	1.0
75a1d9ab-5b8a-4110-898e-231db839cd72	ad9457fa-42fe-4196-9beb-274849ff9f93	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	earl smith	0.0
3f368657-31e7-418a-8245-f5d0d0bf3049	ad9457fa-42fe-4196-9beb-274849ff9f93	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	stephen king	0.0
40f83fa9-5362-4925-9e66-5b9223b7761f	ad9457fa-42fe-4196-9beb-274849ff9f93	7251c912-433d-4305-b471-54f2b9877c98	-273 C	1.0
50c654d4-f3d4-4af9-ab57-2800891150dd	ad9457fa-42fe-4196-9beb-274849ff9f93	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	football	0.0
86cd864b-2565-4767-bb97-96fd25161dfb	b06840bd-3ddc-403a-bc83-12ff97dbd510	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
baaff799-7dd8-45f1-9639-fdf2a25ea6a7	b06840bd-3ddc-403a-bc83-12ff97dbd510	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Beyonce	0.0
c21082c1-e42d-4c53-98b5-59d3b3fad5f6	b06840bd-3ddc-403a-bc83-12ff97dbd510	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
70459a33-d7ef-4e34-a303-dfe99e79554d	b06840bd-3ddc-403a-bc83-12ff97dbd510	83642d04-c127-4ef0-b12a-33e397e3b898	Wood Frog	1.0
0c2a50cc-816b-4f47-97b1-5318b7ef36c7	b06840bd-3ddc-403a-bc83-12ff97dbd510	97d044fd-329c-4e54-a3e1-8a8374dae289	Heat-o-matic	0.0
43e27c5c-ea09-4240-84ac-6f4d0c6e236f	b06840bd-3ddc-403a-bc83-12ff97dbd510	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Leavitt	1.0
20e75929-e43e-41d3-a5cb-e1fc735d3b90	b06840bd-3ddc-403a-bc83-12ff97dbd510	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow cone	1.0
6ebd97ca-83f2-4d37-8d6f-075c193d42fa	b06840bd-3ddc-403a-bc83-12ff97dbd510	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
98fd97ff-3884-4e32-b2ba-2607b504bf7a	ad9457fa-42fe-4196-9beb-274849ff9f93	e54480ed-cc7a-404c-8bd8-68d66b5e9209	snowcone	1.0
7e155437-c8ef-4bc2-8778-7afd5e4fd9d6	d4c26f75-db5c-4538-b9c4-a8854ae01fd9	83642d04-c127-4ef0-b12a-33e397e3b898	Bullfrog	0.0
cf947519-aa29-4e7f-bb9f-272e20bf2cb7	b06840bd-3ddc-403a-bc83-12ff97dbd510	7251c912-433d-4305-b471-54f2b9877c98	-273 C	1.0
1cf45158-e32b-4523-b249-a10c8cbfb5b1	485310a0-f7df-4b1f-8390-c28d6f86b495	83642d04-c127-4ef0-b12a-33e397e3b898	Tree frog	0.0
ff223c97-23a3-4d79-a223-418723ede760	da9327d9-18a5-435f-a4ef-ca7ccf31c7db	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Princess Cut	0.0
76b3cd56-e516-4019-b28b-bdc508ab2e03	961da27c-0bd1-44ef-b132-2c2ad4eaf380	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Sno cone	1.0
b3c1fafe-0690-4b8f-a638-915851564f91	961da27c-0bd1-44ef-b132-2c2ad4eaf380	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
65e2fdbf-9cf0-4d57-bf20-b100639ec06c	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O’Shea Jackson	1.0
8b9aae13-c4fd-4488-9dcb-da2f7f9832de	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
e1e3e884-19ea-44ed-9d79-3b49b76c25b0	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	7251c912-433d-4305-b471-54f2b9877c98	-270	0.0
52563d97-ed58-4c50-a5b0-9403465b2011	961da27c-0bd1-44ef-b132-2c2ad4eaf380	7251c912-433d-4305-b471-54f2b9877c98	-243 degrees	0.0
a32f54dd-fa6d-420f-b210-97fc04aa69f7	961da27c-0bd1-44ef-b132-2c2ad4eaf380	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise Diamond	1.0
841cd4fe-3d43-4216-a410-265f5f82a429	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise cut	1.0
c7c609c7-4e2f-46da-89e8-8313d803774d	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
a275d21b-4d76-42af-a571-27ea304b957e	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
98fa7b5a-a077-433a-9037-8574d6675e05	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	83642d04-c127-4ef0-b12a-33e397e3b898	Wood frog	1.0
ce97dbd9-bcd4-41e6-912b-ed059eb45b65	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	97d044fd-329c-4e54-a3e1-8a8374dae289	Radarange	1.0
e591d685-0384-4fdb-9cd9-32808afbf347	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Leavitt	1.0
4a5a922d-15a5-4319-9d65-74f177edcf37	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	0856b4f2-0098-4f16-82fe-15c492450e95	walt Whitman	0.0
7381241c-659a-4f3e-8bcd-f19c9705ecd5	b06840bd-3ddc-403a-bc83-12ff97dbd510	0856b4f2-0098-4f16-82fe-15c492450e95	Wordsworth?	0.0
3fd04d36-f7d2-409c-8cb7-ceabd3c6b382	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
c914c7f8-00dc-42a8-a7a8-9138c8c3c796	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	0856b4f2-0098-4f16-82fe-15c492450e95	Emily Dickinson	0.0
8b03eec2-9c1b-4d31-b3f9-00669696ce3f	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	83642d04-c127-4ef0-b12a-33e397e3b898	Wood frog	1.0
4fb19107-15f1-486e-b1df-4510c21af682	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	97d044fd-329c-4e54-a3e1-8a8374dae289	Raytheon	0.0
ac2a9b8f-5ec4-4de1-bd15-3f6377063bc6	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon levitt	1.0
104b321c-29b0-4845-95b6-de908aacf69d	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snowcones	1.0
f2e8991a-fead-404a-b5ac-5140e545bd53	2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Yellow snow cones	1.0
b720bc91-4779-4258-ac25-cdd9c704bbe8	961da27c-0bd1-44ef-b132-2c2ad4eaf380	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Oshea Jackson	1.0
a5e70cce-817d-4310-9501-c15b30582d2d	961da27c-0bd1-44ef-b132-2c2ad4eaf380	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
e5e682a4-fa67-475a-a6c0-bf426c86806c	961da27c-0bd1-44ef-b132-2c2ad4eaf380	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi	1.0
d24cf6ed-1b24-41e2-859d-2f703a73f375	961da27c-0bd1-44ef-b132-2c2ad4eaf380	83642d04-c127-4ef0-b12a-33e397e3b898	Wood Frog	1.0
c91f1e37-cd75-4915-82be-be9f523cc6a1	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Stephen King	0.0
75b47d9b-d8d3-46b7-beff-14f8306e45e2	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
fc9be94d-ac2c-4884-b9fa-16e9a728885f	ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
6528717f-b670-4532-b8fa-5008d572ebb0	961da27c-0bd1-44ef-b132-2c2ad4eaf380	97d044fd-329c-4e54-a3e1-8a8374dae289	Radar Range	1.0
ba11408f-d871-4032-a229-c97f36b4962d	48e5624f-068d-4694-aca7-4041b607aa79	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
05d13016-4b45-40f6-aa92-0f34c4622278	48e5624f-068d-4694-aca7-4041b607aa79	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
d5052cb5-76e9-4d68-a5aa-7c073445a0a6	48e5624f-068d-4694-aca7-4041b607aa79	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
d804778d-1003-48a4-bf50-a74ded81d609	48e5624f-068d-4694-aca7-4041b607aa79	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
15b29e35-057e-417b-8d0d-bc0b7dadc5fb	48e5624f-068d-4694-aca7-4041b607aa79	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
048273be-59a1-479d-a1bb-e100cbab10da	48e5624f-068d-4694-aca7-4041b607aa79	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
59004e43-ce64-421b-8354-0c330d726ab3	48e5624f-068d-4694-aca7-4041b607aa79	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
b80218bf-c33f-4c98-9a34-d088e3a9fd8c	48e5624f-068d-4694-aca7-4041b607aa79	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Sam LaPorta	0.0
50408349-89c9-41ef-b16b-7877eb310930	acef5f06-c17a-49b7-8f92-d55f6bc3846f	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
457304c2-94a6-4ccb-98fd-b8e25ce4e3e7	fd339ac5-cfc9-45c6-888a-8028f34879ec	1fbd051a-9a46-4743-8e32-f2b064edd9a6	-	0.0
ed057cd0-30cf-4ddf-b770-57f67e09e563	9737632c-0648-4d1d-8ddf-3a287fcb6572	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
9f095a37-77b8-4b08-a506-9c397be7e963	fd339ac5-cfc9-45c6-888a-8028f34879ec	3a08309f-da7d-4a81-b973-049736e0ef69	-	0.0
3c3c013a-2b6c-4d60-8ea3-cbc61b8eb708	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
cf794c03-3411-4b42-ac06-a72375e23328	af40f930-138a-4df4-a537-15bc309386a3	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
ab997822-3df1-4090-adc2-4adbebb0ab86	48e5624f-068d-4694-aca7-4041b607aa79	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
0d44b7c7-1491-46a0-835a-aca7b1093221	48e5624f-068d-4694-aca7-4041b607aa79	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
65de7ca8-50f5-4eec-8980-4271f9bafe32	acef5f06-c17a-49b7-8f92-d55f6bc3846f	3a08309f-da7d-4a81-b973-049736e0ef69	-	0.0
29ba8441-3f04-4638-b7ac-8e58266b17db	acef5f06-c17a-49b7-8f92-d55f6bc3846f	a362d4d9-6e56-4e50-8dc0-45935ed91a11	-	0.0
a2944b77-9126-49d1-b729-dfa066d76949	acef5f06-c17a-49b7-8f92-d55f6bc3846f	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
c114cac5-fde3-406a-8d80-9748327ae5fa	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
b7d84360-4b3d-4b41-aae6-99fe18339fc7	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquis cut	1.0
8e5a8f29-2521-44f7-bf54-07e2f59a82c4	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	8444d762-c013-4470-a00d-f626a5494c3d	iron	1.0
c768386e-e492-4d5b-9ec4-80c4c2e9dd25	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi	1.0
d2fc5e8e-a53a-40db-b94f-8c0d77b30910	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	97d044fd-329c-4e54-a3e1-8a8374dae289	Radarange	1.0
f72ac730-948d-4626-939b-bef94c796a32	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	83642d04-c127-4ef0-b12a-33e397e3b898	frog frog	0.0
636a701d-9121-466e-9035-84c728670d6b	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	63c24528-abc9-4a55-9764-1f412ac2f6de	Tom Hanks	0.0
3876283f-ab57-4778-a20d-c186571daed3	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Sno-cones	1.0
6fcfd1bc-5595-4b87-a5ef-af79a5e0415f	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shae Jackson	1.0
813e1c99-9ca5-4406-8999-c31cd72d04d5	57e81a1d-fce1-4c10-906e-13a628becb93	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
2773c67c-1191-4d25-a3a5-2fc224338ea6	57e81a1d-fce1-4c10-906e-13a628becb93	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
39e93ffb-fb03-442d-b8aa-ab54e947d10d	57e81a1d-fce1-4c10-906e-13a628becb93	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
738d9647-bb7d-440b-8d2c-e50e3c0d75b2	57e81a1d-fce1-4c10-906e-13a628becb93	8444d762-c013-4470-a00d-f626a5494c3d	Copper	0.0
dacac9dc-d027-49a0-9fb2-6b3dc53c725e	57e81a1d-fce1-4c10-906e-13a628becb93	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi	1.0
eb13a5e6-1909-4ae0-82f5-8b73d2828d7a	57e81a1d-fce1-4c10-906e-13a628becb93	83642d04-c127-4ef0-b12a-33e397e3b898	Brown hopper	0.0
6c2b5649-4455-447c-8277-571eb08dfb9d	57e81a1d-fce1-4c10-906e-13a628becb93	97d044fd-329c-4e54-a3e1-8a8374dae289	Microspark	0.0
950f10e1-eada-4a1f-8ada-8d4bb5f1fd88	57e81a1d-fce1-4c10-906e-13a628becb93	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
926085dd-87da-47f2-81eb-78f1aa992fa3	57e81a1d-fce1-4c10-906e-13a628becb93	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Yellow Snow	0.0
3c3844ab-4c60-469e-872d-9ea3a0e7bdc5	8396455b-6b9c-4715-a638-685ac712b05c	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
7cd86aad-f5df-4ecb-97be-008eb8b955c3	8396455b-6b9c-4715-a638-685ac712b05c	7251c912-433d-4305-b471-54f2b9877c98	-275	1.0
eb27f278-7a00-47f3-9e8e-46194a968fa1	8396455b-6b9c-4715-a638-685ac712b05c	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
09bf9231-7ffb-44eb-8571-a5cf9f085eba	8396455b-6b9c-4715-a638-685ac712b05c	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Sean Jackson	1.0
15c4799e-dd52-4079-a3eb-8dc8a17e0dcc	8396455b-6b9c-4715-a638-685ac712b05c	8444d762-c013-4470-a00d-f626a5494c3d	Iron ore	1.0
eaf989fb-8bc5-4118-861d-d1e9545a1587	8396455b-6b9c-4715-a638-685ac712b05c	0856b4f2-0098-4f16-82fe-15c492450e95	idk	0.0
d26b1f12-1e6e-4374-9549-00f12c4b4291	8396455b-6b9c-4715-a638-685ac712b05c	83642d04-c127-4ef0-b12a-33e397e3b898	North American Tree Frog	0.0
e26bbfd9-ea1f-44a3-9c9c-0962bc6144ea	8396455b-6b9c-4715-a638-685ac712b05c	97d044fd-329c-4e54-a3e1-8a8374dae289	GE	0.0
51c28c76-1fde-4c6e-b434-d78bc4d4d05c	8396455b-6b9c-4715-a638-685ac712b05c	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
e93a18f0-60df-44c6-b25a-91154d285f57	375664fe-e8da-46c7-86ac-83a430b6b8c8	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
01f612c5-087b-43a5-9ec8-e517559d2558	375664fe-e8da-46c7-86ac-83a430b6b8c8	7251c912-433d-4305-b471-54f2b9877c98	-278	1.0
36c02b27-c365-4686-82c5-96784c0b5447	375664fe-e8da-46c7-86ac-83a430b6b8c8	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
42909a91-fff7-4145-acbf-84d34a7b9350	375664fe-e8da-46c7-86ac-83a430b6b8c8	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Steve	0.0
5200e669-a9ef-4c71-8794-8ce99dd7a603	375664fe-e8da-46c7-86ac-83a430b6b8c8	8444d762-c013-4470-a00d-f626a5494c3d	Copper	0.0
e80ecf29-ecd8-47dd-9ef4-71d5fb8d8aa9	375664fe-e8da-46c7-86ac-83a430b6b8c8	0856b4f2-0098-4f16-82fe-15c492450e95	Silverstein	0.0
a5655e25-81ac-4c6d-a8dc-e33282164221	375664fe-e8da-46c7-86ac-83a430b6b8c8	83642d04-c127-4ef0-b12a-33e397e3b898	American Bullfrog	0.0
6cb0e34c-9634-4894-83f5-43c37e5b00bf	375664fe-e8da-46c7-86ac-83a430b6b8c8	97d044fd-329c-4e54-a3e1-8a8374dae289	Warmer Box	0.0
bc84f673-d7f3-4b2b-a886-859c5a350bcc	375664fe-e8da-46c7-86ac-83a430b6b8c8	63c24528-abc9-4a55-9764-1f412ac2f6de	Leonardo Dicaprio	0.0
c145c811-252e-4f55-9b5a-dc44ba6ef4fc	375664fe-e8da-46c7-86ac-83a430b6b8c8	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow Cones	1.0
5b190513-b27c-41d2-a297-abffa198bb63	961da27c-0bd1-44ef-b132-2c2ad4eaf380	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
87786c57-2dd4-4392-8f64-096fe76edad3	0a1b2f94-0921-445e-b1f6-157d01232314	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
c52a7bbc-5876-4f32-bc12-3823e7a69255	0a1b2f94-0921-445e-b1f6-157d01232314	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquis	1.0
e2f8c23f-e955-4fbf-93ab-e66ddc2eb0db	8396455b-6b9c-4715-a638-685ac712b05c	e54480ed-cc7a-404c-8bd8-68d66b5e9209	snow cones	1.0
de2eca6f-df39-4b7b-8fff-7f3e89a52b8c	0a1b2f94-0921-445e-b1f6-157d01232314	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
b6f97f9b-6f3b-46ab-8bcd-ccbc89ab2f6e	0a1b2f94-0921-445e-b1f6-157d01232314	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
12dfb391-efff-4853-a437-1d10d5b8e683	0a1b2f94-0921-445e-b1f6-157d01232314	0856b4f2-0098-4f16-82fe-15c492450e95	Edgar Allan Poe	0.0
d9adf7cf-9bc0-486d-8e14-3fda7825ad92	0a1b2f94-0921-445e-b1f6-157d01232314	83642d04-c127-4ef0-b12a-33e397e3b898	Wood Frog	1.0
6d160e79-5604-4717-b0d6-ab685b208b10	0a1b2f94-0921-445e-b1f6-157d01232314	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Yellow Snow Cones	1.0
4cb5a2d5-72a5-4bb1-b179-a5046b4255c6	57e81a1d-fce1-4c10-906e-13a628becb93	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
0859728e-6360-4514-92f8-d2f3a85be876	2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gayman	1.0
5f0eeb9e-c7ed-4d68-a04b-dc0837104b5d	0a1b2f94-0921-445e-b1f6-157d01232314	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
d905150f-8119-48fa-a4fb-10bd221977e3	acef5f06-c17a-49b7-8f92-d55f6bc3846f	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
b3a28d74-55fb-498f-b09d-21c47c646c8f	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	7251c912-433d-4305-b471-54f2b9877c98	-246	0.0
8ece0c83-f483-4653-9304-36746c427b64	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
6a80b264-2717-4744-be03-6f5018ab2dac	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
fc468441-2981-4e0a-8c73-05ff5dbcae88	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	0856b4f2-0098-4f16-82fe-15c492450e95	Dr. Seuss	0.0
939cb11f-d4f4-460f-94da-2a2930389a08	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	83642d04-c127-4ef0-b12a-33e397e3b898	Wood Frog	1.0
22da4661-4208-4ac7-8a3e-2d223ebf1d7d	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	97d044fd-329c-4e54-a3e1-8a8374dae289	Raytheon	0.0
0ac7ae83-ec57-40b8-a994-929986fd367b	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
e33e9617-fecd-4ddb-b7c2-5f9d3a68521d	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snowcones	1.0
3c9d2671-f124-4506-8216-2e06cd79fecd	898fbb30-d96a-40c5-b01c-9e6ac59843f2	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Shakespere	0.0
4af45393-c250-4281-a370-211bef6cbb4f	898fbb30-d96a-40c5-b01c-9e6ac59843f2	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
e0a3e3c1-8508-4de9-acc1-084f5de221ec	898fbb30-d96a-40c5-b01c-9e6ac59843f2	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Football	0.0
51f9a2a3-cb19-4856-94e1-af406bd91cd0	898fbb30-d96a-40c5-b01c-9e6ac59843f2	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
851b6f73-f76d-4318-bab7-696ed97fea0a	898fbb30-d96a-40c5-b01c-9e6ac59843f2	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
3cdc9372-da21-4f0d-8fa8-eb28dea18a08	898fbb30-d96a-40c5-b01c-9e6ac59843f2	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi - Scottish	1.0
bc947807-1df7-47bc-8191-0d4463bcccd1	898fbb30-d96a-40c5-b01c-9e6ac59843f2	83642d04-c127-4ef0-b12a-33e397e3b898	Bullfrog	0.0
9d000c69-a4cd-41a8-b056-e3614dd3218e	898fbb30-d96a-40c5-b01c-9e6ac59843f2	97d044fd-329c-4e54-a3e1-8a8374dae289	Heatwave	0.0
9a88a35a-d51d-4a49-a660-263f8c3f7161	898fbb30-d96a-40c5-b01c-9e6ac59843f2	63c24528-abc9-4a55-9764-1f412ac2f6de	JGL	1.0
0e50c9c3-6c5d-4f6d-bad1-13497e5ee2ea	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow Cones	1.0
c40227b3-0cfa-4460-bb79-3b24448c82d4	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
f6cfd955-bb9a-4d30-be04-8b70b1af37cc	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	7251c912-433d-4305-b471-54f2b9877c98	-273.15	1.0
e09ed235-c963-48ff-bb49-5f419ce9f87d	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquis Cut	1.0
765822c7-9e2f-4f89-8a7f-b4351669fa42	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O’Shea Jackson	1.0
79c92c5d-48ab-4ed3-b62e-f457f5bf1921	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
07f4f26a-3eeb-479e-9ef4-f2cfcc053752	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	0856b4f2-0098-4f16-82fe-15c492450e95	Walt Whitman	0.0
2dde946b-0dcb-4750-b2a6-19a0c598f1ba	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	83642d04-c127-4ef0-b12a-33e397e3b898	Wood Frog	1.0
d06249a0-f347-41ec-b66d-f656226c240f	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	97d044fd-329c-4e54-a3e1-8a8374dae289	Easy Bake	0.0
7aae333f-d0f4-4171-8e61-cd984c670472	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
69727860-31b9-4e99-ae57-e4b12fa0ae5b	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
23ee945b-afbc-4458-9327-d110422cc382	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Oshea Jackson	1.0
bbb57cc5-3346-4221-998c-ee71cbd2f024	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snowcone	1.0
eee7fbfd-60a8-47e8-9325-f9d63f1302f0	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Tim Burton	0.0
fb7ad963-752e-4265-ac2b-d8b3aed4a44d	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	7251c912-433d-4305-b471-54f2b9877c98	-273	1.0
578add28-0e81-4514-9eb0-2abf21e31c01	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	0856b4f2-0098-4f16-82fe-15c492450e95	Walt Whitman	0.0
9509ec96-cf7f-4748-909c-136b035c6018	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	83642d04-c127-4ef0-b12a-33e397e3b898	tree frog	0.0
8c11d15b-cca5-4076-855a-7fbaa66a9907	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	97d044fd-329c-4e54-a3e1-8a8374dae289	zap it	0.0
2fbbd0ec-cde2-432c-8341-2734379a94b0	7ac8fc6f-1d06-4fa8-b721-f778d2d84694	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
56b2e1db-8c7f-472b-b37b-3af82bab73fa	1b51f960-05c9-4830-b638-8cd1f85b00ad	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman\n	1.0
b4c874e8-c52a-4f13-a425-f8d1b9c039ec	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
6cd26547-04c4-4191-b66a-2abc9ba8ffe1	1b51f960-05c9-4830-b638-8cd1f85b00ad	7251c912-433d-4305-b471-54f2b9877c98	-273\n	1.0
9bbce88c-6621-49c4-839b-05e53a8c6741	1b51f960-05c9-4830-b638-8cd1f85b00ad	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise\n	1.0
12a81e5a-586f-43fc-ac57-035e80b71fff	1b51f960-05c9-4830-b638-8cd1f85b00ad	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	Anthony Johnson\n	0.0
cfb0fb86-e1ee-421b-b4de-60cd71646a0e	1b51f960-05c9-4830-b638-8cd1f85b00ad	8444d762-c013-4470-a00d-f626a5494c3d	Iron\n	1.0
28f09a18-02ed-47cc-af3c-d746d3699fd0	1b51f960-05c9-4830-b638-8cd1f85b00ad	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi	1.0
4ab7ffcb-c4ef-4652-98c8-f55dfef04173	1b51f960-05c9-4830-b638-8cd1f85b00ad	83642d04-c127-4ef0-b12a-33e397e3b898	Zombie\n	0.0
6b62fe92-f397-4fbc-b93a-65ce24a88669	1b51f960-05c9-4830-b638-8cd1f85b00ad	97d044fd-329c-4e54-a3e1-8a8374dae289	RadarRange\n	1.0
0ba285e1-24b9-47ea-97a8-fe968fb13ee8	1b51f960-05c9-4830-b638-8cd1f85b00ad	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon Levitt	1.0
2be6a307-d379-4091-93f8-992fcccc3eef	1b51f960-05c9-4830-b638-8cd1f85b00ad	e54480ed-cc7a-404c-8bd8-68d66b5e9209	\nSnow cones\n	1.0
9cb7965c-b3a7-4cb9-aa5a-701cc26a87b1	898fbb30-d96a-40c5-b01c-9e6ac59843f2	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snowball	1.0
9c1c7e94-72c4-43ca-898a-e9d29a48495d	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	97d044fd-329c-4e54-a3e1-8a8374dae289	General Electric	0.0
450e1be0-8118-443c-b484-34a2c7f3e986	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
7d986a77-1b3b-42a2-a07c-d7c6aab60671	4b2187ab-ce4c-47b1-92c6-8da40344633a	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
ccc1400d-fa05-40fa-b06a-77080857f490	4b2187ab-ce4c-47b1-92c6-8da40344633a	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
a86cb0d2-04e8-4870-86d2-35c1cc2845ee	4b2187ab-ce4c-47b1-92c6-8da40344633a	b3147c88-134f-4f05-92cb-9e76da08f786	Element 65	0.0
12b9a563-d374-471f-b153-202e6f34726a	4b2187ab-ce4c-47b1-92c6-8da40344633a	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Venus	0.0
3988011d-4c0b-4d6c-8f2b-29ded165ce22	4b2187ab-ce4c-47b1-92c6-8da40344633a	0b704edd-082f-444f-a8a8-3c398a16dadc	?	0.0
3235095d-61ee-4c0f-9254-12f925c4fbbd	4b2187ab-ce4c-47b1-92c6-8da40344633a	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
e7c9d4d4-1178-4370-9a02-415ebfa5f7dc	0a1b2f94-0921-445e-b1f6-157d01232314	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
d0feb85c-ee3c-41e8-bb46-dc3bcb57ce1f	0a1b2f94-0921-445e-b1f6-157d01232314	97d044fd-329c-4e54-a3e1-8a8374dae289	Raytheon	0.0
a41b0a36-bd30-4d0a-a31b-9acf3f99dc5a	8c9f13d4-de53-4715-a6c1-3e980be3cbf4	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquise	1.0
eba9b75a-9047-4995-9e7f-f83cdb5d749b	4b2187ab-ce4c-47b1-92c6-8da40344633a	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Gary Kasparov	1.0
18cb5922-88e8-4a62-b43b-6c3fc09188f4	4b2187ab-ce4c-47b1-92c6-8da40344633a	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Pumpkin	0.0
f10ec8df-977e-4432-a39b-5386c8bb222f	c41f72d7-e0e1-48c1-b895-33dc3445c1e4	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
bffca513-e467-4ab7-9519-13380945080d	f148a5b6-20a8-4c22-a0d2-e70722eee85e	7251c912-433d-4305-b471-54f2b9877c98	-273.15	1.0
82906319-f465-440a-ba41-4d10d8ea2678	f148a5b6-20a8-4c22-a0d2-e70722eee85e	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Oval	0.0
50560c20-7a4e-48aa-b661-2fbeb7207ff4	f148a5b6-20a8-4c22-a0d2-e70722eee85e	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
c993e0f3-3a25-4430-b3a4-c8a5228a10d0	f148a5b6-20a8-4c22-a0d2-e70722eee85e	8444d762-c013-4470-a00d-f626a5494c3d	Aluminum	0.0
13a93031-e09a-4a3d-af4f-e90c1644dcb2	f148a5b6-20a8-4c22-a0d2-e70722eee85e	0856b4f2-0098-4f16-82fe-15c492450e95	?????	0.0
ddedff0d-04a1-40e6-891a-3e5d81be1b74	f148a5b6-20a8-4c22-a0d2-e70722eee85e	83642d04-c127-4ef0-b12a-33e397e3b898	Frozen Frog	0.0
8cc7b233-516a-4793-9f41-a4b095d4a689	f148a5b6-20a8-4c22-a0d2-e70722eee85e	97d044fd-329c-4e54-a3e1-8a8374dae289	?????	0.0
70633bd8-c9bd-4582-b18d-c0f4e9f91cee	f148a5b6-20a8-4c22-a0d2-e70722eee85e	63c24528-abc9-4a55-9764-1f412ac2f6de	Joseph Gordon-Levitt	1.0
4906f778-56d1-4821-99d4-dee28d7b8ca0	f148a5b6-20a8-4c22-a0d2-e70722eee85e	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snow Cone (Lemon)	1.0
717a2de7-b215-41a0-8c68-bcf54b6fe784	f148a5b6-20a8-4c22-a0d2-e70722eee85e	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
91efe485-bc9b-4cbd-a5d2-1d8bc6909835	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	e54480ed-cc7a-404c-8bd8-68d66b5e9209	Snowcone	1.0
032d15ef-e50a-4c47-a659-8b6e1b24d7b6	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	eddfb55c-106c-4516-8c5a-0e7aeec6fd45	Neil Gaiman	1.0
40bfcb20-2972-4930-83c5-ba89880ac985	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	7251c912-433d-4305-b471-54f2b9877c98	273	1.0
4c8b45b3-1687-46b2-9192-1ca42fc7dc5c	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	f86a6563-e740-419a-b75b-1a4ce3a8a3bc	Marquis	1.0
a9ff72b5-4955-4f3f-9cee-8bf8a5093442	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	O'Shea Jackson	1.0
30846dab-2221-43bb-a6ff-090f42f804d7	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	8444d762-c013-4470-a00d-f626a5494c3d	Iron	1.0
8573c9f4-6037-46a9-8d45-f653d3a4d6a5	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	0856b4f2-0098-4f16-82fe-15c492450e95	Rumi	1.0
9f9bcf68-f61a-4bf8-b652-342c4a9e2a8e	b136563e-7150-47b0-91c6-73781d88c3e5	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
0c9b13d8-c40e-478d-b802-af94c740a3fc	b136563e-7150-47b0-91c6-73781d88c3e5	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings the two towers	0.0
15313c71-cfa2-456c-85a8-489243899c20	e90a2d0b-7672-4c3b-82c7-44d72fff88d4	83642d04-c127-4ef0-b12a-33e397e3b898	Wood frog	1.0
b2d4e0c7-f756-4efa-9446-3ba77907f79f	b136563e-7150-47b0-91c6-73781d88c3e5	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Steffi Graff	0.0
376ffb71-5651-40f3-a0e3-617186add703	b136563e-7150-47b0-91c6-73781d88c3e5	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
492be9bc-61b6-4043-9209-8add27127dc8	b136563e-7150-47b0-91c6-73781d88c3e5	b3147c88-134f-4f05-92cb-9e76da08f786	Carbon	0.0
f2986a04-aa70-4067-a697-320de01aa511	b136563e-7150-47b0-91c6-73781d88c3e5	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
fb6e9c6b-0048-446f-b072-d7be37bcaa08	b136563e-7150-47b0-91c6-73781d88c3e5	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
385802ab-0f2e-42f2-b347-4d6cf4b15fdc	b136563e-7150-47b0-91c6-73781d88c3e5	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
e0d58813-a836-422d-992b-3ca3ef0ff9a2	b136563e-7150-47b0-91c6-73781d88c3e5	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
efecd3d2-a275-46e0-a10c-d7d42f32cf01	442a6a59-f7eb-4e6a-903c-aef886f66b2a	69a8cee2-208b-415f-9cb3-868dcfe4d29a	No Clue	0.0
2b2fd2a9-4d6d-4320-a735-b66e52a5cea2	442a6a59-f7eb-4e6a-903c-aef886f66b2a	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	Jim Cameron	1.0
c03431a9-8c34-4cc9-a54a-5c2453afd57a	442a6a59-f7eb-4e6a-903c-aef886f66b2a	0b704edd-082f-444f-a8a8-3c398a16dadc	LOTR	1.0
70f0bdc0-45e5-437a-8586-dbfa2d7a409c	442a6a59-f7eb-4e6a-903c-aef886f66b2a	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Maria Sharapova	0.0
4c522fb3-71b5-414c-bba4-d21cc183adff	442a6a59-f7eb-4e6a-903c-aef886f66b2a	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Tommy Jefferson	1.0
dfef23c7-2c85-439e-984d-f2d5488c35d1	b136563e-7150-47b0-91c6-73781d88c3e5	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
d41c12a2-1ecc-49ec-a0ee-206d63c7f546	442a6a59-f7eb-4e6a-903c-aef886f66b2a	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Bobby FIscher	0.0
6def12e5-49e7-4880-b75a-4e05566a3675	4b2187ab-ce4c-47b1-92c6-8da40344633a	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Convection	0.0
3aae42b2-b61f-412d-8fb5-c1605a06a6a8	2b9fae16-d267-419f-98d3-4ea153cf3be4	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
0f37f79b-2639-43d2-ae10-8ed89c5a87df	2b9fae16-d267-419f-98d3-4ea153cf3be4	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
0499021b-7da3-4b44-9740-0c8172399060	2b9fae16-d267-419f-98d3-4ea153cf3be4	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
9ea38519-ee16-469e-929b-51beb2aee59f	febd5f05-a7db-4afc-a366-9289782fee2b	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the rings: Return of the King	1.0
2b2f22d6-bea8-471a-b7e4-45b52841c9e1	febd5f05-a7db-4afc-a366-9289782fee2b	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Margaret Court	1.0
1ce15e92-3e53-46c5-86b1-19e25c65fc2c	febd5f05-a7db-4afc-a366-9289782fee2b	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Chaos Theory	0.0
83845952-79e3-4d78-accc-f5757f385689	febd5f05-a7db-4afc-a366-9289782fee2b	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
29ec795c-11f8-4693-b22b-b7c4da977adb	febd5f05-a7db-4afc-a366-9289782fee2b	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
0c2d2484-4ad1-4039-a378-436c58fa2891	febd5f05-a7db-4afc-a366-9289782fee2b	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
4664f1d6-d205-47e2-8ade-222ce72820b8	febd5f05-a7db-4afc-a366-9289782fee2b	b3147c88-134f-4f05-92cb-9e76da08f786	tree bark	0.0
28d86afc-f489-44f8-a955-457c6559b14b	febd5f05-a7db-4afc-a366-9289782fee2b	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Gary Kasparov	1.0
28edb63f-4cb2-4d1d-b2ef-e01aac25e581	febd5f05-a7db-4afc-a366-9289782fee2b	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Krishna	0.0
b2c9d53b-64c9-4c92-af5c-2d1253c26617	20d0245d-1f5a-47f1-90aa-2a03662a1e63	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
2482c090-dc99-42eb-be8a-4f46249689c1	20d0245d-1f5a-47f1-90aa-2a03662a1e63	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings: Return of the King	1.0
8b084eb3-dadb-4a30-b30c-6b5c1bfa8e78	20d0245d-1f5a-47f1-90aa-2a03662a1e63	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Margaret Court 	1.0
7e303f74-6bc7-4768-a486-989a53b09d9d	20d0245d-1f5a-47f1-90aa-2a03662a1e63	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
fbd1447d-1e54-49a6-86e3-2aa98dd83bd4	20d0245d-1f5a-47f1-90aa-2a03662a1e63	b3147c88-134f-4f05-92cb-9e76da08f786	Caesium	1.0
a285daaa-d8c2-478b-9309-c1a09c2b8f34	20d0245d-1f5a-47f1-90aa-2a03662a1e63	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
351d3dc5-aa9a-4f97-93a2-619f2d5baf1e	20d0245d-1f5a-47f1-90aa-2a03662a1e63	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
16c97b80-b631-4c54-ba51-adcd66414492	20d0245d-1f5a-47f1-90aa-2a03662a1e63	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
5e8e152a-c349-4d07-8821-6051bb841483	bd4708aa-3963-4797-b680-d34cc61816d3	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
9ea091b8-870b-4eea-a5e7-a3258aa82892	bd4708aa-3963-4797-b680-d34cc61816d3	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
1a080296-c266-43d1-8b01-8383607dc620	442a6a59-f7eb-4e6a-903c-aef886f66b2a	f9343428-ec21-4cca-ac67-a7670687d600	Lemur	0.0
d8f9062d-09f5-45cc-8886-43474bf7122b	442a6a59-f7eb-4e6a-903c-aef886f66b2a	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Memory Charm	0.0
77e03e97-bcc8-4dcc-8f69-a1c8a2d656f5	442a6a59-f7eb-4e6a-903c-aef886f66b2a	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Disfunction	0.0
3ceaffe7-cee1-4058-96ce-7d8130954458	2b9fae16-d267-419f-98d3-4ea153cf3be4	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
d75db9fe-c15a-475b-b24a-68f3be1852e1	2b9fae16-d267-419f-98d3-4ea153cf3be4	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Brahma	0.0
79d90831-45ac-4d17-8157-ba3f682e0557	2b9fae16-d267-419f-98d3-4ea153cf3be4	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
ac2b58b4-e641-4911-ba48-9b2f6a1916ac	2b9fae16-d267-419f-98d3-4ea153cf3be4	0b704edd-082f-444f-a8a8-3c398a16dadc	Toy Story 2	0.0
7107bcc0-1535-4df7-abcb-513a1b1109c2	2b9fae16-d267-419f-98d3-4ea153cf3be4	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Margaret Court	1.0
60bbdfcd-7e2c-47d0-a9bb-fcce18d449c2	2b9fae16-d267-419f-98d3-4ea153cf3be4	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
d7a7f136-2cec-44ff-8bb8-1961dad05fe1	febd5f05-a7db-4afc-a366-9289782fee2b	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
f39e7528-e180-44c1-8d39-c37d03607bc2	20d0245d-1f5a-47f1-90aa-2a03662a1e63	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
cd69dcf2-5e04-4c71-aeee-883e8431fbe6	bd4708aa-3963-4797-b680-d34cc61816d3	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
1c88bcd7-81d4-4fc4-ad0a-4ce117de8575	bd4708aa-3963-4797-b680-d34cc61816d3	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
832d1a94-5a04-4d97-8292-ef1e8e9df594	bd4708aa-3963-4797-b680-d34cc61816d3	0b704edd-082f-444f-a8a8-3c398a16dadc	LOTR: Return of the King	1.0
b3478b90-e255-4df6-95f9-b45ff06ccf03	bd4708aa-3963-4797-b680-d34cc61816d3	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Steffi Graf	0.0
fd301373-3ef3-4bc5-af4e-d6fbe1b323c6	bd4708aa-3963-4797-b680-d34cc61816d3	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
4233298d-0d3b-4c0d-aedc-d689664e395f	bd4708aa-3963-4797-b680-d34cc61816d3	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
3a75aeb4-ff0d-4c43-844a-fdfd26a3e541	bd4708aa-3963-4797-b680-d34cc61816d3	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
bbbd80c6-e6d2-4c6b-8c58-35dce4ab32c1	c05fe4e9-7050-400e-bbcf-34b9c582b18c	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
772c8722-ac08-443e-9fbb-9f3ec7b6907e	c05fe4e9-7050-400e-bbcf-34b9c582b18c	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Gara Kasparov	1.0
7f4aa035-95f1-4edc-ac69-d954b9f347ce	c05fe4e9-7050-400e-bbcf-34b9c582b18c	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
fbb8e56b-44f8-4473-8903-80789dc2e1d5	c05fe4e9-7050-400e-bbcf-34b9c582b18c	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
4d83618b-2a4e-4270-bb11-a45448f29a3e	c05fe4e9-7050-400e-bbcf-34b9c582b18c	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings: Return of the King	1.0
f81e95cf-7fc1-419e-9609-46f8e04516b8	442a6a59-f7eb-4e6a-903c-aef886f66b2a	b3147c88-134f-4f05-92cb-9e76da08f786	Gold	0.0
d974672f-16c0-452c-9bb7-87ce76525203	2b9fae16-d267-419f-98d3-4ea153cf3be4	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
9573f969-6ef1-4b88-bf7c-14eddd0004e2	4b2187ab-ce4c-47b1-92c6-8da40344633a	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
b2d3d32b-4ea6-4ada-8b99-ab2cf92f2fca	c05fe4e9-7050-400e-bbcf-34b9c582b18c	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
12877573-720a-4bba-bf23-4754d07192ed	c05fe4e9-7050-400e-bbcf-34b9c582b18c	b3147c88-134f-4f05-92cb-9e76da08f786	-	0.0
0f78e723-52bb-4000-bfa0-08fa550e555c	c05fe4e9-7050-400e-bbcf-34b9c582b18c	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	-	0.0
0aeb2733-c433-4173-a0db-592d61095953	c05fe4e9-7050-400e-bbcf-34b9c582b18c	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
3c184752-61f8-45ac-aa5b-79f51fe811de	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Magnus Carleson	0.0
5ec1b17b-4ad8-4c12-a6a0-d711023a3389	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	Christopher Nolan	0.0
f468c3e0-fa92-42f7-8daa-37923ea98bf4	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	0b704edd-082f-444f-a8a8-3c398a16dadc	Toy Story 2	0.0
88610991-4a02-43f7-ab97-ee2c9ed2d0f9	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Venus Williams	0.0
88154916-f5ca-44e9-857b-c7dff2541c51	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Law of chaos	1.0
eb95c505-e8e4-4a5b-bc7d-fd45143e74cf	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	f9343428-ec21-4cca-ac67-a7670687d600	Fibula	0.0
b47bc584-5b7c-446f-8a8f-a3a86265c0bf	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	69a8cee2-208b-415f-9cb3-868dcfe4d29a	The Moon	0.0
4718a2a3-0fef-4ad6-b661-915d08640863	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	b3147c88-134f-4f05-92cb-9e76da08f786	Gold	0.0
21a36ddb-db61-4bcf-aa62-73b3daf20e23	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Forgetto	0.0
6907941e-8cd1-418c-9616-577513fd92d2	23f7ca06-6851-405c-b8ef-43cf620c3340	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
9f5cb462-2ec1-4270-b557-c159cfc53684	23f7ca06-6851-405c-b8ef-43cf620c3340	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Karpov	0.0
864771ed-49ed-4289-b3b6-2f99c497b8e8	23f7ca06-6851-405c-b8ef-43cf620c3340	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
39533870-b04f-449e-8337-299a926305e0	23f7ca06-6851-405c-b8ef-43cf620c3340	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings the Twin Towers	1.0
bc6fecac-b27d-498a-b907-5c99fb71561a	23f7ca06-6851-405c-b8ef-43cf620c3340	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Billie Jean King	0.0
da3eec6d-1085-4382-8dfa-d5a85958423f	23f7ca06-6851-405c-b8ef-43cf620c3340	b3147c88-134f-4f05-92cb-9e76da08f786	Carbon	0.0
9cd6dc51-5354-4492-a942-aaad7df2ef11	23f7ca06-6851-405c-b8ef-43cf620c3340	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
e8ca93e0-a8fc-4e3d-ac7b-9b5af2235cc0	23f7ca06-6851-405c-b8ef-43cf620c3340	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Abracadabra	0.0
2d14511d-0969-42c2-9e88-c8fe0a618691	23f7ca06-6851-405c-b8ef-43cf620c3340	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
26bac4a3-b638-4d40-a96f-1c9ff1c2760c	23f7ca06-6851-405c-b8ef-43cf620c3340	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Buddha	0.0
f16005e7-9fe2-4744-9e99-fca64f1bca43	20d0245d-1f5a-47f1-90aa-2a03662a1e63	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
39ef37b3-394d-4e5e-b45a-df33e5434bd2	2c442598-df27-4604-87f6-301fe91fee77	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
efae909f-1d8c-4e02-8c45-dc4a0d3cf57a	80cab912-50ad-4f15-b475-d4fc6caf8874	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
b76e7dc3-b5d3-4dc9-bab9-c6139a0f819d	80cab912-50ad-4f15-b475-d4fc6caf8874	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings Two Towers	1.0
2efd4b95-1909-4b16-8486-45c406061a62	80cab912-50ad-4f15-b475-d4fc6caf8874	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Billie Jean King	0.0
ad70a9aa-b3f7-4776-9b6c-f62d16efdfa2	80cab912-50ad-4f15-b475-d4fc6caf8874	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
fa3a6656-874f-40c0-8376-262676c7139c	80cab912-50ad-4f15-b475-d4fc6caf8874	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
a18af559-cafa-4a7e-be1b-998b0b50b508	80cab912-50ad-4f15-b475-d4fc6caf8874	f9343428-ec21-4cca-ac67-a7670687d600	Shinbone	0.0
feb25cca-da73-4206-9c57-8218e97fbaec	80cab912-50ad-4f15-b475-d4fc6caf8874	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Oliviate	1.0
ad18a645-8d87-4ea6-beae-65b8c88ab3eb	80cab912-50ad-4f15-b475-d4fc6caf8874	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	NA	0.0
2338e193-2b39-4bff-b601-e3dece6074dc	80cab912-50ad-4f15-b475-d4fc6caf8874	69a8cee2-208b-415f-9cb3-868dcfe4d29a	NA	0.0
5a743380-9dac-48ee-85b7-b5074b91058a	2c442598-df27-4604-87f6-301fe91fee77	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
f63ca0f6-834d-4e60-8722-01d1b1eabdc7	2c442598-df27-4604-87f6-301fe91fee77	69a8cee2-208b-415f-9cb3-868dcfe4d29a	idk	0.0
e09786f6-ab72-4865-9284-3b3ca33d03f7	2c442598-df27-4604-87f6-301fe91fee77	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
99533ff8-50f0-48d1-845a-23d0f65f99be	2c442598-df27-4604-87f6-301fe91fee77	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings: Return of the King	1.0
6de20388-6a31-48a3-993a-5eeb6cfb9a1a	2c442598-df27-4604-87f6-301fe91fee77	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Steffi Graf	0.0
f8efb8ae-22d6-4b44-9e3a-5c2000f310f5	2c442598-df27-4604-87f6-301fe91fee77	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
9e396d3b-7bbd-4bc5-84b8-4f7e48fad263	2c442598-df27-4604-87f6-301fe91fee77	b3147c88-134f-4f05-92cb-9e76da08f786	Uranium	0.0
7bcbaae7-3e07-486e-be1a-4ac77f7214ee	2c442598-df27-4604-87f6-301fe91fee77	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
d28e6f47-ecdf-44d9-b8f5-81651cebe963	bd4708aa-3963-4797-b680-d34cc61816d3	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
6e9940a7-119c-4619-8b97-fe0f067b0bcc	80cab912-50ad-4f15-b475-d4fc6caf8874	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
8ad083bf-add4-4254-aa11-9b87d64004d9	c05fe4e9-7050-400e-bbcf-34b9c582b18c	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
27596045-df35-42ee-8794-fb9b210e8df3	59a20d9e-de5b-4ff1-b2ab-76dd17612e80	884b11fd-fa04-42a8-a903-8aa9f39e0a37	James Madison	0.0
0e75fab5-1ee8-4161-8e02-e0c3966f7a96	acef5f06-c17a-49b7-8f92-d55f6bc3846f	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
f875503b-544f-4b2e-856e-22345b3bb329	acef5f06-c17a-49b7-8f92-d55f6bc3846f	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
f9626f1d-51f5-4e3f-a688-9f3531355b1e	acef5f06-c17a-49b7-8f92-d55f6bc3846f	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
0eae7c49-ff85-4f0e-bbee-bb0d337d89cf	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Ghandi	0.0
81476933-8e8b-451a-9539-4a7c99f7e520	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
71120780-b4b8-4302-b3d5-3315c6aca9af	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	0b704edd-082f-444f-a8a8-3c398a16dadc	Star Wars	0.0
2f3ffd10-97c1-4fe1-bd67-50240208f42d	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
e7d62dc0-40d5-4e85-9810-531b688754d0	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
a7126db3-2148-4e4b-9d7a-a592de756423	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	f9343428-ec21-4cca-ac67-a7670687d600	Tibula	1.0
aa90c8f8-17aa-47f6-957d-dff078dd2b3a	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
d44288e5-9399-4a79-8e82-d9f0846ea8d1	d3713227-c7e6-49c6-b0a0-9addebdc181c	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
fc6289d2-6bbe-48b0-8784-7cef90688c7c	d3713227-c7e6-49c6-b0a0-9addebdc181c	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
e94cbf03-7d14-4a59-9eb3-d8177c6ce147	d3713227-c7e6-49c6-b0a0-9addebdc181c	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
e051a7fa-e3a5-4201-bf71-729aa91e2a30	d3713227-c7e6-49c6-b0a0-9addebdc181c	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	Cameron	1.0
1fa36183-b7bf-4ff2-95b3-ad4a2fcbbef0	cbee09e7-3674-4d54-b3f5-ca288aa1071d	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
2040324c-d967-4e64-8b89-f82c070875bb	cbee09e7-3674-4d54-b3f5-ca288aa1071d	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
bd25aefb-eb2e-4041-a659-f9d20990934a	cbee09e7-3674-4d54-b3f5-ca288aa1071d	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
6726cbca-f0e8-4fbf-aa0d-5f52388a4d07	cbee09e7-3674-4d54-b3f5-ca288aa1071d	b3147c88-134f-4f05-92cb-9e76da08f786	Cesium	1.0
182e8772-8569-4301-8772-d9c78fced308	cbee09e7-3674-4d54-b3f5-ca288aa1071d	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
31821886-0d85-4269-8469-a0b6b1a308b6	cbee09e7-3674-4d54-b3f5-ca288aa1071d	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
bdb07af6-938e-40f0-ad2b-04207263bcec	a7076f01-f196-4b63-b197-9ad942687786	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
965227ad-8ff7-4638-93f5-0fe0a2fdd52a	a7076f01-f196-4b63-b197-9ad942687786	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
89bc55ba-24fb-41dc-a3c9-f2cc5970ff89	a7076f01-f196-4b63-b197-9ad942687786	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
ea1c6df2-fcf1-4614-bc1e-4d0ca36c18c1	a7076f01-f196-4b63-b197-9ad942687786	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
91ee24ea-2fca-40bb-97b2-2eff2b51fc3e	a7076f01-f196-4b63-b197-9ad942687786	0b704edd-082f-444f-a8a8-3c398a16dadc	The Lord of the Rings: The Return of the King	1.0
5846c06f-a44e-4fc5-aa6a-3f4ca3013d99	a7076f01-f196-4b63-b197-9ad942687786	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Margaret Court	1.0
49c468e2-7b30-47ae-96ad-66826bd4797a	a7076f01-f196-4b63-b197-9ad942687786	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
70a6be18-d70f-46b9-b9f1-75c1c8e0f0eb	a7076f01-f196-4b63-b197-9ad942687786	b3147c88-134f-4f05-92cb-9e76da08f786	Carbon	0.0
3f09e105-4b8c-41de-8e8e-60e8864a7960	a7076f01-f196-4b63-b197-9ad942687786	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
0d6a7019-2c2e-42cf-a7d7-c9f427937263	a7076f01-f196-4b63-b197-9ad942687786	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
1183cc6e-e46c-4325-949c-2ea45b641cc3	acef5f06-c17a-49b7-8f92-d55f6bc3846f	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
2e822b59-076b-4d08-92d9-d9412afa1f2d	d3713227-c7e6-49c6-b0a0-9addebdc181c	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings	1.0
3d3709c0-906a-4282-b7f8-f7401d543650	d3713227-c7e6-49c6-b0a0-9addebdc181c	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Sharapova	0.0
a34a111a-bc78-40b6-ba90-6d7df4fc3cf4	d3713227-c7e6-49c6-b0a0-9addebdc181c	8a5643e0-ecbe-4e1a-9291-4e2e69401186	entropy	1.0
5cf5eec8-9cb6-405d-a5f2-1c06e0758635	d3713227-c7e6-49c6-b0a0-9addebdc181c	b3147c88-134f-4f05-92cb-9e76da08f786	helium	0.0
444eb12f-7008-413d-9957-83e4160c44eb	d3713227-c7e6-49c6-b0a0-9addebdc181c	f9343428-ec21-4cca-ac67-a7670687d600	tibia	1.0
e926c42f-27ae-44b5-aadb-fbf653c38dbd	d3713227-c7e6-49c6-b0a0-9addebdc181c	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
d5ccc168-903c-4769-8774-b6351a8a33ad	cbee09e7-3674-4d54-b3f5-ca288aa1071d	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
76d7de4d-f549-466e-9ceb-5ec00bc0b8bb	cbee09e7-3674-4d54-b3f5-ca288aa1071d	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
e6bc03f2-3dab-449d-b7f9-6fdc463c332c	cbee09e7-3674-4d54-b3f5-ca288aa1071d	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings: The Return of the King	1.0
974bc9c8-8fe0-4e20-871a-62f89011ddc8	cbee09e7-3674-4d54-b3f5-ca288aa1071d	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Venus Williams	0.0
2ac533a9-5ff2-4108-8fd8-1739d02e001c	2c442598-df27-4604-87f6-301fe91fee77	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
a1721f58-617c-4723-8a12-a695d5c10199	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
e38e60f5-cbb2-4cc2-83a3-4768da386f46	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Harry	0.0
413a11b0-7758-4d37-b9e4-d4add207f766	fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Naomi Osaka	0.0
d148a382-eede-4502-8d7a-6bdc74432a79	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
3edd930d-4ad7-48e6-99a5-925e02ed6654	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
6cc91bbe-b9c8-443e-9316-85981d26bd7a	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	0b704edd-082f-444f-a8a8-3c398a16dadc	Titanic	0.0
d1a4d249-a1b2-45ab-a068-ca06b8bfedc7	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Steffi Graf	0.0
22fb0615-c002-4bee-894a-3209101ac27c	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
cba14a84-0b85-4db4-9b5f-15dc67395a5f	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	b3147c88-134f-4f05-92cb-9e76da08f786	Cesium	1.0
86e2b8fe-8688-4d49-957b-4fd53231c65a	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
6d844d2e-f86a-42ac-816c-5caf39250a96	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
2d7e21f7-3def-4986-a02f-513adeb6ccc5	a78372e8-c6d9-4800-b826-a11709eab8e7	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
18a51b7a-cd9a-49e5-b608-690f32ed706e	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
ffdda389-da86-42e7-b19d-b56833af115a	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
378773d7-4cad-485c-a8ec-9215b785a5a1	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
d4b7033e-bd03-4301-8767-75418256140b	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings (probably the 3rd one?)	1.0
34c9dad5-7ec4-4b12-9ed4-4f4d958a1252	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Billie Jean King	0.0
ed643d61-3c13-4e45-bf66-a570fb6cd3ff	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
c11d0a03-972d-4ce4-979b-c4ab962af428	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	b3147c88-134f-4f05-92cb-9e76da08f786	Helium	0.0
d138f33f-bf2e-4dd4-aded-6a12d6b73e0e	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
faa006ce-0953-4139-9c59-49a2f6deaa30	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
1c24b036-b542-4daa-8afa-ffc691199989	783abb02-97b4-467c-ae0b-f1739337674b	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Jefferson	1.0
bac45641-83c7-412d-98af-bec5a44ccaa4	a78372e8-c6d9-4800-b826-a11709eab8e7	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
e88f372b-0b78-4ba6-866d-0ab0ba1c1883	a78372e8-c6d9-4800-b826-a11709eab8e7	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
8a38639b-d7ec-4cbe-a992-1e3975179e0f	a78372e8-c6d9-4800-b826-a11709eab8e7	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Margaret Court	1.0
d0f83b97-9205-48c7-b7c5-75cc0b1cfaae	a78372e8-c6d9-4800-b826-a11709eab8e7	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
30042834-c499-4b33-a304-173c8108f574	a78372e8-c6d9-4800-b826-a11709eab8e7	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate	1.0
6104c406-81fa-454d-9445-d60001877c03	a78372e8-c6d9-4800-b826-a11709eab8e7	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
184b2b51-fa6d-47cf-992f-8f6a4a7b03f2	a78372e8-c6d9-4800-b826-a11709eab8e7	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Osmosis	0.0
53432a4f-0098-4cb2-b860-4ac5e208c67c	a78372e8-c6d9-4800-b826-a11709eab8e7	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
5ad1181e-f168-4929-81d0-f71f58ab22c4	449dd37c-632f-496a-9aa1-f02666a47ea9	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
1f943753-0b21-4b93-af9d-45a240c8b385	449dd37c-632f-496a-9aa1-f02666a47ea9	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
aa06b0f4-3b8e-4d54-8535-14a5feca62d3	449dd37c-632f-496a-9aa1-f02666a47ea9	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
3715686c-6424-4315-abf2-c97ab9769347	449dd37c-632f-496a-9aa1-f02666a47ea9	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	James Cameron	1.0
de51d5a6-6997-4ced-92b2-7a7f93a54f1d	449dd37c-632f-496a-9aa1-f02666a47ea9	0b704edd-082f-444f-a8a8-3c398a16dadc	The Lord of the Rings: The Return of the King	1.0
425b26ea-b0a2-4568-983f-e2075cc33328	449dd37c-632f-496a-9aa1-f02666a47ea9	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Billie Jean King	0.0
3ae69386-4c4f-401f-9f7c-954acfbe61e9	449dd37c-632f-496a-9aa1-f02666a47ea9	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
ba20488a-b950-4135-b27d-c7e562fa735e	449dd37c-632f-496a-9aa1-f02666a47ea9	b3147c88-134f-4f05-92cb-9e76da08f786	Hydrogen	0.0
e9f205f9-0346-4749-9975-f88c0617b964	449dd37c-632f-496a-9aa1-f02666a47ea9	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
c7fcebac-1b34-4e59-8b51-6bd8262f7b3c	449dd37c-632f-496a-9aa1-f02666a47ea9	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Obliviate (false memory charm)	1.0
72019ef0-f7aa-4e57-896e-9dd05c3ff4d0	783abb02-97b4-467c-ae0b-f1739337674b	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Kasparov	1.0
ca5fd164-cfe0-40b5-8122-09248181a448	783abb02-97b4-467c-ae0b-f1739337674b	69a8cee2-208b-415f-9cb3-868dcfe4d29a	Vishnu	1.0
c5da541d-fff6-419a-a35a-16aec3418c87	783abb02-97b4-467c-ae0b-f1739337674b	f0f64982-dbc7-4f4c-98fe-c0f7746471c9	Cameron	1.0
d37b3518-5db5-4caa-9273-864ab2705c45	783abb02-97b4-467c-ae0b-f1739337674b	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings: The Return of the King	1.0
a090f3a0-cc56-45e8-925e-83cbed5ec895	783abb02-97b4-467c-ae0b-f1739337674b	b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	Navratilova	0.0
b7143ebd-858f-4147-b9d0-6f71e45f605f	783abb02-97b4-467c-ae0b-f1739337674b	8a5643e0-ecbe-4e1a-9291-4e2e69401186	Entropy	1.0
69102546-2e8c-462b-bb96-0037523b4d34	783abb02-97b4-467c-ae0b-f1739337674b	b3147c88-134f-4f05-92cb-9e76da08f786	Cesium	1.0
a8b6e29f-cb89-4005-875f-2c332967bf64	783abb02-97b4-467c-ae0b-f1739337674b	f9343428-ec21-4cca-ac67-a7670687d600	Tibia	1.0
b5b902a3-e53c-43dd-869c-ac5dbc80cfa1	783abb02-97b4-467c-ae0b-f1739337674b	e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	Oblivio	1.0
86ec185f-ee8a-4a9d-97b0-e7a7a48116c1	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	541eec43-a9d5-44a4-a8c8-0d1f4879a02f	Garry Kasparov	1.0
0bac87ed-ce3c-439b-ad39-0869edf39172	b85d516c-6ffa-4f69-8c5d-d120dfd43be5	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
2e4dee8e-3575-4da0-b8c5-528ef803d863	b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	884b11fd-fa04-42a8-a903-8aa9f39e0a37	Thomas Jefferson	1.0
4a57dfcf-aa4e-4b02-8e8c-e074a5bc354e	a78372e8-c6d9-4800-b826-a11709eab8e7	0b704edd-082f-444f-a8a8-3c398a16dadc	Lord of the Rings - Return of the King	1.0
9bb8ab57-5738-4ca5-8675-77fc7e3de693	042d1ae9-d11d-4b04-a676-56592dd5420a	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
93a57107-f42a-4bf8-8a47-37c0376e24ba	042d1ae9-d11d-4b04-a676-56592dd5420a	6541051c-0452-492d-b054-9a1040393283	206	1.0
0a2b3b68-073e-4fa7-8baa-41a4578c5f24	042d1ae9-d11d-4b04-a676-56592dd5420a	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
10d39c38-650e-4aac-b5cd-6ea1b80d325f	042d1ae9-d11d-4b04-a676-56592dd5420a	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautilus	1.0
f7af8269-e87e-40d6-841b-1896db6d6917	042d1ae9-d11d-4b04-a676-56592dd5420a	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
f6a486a6-bec4-4076-bcab-1b78c4be3f29	042d1ae9-d11d-4b04-a676-56592dd5420a	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic	0.0
8db0612f-4374-4229-abde-4435c5c57885	042d1ae9-d11d-4b04-a676-56592dd5420a	11c321e5-1143-4634-aa20-27a025c3e47e	-	0.0
5b2977f7-be73-4d45-8b87-4c64fe1e832b	042d1ae9-d11d-4b04-a676-56592dd5420a	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	-	0.0
0a9453ac-cbdb-46a5-9ed7-c20e45be2a39	042d1ae9-d11d-4b04-a676-56592dd5420a	eec9096b-2e69-40b5-a334-8169c5c885d5	-	0.0
f0c84a7c-fc50-43fb-85e6-a65897e49e34	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
42978480-4101-43c0-9c8d-8563d5273673	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	e8528d5a-bf83-4c9b-ba96-92e39f204b75	bore measurement/diameter of the bullet	1.0
9f0f7206-d5f3-4a73-8672-0b5d9e3ce11a	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
db0e9d34-690c-4431-9df0-20085703ab51	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Eastern Hellbender	1.0
75e15345-bc3d-48a1-8b23-b4c7158f602b	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	6541051c-0452-492d-b054-9a1040393283	206	1.0
1a8d7d2f-3e09-430f-ae70-2728da9c3b74	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
6f7398d4-4860-4c31-946d-4ce5f8107ad5	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	4f907b77-fa2a-43c9-a20b-cf25754566fc	the Nautilus	1.0
ad3bd3d8-4b97-4f26-99c3-91d78dd4d998	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus Nerve	1.0
04770a5d-1959-4f27-82ae-b8d44a290858	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	11c321e5-1143-4634-aa20-27a025c3e47e	consultant	0.0
65120a67-d519-427d-8c1c-dbc8bb7e39d0	3f6f114b-b511-4842-9eb1-b1c195b7bc5e	b99de020-d815-4cdc-b389-e73aa2b34250	WW1 - World War 1	1.0
fd9a4b6c-5008-4634-9195-9fb786b0ee7d	e7e898c0-090e-46c4-9261-b263ee596494	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Green	0.0
507b244d-a456-409f-ad77-d47c0d61d099	e7e898c0-090e-46c4-9261-b263ee596494	6541051c-0452-492d-b054-9a1040393283	206	1.0
7026cd0b-88f3-40fe-896b-93377cdd477e	e7e898c0-090e-46c4-9261-b263ee596494	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
3eae3d09-6d85-425b-88a8-2fa5026c4363	e7e898c0-090e-46c4-9261-b263ee596494	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud Consultant	1.0
9a639426-88a6-465b-924d-51b676d853ae	e7e898c0-090e-46c4-9261-b263ee596494	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautilus	1.0
5e83dfcb-0b1d-4e66-b91d-0f9e8a1f4827	e7e898c0-090e-46c4-9261-b263ee596494	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
fdaef6bf-2544-4d58-b32b-6ccde129c710	e7e898c0-090e-46c4-9261-b263ee596494	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic Nerve	0.0
9314ec9b-77e2-41fe-b012-1993690154cd	e7e898c0-090e-46c4-9261-b263ee596494	31e8e209-48ff-49eb-8891-50445e1b0456	Iron Lady	0.0
f44831e1-20cf-4784-8c20-a329db8743c8	e7e898c0-090e-46c4-9261-b263ee596494	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet	1.0
91b09079-210e-46ea-8c45-74117fc97bb2	e7e898c0-090e-46c4-9261-b263ee596494	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermompolus	1.0
6f27301f-14ca-4bc9-a187-87d724e053bc	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	eec9096b-2e69-40b5-a334-8169c5c885d5	Amelia (Mia) Thermopolis Rinaldi	1.0
21acd3e1-337c-43a7-82fd-f05e795091b0	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter of the bullet/barrel	1.0
bce3f13c-7609-4f6e-8488-082daba6c298	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
8a54fc68-5c48-4dcf-af5f-a14d7fe570e7	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Eastern Giant Salamander 	0.0
6895b185-2ff5-49b2-9e52-53287601f43b	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	6541051c-0452-492d-b054-9a1040393283	206 (babies are born with 303)	1.0
36c0d9a8-0457-48be-a5f3-b71f57950cbc	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
0e6dbc38-cd39-472e-8d03-fad297dc619c	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	11c321e5-1143-4634-aa20-27a025c3e47e	Consultant	0.0
05dca494-ab83-412d-9fda-921538eb031e	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	4f907b77-fa2a-43c9-a20b-cf25754566fc	Submarine Dory	0.0
aff82b3b-a899-456f-8022-52bb25255922	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
2627638f-03bb-40d1-9018-d6d5da878b9f	e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
0dc842cf-d471-4df7-a1ba-18b9dd5c4002	4c292138-6a33-44c6-befa-8d81692f3fab	eec9096b-2e69-40b5-a334-8169c5c885d5	Princess Mia Thermopolis of Genovia	1.0
12016dd6-8bcb-4f05-a890-9486f5388e8b	4c292138-6a33-44c6-befa-8d81692f3fab	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter	1.0
4273b1fc-945c-4577-8339-cb30d02ad2de	4c292138-6a33-44c6-befa-8d81692f3fab	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
dfe0cdc7-eba9-4d97-9006-bd71756bb5f7	4c292138-6a33-44c6-befa-8d81692f3fab	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Hellbender	1.0
0b278810-4748-4c50-be20-4b71c2f029e8	4c292138-6a33-44c6-befa-8d81692f3fab	6541051c-0452-492d-b054-9a1040393283	206	1.0
d94f6a2a-e978-479d-b538-e7cabd8f9b46	4c292138-6a33-44c6-befa-8d81692f3fab	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
287a5fe2-d78a-4e15-9e71-501b9f6751e0	042d1ae9-d11d-4b04-a676-56592dd5420a	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bore of the Rifle	1.0
25c5a32f-d845-4da0-886d-80ebc737651f	4c292138-6a33-44c6-befa-8d81692f3fab	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
c5714d61-db24-4004-bedb-3f313781381b	4c292138-6a33-44c6-befa-8d81692f3fab	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic	0.0
82b4aff2-dca1-4bd4-b88e-6e40ad8a09dd	52cb4736-576a-4bda-a8fd-cb252dc84d2f	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia, Princess of Genovia	1.0
d4d696dd-f10b-4922-82af-0b210caa44da	52cb4736-576a-4bda-a8fd-cb252dc84d2f	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter	1.0
71c48e11-581a-4a88-8ffb-7c92cff7596e	52cb4736-576a-4bda-a8fd-cb252dc84d2f	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
55562c72-804d-499b-a0b9-f29e47ffe613	52cb4736-576a-4bda-a8fd-cb252dc84d2f	6541051c-0452-492d-b054-9a1040393283	212	0.0
e9e5991a-0e8a-4d75-a518-b2e7939ce67a	52cb4736-576a-4bda-a8fd-cb252dc84d2f	2ca22c03-8408-4751-845a-288a00d80b12	Margaret Court	0.0
aa5f36a0-2a80-4041-b51f-65dbd5b1d90a	52cb4736-576a-4bda-a8fd-cb252dc84d2f	11c321e5-1143-4634-aa20-27a025c3e47e	BAA Consultant	0.0
dac64ed5-9ce3-4682-be70-6df34496c4e0	52cb4736-576a-4bda-a8fd-cb252dc84d2f	4f907b77-fa2a-43c9-a20b-cf25754566fc	Yellow Submarine	0.0
32f234ac-06a5-44ae-a4ff-9c3fbbb77dab	52cb4736-576a-4bda-a8fd-cb252dc84d2f	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
0ca250ab-5f31-45fa-9805-5f6af17a6494	52cb4736-576a-4bda-a8fd-cb252dc84d2f	12914612-937e-425f-bfd2-bb3886c6f5ad	Emphatic	0.0
d6b84e4c-656d-4f70-92ba-074f28a4c903	5cef652a-10e7-4094-a3ff-f099614bc2b3	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
d13af8d9-acb5-40d4-90a9-a9f4cad201ad	5cef652a-10e7-4094-a3ff-f099614bc2b3	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet size	1.0
0b0f9984-3708-4fd5-87c6-b30f69d8c1ff	5cef652a-10e7-4094-a3ff-f099614bc2b3	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchhill	1.0
1e826c6a-7466-424d-aece-40e26964404e	5cef652a-10e7-4094-a3ff-f099614bc2b3	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Green	0.0
b6d67bf8-82e3-4fb6-8179-4e2eea420edf	5cef652a-10e7-4094-a3ff-f099614bc2b3	6541051c-0452-492d-b054-9a1040393283	206	1.0
87a8cfa7-dae7-4ef1-8bd8-a7e32bf1cfa9	5cef652a-10e7-4094-a3ff-f099614bc2b3	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
9b5f4ed4-bc09-4498-9d80-4287b5fed639	5cef652a-10e7-4094-a3ff-f099614bc2b3	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud Architect	0.0
c5c33cf0-bdd0-42d0-b6f7-6a1c1e46a622	5cef652a-10e7-4094-a3ff-f099614bc2b3	4f907b77-fa2a-43c9-a20b-cf25754566fc	Ethan	0.0
dc0aba56-407b-49ae-bb44-30f304c66508	5cef652a-10e7-4094-a3ff-f099614bc2b3	b99de020-d815-4cdc-b389-e73aa2b34250	Civil War	0.0
e393460f-30e9-4a0b-a68f-ed766b363cbe	5cef652a-10e7-4094-a3ff-f099614bc2b3	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus Nerve	1.0
92c4e17c-2ccd-48a4-a9e9-66afe0cabb2e	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
35309493-234b-41e1-bc47-b0a79062fdaa	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	31e8e209-48ff-49eb-8891-50445e1b0456	Churchill	1.0
5cfbec87-03fc-48a1-a18c-64a6cb63e5e2	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Ozark Hellraiser	1.0
d86bc6de-57bd-45a7-8408-e5314611f9ce	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	6541051c-0452-492d-b054-9a1040393283	206	1.0
06813720-b430-4374-92bc-a70ba896b964	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
5c8fd85f-c253-4379-b039-57997d8966e3	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	11c321e5-1143-4634-aa20-27a025c3e47e	Engagement Manager	0.0
2b14d9a2-75ce-4cd3-9737-0233ce0fadb5	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
3441dd60-daea-45fa-9f30-7cbc4b9c5b06	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic nerve	0.0
92ddb957-4dcd-4eb6-bb7a-22f3371875a2	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	4f907b77-fa2a-43c9-a20b-cf25754566fc	Spirit of the Sea	0.0
e2417a31-e019-4160-9bbc-051e28fb8a34	f277a447-6172-4535-a358-1d93f6549f58	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis (Princess of Genovia)	1.0
fea4f06d-5a95-4eb5-95a8-56419c72e90e	f277a447-6172-4535-a358-1d93f6549f58	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter of the bullet and barrel	1.0
6b7f5f5b-2209-44e3-ae8d-a1fc6e01fbe3	f277a447-6172-4535-a358-1d93f6549f58	31e8e209-48ff-49eb-8891-50445e1b0456	Neville Chamberlain	0.0
e8892ef5-00a6-461f-99be-9ba67decb319	f277a447-6172-4535-a358-1d93f6549f58	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Hellbender	1.0
f48bbc28-a1de-4bcc-9378-85121381822b	f277a447-6172-4535-a358-1d93f6549f58	6541051c-0452-492d-b054-9a1040393283	206	1.0
9ec171a5-e2ce-41ac-b7c5-e181611d7ebc	f277a447-6172-4535-a358-1d93f6549f58	2ca22c03-8408-4751-845a-288a00d80b12	Monika Seles	1.0
7069d622-e336-4478-ad92-81aa0bc1cdb8	f277a447-6172-4535-a358-1d93f6549f58	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud Consultant (MC)	1.0
ef8fc398-5836-4c46-a437-fac67a284244	f277a447-6172-4535-a358-1d93f6549f58	4f907b77-fa2a-43c9-a20b-cf25754566fc	The Nautilus	0.0
f4dff3aa-660e-4fa8-b9b5-c462ea17c6aa	f277a447-6172-4535-a358-1d93f6549f58	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
33c23769-3277-46ef-91d4-1153a554cfeb	f277a447-6172-4535-a358-1d93f6549f58	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
1d519346-1e79-4274-9ae0-057f118725d1	c950b1fc-69d4-48d3-86a3-5ac401b34138	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
d6ae2aa3-9810-41df-8103-60d445d900b7	c950b1fc-69d4-48d3-86a3-5ac401b34138	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter of the bullet	1.0
f76b1a94-7113-466c-8eb2-da1f05c71e45	c950b1fc-69d4-48d3-86a3-5ac401b34138	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
48aa7ad7-5698-4214-b160-aa7539b4df35	c950b1fc-69d4-48d3-86a3-5ac401b34138	6541051c-0452-492d-b054-9a1040393283	206	1.0
6f5b5c87-2eaa-435f-9c27-d58319a92164	c950b1fc-69d4-48d3-86a3-5ac401b34138	2ca22c03-8408-4751-845a-288a00d80b12	Monica Seles	1.0
8cf51106-c65a-4016-bc77-2d9747e1bf76	c950b1fc-69d4-48d3-86a3-5ac401b34138	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud Architect	0.0
932bc8c0-b96a-4249-b669-7747e6c618c0	c950b1fc-69d4-48d3-86a3-5ac401b34138	4f907b77-fa2a-43c9-a20b-cf25754566fc	The Nautilus	1.0
6b310742-862e-4128-b874-b8a2de002398	4c292138-6a33-44c6-befa-8d81692f3fab	4f907b77-fa2a-43c9-a20b-cf25754566fc	The Nautilus	1.0
d2a4c6fc-aca1-42c6-8859-44ac15eae618	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
886f7131-898b-42dd-bd4d-dcad4e78aae9	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
9c8d8d54-817d-425c-a3d7-bf0006a42866	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
faff10ce-8a38-4bf6-a83a-5d5229287220	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
7f8fc490-dee8-45fd-9ab3-51096fdb06e2	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
8dd1c9bd-3174-4716-a7ce-7004b1eed9ed	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Travis Kelce	0.0
bf31162b-18bd-49f5-a41a-ed9154f73343	839176b9-558e-43c6-a1eb-47f16269e4db	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
5407a479-85d4-4762-a619-b6fe5997d704	a706b7be-b597-4893-92f5-f95083d05de4	6541051c-0452-492d-b054-9a1040393283	207	0.0
d896b7af-e0b3-4d3e-8f10-5af34026cdde	a706b7be-b597-4893-92f5-f95083d05de4	2ca22c03-8408-4751-845a-288a00d80b12	Sharapova	0.0
10f0885d-72e9-4af6-9d99-40adfab8aafa	a706b7be-b597-4893-92f5-f95083d05de4	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud consultant	1.0
697d657c-e2e1-445f-9f7d-9aa6daa0bb4f	a706b7be-b597-4893-92f5-f95083d05de4	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautica	1.0
de55e1e2-c7f4-4481-835c-502c3b693893	a706b7be-b597-4893-92f5-f95083d05de4	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
ea74730e-1182-424b-9de1-a0874d1f6ec0	a706b7be-b597-4893-92f5-f95083d05de4	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus	1.0
87af85df-09eb-4dad-aa0c-d85508b807b8	639136f8-b968-48b6-97e7-09683c743a22	eec9096b-2e69-40b5-a334-8169c5c885d5	Princess Ann	0.0
4f95a04f-2c2d-4e2b-ba42-ee0b6725713a	639136f8-b968-48b6-97e7-09683c743a22	b99de020-d815-4cdc-b389-e73aa2b34250	WW1	1.0
bb0dd3e9-cac1-40a4-bc83-2fca13029f98	639136f8-b968-48b6-97e7-09683c743a22	12914612-937e-425f-bfd2-bb3886c6f5ad	central nervous system	0.0
0c73c3f5-4ef0-411e-8d13-11b526fffc8a	acef5f06-c17a-49b7-8f92-d55f6bc3846f	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
06da920b-ebcd-4cc8-a10b-0351a4f01081	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Pontius Pilate	0.0
9ed0b8eb-f3d5-4d8e-b2d7-c35868de95e2	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	3a08309f-da7d-4a81-b973-049736e0ef69	John Adams	0.0
243e38dd-716a-481e-9e38-76e4eab9694f	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
aa5c9f0d-1d29-4f78-b8c0-12af5403f716	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
b9561a4e-b5e1-4a39-bba3-12b6ef124687	839176b9-558e-43c6-a1eb-47f16269e4db	3a08309f-da7d-4a81-b973-049736e0ef69	Charles Dickins	0.0
d37cd990-e133-41e1-a3e2-03dd8b121c99	eed34ef9-492e-455b-bc38-26568b1dccee	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
f0fbfe79-a152-426a-a6b6-2e0c3245970a	eed34ef9-492e-455b-bc38-26568b1dccee	0d21d6f7-63b1-4758-a746-fbaf6871747a	Carotene 	0.0
ce3dee49-46f2-430f-98be-1fb3e464b65d	95dd2780-2e0a-4f7d-a869-c44955822f9d	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
0eccad39-fe89-47fc-a5a9-95862c6664c9	95dd2780-2e0a-4f7d-a869-c44955822f9d	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Hellbender	1.0
1721c2a1-b185-49cd-9582-6159f3927493	639136f8-b968-48b6-97e7-09683c743a22	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet Width	1.0
96f652b1-e388-446a-9857-afc5d3f2e430	639136f8-b968-48b6-97e7-09683c743a22	31e8e209-48ff-49eb-8891-50445e1b0456	Nevil Chamberlain	0.0
440a189a-6928-4763-aafc-5afde7d4d8be	639136f8-b968-48b6-97e7-09683c743a22	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	weird lizard thing	0.0
4cdf04e6-5256-4e74-b4ce-8bf8cecd60cc	639136f8-b968-48b6-97e7-09683c743a22	6541051c-0452-492d-b054-9a1040393283	206	1.0
22af2238-71a2-49ab-9871-757b0c6f8f05	639136f8-b968-48b6-97e7-09683c743a22	2ca22c03-8408-4751-845a-288a00d80b12	Martina Naratolova 	0.0
b9407486-057f-4192-9db1-f675e2185674	639136f8-b968-48b6-97e7-09683c743a22	11c321e5-1143-4634-aa20-27a025c3e47e	Sr. Consultant	0.0
2e22adf8-04a8-4591-ba21-00b9cf2e878c	639136f8-b968-48b6-97e7-09683c743a22	4f907b77-fa2a-43c9-a20b-cf25754566fc	Ethan Erusha	0.0
7ecc0a6a-e3cd-4bae-ab4d-586ac93ba281	95dd2780-2e0a-4f7d-a869-c44955822f9d	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia	0.0
3ef0d32c-2b27-4b0d-a4f5-cb6031a3c148	95dd2780-2e0a-4f7d-a869-c44955822f9d	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet Diameter	1.0
ebf4cbec-a5e1-497d-8d7c-e693c39dc3b4	95dd2780-2e0a-4f7d-a869-c44955822f9d	6541051c-0452-492d-b054-9a1040393283	206	1.0
46ad3fd7-0af2-4266-8f4d-7939c691c039	95dd2780-2e0a-4f7d-a869-c44955822f9d	2ca22c03-8408-4751-845a-288a00d80b12	Unknown	0.0
5b7869d2-81f8-437b-91af-4f94c62c29e9	95dd2780-2e0a-4f7d-a869-c44955822f9d	11c321e5-1143-4634-aa20-27a025c3e47e	Consulting	0.0
ae23d409-0073-42aa-889c-4a170528bb4c	95dd2780-2e0a-4f7d-a869-c44955822f9d	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautilus	1.0
7cdc7eab-d232-44cb-8c03-c55e4f8247d0	95dd2780-2e0a-4f7d-a869-c44955822f9d	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
655430cb-028e-4d71-a1a3-be4f6a8fddc2	c950b1fc-69d4-48d3-86a3-5ac401b34138	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
771c8741-73e8-4a41-bfce-faeb3196e31c	c950b1fc-69d4-48d3-86a3-5ac401b34138	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
4390381d-cc10-4acd-ac0a-5a9478fc1580	c950b1fc-69d4-48d3-86a3-5ac401b34138	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Komodo dragon	0.0
635f18f2-6de4-4e55-a730-101a43d278e6	a706b7be-b597-4893-92f5-f95083d05de4	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
e7309d5f-3f33-401a-982f-83fac3767849	a706b7be-b597-4893-92f5-f95083d05de4	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bore diameter	1.0
de9ebb9c-20af-45e5-ab4f-910ad3e943e8	a706b7be-b597-4893-92f5-f95083d05de4	31e8e209-48ff-49eb-8891-50445e1b0456	Churchill	1.0
a2f5e79f-7fb9-4539-8879-26e0470e8138	a706b7be-b597-4893-92f5-f95083d05de4	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Great spotted geezer	0.0
439943d0-822b-43b3-9862-6bc95a0ab380	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
bb1a7768-8c50-4f58-a213-3aa9c2627d10	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	11c321e5-1143-4634-aa20-27a025c3e47e	Consultant	1.0
0a180861-a57e-4d38-b5e7-bb2c423ec201	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	2ca22c03-8408-4751-845a-288a00d80b12	Billie Jean King	0.0
58b2e144-e0f1-47b2-b3a2-d66398cc1afd	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	6541051c-0452-492d-b054-9a1040393283	206	1.0
45c2b0c4-9957-4efb-9cf0-2c5f8f915335	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
8c956700-6b3b-42f0-9699-acf0121b7c9e	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	e8528d5a-bf83-4c9b-ba96-92e39f204b75	The bullet's diameter	1.0
b80173e6-ce63-4374-8b1a-a1d0a0d965c8	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
1246f0c1-b034-4e36-9bf6-abbe477a61e7	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautilus	1.0
4e039907-0bbb-4675-96cc-1a4475c36f77	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Large Salamander	0.0
5c2e64d4-f2c3-46a2-ae63-b11054b0b038	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	e8528d5a-bf83-4c9b-ba96-92e39f204b75	width of round in bullet in mm	1.0
d4ceb527-21d8-43a9-b86e-2e3358e6c412	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	31e8e209-48ff-49eb-8891-50445e1b0456	Churchill	1.0
4f84ef7a-93e1-4b50-8fd6-2d0e66ffc037	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Ghila monster	0.0
169a51cd-423c-4d35-a795-2dae06c9e394	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	6541051c-0452-492d-b054-9a1040393283	250	0.0
5e7d0aa7-7edb-4ff4-ad1e-6500c36596c3	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	2ca22c03-8408-4751-845a-288a00d80b12	Serena Williams 	0.0
dc3a38ce-7b71-433f-8ab9-9db84afd2cd4	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	11c321e5-1143-4634-aa20-27a025c3e47e	Solutions architect 	0.0
3f4815dd-026b-403b-a2fa-b581f0d0708c	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	4f907b77-fa2a-43c9-a20b-cf25754566fc	Nautilus 	1.0
d056c8a5-c260-45a7-8eb1-86ec5047d5d1	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	b99de020-d815-4cdc-b389-e73aa2b34250	World War 2	0.0
0f4df3bc-c3ef-4218-a6d9-98060e8ef209	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	12914612-937e-425f-bfd2-bb3886c6f5ad	Something	0.0
ba167d5d-72c3-47ef-8067-5e1a06207de8	c188a1bb-7151-47b1-afb8-a11bc1a2fd35	eec9096b-2e69-40b5-a334-8169c5c885d5	Diabela	0.0
f9c43185-b64b-443e-ba42-1371c9dc6ebd	203385f2-7ed8-41d5-9911-d3b4edc3715c	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet size/diameter	1.0
64d951bd-c32b-42b5-a69e-b3fa1ea834cb	203385f2-7ed8-41d5-9911-d3b4edc3715c	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
4c1275d2-6bfc-4110-bb0b-166027651c1d	203385f2-7ed8-41d5-9911-d3b4edc3715c	31e8e209-48ff-49eb-8891-50445e1b0456	Churchill	1.0
5704d5af-7c6b-4691-996d-0e46e52d9e69	203385f2-7ed8-41d5-9911-d3b4edc3715c	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Hellbender	1.0
06c7e4a9-fd22-4009-9e28-bf8a77f317b0	203385f2-7ed8-41d5-9911-d3b4edc3715c	6541051c-0452-492d-b054-9a1040393283	206	1.0
9df6e74d-10a3-47b8-ae34-ba13d6b88e7c	203385f2-7ed8-41d5-9911-d3b4edc3715c	11c321e5-1143-4634-aa20-27a025c3e47e	Sr Analyst	0.0
71b12505-5165-4c55-addf-f50dbf5b50a3	203385f2-7ed8-41d5-9911-d3b4edc3715c	4f907b77-fa2a-43c9-a20b-cf25754566fc	The Nautilus	1.0
f1a2ad21-b12a-49f6-845f-3839be3e396c	203385f2-7ed8-41d5-9911-d3b4edc3715c	b99de020-d815-4cdc-b389-e73aa2b34250	WWI	1.0
54bd642c-e08f-4f27-ba4c-9635e98f395a	203385f2-7ed8-41d5-9911-d3b4edc3715c	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
593966a6-ff1e-4a86-b011-85dc73ee9d3b	203385f2-7ed8-41d5-9911-d3b4edc3715c	2ca22c03-8408-4751-845a-288a00d80b12	-	0.0
0c680f65-1db1-48e5-9721-846a1af5be89	700e94e2-b160-4d8a-bb02-e3b748483194	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia	1.0
ff56f6c7-2b38-4b73-b939-46107d6f4e19	700e94e2-b160-4d8a-bb02-e3b748483194	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Diameter of the bullet	1.0
984b4f9c-2b14-4150-a419-1366b7c538e6	700e94e2-b160-4d8a-bb02-e3b748483194	31e8e209-48ff-49eb-8891-50445e1b0456	King Henry 	0.0
03c97b12-44c1-421f-8890-3539fb708454	700e94e2-b160-4d8a-bb02-e3b748483194	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Giant Salamander	0.0
204ac04b-53c6-431c-8b0e-5d289cf77666	700e94e2-b160-4d8a-bb02-e3b748483194	6541051c-0452-492d-b054-9a1040393283	237	0.0
9669199c-8aba-4ae2-aff0-d5903c74f55a	700e94e2-b160-4d8a-bb02-e3b748483194	2ca22c03-8408-4751-845a-288a00d80b12	No	0.0
110e7a82-a5ff-4928-852d-72e12eb9b93f	700e94e2-b160-4d8a-bb02-e3b748483194	11c321e5-1143-4634-aa20-27a025c3e47e	Consultant	0.0
32801ce7-5e8b-4ee0-b4a2-b74cac52679f	700e94e2-b160-4d8a-bb02-e3b748483194	4f907b77-fa2a-43c9-a20b-cf25754566fc	No	0.0
17284644-b5f6-4f00-9792-12e5d11ce78a	700e94e2-b160-4d8a-bb02-e3b748483194	b99de020-d815-4cdc-b389-e73aa2b34250	WWI	1.0
3b8fe89d-86e6-4038-90c2-45cb798a7806	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
4a3c95f5-8cbe-46ee-b49f-7e9126b8915d	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Size of the bullet	1.0
842a06d2-8337-43ee-accc-4db47f54f185	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
c99108e4-9d91-410b-845b-2f91d4aae5c1	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Ataxia	0.0
ea5dd245-9473-4ca6-98e1-7b4e94c6c7e8	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	6541051c-0452-492d-b054-9a1040393283	206	1.0
0268c4c7-fe68-43db-87b6-1a2643671d29	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	2ca22c03-8408-4751-845a-288a00d80b12	Martina Hingis	0.0
ff6f0245-a0e5-4403-8b99-876f99f5668a	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	11c321e5-1143-4634-aa20-27a025c3e47e	Cloud consultant	1.0
7b0967ee-81ee-4f70-a0e7-e58e07bf0caf	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	4f907b77-fa2a-43c9-a20b-cf25754566fc	The Nautilus	1.0
12710f08-c2d2-483d-9ff6-768a37ca3a65	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	b99de020-d815-4cdc-b389-e73aa2b34250	WWI	1.0
95a5b143-5145-4465-8048-49c0d297080c	55e4f319-c2ff-4ea6-a856-fb7041ba96bf	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic Nerve	0.0
cd1dbb09-89c8-479c-b8b4-0f8f5495a007	25ef8181-acf4-4dd2-ac23-5bb56794dd4c	12914612-937e-425f-bfd2-bb3886c6f5ad	Sciatic nerve	0.0
e36e73b5-f079-40c1-bad5-74612d463d1e	f92963a8-3216-4085-a00c-83c0be17df7a	2ca22c03-8408-4751-845a-288a00d80b12	Sounds like a Russian player but I don't know any so I had to give up.	0.0
1f4b5f4d-2827-4ec2-8020-110ded8e0e4d	95dd2780-2e0a-4f7d-a869-c44955822f9d	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus Nerve	1.0
829dcd6f-b9bb-426e-8814-660e6ca56b7f	4c292138-6a33-44c6-befa-8d81692f3fab	11c321e5-1143-4634-aa20-27a025c3e47e	Consultant?	0.0
145c8cd6-cf88-49fa-9db8-a96601dd77cf	52cb4736-576a-4bda-a8fd-cb252dc84d2f	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Red Spotted Salamander	0.0
0b821915-f2ac-4a0d-854d-c4647b9f3da0	a775cc8b-6b1b-47f8-8db2-f6c2402d2898	e8528d5a-bf83-4c9b-ba96-92e39f204b75	Bullet/barrel diameter	1.0
f4d38a2a-ec90-4f05-9ce6-85a5347ee6db	700e94e2-b160-4d8a-bb02-e3b748483194	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
1bef9c67-1ae0-4f95-8f35-eadd988125bb	9fc8dc00-55b2-433a-9d83-f99086d4c90d	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
12a25adc-b36c-48df-9d8e-603f0f058f8c	9fc8dc00-55b2-433a-9d83-f99086d4c90d	e8528d5a-bf83-4c9b-ba96-92e39f204b75	The bullet size	1.0
bef54a4d-b2b3-441b-94d4-d9f96868bc02	9fc8dc00-55b2-433a-9d83-f99086d4c90d	31e8e209-48ff-49eb-8891-50445e1b0456	Churchill	1.0
f28d3d83-0ae8-47b5-b9fb-45b196f582ec	9fc8dc00-55b2-433a-9d83-f99086d4c90d	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Slimy McSlimer	0.0
e472aaf3-da28-4157-a66c-0dc5f96a53af	9fc8dc00-55b2-433a-9d83-f99086d4c90d	6541051c-0452-492d-b054-9a1040393283	206	1.0
e3419260-51e4-4f00-a631-a4aa855099c1	9fc8dc00-55b2-433a-9d83-f99086d4c90d	2ca22c03-8408-4751-845a-288a00d80b12	Seles	1.0
ad54da03-bb8f-4116-84f1-d14d38eb1d7c	9fc8dc00-55b2-433a-9d83-f99086d4c90d	11c321e5-1143-4634-aa20-27a025c3e47e	EM	0.0
96408697-99af-4d61-af91-5ddf17276a48	9fc8dc00-55b2-433a-9d83-f99086d4c90d	4f907b77-fa2a-43c9-a20b-cf25754566fc	P. sherman 42 wallaby way	0.0
8bab655a-b925-453a-ae37-a95b7424a867	9fc8dc00-55b2-433a-9d83-f99086d4c90d	b99de020-d815-4cdc-b389-e73aa2b34250	Cold War	0.0
39ef246e-8244-40db-9491-c6bd9133dc31	9fc8dc00-55b2-433a-9d83-f99086d4c90d	12914612-937e-425f-bfd2-bb3886c6f5ad	The nerve of our clients	0.0
90c8249f-f2a3-4fad-95dc-26d70564f353	f92963a8-3216-4085-a00c-83c0be17df7a	e8528d5a-bf83-4c9b-ba96-92e39f204b75	The diameter of the bullet	1.0
274f97f9-e278-4f37-a51c-8c6f870274ce	f92963a8-3216-4085-a00c-83c0be17df7a	31e8e209-48ff-49eb-8891-50445e1b0456	Winston Churchill	1.0
05d2c4f7-c92e-47c9-81b5-b6152d8647dc	f92963a8-3216-4085-a00c-83c0be17df7a	6541051c-0452-492d-b054-9a1040393283	266	0.0
bf25034a-d4a1-472f-8947-fcd8258cf801	f92963a8-3216-4085-a00c-83c0be17df7a	11c321e5-1143-4634-aa20-27a025c3e47e	Analyst	0.0
a916baff-8fc2-4f80-a384-03b98ef46113	f92963a8-3216-4085-a00c-83c0be17df7a	4f907b77-fa2a-43c9-a20b-cf25754566fc	Explorer	0.0
daa15048-f3e5-4870-a12b-81487d06f7b3	f92963a8-3216-4085-a00c-83c0be17df7a	b99de020-d815-4cdc-b389-e73aa2b34250	World War 1	1.0
cbc1a01a-b550-4c36-a19f-4f27c7ed2225	f92963a8-3216-4085-a00c-83c0be17df7a	12914612-937e-425f-bfd2-bb3886c6f5ad	Vagus nerve	1.0
c6401009-ec2b-4366-ac37-5596c63b3636	f92963a8-3216-4085-a00c-83c0be17df7a	eec9096b-2e69-40b5-a334-8169c5c885d5	Mia Thermopolis	1.0
266268dd-d237-4abc-921c-5839faf6c3e3	f92963a8-3216-4085-a00c-83c0be17df7a	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	Hellbender	1.0
5663f9b9-2d15-483b-92ea-3f8968eb8cac	839176b9-558e-43c6-a1eb-47f16269e4db	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
b1c1fc69-272e-4147-a199-4a720025dd70	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	29609503-20e1-4492-9819-5c0713d1691e	Susan Polgar	0.0
a05cbb1e-1380-4026-aa52-5c291a3efede	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
1578a998-6185-4710-a06f-df178bd38a4f	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamlin	1.0
8b88e718-efb4-4467-846a-cfe1bdd0365e	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
8f302322-a7ba-459e-b934-15fb94c7aa47	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
246f610e-59b4-4384-9ca2-5ac600dbeb23	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
25856aea-b185-44bb-b81f-f73e088ae86c	2d37ba60-1577-4eb5-8c1e-1ede581dc559	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
150b34dd-0b19-4572-a016-c2d5d12c255f	2d37ba60-1577-4eb5-8c1e-1ede581dc559	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
42a82987-ca81-4a9d-a863-a949a7e40b1f	2d37ba60-1577-4eb5-8c1e-1ede581dc559	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
d4bf8288-4726-4bfb-8514-2fbef5b5137f	2d37ba60-1577-4eb5-8c1e-1ede581dc559	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
6b16a59d-9d8b-4a2b-b19e-de62a0e4c88b	2d37ba60-1577-4eb5-8c1e-1ede581dc559	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
2857febc-2e46-4484-8b37-db2cf0a23710	2d37ba60-1577-4eb5-8c1e-1ede581dc559	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamelin	1.0
f4994a89-6be1-42f4-8561-31a1ff66a09f	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
5f7cc456-1daf-406d-b3b8-02107782c63a	839176b9-558e-43c6-a1eb-47f16269e4db	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Thomas Muller	0.0
bcb507e3-8c7c-4e6d-bf98-86ea4c999335	839176b9-558e-43c6-a1eb-47f16269e4db	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
993e076a-79b7-4217-b0d1-a412936576d4	839176b9-558e-43c6-a1eb-47f16269e4db	eef09846-d717-48e6-838d-30af16c6dda2	12 angry men	1.0
1904d67e-4a92-4188-8b93-5ab4042ba2df	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
6787040b-c3b4-4abb-ac4a-9a18b84053df	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
a88e6404-6947-4ac9-b289-fefe14316fa3	0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
48dc6b60-a60b-4dce-a7e1-5db30e7ad1d5	839176b9-558e-43c6-a1eb-47f16269e4db	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
d1ae539e-6d7c-448e-bc7c-cf102bce3cfd	839176b9-558e-43c6-a1eb-47f16269e4db	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
f4d96b55-f963-4b08-9f74-ab5d6232fafe	839176b9-558e-43c6-a1eb-47f16269e4db	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Derrick Henry	0.0
e59cc43e-61b2-43e9-b13b-9d29a0e8cc39	839176b9-558e-43c6-a1eb-47f16269e4db	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
89739248-4911-4b06-9d9e-a9bd8f4399a8	eed34ef9-492e-455b-bc38-26568b1dccee	5182d01b-0798-48f5-9087-40969a5d641e	Elgin Taylor 	0.0
5664a55c-e2eb-4216-96f8-1779443da6d1	eed34ef9-492e-455b-bc38-26568b1dccee	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Mary Queen of Scots	0.0
25d5efff-4b4d-4a25-a1be-4d63e99d8491	083f1c0e-8593-440a-857d-64ed4a2fa1c0	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
258196d7-5c73-46b7-8615-ab3a9a9b5f78	083f1c0e-8593-440a-857d-64ed4a2fa1c0	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
db5f1083-d4c8-46bf-b34a-ff2fc43e94a2	083f1c0e-8593-440a-857d-64ed4a2fa1c0	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
5ee352c7-f9e3-4d84-8e2d-de1cb7a2ffc9	083f1c0e-8593-440a-857d-64ed4a2fa1c0	29609503-20e1-4492-9819-5c0713d1691e	Judit Polgar	1.0
a4a20f93-e945-42f9-822a-901fe364568e	083f1c0e-8593-440a-857d-64ed4a2fa1c0	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
6fa680ac-7145-4b95-aa77-f15cac1fb6e2	083f1c0e-8593-440a-857d-64ed4a2fa1c0	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
a9ab499d-9318-43d3-ad90-e9e3d3a31d7a	083f1c0e-8593-440a-857d-64ed4a2fa1c0	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamlin	1.0
48003c98-95fd-4e18-a831-bf0feb2105d7	404d6a9f-695d-4896-b8a6-03260fda9e65	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
8e133771-0448-4144-966e-e72fd48bd83f	404d6a9f-695d-4896-b8a6-03260fda9e65	0f67ead7-5a1a-41a9-ae22-7f432eedf319	Scream 7	1.0
ec07246d-a6c1-4340-bc50-faf523a526e7	404d6a9f-695d-4896-b8a6-03260fda9e65	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
58df886a-9415-458f-8764-18958c943888	a4c35b66-5dda-408c-ae6b-19a04eddc469	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
73320a85-3924-443f-bf5e-39300c858746	a4c35b66-5dda-408c-ae6b-19a04eddc469	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
3851dd18-9f8d-476a-af93-b4e424311cde	a4c35b66-5dda-408c-ae6b-19a04eddc469	29609503-20e1-4492-9819-5c0713d1691e	Beyonce	0.0
24fbdb57-724d-4d71-82a7-83fba3e774af	a4c35b66-5dda-408c-ae6b-19a04eddc469	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
612af2fe-feca-4df4-a031-96aefc913b49	a4c35b66-5dda-408c-ae6b-19a04eddc469	cc766341-ed8b-4640-b479-004e220fc266	James	0.0
9c63f0c0-6e9a-48e3-8a2f-03eb201ab809	a4c35b66-5dda-408c-ae6b-19a04eddc469	0f67ead7-5a1a-41a9-ae22-7f432eedf319	5	0.0
91bdf4f6-288d-4d68-b0e1-4140c97b4748	bca7d85d-de27-472c-99e9-ad2ff88bf923	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
56b0045d-6864-41e3-9f1d-f1a01db47945	bca7d85d-de27-472c-99e9-ad2ff88bf923	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
90ceb01c-0d9b-4515-a388-fdefc546bbc9	bca7d85d-de27-472c-99e9-ad2ff88bf923	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
11a70063-c8f1-4d64-b69e-5e6bac533a88	bca7d85d-de27-472c-99e9-ad2ff88bf923	cc766341-ed8b-4640-b479-004e220fc266	Mike	0.0
12c1de29-a41a-46f4-977f-41398b8ebd4b	bca7d85d-de27-472c-99e9-ad2ff88bf923	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Dorseldorf	0.0
0cdb8138-6139-4b97-bb30-81d322da542e	bca7d85d-de27-472c-99e9-ad2ff88bf923	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
0c38acdd-282c-4946-ae18-bf3c5b886d31	2d37ba60-1577-4eb5-8c1e-1ede581dc559	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
06e4f676-25d2-4e74-b075-8b4b0a280d86	2d37ba60-1577-4eb5-8c1e-1ede581dc559	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
2896d2c5-b7e2-412e-b827-a5fef92e8ede	2d37ba60-1577-4eb5-8c1e-1ede581dc559	29609503-20e1-4492-9819-5c0713d1691e	Judit Polgar	1.0
73cfb33f-a062-4ff6-9c84-dc79de4926a3	083f1c0e-8593-440a-857d-64ed4a2fa1c0	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
50a6ced2-c6bb-45e9-a452-80e8a8564837	083f1c0e-8593-440a-857d-64ed4a2fa1c0	0f67ead7-5a1a-41a9-ae22-7f432eedf319	Seven	1.0
88066e1b-0028-4e57-8ac7-ed67d9a462b4	083f1c0e-8593-440a-857d-64ed4a2fa1c0	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
2de1fa64-34d8-4689-b46a-34d9c8706712	eed34ef9-492e-455b-bc38-26568b1dccee	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
df04ffbb-6a8f-412b-955f-a4da07d3e1f2	eed34ef9-492e-455b-bc38-26568b1dccee	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
9c02a469-a5fd-4a18-8d02-2d1722a837f9	eed34ef9-492e-455b-bc38-26568b1dccee	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
dc58de61-8db0-4733-84dc-3550a14d5212	eed34ef9-492e-455b-bc38-26568b1dccee	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jaxon Smith Ngiba	0.0
9d9e2477-beb8-4057-8b5b-15ef819b5217	404d6a9f-695d-4896-b8a6-03260fda9e65	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
e8c3d3c7-f4a5-4a8c-ab2d-983f3e110c85	404d6a9f-695d-4896-b8a6-03260fda9e65	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
72290ab0-3ec5-48e6-9d44-2b2a4a6fa11f	404d6a9f-695d-4896-b8a6-03260fda9e65	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
4d35c58a-4876-4e88-8e99-61b1309bc3d9	404d6a9f-695d-4896-b8a6-03260fda9e65	29609503-20e1-4492-9819-5c0713d1691e	Essak Seddiq	0.0
3174865a-0006-4555-8b29-1e2e14710d2b	404d6a9f-695d-4896-b8a6-03260fda9e65	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
fd1a70f4-9648-4aa2-86ca-5cccb28f9c59	404d6a9f-695d-4896-b8a6-03260fda9e65	cc766341-ed8b-4640-b479-004e220fc266	Frenchie	0.0
37342cd9-3294-4c75-9711-8a37ef30cb02	404d6a9f-695d-4896-b8a6-03260fda9e65	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamelin	1.0
67e22ad6-b6ae-408a-afcc-8f5564449238	a4c35b66-5dda-408c-ae6b-19a04eddc469	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Lundz	0.0
f36e5794-358d-4739-ba3b-a745e80174af	a4c35b66-5dda-408c-ae6b-19a04eddc469	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
de84d04b-a8fd-4d9f-872a-4daa8175329a	bca7d85d-de27-472c-99e9-ad2ff88bf923	94d67cea-8f68-4646-bd8a-9c078d980ce1	Mica	0.0
2b3db187-0093-4afc-bd82-10b6f480969f	bca7d85d-de27-472c-99e9-ad2ff88bf923	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
3c285152-28d1-4547-998d-6e09e23690ba	a4c35b66-5dda-408c-ae6b-19a04eddc469	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
2b93f13a-d9d5-4c4c-9c71-c76ef56b7dc7	a4c35b66-5dda-408c-ae6b-19a04eddc469	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
8c6401e6-8157-44d8-9342-ec359b25750c	bca7d85d-de27-472c-99e9-ad2ff88bf923	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
2c24df77-5afb-4522-8918-cdc0e1ad9b62	2d37ba60-1577-4eb5-8c1e-1ede581dc559	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
58af95e9-dd3b-4a18-9c0d-9b95384f1f56	eed34ef9-492e-455b-bc38-26568b1dccee	3a08309f-da7d-4a81-b973-049736e0ef69	Jonathan Nolan	0.0
ab813b90-4176-4e17-9cfc-e7b49df418bb	79af663b-0c91-4782-ab8a-95dd32d58afa	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
3ee4f2ab-f2bd-4888-b1dd-843398384638	79af663b-0c91-4782-ab8a-95dd32d58afa	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamelin	1.0
e57eac3b-904f-4b4a-97c5-30f8000dd59f	79af663b-0c91-4782-ab8a-95dd32d58afa	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
f819fa2d-2d04-48af-976c-9e5eff11ceb1	79af663b-0c91-4782-ab8a-95dd32d58afa	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
a74ef739-7ce7-494c-89b2-f0f77a5d3767	79af663b-0c91-4782-ab8a-95dd32d58afa	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
a54e24a3-2df5-45f0-94be-d45e2bffa0a6	79af663b-0c91-4782-ab8a-95dd32d58afa	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
db01ac4f-16d6-46dd-a723-88b4d1e0e278	79af663b-0c91-4782-ab8a-95dd32d58afa	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo XIII	1.0
9401f905-5537-4975-a584-68a66a4a78bf	79af663b-0c91-4782-ab8a-95dd32d58afa	29609503-20e1-4492-9819-5c0713d1691e	?	0.0
9bfc292b-d3cf-4d08-a8bd-fc56ebc598df	7a519f5d-68e4-473a-b1af-f119519887c1	94d67cea-8f68-4646-bd8a-9c078d980ce1	graphite	0.0
9cbd55c2-a68c-408f-9b5d-38b8a585f6de	7a519f5d-68e4-473a-b1af-f119519887c1	cc766341-ed8b-4640-b479-004e220fc266	john	0.0
8907f066-9153-4aa6-86ae-433feaed55bb	dd5f92cb-4f97-46de-9ba1-2a21806346e9	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamlin	1.0
06e954a0-1eb7-4d07-95ac-3165c3191b4b	dd5f92cb-4f97-46de-9ba1-2a21806346e9	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
39208999-4381-4718-a5ad-d638c6a03e38	dd5f92cb-4f97-46de-9ba1-2a21806346e9	0f67ead7-5a1a-41a9-ae22-7f432eedf319	Scream 7	1.0
a311da69-b060-4652-838f-dffad9efa529	dd5f92cb-4f97-46de-9ba1-2a21806346e9	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
ba7f9a04-09f5-4fb2-9756-f159ef7c9ff9	dd5f92cb-4f97-46de-9ba1-2a21806346e9	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
447a5e4f-d509-405e-aa38-444752af042c	dd5f92cb-4f97-46de-9ba1-2a21806346e9	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
a10b7030-8b64-4ca5-b69b-4986d250ff38	dd5f92cb-4f97-46de-9ba1-2a21806346e9	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
1770e0f6-d0da-4144-90e9-4f7df0988cb0	dd5f92cb-4f97-46de-9ba1-2a21806346e9	29609503-20e1-4492-9819-5c0713d1691e	idk :(	0.0
3ee419a3-b3ca-46d2-a203-3c548e9bda2f	dd5f92cb-4f97-46de-9ba1-2a21806346e9	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
4aa4a016-e311-44b0-8afe-7b423172f182	50277dea-52b8-44c8-9184-26d1d38a39b1	cc766341-ed8b-4640-b479-004e220fc266	Fred	0.0
d729246f-3e5a-49b7-8bd7-b9f425b2d32b	7a519f5d-68e4-473a-b1af-f119519887c1	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	hameline	1.0
75a874de-fa7c-481d-acf2-94412da793ca	7a519f5d-68e4-473a-b1af-f119519887c1	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
ebb84d91-3ce6-4859-8d7d-5f2afc12fd9e	7a519f5d-68e4-473a-b1af-f119519887c1	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
7dc587ea-1e11-457b-859a-b036d9234136	7a519f5d-68e4-473a-b1af-f119519887c1	3f149c70-f473-4159-96e6-da43de13c388	tuberculosis	1.0
d2836311-b715-40a3-bb5f-c4366472a421	7a519f5d-68e4-473a-b1af-f119519887c1	49bbe70f-f339-4d32-a042-09426d6a7a07	the holy grail	0.0
44514881-7da5-43eb-be6b-6de295fc84da	7a519f5d-68e4-473a-b1af-f119519887c1	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	apollo 13	1.0
45c1085a-f7fa-4168-b7dd-04b911bc6a99	7a519f5d-68e4-473a-b1af-f119519887c1	47d131b5-e18c-4a23-8663-2c1e859cd798	archimedes	1.0
0e2f006b-7bd5-4327-990c-fcb827b25784	7a519f5d-68e4-473a-b1af-f119519887c1	29609503-20e1-4492-9819-5c0713d1691e	judit polgar	1.0
245435af-582e-4fdd-885f-63ae2a110b60	2543377e-aa52-47d9-8beb-b13a7b146b26	94d67cea-8f68-4646-bd8a-9c078d980ce1	Sandstone	0.0
2b33218d-8d5a-4cea-9d97-db2c41df7cab	2543377e-aa52-47d9-8beb-b13a7b146b26	cc766341-ed8b-4640-b479-004e220fc266	James	0.0
48615dc6-c051-44e0-b88c-4a2be5832c55	50277dea-52b8-44c8-9184-26d1d38a39b1	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Berlin	0.0
4cae78e8-d7db-4a66-8dec-8c933879f7e8	50277dea-52b8-44c8-9184-26d1d38a39b1	429a804d-41cc-43b3-af55-3ee1c6bd08fc	K-pop Demon Slayer	0.0
989eb7c0-8a9a-4222-b594-0f622c109897	50277dea-52b8-44c8-9184-26d1d38a39b1	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
0b7be011-23a4-461a-9301-4178a08a5266	50277dea-52b8-44c8-9184-26d1d38a39b1	3f149c70-f473-4159-96e6-da43de13c388	Scarlett Fever	0.0
d2b5a5c6-ea80-4101-bcfb-98699dedfbe3	50277dea-52b8-44c8-9184-26d1d38a39b1	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
9f557a05-1c1f-40a4-bb95-6f65bc14bae5	50277dea-52b8-44c8-9184-26d1d38a39b1	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 14	0.0
370979f8-c051-4b27-9272-ec67b067cc27	50277dea-52b8-44c8-9184-26d1d38a39b1	47d131b5-e18c-4a23-8663-2c1e859cd798	Pythagoras	0.0
4bb495ef-2214-404e-b847-e9a47f8cf1dc	50277dea-52b8-44c8-9184-26d1d38a39b1	29609503-20e1-4492-9819-5c0713d1691e	Margo Beck	0.0
dca250ba-2f6e-45cc-925c-545c4e009226	bca7d85d-de27-472c-99e9-ad2ff88bf923	29609503-20e1-4492-9819-5c0713d1691e	Elizabeth	0.0
fb7def8d-ea57-4dda-a703-2147364dec5c	79af663b-0c91-4782-ab8a-95dd32d58afa	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
57c574fe-cbbf-4959-9e75-09a26418675e	2543377e-aa52-47d9-8beb-b13a7b146b26	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Bavaria	0.0
e078a24a-0412-43e8-8957-0b65807c69dc	2543377e-aa52-47d9-8beb-b13a7b146b26	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
247b4dbb-565d-4dbd-81c1-ad479f4d5ddb	2543377e-aa52-47d9-8beb-b13a7b146b26	0f67ead7-5a1a-41a9-ae22-7f432eedf319	6	0.0
8d02c228-17d4-41e2-adc2-47916dfea75b	2543377e-aa52-47d9-8beb-b13a7b146b26	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
fc42916c-1a24-4501-86ea-f8fae0225743	2543377e-aa52-47d9-8beb-b13a7b146b26	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 8	0.0
8e167166-6aa3-4cc7-b720-b28b6540458a	2543377e-aa52-47d9-8beb-b13a7b146b26	47d131b5-e18c-4a23-8663-2c1e859cd798	Bernoulli	0.0
3da15719-bec9-4ba7-82d4-5077bf207616	2543377e-aa52-47d9-8beb-b13a7b146b26	29609503-20e1-4492-9819-5c0713d1691e	No idea :(	0.0
42b16ad8-a78f-4df9-8293-812b95af52d9	dd5f92cb-4f97-46de-9ba1-2a21806346e9	cc766341-ed8b-4640-b479-004e220fc266	James	0.0
04cf7068-5787-4498-a8bd-2d366135ecda	50277dea-52b8-44c8-9184-26d1d38a39b1	94d67cea-8f68-4646-bd8a-9c078d980ce1	Lithium	0.0
ff80edaf-a89e-49c7-8bde-3f5091d450e8	bee362a7-4dd6-4227-904e-bfa3c3b44908	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
f44c7afc-c160-4137-9142-c5983ef373c6	bee362a7-4dd6-4227-904e-bfa3c3b44908	5182d01b-0798-48f5-9087-40969a5d641e	Wilt Chamberlain	0.0
e014876d-f96f-4a0b-b67c-55d032399a54	bee362a7-4dd6-4227-904e-bfa3c3b44908	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Par	1.0
cfbd0259-f929-4e02-81e6-8fef3186abf9	bee362a7-4dd6-4227-904e-bfa3c3b44908	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
4af81955-fff1-483c-857c-62dbb9b89250	bee362a7-4dd6-4227-904e-bfa3c3b44908	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
e200de8b-bdfa-4636-95fb-da8155303f5e	bee362a7-4dd6-4227-904e-bfa3c3b44908	eef09846-d717-48e6-838d-30af16c6dda2	The Last Juror	0.0
72b08f72-ef11-4329-a753-08982fb4fe85	bee362a7-4dd6-4227-904e-bfa3c3b44908	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
897065f8-9d23-4edd-b363-f812f83f7ed7	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
36d9e73b-93cd-4b24-a027-0a2cd25ce0e0	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
d97b9ac2-29f4-432f-8b70-ad4ac804e538	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	29609503-20e1-4492-9819-5c0713d1691e	unknown	0.0
b0500184-8846-42a4-a4c5-674f45a865d9	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamelin	1.0
4cf2d248-fa5e-4d2f-acd8-04219776db19	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	429a804d-41cc-43b3-af55-3ee1c6bd08fc	Huntrix	0.0
905488ca-f34b-4711-b50a-2a5ad208ba98	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	0f67ead7-5a1a-41a9-ae22-7f432eedf319	Scream 7	1.0
fec356f2-cf78-4b72-846b-cee5432ca297	3267c0e8-b8b0-4d37-a57e-d1c6da230554	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
22a2071b-8cbc-4ee0-8723-227eaed8197d	3267c0e8-b8b0-4d37-a57e-d1c6da230554	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
9571e3eb-9616-4e8a-a86b-582a9b7aa2fb	3267c0e8-b8b0-4d37-a57e-d1c6da230554	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
de53d583-1bda-4904-a309-4c9368b49f06	3267c0e8-b8b0-4d37-a57e-d1c6da230554	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
66e8a6b4-6cc5-4063-a0a7-b1eab22cffc8	857255dd-891c-4ea0-bdf8-a96b40cd1c20	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
4a6075e4-aa3a-4cf6-97bd-715ce7b23ad1	857255dd-891c-4ea0-bdf8-a96b40cd1c20	29609503-20e1-4492-9819-5c0713d1691e	IBM	0.0
3e7b1ec5-9edb-4d00-b892-21d9519785a2	857255dd-891c-4ea0-bdf8-a96b40cd1c20	94d67cea-8f68-4646-bd8a-9c078d980ce1	Gold	0.0
68b0faa6-7a7c-47b0-b035-bc1053d24069	857255dd-891c-4ea0-bdf8-a96b40cd1c20	cc766341-ed8b-4640-b479-004e220fc266	Ben	0.0
7df1bd52-b8ba-4f02-8adb-f23243dc0ef3	857255dd-891c-4ea0-bdf8-a96b40cd1c20	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Munich	0.0
0e0e21d6-fd31-45a5-b332-b86aa7db8139	857255dd-891c-4ea0-bdf8-a96b40cd1c20	49bbe70f-f339-4d32-a042-09426d6a7a07	Space Monkeys	0.0
e9902dc3-63e8-4e4f-8f67-9fc2c7b4caa3	3267c0e8-b8b0-4d37-a57e-d1c6da230554	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talcum	1.0
db324818-be49-45c1-89c1-41b638003d18	3267c0e8-b8b0-4d37-a57e-d1c6da230554	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamlin	1.0
12ff67ee-3de9-484d-b917-ad4ea6ae1547	3267c0e8-b8b0-4d37-a57e-d1c6da230554	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
d10143d6-11f2-4a7d-a0fd-b673eb58c6a6	3267c0e8-b8b0-4d37-a57e-d1c6da230554	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
b7edf0b3-2716-4f5c-92f9-e1237fa64e6f	3267c0e8-b8b0-4d37-a57e-d1c6da230554	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
e4e2eb68-1716-447a-9d5b-0a979f347ce5	3267c0e8-b8b0-4d37-a57e-d1c6da230554	29609503-20e1-4492-9819-5c0713d1691e	Beth Harmon	0.0
b2331ff3-ed81-48fe-8884-5fbe3f97b065	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	94d67cea-8f68-4646-bd8a-9c078d980ce1	Gold	0.0
97a2fb5d-4724-4026-8574-8e5e4780b00c	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
167963d7-1802-482e-a104-59d473daa311	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Munich	0.0
ac2c6037-883c-43de-b84d-221f9a90fd06	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
8e66cba0-91e5-4c64-8045-5193f388a411	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	0f67ead7-5a1a-41a9-ae22-7f432eedf319	6	0.0
f492f176-0f0f-4cb7-8922-258bb5b98008	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
f8c735ce-a448-45b3-a8eb-449833448f00	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	49bbe70f-f339-4d32-a042-09426d6a7a07	One piece	1.0
5cfe47ef-70ba-4c97-89e9-966595d6d14a	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
a2ddebbd-02e6-45dd-8a21-a9d078a11e5d	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
9ea4cebb-9323-4ce4-b903-d44ecb013d5d	c7165fe2-4d3c-4a38-94c1-e1dbc4969457	29609503-20e1-4492-9819-5c0713d1691e	Judith Polgar	1.0
554da2e0-9913-4765-bfcc-dcc3ab356d75	e48c7bec-d192-43dc-b1e3-c6470aca44fe	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
7a780334-54c1-4da5-a13e-07117c1c1db7	e48c7bec-d192-43dc-b1e3-c6470aca44fe	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamlin	1.0
38d43d71-15cc-4cd4-9102-8e4c8d72826e	857255dd-891c-4ea0-bdf8-a96b40cd1c20	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
0a2ee3a1-16a1-4948-ad28-6bc4f7d576d0	857255dd-891c-4ea0-bdf8-a96b40cd1c20	3f149c70-f473-4159-96e6-da43de13c388	menengitus	0.0
d13e465d-91a7-434b-8bec-aeb1bafc9ad1	857255dd-891c-4ea0-bdf8-a96b40cd1c20	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
0ce7e73c-1a62-4254-869e-3b8e10c798ec	857255dd-891c-4ea0-bdf8-a96b40cd1c20	47d131b5-e18c-4a23-8663-2c1e859cd798	Floatation	0.0
1f5b5562-e86b-4a91-a60b-a7137348c87b	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	cc766341-ed8b-4640-b479-004e220fc266	Louis	1.0
e7f3be07-05fe-4809-8aff-06c5f2f63036	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
4bc85654-c671-4897-b951-8800ba25a47b	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
1a97be61-6532-4d34-9623-91092b51c371	d19226c5-9e7d-4ecf-b90c-d68536ea40ef	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
5abcbf2d-d430-4839-bf4b-8dc9ad75eff3	554cb6f2-fdcc-4a4b-983c-88d996d69c63	29609503-20e1-4492-9819-5c0713d1691e	Judit Polgar	1.0
2976b6fb-f489-4ee9-af85-c32c8d9f3d63	554cb6f2-fdcc-4a4b-983c-88d996d69c63	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
e36fe3fe-e18f-43f4-a1fd-e53ab73c2e32	554cb6f2-fdcc-4a4b-983c-88d996d69c63	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
4ce7dc23-5790-4e01-82a3-c623bc03785c	38a2f6ae-6558-43dc-984a-4bfafd616d11	49bbe70f-f339-4d32-a042-09426d6a7a07	Sailor moon	0.0
1fcc25b3-4fb9-46d1-bd2c-fd892325d250	38a2f6ae-6558-43dc-984a-4bfafd616d11	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Moon Landing Apollo 13	1.0
71a7ea30-fb8a-4015-bffb-b3f96505b215	38a2f6ae-6558-43dc-984a-4bfafd616d11	47d131b5-e18c-4a23-8663-2c1e859cd798	Euler	0.0
4986f064-d362-469f-810b-0a9dea87929e	38a2f6ae-6558-43dc-984a-4bfafd616d11	29609503-20e1-4492-9819-5c0713d1691e	Na	0.0
fd232690-9972-4b34-8b62-d11b6e874271	79af663b-0c91-4782-ab8a-95dd32d58afa	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes of Syracuse	1.0
89eed0be-494d-4118-8dbc-81a4ad0475bd	2543377e-aa52-47d9-8beb-b13a7b146b26	3f149c70-f473-4159-96e6-da43de13c388	Measles	0.0
46111d5b-99b0-4e3f-9817-41c467a5988e	e48c7bec-d192-43dc-b1e3-c6470aca44fe	cc766341-ed8b-4640-b479-004e220fc266	Sam	0.0
40511c29-6ba3-4539-8edd-1c80c641e765	e48c7bec-d192-43dc-b1e3-c6470aca44fe	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
2ffd8f6f-f8bb-43cd-ad27-42452296239a	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	94d67cea-8f68-4646-bd8a-9c078d980ce1	Talc	1.0
526ece23-2213-426b-8dd2-fe5c8a1a31b4	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
97cd6384-17ea-4512-8337-e3d001c23ad5	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	29609503-20e1-4492-9819-5c0713d1691e	Judit Polgar	1.0
1af01143-c664-41dc-9d48-8a6084377bd3	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
71d11b49-115d-402f-9314-e467873389b6	554cb6f2-fdcc-4a4b-983c-88d996d69c63	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
1cc64d2c-f651-4590-a8e5-2e6ab41a1889	554cb6f2-fdcc-4a4b-983c-88d996d69c63	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
1e2e21fa-4a95-4cc0-86ef-8bea9399a323	554cb6f2-fdcc-4a4b-983c-88d996d69c63	cc766341-ed8b-4640-b479-004e220fc266	James	0.0
dea39516-a820-4711-a231-6f4b60e5ea2c	554cb6f2-fdcc-4a4b-983c-88d996d69c63	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Berlin	0.0
95e31f8f-1049-42c4-9f2b-2c9426e3e9e6	554cb6f2-fdcc-4a4b-983c-88d996d69c63	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
b1e761f9-e3fd-40de-982a-ee9b344b2029	554cb6f2-fdcc-4a4b-983c-88d996d69c63	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
0000c5ce-377c-4dd9-9aaf-e90e01dc0d33	554cb6f2-fdcc-4a4b-983c-88d996d69c63	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
d846921b-f54a-472e-8ebc-738d0be86e92	e48c7bec-d192-43dc-b1e3-c6470aca44fe	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
86ba8b19-95c4-4790-9d97-0e122536ae5a	e48c7bec-d192-43dc-b1e3-c6470aca44fe	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
deba0278-a3ab-498b-bbf1-d9b6a3457a62	e48c7bec-d192-43dc-b1e3-c6470aca44fe	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
32e00d67-d56f-4352-bb53-e4a968eaa7a2	e48c7bec-d192-43dc-b1e3-c6470aca44fe	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
ba6919d7-a649-4592-8021-24d01ed632dd	e48c7bec-d192-43dc-b1e3-c6470aca44fe	47d131b5-e18c-4a23-8663-2c1e859cd798	Archimedes	1.0
fc54891c-afa8-4ac1-91b5-e3f62cb2b5d8	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	cc766341-ed8b-4640-b479-004e220fc266	Luis	1.0
6d8c1be9-2c0c-4598-ad5f-c2f57a2ab016	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	Hamelin	1.0
c36c5010-89aa-4b2e-af70-253679937bfc	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
29f61344-d796-4324-bfa1-9fb58af17fd3	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	3f149c70-f473-4159-96e6-da43de13c388	Tuberculosis	1.0
571d8e8b-21ad-46e3-b723-f59617654656	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	49bbe70f-f339-4d32-a042-09426d6a7a07	One Piece	1.0
2ef71314-a51c-4a35-8c5d-4e163f6b91ad	38a2f6ae-6558-43dc-984a-4bfafd616d11	94d67cea-8f68-4646-bd8a-9c078d980ce1	Sulfur	0.0
5b3c2727-4f03-48fd-aa83-d55a6ee5e0f8	38a2f6ae-6558-43dc-984a-4bfafd616d11	cc766341-ed8b-4640-b479-004e220fc266	Andy	0.0
de547b7f-e476-42bc-8e63-04261cf6950a	38a2f6ae-6558-43dc-984a-4bfafd616d11	0b96243d-6a1b-47ef-9d61-5be40ab6ee35	NA	0.0
1987871d-8d15-47bf-b5b6-d6333fcc3436	38a2f6ae-6558-43dc-984a-4bfafd616d11	429a804d-41cc-43b3-af55-3ee1c6bd08fc	BTS	1.0
1738e889-a1dc-470b-a32c-1fba148ce2f1	38a2f6ae-6558-43dc-984a-4bfafd616d11	0f67ead7-5a1a-41a9-ae22-7f432eedf319	7	1.0
9ac71a0a-0c07-4ebb-b9cb-ce34e9889052	38a2f6ae-6558-43dc-984a-4bfafd616d11	3f149c70-f473-4159-96e6-da43de13c388	Pneumonia 	0.0
a099584f-fc1a-4713-af62-5d16f0075ea3	e48c7bec-d192-43dc-b1e3-c6470aca44fe	29609503-20e1-4492-9819-5c0713d1691e	Judith Polgar	1.0
3ff96018-a35e-4b1c-88a9-9e6e47f2688c	7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	a9bdb28c-acbf-484b-b02f-c0679ad3ac75	Apollo 13	1.0
5113292d-5924-4dd0-807a-4ca831775908	9737632c-0648-4d1d-8ddf-3a287fcb6572	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
c2eeca3a-1b63-4ae4-b10f-901047cba8cc	9737632c-0648-4d1d-8ddf-3a287fcb6572	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
dd9a8847-7d4d-4f28-b574-a29caf06a638	9737632c-0648-4d1d-8ddf-3a287fcb6572	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
eef535f4-a520-4d15-b0ae-a1e13c28fb3e	9737632c-0648-4d1d-8ddf-3a287fcb6572	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120 degrees	1.0
e8e77010-0112-44df-8cab-5ae1005414b0	9737632c-0648-4d1d-8ddf-3a287fcb6572	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
fcdcd7e2-c859-4fef-951c-1b458e87e488	9737632c-0648-4d1d-8ddf-3a287fcb6572	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
4d48d3d9-72a5-4f94-9abd-73b3c0886be4	9737632c-0648-4d1d-8ddf-3a287fcb6572	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chiton	1.0
d1846330-046b-43c3-8def-57102ad62cb3	9737632c-0648-4d1d-8ddf-3a287fcb6572	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Sequan Barkley	0.0
74ef3bc4-09ba-47f1-8432-d60ce7d2b43d	c41035c1-6eaf-4a48-9c97-6ea86861575d	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
fc587134-d611-49a3-9bef-8dba7ca1c54c	c41035c1-6eaf-4a48-9c97-6ea86861575d	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Isabella	0.0
2da8b217-70d4-45ed-834c-2b6d792c0cb9	c41035c1-6eaf-4a48-9c97-6ea86861575d	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
ea02bab1-53c3-4268-956b-01c973447cfc	c41035c1-6eaf-4a48-9c97-6ea86861575d	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
37266874-4ff1-4a64-8f77-9127e1dcfb63	c41035c1-6eaf-4a48-9c97-6ea86861575d	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
fd595ab8-cc61-4972-99b1-e5784addb293	c41035c1-6eaf-4a48-9c97-6ea86861575d	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
b4883044-358f-47e8-bdf2-d07b1be8a64c	c41035c1-6eaf-4a48-9c97-6ea86861575d	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
f26e5eaf-ed4f-4bd9-88c4-dda70adbc4e2	c41035c1-6eaf-4a48-9c97-6ea86861575d	dbd581c6-c54f-4aa1-9189-0de6967efdaf	?	0.0
2676b602-749c-4d0c-8662-a9f3f351e334	c41035c1-6eaf-4a48-9c97-6ea86861575d	5182d01b-0798-48f5-9087-40969a5d641e	?	0.0
d1d75b33-2959-4e5c-8675-699cb512c934	f0feddb4-ef0d-454e-8052-2b11b39d89d8	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
00971f93-5b44-4737-814b-773509799867	ab2b199c-3445-4cc2-be59-698d68272746	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
53f14d88-f977-4cb4-9102-0f7b1a175336	ab2b199c-3445-4cc2-be59-698d68272746	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
367470c2-307b-424b-9d02-1281251c85ad	ab2b199c-3445-4cc2-be59-698d68272746	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
d5fb1f69-dad7-4bae-a793-175dc2f62247	ab2b199c-3445-4cc2-be59-698d68272746	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
aa182c6c-b268-4682-95b5-bfb6151a5cc7	ab2b199c-3445-4cc2-be59-698d68272746	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
d8c84638-4038-452d-b7ad-e296e3e40a99	ab2b199c-3445-4cc2-be59-698d68272746	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
3a521fda-ce9e-4318-8fea-61f55bd30a7b	ab2b199c-3445-4cc2-be59-698d68272746	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
0e7777ad-1faf-4931-ad28-2807c0d0071b	ab2b199c-3445-4cc2-be59-698d68272746	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
6a8361bb-7619-447c-a280-55f0c946a3e9	ab2b199c-3445-4cc2-be59-698d68272746	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
90c38eb9-b8e5-4462-a2bf-3b797fb94d3c	ab2b199c-3445-4cc2-be59-698d68272746	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
e58c7364-61c5-414d-a9b6-77798676b2d6	44117173-dda3-488d-bc86-6c33dbe9ec8e	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
14af14aa-1a62-4237-b4d0-f46b34d724e2	44117173-dda3-488d-bc86-6c33dbe9ec8e	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
278a2359-d361-48c8-a482-e397a196c139	44117173-dda3-488d-bc86-6c33dbe9ec8e	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
5c624af0-29b3-4543-917c-ada2c40f4b15	44117173-dda3-488d-bc86-6c33dbe9ec8e	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
afe5b64c-50f6-44a2-b745-e866577c8c02	44117173-dda3-488d-bc86-6c33dbe9ec8e	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
05debbd4-b85e-4bdd-b65d-acbb6df7c54f	44117173-dda3-488d-bc86-6c33dbe9ec8e	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
1cfd0783-a0ae-4350-aac1-fa1cbafa20fb	44117173-dda3-488d-bc86-6c33dbe9ec8e	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
1d1f1973-4206-4ec3-a334-91e6d238c48c	44117173-dda3-488d-bc86-6c33dbe9ec8e	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
e6a9d30e-142e-47df-93f9-023796b640f3	44117173-dda3-488d-bc86-6c33dbe9ec8e	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
0a1ef33e-c3c7-46bc-9c7e-5629cce59756	44117173-dda3-488d-bc86-6c33dbe9ec8e	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
e0fe8eb7-7a81-41a0-ab37-0e2c633cae8e	9cd05538-1036-4823-a759-25a92e7329b1	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
9fee4ec0-8f21-4b48-a3b4-2bf8f4314229	9cd05538-1036-4823-a759-25a92e7329b1	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
d68b2352-cd4a-44e6-97ce-48492bdfb081	9cd05538-1036-4823-a759-25a92e7329b1	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
db2f10ae-5814-43d3-8ead-573eefb87dc3	9cd05538-1036-4823-a759-25a92e7329b1	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
a1a41fda-5ba8-44f2-9263-1127b9f9bee7	9cd05538-1036-4823-a759-25a92e7329b1	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
eb7b620b-4289-48c5-826d-bd2e6be3e4b7	9cd05538-1036-4823-a759-25a92e7329b1	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
6b0b11b9-7857-4aec-8dd4-99f501b8f357	9cd05538-1036-4823-a759-25a92e7329b1	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo Yo Ma	1.0
8029d4f7-2eaa-465a-9083-4ce0f4b5f828	9cd05538-1036-4823-a759-25a92e7329b1	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
918435eb-fa00-4e8c-b48c-301be8544e09	9cd05538-1036-4823-a759-25a92e7329b1	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
e16c71c2-cc02-4c1b-88b2-7f4ec73e65a6	bee362a7-4dd6-4227-904e-bfa3c3b44908	0d21d6f7-63b1-4758-a746-fbaf6871747a	Keratin	0.0
0692f9b1-d219-4e29-b4b4-eef51bd290b8	bee362a7-4dd6-4227-904e-bfa3c3b44908	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Johnathan Taylor	1.0
3ec4a647-bd33-493f-a582-19e60c9fe253	9737632c-0648-4d1d-8ddf-3a287fcb6572	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crighton	1.0
e0c356d7-3528-4bfe-bc4e-29a68526155e	eed34ef9-492e-455b-bc38-26568b1dccee	eef09846-d717-48e6-838d-30af16c6dda2	Runaway Jury	0.0
cd7b0840-4a8a-4eed-b0cd-88640b6f0fd6	c41035c1-6eaf-4a48-9c97-6ea86861575d	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
9c632bcd-c58a-4ca8-934e-a3f2f67c7e9f	f0feddb4-ef0d-454e-8052-2b11b39d89d8	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
277511ad-44a1-4c44-b080-1b199966fab6	f0feddb4-ef0d-454e-8052-2b11b39d89d8	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
9285c553-1c90-47fd-a465-8332f9687e98	bee362a7-4dd6-4227-904e-bfa3c3b44908	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
a7c46cf4-32e3-42fa-8767-9a7c5b5c4dcc	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
b26aa1bf-814c-4a71-9aaf-6287c449924b	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
da55260c-4ef2-4c92-8b56-03bddaf1be8a	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
d703a78f-3536-4919-b36f-0ddaa2e97f3f	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
8495be07-299e-4291-8d3c-3a0fe398525c	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberpatch	1.0
a4f405ff-e868-4411-82c8-a92d452606b2	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
53043efa-05af-4a21-9bbb-95211d01e3f0	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
706c9037-8b59-4923-8528-9d891058ad18	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
414bd7b0-35b6-43d3-bb32-4835fb3e34c8	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
0206791d-8ebf-40d4-a8c6-5b82b7d17b8c	44c6ae69-53af-40a1-bd37-8cf0f2a58eab	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
c981d583-f3d3-4c37-8452-3cb5dc28e173	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
47b11d9c-1264-407e-aadc-77f864d22c67	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
4f0dab23-712e-4b36-8c1b-f14a37aa40e8	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
f1ed998c-83cd-4603-9371-94e5b691aabf	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
021aa435-3316-41c1-b772-6449f3c3540a	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
50b87c02-b176-4983-bd5b-df420c6a377b	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
0b9b9c18-a1cb-4ed7-a7ec-5d8d25c1ea79	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
094f42b5-917f-4a95-8f2d-f65f1dee8fc7	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
ed6e94b7-746a-4ee0-846b-5db50524883a	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
b553160f-44d7-4ad7-a9dd-3baa581b3a8b	f85546b6-b7f2-449c-a0aa-c38e5d88c61f	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
d59c3ac0-6af4-4d16-af7d-09e9312aea0e	00a224b3-7b5a-4ef3-ad79-0d211d2477de	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
aca9e7b4-9777-4ebd-a1e6-0078829005be	00a224b3-7b5a-4ef3-ad79-0d211d2477de	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
2db458ea-83ed-4450-9512-aded355b0c28	00a224b3-7b5a-4ef3-ad79-0d211d2477de	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
fb6d14dd-9f63-407b-a7ec-97f6c0ecf5f5	00a224b3-7b5a-4ef3-ad79-0d211d2477de	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
71f59b3c-ce76-47d7-a192-a270d4ac3792	00a224b3-7b5a-4ef3-ad79-0d211d2477de	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
8799f4a6-9e8d-4f5f-848a-79a3fe1bb9e6	00a224b3-7b5a-4ef3-ad79-0d211d2477de	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo-Yo Ma	1.0
0847f1ff-c16a-4c8f-864d-de88713e9b06	00a224b3-7b5a-4ef3-ad79-0d211d2477de	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
759427e7-3011-41c6-a2eb-41224f792dad	00a224b3-7b5a-4ef3-ad79-0d211d2477de	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
45caabd7-c4ed-448e-b87a-9d45e1e6e5cd	00a224b3-7b5a-4ef3-ad79-0d211d2477de	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
0c37e506-d309-4e7c-9576-c201bf47bc9f	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
ffae8399-d8ae-439a-a561-22a43d5162e8	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
b68e58f3-c996-451c-bf50-b3757152ae78	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhamad Ali	1.0
53cdb534-b379-4e22-b615-b5cbd16b78dc	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
2c203b0e-2e50-4912-bdbb-c159cd9b7761	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
7964b2bb-6ae7-4a8c-b6b8-6a2bea10eb49	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
30d9c01b-5af7-4459-bdde-7aceee5e3be2	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo-yo Ma	1.0
c4c3cb4d-b1e3-49f8-9324-c91a6d81f0ea	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
612f58d1-36a4-476a-b8d7-17dbf0643060	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
7aa702ad-fe51-480a-b3c1-93041bb170cc	f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
ae95ca14-3063-411e-9f76-8a450dda40c7	3c7ad9df-a442-47cb-8949-c61aaae09e02	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
aa98c5ed-a631-4d88-869d-48572e23b211	3c7ad9df-a442-47cb-8949-c61aaae09e02	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
d70f6a63-3224-417a-be25-34f7a76e7239	3c7ad9df-a442-47cb-8949-c61aaae09e02	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
a0718795-ff29-48f5-99cc-c9caa4279758	3c7ad9df-a442-47cb-8949-c61aaae09e02	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo-Yo Ma	1.0
edf8caa6-a594-4349-9b67-94637814ae3a	3c7ad9df-a442-47cb-8949-c61aaae09e02	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
3401080f-d8eb-4948-9886-1ebb75f626aa	3c7ad9df-a442-47cb-8949-c61aaae09e02	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
0ea89da0-881b-496d-947f-2cb3b58d59fa	3c7ad9df-a442-47cb-8949-c61aaae09e02	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
73a6f130-b911-4c25-9339-82db77374740	3c7ad9df-a442-47cb-8949-c61aaae09e02	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
f88d0aeb-4d8d-4c63-b8e9-be4c598c65d4	3c7ad9df-a442-47cb-8949-c61aaae09e02	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
c0d13247-0638-444e-93de-b2ab86712403	04477634-d57e-4983-8a74-43f48775f518	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
c1f507e9-558a-4cc0-8740-702668c28966	04477634-d57e-4983-8a74-43f48775f518	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
97e28e3e-434d-479b-b32e-35f94175be1e	04477634-d57e-4983-8a74-43f48775f518	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
df5b7354-3838-40ae-bb4f-48a50d53b994	04477634-d57e-4983-8a74-43f48775f518	cd885510-9d84-4643-b881-e4f52d624fa4	Abe Lincoln	1.0
852d0566-13e5-41ed-acd0-2f13bf3f2752	04477634-d57e-4983-8a74-43f48775f518	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
ff32701a-7017-4178-97bc-45d91b1af82a	04477634-d57e-4983-8a74-43f48775f518	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
1ab1420d-042a-4f15-a676-dae6c84779bf	04477634-d57e-4983-8a74-43f48775f518	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo-yo Ma	1.0
340a8993-7053-43e0-aaac-b66a58c31e3d	04477634-d57e-4983-8a74-43f48775f518	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
62fae925-06ba-4233-b1a6-01ae3eb33c87	04477634-d57e-4983-8a74-43f48775f518	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Rider	1.0
dd5f618a-9add-47fb-91d6-6b471ec87ad6	04477634-d57e-4983-8a74-43f48775f518	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
1d2e3a02-53a1-490d-90d6-f51dbdfcaabf	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Onassis	0.0
0856ca72-c54a-44c2-b397-46eed567dd30	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
2f2f0a1c-da87-403c-82e7-89416368362f	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Mohammad Ali	1.0
8734ba3b-37b5-4924-be09-ebeccd731026	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
b2d52049-9d33-4f4c-a8b2-10ad76809c63	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
09209ba4-99fe-47fe-bbf3-8deaae1eb47e	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
94f04225-d8be-41df-9bd8-a866990c8eae	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo Yo Ma	1.0
14beaf61-d48c-4514-9cd4-30311a7169d7	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
c19a2608-834d-4e26-9e27-7383fa8e29e6	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
7d20c8c3-389e-4844-9fe5-09ffe7a6d45c	9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
2152d4c3-1fea-4728-bed4-a75326943e7f	fcffac86-1285-460a-bc9a-0e1cf504a430	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
933e8168-ffe5-4173-8361-2f7f982b4d52	fcffac86-1285-460a-bc9a-0e1cf504a430	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
716151c2-e6cb-486d-8f50-6b446195ddae	fcffac86-1285-460a-bc9a-0e1cf504a430	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
74e34b2f-21e8-49f4-81a3-3516947be2fb	fcffac86-1285-460a-bc9a-0e1cf504a430	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
1ee58cd7-8815-4e70-9515-02f4a8c0811c	fcffac86-1285-460a-bc9a-0e1cf504a430	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
278caaa7-e20a-4816-b384-398fc824c8c0	fcffac86-1285-460a-bc9a-0e1cf504a430	ea095d63-fcaf-4bdf-80a7-34d160793c2a	YoYo Ma	1.0
e3dd5e07-9890-4979-99f6-4e257d24f8f6	fcffac86-1285-460a-bc9a-0e1cf504a430	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
1a98bce2-490e-45eb-b4f2-6f108941cb22	fcffac86-1285-460a-bc9a-0e1cf504a430	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
6a258ed1-beaf-47c2-bb47-839e8eeeff06	fcffac86-1285-460a-bc9a-0e1cf504a430	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
6e85cd72-afb7-42e5-a3ea-17bd484e0309	554f4b2f-78eb-485f-983d-25fbe8788151	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
fe82bca0-8ef9-41ce-9790-87afc503b483	554f4b2f-78eb-485f-983d-25fbe8788151	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
b8661cee-fe29-4206-81c2-258262b0b0a9	554f4b2f-78eb-485f-983d-25fbe8788151	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
66f4a0a5-a015-4cbe-830b-4ef281c7ba62	554f4b2f-78eb-485f-983d-25fbe8788151	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
cb6bf8d5-7204-4c49-89b9-0b76db41eee7	554f4b2f-78eb-485f-983d-25fbe8788151	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
9627b3f9-a423-4231-b162-56291f7bc131	554f4b2f-78eb-485f-983d-25fbe8788151	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
724b4301-5981-411b-a4bc-7227da76b09c	554f4b2f-78eb-485f-983d-25fbe8788151	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo Yo Ma	1.0
b4a63d79-d5c4-45e2-9482-ef3e02611520	554f4b2f-78eb-485f-983d-25fbe8788151	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
07d59f95-89a7-400e-9aec-298c68e5fc0e	554f4b2f-78eb-485f-983d-25fbe8788151	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
a9acc223-545a-41d4-a857-7208ba645239	554f4b2f-78eb-485f-983d-25fbe8788151	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
95b10beb-16df-4439-90b6-d7626c629b00	3a16123d-175c-4f4f-83e3-7e286c662fd4	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
2dcdbae0-e64a-4f62-b803-78900f566524	3a16123d-175c-4f4f-83e3-7e286c662fd4	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
d88076f3-b3a2-44ad-b4d0-aa5de0d37c2a	3a16123d-175c-4f4f-83e3-7e286c662fd4	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Mohammed Ali	1.0
54c527ca-04fd-4a9d-a23d-af0420ea4f91	3a16123d-175c-4f4f-83e3-7e286c662fd4	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
1146e8da-10ae-4dcb-831d-16bce9f3ef8a	3a16123d-175c-4f4f-83e3-7e286c662fd4	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
f72e85b9-cf0c-45db-b664-720b00cfac0d	3a16123d-175c-4f4f-83e3-7e286c662fd4	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
d7696096-4732-445f-806c-d0376f76990f	3a16123d-175c-4f4f-83e3-7e286c662fd4	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo Yo Ma	1.0
4a42f85c-f913-4457-b304-214d0f57933c	3a16123d-175c-4f4f-83e3-7e286c662fd4	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
c95dfcb5-c4c5-4c0c-a0f3-e0657f40c6f8	3a16123d-175c-4f4f-83e3-7e286c662fd4	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
cd48e0f0-72e5-4511-8e07-c4cf7fea4dcf	f0feddb4-ef0d-454e-8052-2b11b39d89d8	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
b6345d81-43aa-4411-8824-8c3f37177c7c	f0feddb4-ef0d-454e-8052-2b11b39d89d8	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
a2ad9e1c-0ef0-4b6a-881f-0c641780295a	3a16123d-175c-4f4f-83e3-7e286c662fd4	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
1c494420-a3b8-4bfc-aa53-90ea5ecc1f6e	ebbbd0be-2299-4eb1-96bc-8fc01914739d	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
8941312a-2d4a-449f-a31c-da11b2ec9efd	ebbbd0be-2299-4eb1-96bc-8fc01914739d	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
8e21dc00-88c3-435e-8e59-7f042d8e4db2	ebbbd0be-2299-4eb1-96bc-8fc01914739d	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Mohammad Ali	1.0
b6add628-cb76-479b-9a8f-fe18c8075013	ebbbd0be-2299-4eb1-96bc-8fc01914739d	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
10ef4ddf-4d59-421b-a2bd-10bf979cfb7c	ebbbd0be-2299-4eb1-96bc-8fc01914739d	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
f460981d-209f-484b-b547-3cdbe27e5474	ebbbd0be-2299-4eb1-96bc-8fc01914739d	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
ebcde35d-9857-4428-a02e-5a66de29716b	ebbbd0be-2299-4eb1-96bc-8fc01914739d	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
00f31975-db4d-4312-8fe2-a2b9fd4b2b31	ebbbd0be-2299-4eb1-96bc-8fc01914739d	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
370fa7a9-3c07-4edf-a91a-af7c014f85ea	ebbbd0be-2299-4eb1-96bc-8fc01914739d	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen 	1.0
c178e02c-38f8-4315-babe-bfa9a7829431	ebbbd0be-2299-4eb1-96bc-8fc01914739d	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
31c2e528-d892-461c-bac1-d23afe2bce9b	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
882e5cf4-fda6-4c4e-8bd5-7f4c4d7202c6	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
342a15a6-ab34-4507-83f1-0daa4536e0a2	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali	1.0
868c6c70-2d66-4a01-ae4c-8b44d2b1ad5d	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
a74d2725-2aeb-4a80-a710-883b47ff2c0b	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
bebfde48-98b0-4847-b2d5-a4c3fae821fc	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
9f526509-0dbf-4d25-a954-71d742d9afdf	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yo Yo Ma	1.0
0824b802-6cba-44fe-b77c-f8f71ebb8e1d	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
ec7c1c40-1bfd-4da5-be6c-f0b2b971cbc7	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
744fd90d-e071-4cb9-b7e2-faaeabf0a469	c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
bbaa1936-4d1d-415a-beb9-201cecf77f24	871d5fbf-7654-44ec-81b8-b880f2b720a0	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
403283ad-a4fe-4893-a246-7276f213f41e	871d5fbf-7654-44ec-81b8-b880f2b720a0	cd885510-9d84-4643-b881-e4f52d624fa4	Abrahim Lincoln	1.0
bc02c53e-500e-4ed0-a5a3-e7f5cc4d531d	871d5fbf-7654-44ec-81b8-b880f2b720a0	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
345eb9e7-39f2-45d2-9e5d-1cf4ccca9817	871d5fbf-7654-44ec-81b8-b880f2b720a0	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
060a7791-2916-4b48-a2d7-e5fdbca928f7	871d5fbf-7654-44ec-81b8-b880f2b720a0	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightening McQueen	1.0
50ba0b89-24f6-4bb9-8b1c-279cb82a8669	871d5fbf-7654-44ec-81b8-b880f2b720a0	ea095d63-fcaf-4bdf-80a7-34d160793c2a	NA	0.0
bafa401e-979a-43e0-9d48-26b3a9b17406	871d5fbf-7654-44ec-81b8-b880f2b720a0	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	NA	0.0
e91bda37-dcc5-4742-8d35-46ae92d4b73b	871d5fbf-7654-44ec-81b8-b880f2b720a0	f377b506-4977-4158-acdc-1f4c093ff55d	NA	0.0
bd3cbbaa-01db-4fae-b119-8341c9edd567	871d5fbf-7654-44ec-81b8-b880f2b720a0	f32f9276-e3af-449e-b855-cdc81e2ed660	NA	0.0
678d0f5b-2039-4f74-8f38-c1350cf946ff	871d5fbf-7654-44ec-81b8-b880f2b720a0	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
52fd3ee5-8b38-4bc8-9265-c17a58eb7060	49e23d01-cc36-44a6-b744-35e91fb4c3d2	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
8b76b31b-3168-471f-954f-48246d919966	49e23d01-cc36-44a6-b744-35e91fb4c3d2	f377b506-4977-4158-acdc-1f4c093ff55d	Franz Ferdinand	1.0
8e8c74ec-ed8f-4445-b9f5-87ad2ea589e4	49e23d01-cc36-44a6-b744-35e91fb4c3d2	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Mohammed Ali	1.0
29d18e52-3a55-4f88-b982-81c982c5223e	49e23d01-cc36-44a6-b744-35e91fb4c3d2	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
1740de33-511c-4590-9289-81a87c00557d	49e23d01-cc36-44a6-b744-35e91fb4c3d2	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
5be35daf-dd56-4cc1-a99d-481b47c84db4	49e23d01-cc36-44a6-b744-35e91fb4c3d2	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela	1.0
cd3f0c74-9b00-4b6d-b910-38b7863c063d	49e23d01-cc36-44a6-b744-35e91fb4c3d2	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma (Cousin <3)	1.0
6a866e40-6588-46e7-a94f-fe23e75397fe	49e23d01-cc36-44a6-b744-35e91fb4c3d2	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
a5b49083-03a0-4c7c-8b9c-801d4511ea1f	49e23d01-cc36-44a6-b744-35e91fb4c3d2	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Ride	1.0
433904bb-4262-45ea-94e7-6a9f275c56d2	49e23d01-cc36-44a6-b744-35e91fb4c3d2	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
8d9402ec-2dff-40bc-bf97-13eb5f502f04	f0feddb4-ef0d-454e-8052-2b11b39d89d8	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
c759b89c-1d52-496b-bcc4-eab2ca5d6e26	f0feddb4-ef0d-454e-8052-2b11b39d89d8	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
23f843f2-628d-4f82-995b-53ddce4d6b37	f0feddb4-ef0d-454e-8052-2b11b39d89d8	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
5c854910-7b06-4e0b-9742-b334a7be2b6a	f0feddb4-ef0d-454e-8052-2b11b39d89d8	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathon Taylor	1.0
70485552-f864-420d-bdb3-a01f6b7d1dc2	f0feddb4-ef0d-454e-8052-2b11b39d89d8	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
a6bab84a-a772-4ffd-a447-8771320b9172	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
a9072c44-eaa9-4449-a5f3-2aadbfd72aa7	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120 degrees	1.0
fea41543-63a6-4cb8-81ce-4466c510d978	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	eef09846-d717-48e6-838d-30af16c6dda2	12 angry men	1.0
7b8ec26a-c830-4815-9d9c-ae0f628a9e06	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
5289e907-f1c7-49fc-8fd5-c9ee7823cff9	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
0245dbf6-40b8-4f03-80f0-4066135f7867	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
05f6eeed-1b53-41dc-8728-9529f6e4ee12	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	3a08309f-da7d-4a81-b973-049736e0ef69	Unsure	0.0
d79d8c0b-de7e-467a-9d5e-19f4a7f77bd2	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Unsure	0.0
85bc16fd-42ba-421a-b7c2-08456764d35a	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
33ae1e0b-3440-4497-9b4f-a08b80414433	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
73692aa3-6f01-41ad-bf50-ff9cc6a7f8de	80665cd6-323d-4543-a58b-8328f4021250	58bf6902-dd91-4db2-9dd7-f5503dcce9c7	Sally Saddle	0.0
92de975a-78ad-44de-8156-c5afcf3e6f60	80665cd6-323d-4543-a58b-8328f4021250	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	-	0.0
75f02108-0b04-4278-a017-ecd172f990a1	9cd05538-1036-4823-a759-25a92e7329b1	80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	Lightning McQueen	1.0
29a75def-eeb2-40e5-9bf1-ba8f5fdc42f8	00a224b3-7b5a-4ef3-ad79-0d211d2477de	cd885510-9d84-4643-b881-e4f52d624fa4	Abraham Lincoln	1.0
b0a03c96-ee9a-4128-b5c9-27dfa5196b8c	3c7ad9df-a442-47cb-8949-c61aaae09e02	f32f9276-e3af-449e-b855-cdc81e2ed660	Jackie Kennedy	1.0
ca5dc018-de1a-48b9-bdd2-9a6d9f71a7bb	fcffac86-1285-460a-bc9a-0e1cf504a430	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
9a3fa231-8a2a-4b0a-b3ec-87b0d936cacb	80665cd6-323d-4543-a58b-8328f4021250	f32f9276-e3af-449e-b855-cdc81e2ed660	-	0.0
9d3fe541-f877-4ffe-930d-e7f4d15e631b	80665cd6-323d-4543-a58b-8328f4021250	f377b506-4977-4158-acdc-1f4c093ff55d	-	0.0
7a20d6b9-e11e-4340-bb8f-1576b02199fc	80665cd6-323d-4543-a58b-8328f4021250	e9e7ebae-d93f-48e3-b6fd-475a2b0af964	Muhammad Ali(baba) 	1.0
0e3934b8-c8a4-46ea-b8ac-9d6a8f4dcade	80665cd6-323d-4543-a58b-8328f4021250	cd885510-9d84-4643-b881-e4f52d624fa4	Abe Lincoln	1.0
cf91d972-5c79-440b-92ab-bfb57516672a	80665cd6-323d-4543-a58b-8328f4021250	7da1e06a-b83c-4816-b6e3-60eec7eab605	Benedict Cumberbatch	1.0
52cecabf-26a5-44c0-907e-3596fd61ed88	80665cd6-323d-4543-a58b-8328f4021250	722388ea-33de-42e0-a9b6-03608e8e461b	Nelson Mandela 	1.0
e916469e-9586-41c1-b4e6-34e6982a29d2	80665cd6-323d-4543-a58b-8328f4021250	ea095d63-fcaf-4bdf-80a7-34d160793c2a	Yoyo Ma	1.0
490851cf-53ed-4904-bfe5-9e7647f15280	80665cd6-323d-4543-a58b-8328f4021250	775bd148-0be2-4cd5-a67e-5f97f4a08509	Bruce Lee	1.0
0a764457-4391-4e9d-8bdf-8ef366def25c	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
db63c60c-4510-4d50-af6a-f274a9343824	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine of Aragon	1.0
28f37d2d-3f76-4404-a612-1491640774a8	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
f31022fa-9958-411a-afd9-2485a7a8a3bd	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
56bb9adb-b41f-4d2c-87a0-87937d3ce4b7	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
bbbf763e-38c6-4b9c-b9ea-ea23fda1e612	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Uzbekistan	0.0
29266126-5ef0-4fee-959e-6314035cb40c	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	0d21d6f7-63b1-4758-a746-fbaf6871747a	Cartilage	0.0
5303abc9-d337-4a0f-9e0a-ae92624c613c	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathon Taylor	1.0
3317cb3b-73c3-4914-a1e8-2519197376cd	af40f930-138a-4df4-a537-15bc309386a3	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
99d62e43-122e-47bc-8dc4-91c322865bf6	af40f930-138a-4df4-a537-15bc309386a3	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Chrichton	1.0
dc621efe-7927-4b7b-aff7-0adb05c3c970	af40f930-138a-4df4-a537-15bc309386a3	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russel	1.0
7bef70ae-cdaa-4e61-9218-b38f9236e58d	af40f930-138a-4df4-a537-15bc309386a3	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
49efcd03-fded-47e9-baf0-97758a620731	af40f930-138a-4df4-a537-15bc309386a3	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
83c94c0b-af05-4e64-aba3-cca5c71318c0	af40f930-138a-4df4-a537-15bc309386a3	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120 Degrees	1.0
a1e19638-1689-4187-85af-b845eea365d4	af40f930-138a-4df4-a537-15bc309386a3	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
c68e1b47-f6c8-4566-bbbd-ca83e118d48c	af40f930-138a-4df4-a537-15bc309386a3	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
9c560178-df7d-4e2e-96c5-f545d2cd4aa7	af40f930-138a-4df4-a537-15bc309386a3	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
995bd9cb-86d8-4da0-8d0b-96ed32860c65	af2179b0-d768-4c8f-9d26-abb437862899	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
f3640228-7da7-4c4b-93f4-92e2c8d799d1	af2179b0-d768-4c8f-9d26-abb437862899	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crighton	1.0
733a6f8c-4afd-406a-9d79-ee4f86e99be8	af2179b0-d768-4c8f-9d26-abb437862899	5182d01b-0798-48f5-9087-40969a5d641e	Coach Carter	0.0
96e6c290-b19d-4009-89c7-788e664d2018	af2179b0-d768-4c8f-9d26-abb437862899	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Jane Seymore	0.0
604ba6c9-c231-4f8d-8244-7559dd3b518e	af2179b0-d768-4c8f-9d26-abb437862899	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
c2c21e06-76fe-4d78-bbb5-bde33e5aea47	af2179b0-d768-4c8f-9d26-abb437862899	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
5231c903-f0e9-4991-a86a-183beaae78f8	af2179b0-d768-4c8f-9d26-abb437862899	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
fa0598c3-13f3-400a-9fb8-2b4cc492d047	9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	5182d01b-0798-48f5-9087-40969a5d641e	Dr. J	0.0
1eb8ce56-506b-4342-9708-7f005e5de993	3f3a4921-8639-4f9c-8358-e366c38b18e9	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
2b071ca8-7fa6-4673-91a0-be1ce59ea5a1	3f3a4921-8639-4f9c-8358-e366c38b18e9	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
e381db2b-8b59-44d4-b241-e2a4230cd361	fd339ac5-cfc9-45c6-888a-8028f34879ec	0d21d6f7-63b1-4758-a746-fbaf6871747a	Calcium Carbonate	0.0
fd6daa33-60ed-4609-811f-efb60b47ce22	fd339ac5-cfc9-45c6-888a-8028f34879ec	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
8e05d7df-640d-4f3f-a0c1-adcb6e571b81	fd339ac5-cfc9-45c6-888a-8028f34879ec	eef09846-d717-48e6-838d-30af16c6dda2	-	0.0
5fb132fd-0be7-4196-96cf-a332fa7373fc	af2179b0-d768-4c8f-9d26-abb437862899	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Norway	0.0
21ac07a9-be0d-4ac6-8372-b9cf020aac0a	af2179b0-d768-4c8f-9d26-abb437862899	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
3d0dda02-3828-4aa3-beef-40373fa32fd2	af2179b0-d768-4c8f-9d26-abb437862899	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Kenneth Walker	0.0
a057ca59-2ccf-4c77-8fe0-b5f6be0993fb	3f3a4921-8639-4f9c-8358-e366c38b18e9	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
63f28454-4d16-4a3e-8c42-a2c5472f57d0	3f3a4921-8639-4f9c-8358-e366c38b18e9	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
77f00329-6388-453f-b879-1ceb5d301502	3f3a4921-8639-4f9c-8358-e366c38b18e9	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
29b3172a-ec40-4e8a-8f8b-8630f8aee1b5	3f3a4921-8639-4f9c-8358-e366c38b18e9	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
241c1caf-3fec-41ee-b661-9cfd5ace9773	3f3a4921-8639-4f9c-8358-e366c38b18e9	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
36196973-c11f-43c9-af6d-0d55f4c576cd	3f3a4921-8639-4f9c-8358-e366c38b18e9	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120 degrees	1.0
447f7f31-0c1c-494a-82f1-96a8eb640456	3f3a4921-8639-4f9c-8358-e366c38b18e9	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
68566f1b-0194-49ff-8ff8-34b2a81dc225	3f3a4921-8639-4f9c-8358-e366c38b18e9	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
1bada6cb-c55f-4109-9233-a8f433296262	aee07542-11df-4bf4-a228-f7e11da5009f	1fbd051a-9a46-4743-8e32-f2b064edd9a6	Nero	1.0
b8983020-d7e6-4d5c-a651-9b58f83f834d	aee07542-11df-4bf4-a228-f7e11da5009f	3a08309f-da7d-4a81-b973-049736e0ef69	Michael Crichton	1.0
2485b219-af8d-46b7-be98-5701550aa8e5	aee07542-11df-4bf4-a228-f7e11da5009f	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell	1.0
2f07a1ab-2043-4313-b2df-119e5ff5ba42	aee07542-11df-4bf4-a228-f7e11da5009f	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Anne Boleyn	0.0
2d42a6de-d57d-4fc9-a056-b469ea863e60	aee07542-11df-4bf4-a228-f7e11da5009f	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
8888b52f-78fb-4761-abc9-9ecdc8d22ee6	aee07542-11df-4bf4-a228-f7e11da5009f	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120 degrees	1.0
3a86531c-a70c-4522-ac12-cd540fa6de52	aee07542-11df-4bf4-a228-f7e11da5009f	eef09846-d717-48e6-838d-30af16c6dda2	12 Angry Men	1.0
03d0df96-68a6-4c53-bc08-bd6263eae59f	aee07542-11df-4bf4-a228-f7e11da5009f	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Poland	1.0
29af26af-54ef-4c2f-8a28-6f10deaae09b	aee07542-11df-4bf4-a228-f7e11da5009f	0d21d6f7-63b1-4758-a746-fbaf6871747a	Chitin	1.0
d6d72c67-abce-492e-a984-9341d2bcdc25	aee07542-11df-4bf4-a228-f7e11da5009f	dbd581c6-c54f-4aa1-9189-0de6967efdaf	Jonathan Taylor	1.0
665e5bd3-a869-412c-99fb-5c5ab1d63e49	fd339ac5-cfc9-45c6-888a-8028f34879ec	5182d01b-0798-48f5-9087-40969a5d641e	Bill Russell\n	1.0
e51ad2b5-c0fa-40dd-8ffb-5b02581738e9	fd339ac5-cfc9-45c6-888a-8028f34879ec	a362d4d9-6e56-4e50-8dc0-45935ed91a11	Catherine Parr	1.0
217ec633-6b89-4293-92ca-31d2d66864ee	fd339ac5-cfc9-45c6-888a-8028f34879ec	265c8bcf-d174-40ce-a3ef-231fc92c61e7	Bruce Willis	1.0
34b29dda-6b21-4243-9a96-fdb87e5e9aef	fd339ac5-cfc9-45c6-888a-8028f34879ec	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	120	1.0
9b756821-f0c4-4497-86c9-02d04651e060	fd339ac5-cfc9-45c6-888a-8028f34879ec	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	Slovenia	0.0
5d7b4c43-3c2e-4ef1-a981-9a505eda318c	91cff167-69c2-436d-885d-9701027fd8e7	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
d136e625-f11d-4a43-949f-697077e597bc	91cff167-69c2-436d-885d-9701027fd8e7	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
c9152913-a11d-4f15-984e-37a740cea413	91cff167-69c2-436d-885d-9701027fd8e7	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expedition	1.0
d2516de9-ecae-4db4-8ce2-eaa9769dd315	91cff167-69c2-436d-885d-9701027fd8e7	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 4	1.0
16f9bdfd-3b7c-4ec0-92c9-2c8471332a4d	91cff167-69c2-436d-885d-9701027fd8e7	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Silver Flames	1.0
288797e7-8247-44f7-b9e5-570e03f004e4	91cff167-69c2-436d-885d-9701027fd8e7	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
a45f121d-84c8-471c-813f-084b7639780a	91cff167-69c2-436d-885d-9701027fd8e7	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Digeridoo	1.0
d7049f40-c992-4130-96b6-62c95b6bdf13	91cff167-69c2-436d-885d-9701027fd8e7	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
b99827e7-b2c7-43be-ac67-60fb676f633c	91cff167-69c2-436d-885d-9701027fd8e7	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
10534a12-a4de-49d8-ba4b-0c231f43983e	2f4fc88f-4371-4968-8598-164059301b73	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
dbaab061-58ec-40c3-940b-06e2ceec24f3	2f4fc88f-4371-4968-8598-164059301b73	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
80c02df4-e114-4aa9-afc0-178abd73f2d4	2f4fc88f-4371-4968-8598-164059301b73	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
92645b01-0d75-4915-b37b-9cca2f2bf3a3	2f4fc88f-4371-4968-8598-164059301b73	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Expedition	1.0
26631fcf-240f-4751-8be7-85cc67c0e8cd	2f4fc88f-4371-4968-8598-164059301b73	37c12c30-e218-4cd9-a9b0-0ca51b80d895	4	0.0
77307094-21aa-482e-8180-8ca2247d8448	2f4fc88f-4371-4968-8598-164059301b73	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Mist and Fury	0.0
ff636e33-8c9a-4a54-a3cd-ab6e7af32e6c	2f4fc88f-4371-4968-8598-164059301b73	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
966964f9-b185-4367-aaf9-9f0d49d8750e	2f4fc88f-4371-4968-8598-164059301b73	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
e600edbe-8605-4031-a6bc-6d89044b84d6	2f4fc88f-4371-4968-8598-164059301b73	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
45e892ee-95c0-499c-af95-997af237b729	d3cdc313-b316-4503-8689-e88cdbdb8999	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
eb98ddc1-12f4-4a00-95cb-be6fd69044cf	8fe2128e-3075-458f-8885-34f07759772c	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
7e567c5d-a531-4192-973e-5e2fa0d149d3	8fe2128e-3075-458f-8885-34f07759772c	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
5e28c677-052a-43a1-afb6-1d169f90a04d	8fe2128e-3075-458f-8885-34f07759772c	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
42bf8295-431a-4e81-8530-c744d24c52ed	8fe2128e-3075-458f-8885-34f07759772c	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Expedition	1.0
b5e55ef5-73b0-4832-8e1e-78b4daad4ebc	8fe2128e-3075-458f-8885-34f07759772c	37c12c30-e218-4cd9-a9b0-0ca51b80d895	4s	1.0
a3465232-5a2d-474f-bd7e-c0bb6f4d6b89	8fe2128e-3075-458f-8885-34f07759772c	0e6fce33-9670-41f7-a008-60873728ad08	A court of mist and fury	0.0
fadc7337-6213-4661-b872-926c8e20d3ed	8fe2128e-3075-458f-8885-34f07759772c	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
1ff1a0b6-2928-4ae8-9a93-6e8f58978de6	8fe2128e-3075-458f-8885-34f07759772c	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Diggeri doo	1.0
15a7c417-7779-4f62-8c30-4c0af0439215	8fe2128e-3075-458f-8885-34f07759772c	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
306b0224-a5a6-422f-b0ab-a69daf656c6a	d3cdc313-b316-4503-8689-e88cdbdb8999	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
9021bfb4-7ae6-4f7e-b3a9-996e5c580046	d3cdc313-b316-4503-8689-e88cdbdb8999	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
ff05864a-c159-486b-9745-d703b887cf6e	d3cdc313-b316-4503-8689-e88cdbdb8999	e59430e4-2538-4522-82ab-54a6fe259346	Artic Monkeys	1.0
61d54456-dd3d-45be-a859-cc71cb219a17	d3cdc313-b316-4503-8689-e88cdbdb8999	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expidition	1.0
93d8ec1c-e438-4c89-be28-c64d8f55076f	d3cdc313-b316-4503-8689-e88cdbdb8999	37c12c30-e218-4cd9-a9b0-0ca51b80d895	Iphone mini	1.0
9a3fafe3-5abb-48ea-b0a3-7a2a046a12b0	d3cdc313-b316-4503-8689-e88cdbdb8999	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Silver Flames	1.0
9c11ba52-d772-43e2-a9e8-1e7280c42789	d3cdc313-b316-4503-8689-e88cdbdb8999	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
fd669722-17cf-42bf-b459-8cacbafbf254	d3cdc313-b316-4503-8689-e88cdbdb8999	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
9a9c9365-562b-402e-919d-fa80a7587134	d3cdc313-b316-4503-8689-e88cdbdb8999	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
7264a5dd-e844-444d-82c0-29405a6c2b7d	91cff167-69c2-436d-885d-9701027fd8e7	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
a52ea7d7-45c0-4f29-aab8-c995d3e45e0d	1d132142-d768-45cc-a2de-5134d0fa1386	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
7092e1e6-7ccb-4d94-aa5e-7df3048284c2	1d132142-d768-45cc-a2de-5134d0fa1386	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
03248f43-c749-4d3e-b490-6e051a50b90f	1d132142-d768-45cc-a2de-5134d0fa1386	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Escape	0.0
be4538c6-b4e2-429e-842a-dd661d740d28	1d132142-d768-45cc-a2de-5134d0fa1386	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 4S	1.0
79408fc9-efe4-427e-a736-0f80043e7707	1d132142-d768-45cc-a2de-5134d0fa1386	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Silver Flames	1.0
25f353ed-968d-4064-972b-8b340776f267	2f4fc88f-4371-4968-8598-164059301b73	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	How to Train Your Dragon	0.0
c24aaf73-1d17-4057-9ad3-d12e23a7034d	1d132142-d768-45cc-a2de-5134d0fa1386	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
49b3d762-9ce5-4be1-9367-4e7a900dc56a	8fe2128e-3075-458f-8885-34f07759772c	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Robots	0.0
8ada6638-2777-45c9-83f0-9762542142d2	1d132142-d768-45cc-a2de-5134d0fa1386	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic crisp	1.0
b4ed7514-53d9-4373-ba01-b5ea9d4b7e4f	1d132142-d768-45cc-a2de-5134d0fa1386	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
7b3879ec-feec-4de0-a21d-84db5e91ff09	dc91f88c-a26e-4b94-b649-0255795b43d6	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
fb83a8fd-7ff8-48aa-a0f8-d3233866f2c9	6922c3b9-bf2f-46e8-a872-6e06e55082fa	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
994f707d-a391-492c-b6a2-3237aeda94eb	6922c3b9-bf2f-46e8-a872-6e06e55082fa	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
311a930f-b71f-410e-9801-ad55f075670b	6922c3b9-bf2f-46e8-a872-6e06e55082fa	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
a63fc7f0-a1d6-40c6-bf4a-b53eb69c9cee	6922c3b9-bf2f-46e8-a872-6e06e55082fa	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expedition	1.0
9638b7c1-493c-46c0-af97-3a8179375fd7	6922c3b9-bf2f-46e8-a872-6e06e55082fa	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 4	0.0
39eb8eaa-5dfb-49e4-8e26-943b1201410e	6922c3b9-bf2f-46e8-a872-6e06e55082fa	0e6fce33-9670-41f7-a008-60873728ad08	A [Something] of [Something] and [Something]	0.0
b57a8893-f7c4-4e3a-babb-52339871eb14	6922c3b9-bf2f-46e8-a872-6e06e55082fa	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
7820ad04-5dbb-441b-9f0a-79a35baed17e	6922c3b9-bf2f-46e8-a872-6e06e55082fa	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
80a4d323-55e1-4ec1-8a61-018b10671282	6922c3b9-bf2f-46e8-a872-6e06e55082fa	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
9bca84f3-25fc-4fce-b822-f06d97e0add7	fa9f16ef-ee61-4724-b74c-a1a59bbde834	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Finding Nemo	0.0
bffbe79f-733d-4044-a47f-cd19bbc31398	86d47cae-e1c1-41c1-8192-23cb607b0504	e59430e4-2538-4522-82ab-54a6fe259346	-	0.0
1cbdf505-8043-4fca-a55e-a1c8d9da63ea	86d47cae-e1c1-41c1-8192-23cb607b0504	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Explorer	1.0
250814d0-5ca9-4c38-bd19-2cbdc62caaf6	86d47cae-e1c1-41c1-8192-23cb607b0504	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 5	1.0
28b70700-1630-428c-9d22-b451b5512b27	86d47cae-e1c1-41c1-8192-23cb607b0504	0e6fce33-9670-41f7-a008-60873728ad08	-	0.0
47cb4dd6-9df9-4c82-a2f3-9c66bc2713b5	86d47cae-e1c1-41c1-8192-23cb607b0504	d78f114d-3171-472e-8647-b372b74d5a10	Fuji	1.0
0d1b2a8d-1aab-4c2f-9b87-5dbca21a161d	86d47cae-e1c1-41c1-8192-23cb607b0504	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	-	1.0
2b60fdbb-e504-4e34-837b-0110a798a88e	86d47cae-e1c1-41c1-8192-23cb607b0504	38b415db-a685-4ae3-a883-097b3d8be296	-	0.0
54091940-6aad-46b8-917f-1dcf7d9eabd4	86d47cae-e1c1-41c1-8192-23cb607b0504	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	-	1.0
1b6f7944-e27e-4398-8ba3-1de876a29a51	86d47cae-e1c1-41c1-8192-23cb607b0504	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
5fbafc8e-3ba2-4c68-a682-4222564af9ad	1d132142-d768-45cc-a2de-5134d0fa1386	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
07b0ae61-0c5a-46bc-9407-ae5a28aff61e	dc91f88c-a26e-4b94-b649-0255795b43d6	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
9d3d570a-9e9b-424b-ab86-238ac73f3b30	dc91f88c-a26e-4b94-b649-0255795b43d6	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
007dd6ed-59ef-466f-8ea1-e383e00d217a	dc91f88c-a26e-4b94-b649-0255795b43d6	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
1f2c9175-55cb-40e2-a931-ca9540b00d39	dc91f88c-a26e-4b94-b649-0255795b43d6	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Escapade	0.0
81ad877f-4bb9-4814-94b6-631be892f86b	dc91f88c-a26e-4b94-b649-0255795b43d6	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 4	0.0
80c546a1-28d3-42cc-be5c-0753886a7bde	dc91f88c-a26e-4b94-b649-0255795b43d6	0e6fce33-9670-41f7-a008-60873728ad08	The unmasked man	0.0
3fcc6fef-741a-419a-a2e8-e8e05539d8e4	dc91f88c-a26e-4b94-b649-0255795b43d6	d78f114d-3171-472e-8647-b372b74d5a10	Fuji	0.0
3db8b102-8fd7-4abd-a9ca-669f9b0f07ff	dc91f88c-a26e-4b94-b649-0255795b43d6	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Digeridoo	1.0
c2ff0a30-0063-4672-84b6-57034f722b47	dc91f88c-a26e-4b94-b649-0255795b43d6	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
8eaf0cf0-0bed-4638-83f4-a657f240cf95	6922c3b9-bf2f-46e8-a872-6e06e55082fa	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
8478c061-2b36-4a40-8df3-1a8ba1259877	1de93da7-5250-4050-9aa5-396db4430920	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
fc2e650b-fe42-47ac-87c5-4e66d72e034e	1de93da7-5250-4050-9aa5-396db4430920	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expedition	1.0
cfd6044c-4542-411c-a545-d7ae71b85725	1de93da7-5250-4050-9aa5-396db4430920	37c12c30-e218-4cd9-a9b0-0ca51b80d895	Iphone 4	0.0
f18e9a2d-c032-4d08-8348-bbdbd819ca07	1de93da7-5250-4050-9aa5-396db4430920	0e6fce33-9670-41f7-a008-60873728ad08	Court of Silver Flames	1.0
89dbbd0b-18d3-4095-bd60-452f627cb20a	1de93da7-5250-4050-9aa5-396db4430920	d78f114d-3171-472e-8647-b372b74d5a10	Fuji Apple	0.0
47d107a9-783c-4a7f-98e6-4df0fdfeae2e	1de93da7-5250-4050-9aa5-396db4430920	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Dijeridoo	1.0
45216594-261a-4c40-ab8c-f84eb50802fc	1de93da7-5250-4050-9aa5-396db4430920	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	NA	0.0
fe7dec35-7770-41b7-8c25-35bb0262f0bc	1de93da7-5250-4050-9aa5-396db4430920	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron.....	1.0
1a5e2905-1d59-43ca-9cfa-e54e3ef71bbb	fa9f16ef-ee61-4724-b74c-a1a59bbde834	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
eab1416d-e8a7-41c4-a84a-2f03f05bff64	fa9f16ef-ee61-4724-b74c-a1a59bbde834	b9a81840-19d2-4ca9-90eb-97d14391050c	Katniss	0.0
b0c3cd97-e57b-4ad2-b0a4-e247659ff4cd	fa9f16ef-ee61-4724-b74c-a1a59bbde834	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
4d517745-2609-4e26-af85-f28a53467354	fa9f16ef-ee61-4724-b74c-a1a59bbde834	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Explorer	0.0
e4405239-9966-4dbb-9d5f-5786633fb9e6	fa9f16ef-ee61-4724-b74c-a1a59bbde834	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 4	0.0
49d4dc44-9360-490c-8f39-a81bd7331738	fa9f16ef-ee61-4724-b74c-a1a59bbde834	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Silver Flames	1.0
3c43c482-411f-420d-a21b-b2d4b23e39b2	1de93da7-5250-4050-9aa5-396db4430920	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
2593713e-0830-450b-9c25-7903a3ae50c1	86d47cae-e1c1-41c1-8192-23cb607b0504	b9a81840-19d2-4ca9-90eb-97d14391050c	-	1.0
d2866e56-ebbb-47af-8ab5-7414cfd9c80f	9efe45f9-c782-40ea-b789-681ed7c82095	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
112a7c15-9b1b-4f4d-a89f-fcb2d431181f	9efe45f9-c782-40ea-b789-681ed7c82095	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
7353ff77-1a07-479e-9b0e-df561a09da9e	9efe45f9-c782-40ea-b789-681ed7c82095	e59430e4-2538-4522-82ab-54a6fe259346	arctic monkeys	1.0
03bc8bbb-f9b6-4ac7-9b59-a9179d4969eb	9efe45f9-c782-40ea-b789-681ed7c82095	37c12c30-e218-4cd9-a9b0-0ca51b80d895	Iphone SE	0.0
9888832e-1864-4911-a922-e95b21a0faf5	9efe45f9-c782-40ea-b789-681ed7c82095	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Digiridoo	1.0
c6da0dff-271b-4673-b8d5-ba85aa90dcb5	9efe45f9-c782-40ea-b789-681ed7c82095	38b415db-a685-4ae3-a883-097b3d8be296	dodecahedron	1.0
1281aa5b-e30f-4383-a18b-c6cf30724939	9efe45f9-c782-40ea-b789-681ed7c82095	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	N/a	0.0
c5c5421e-436b-435d-93cb-c78aa05b35ed	9efe45f9-c782-40ea-b789-681ed7c82095	0e6fce33-9670-41f7-a008-60873728ad08	dunno	0.0
2c524ce4-e82b-4c5b-a913-9d9c56410b1c	9efe45f9-c782-40ea-b789-681ed7c82095	d78f114d-3171-472e-8647-b372b74d5a10	dunno	0.0
4e3090d3-eed8-4374-9535-e0c03d2fdd94	2852dcf2-331b-4d54-9bbc-1a734535da1c	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
1530524e-bf0a-41a0-a8da-9386451ebe8b	2852dcf2-331b-4d54-9bbc-1a734535da1c	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
ea3c2e45-8ad7-4214-8d27-b0566382981c	2852dcf2-331b-4d54-9bbc-1a734535da1c	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
ea8ab8e1-596d-48e3-ac0c-80471771afc0	2852dcf2-331b-4d54-9bbc-1a734535da1c	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
e368b3cd-4a2a-4b7d-a4b2-0150ab187246	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
1de3d688-b304-4894-887f-0c62b7800143	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Interceptor	0.0
f4e0528e-3659-483d-8df1-cb9ec742ac2b	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	37c12c30-e218-4cd9-a9b0-0ca51b80d895	5S	0.0
b06448d5-ac88-4aa3-99fe-ff71d12afdcb	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
2d33ed01-960d-4dae-90f5-a033711bea71	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
4e4c11b3-e93d-4156-a517-c345a249eb0b	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
04d902d0-bda1-47ab-a211-3e5dae92fa85	bbeeb813-d9dc-4da7-b86a-a08b81089a20	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	MegaMind	1.0
eb386d14-c9db-4752-9ab1-912b1ae41b33	bbeeb813-d9dc-4da7-b86a-a08b81089a20	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
6a1d08d2-1f0a-40dc-8f02-141149d813e6	bbeeb813-d9dc-4da7-b86a-a08b81089a20	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
bdbd9eb6-2926-4dd3-9289-bc57b2964229	bbeeb813-d9dc-4da7-b86a-a08b81089a20	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
0b7d0225-7419-42db-b5eb-c01c03a5a2c3	bbeeb813-d9dc-4da7-b86a-a08b81089a20	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expedition	1.0
cabba385-1cbf-491f-946c-9b90987747d1	bbeeb813-d9dc-4da7-b86a-a08b81089a20	37c12c30-e218-4cd9-a9b0-0ca51b80d895	Iphone 5s	0.0
dcc22acc-f9cf-4db0-ae6c-af675278630e	bbeeb813-d9dc-4da7-b86a-a08b81089a20	0e6fce33-9670-41f7-a008-60873728ad08	Court of Silver Flames	1.0
9067cd59-8e0f-4243-999c-af9e653f8af7	bbeeb813-d9dc-4da7-b86a-a08b81089a20	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
57ea776b-47cb-4188-822a-6ec2a09a9f6f	bbeeb813-d9dc-4da7-b86a-a08b81089a20	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Digeradoo	1.0
3ffae2d6-c539-4cfd-a19b-a55f1d58f37a	bbeeb813-d9dc-4da7-b86a-a08b81089a20	38b415db-a685-4ae3-a883-097b3d8be296	Pentacube	0.0
6873427c-c3f5-4ddc-a57d-de9a060fb0d1	fa9f16ef-ee61-4724-b74c-a1a59bbde834	d78f114d-3171-472e-8647-b372b74d5a10	Red Delicious	0.0
b443105d-dc38-41da-b2f1-aefacdc4f05a	fa9f16ef-ee61-4724-b74c-a1a59bbde834	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
18f8d21d-84e0-4ab4-9885-823f098d1d9d	fa9f16ef-ee61-4724-b74c-a1a59bbde834	38b415db-a685-4ae3-a883-097b3d8be296	Pentahedron	0.0
7e2d5c38-861d-45e0-bbcf-ae1538f31fe9	9efe45f9-c782-40ea-b789-681ed7c82095	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Endeavor	0.0
89fde185-8b9f-4c22-a933-461a111977fa	2852dcf2-331b-4d54-9bbc-1a734535da1c	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Expedition	1.0
5f75526e-2124-4406-8298-7a46342b4322	2852dcf2-331b-4d54-9bbc-1a734535da1c	37c12c30-e218-4cd9-a9b0-0ca51b80d895	iPhone 5	0.0
f8de0dd0-dd8a-4f9b-a140-89d14f24e14e	2852dcf2-331b-4d54-9bbc-1a734535da1c	0e6fce33-9670-41f7-a008-60873728ad08	A Court of Silver Flames	1.0
be113b1b-4dbd-4fe9-9895-8dc127e21717	2852dcf2-331b-4d54-9bbc-1a734535da1c	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
03299b7c-3960-4ec7-bb64-d6f25f1cdfad	2852dcf2-331b-4d54-9bbc-1a734535da1c	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
56967288-09d8-41d9-a1a3-45174ce3b5e5	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Finding Nemo	0.0
353d83c9-c730-4627-8b32-2129061127f4	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
44298e58-fd2f-41c7-bf72-e607251c2786	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	b9a81840-19d2-4ca9-90eb-97d14391050c	Primrose	1.0
986be9b9-9230-4a39-9b3d-577b84f6292b	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	0e6fce33-9670-41f7-a008-60873728ad08	?	0.0
3c23a7e7-9f1a-41af-be4a-a68e095f88a6	1d132142-d768-45cc-a2de-5134d0fa1386	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Didgeridoo	1.0
45b89393-3007-47b9-bf65-cfaf3c44374f	20f38dcb-9515-4149-a3c5-df9db702352f	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	Megamind	1.0
8295b3a2-16c0-442a-beb6-ddd1e4f71328	20f38dcb-9515-4149-a3c5-df9db702352f	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
5589241b-c3aa-4fdb-9fdc-5a92a0eae972	20f38dcb-9515-4149-a3c5-df9db702352f	b9a81840-19d2-4ca9-90eb-97d14391050c	Katniss	0.0
916c70ed-087d-4b14-ab44-5b9e103cd2a7	20f38dcb-9515-4149-a3c5-df9db702352f	e59430e4-2538-4522-82ab-54a6fe259346	Arctic Monkeys	1.0
d0aa956c-032d-4d35-a236-126695923a53	20f38dcb-9515-4149-a3c5-df9db702352f	d3f4136e-d770-4dae-8ff2-51c3091f4d12	Ford Expedition	1.0
fcf2e79f-e6e8-407b-b947-944c688a99a2	20f38dcb-9515-4149-a3c5-df9db702352f	37c12c30-e218-4cd9-a9b0-0ca51b80d895	SE	0.0
19979f3d-5851-47c8-a9c5-63f4857dfce9	20f38dcb-9515-4149-a3c5-df9db702352f	0e6fce33-9670-41f7-a008-60873728ad08	Veil of Leaves	0.0
09a0b005-7983-4783-84d7-43ae668f2e1e	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
49a8c030-8deb-443b-814a-78b27307e1e4	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
e8ff21fc-036f-4ca6-a2b0-5a6de5794167	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
991008c7-9f63-49c9-9a01-082607f27f4c	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
2435b605-9e4f-4ea1-a012-00e3df740ebf	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
8974f8d6-f930-4f4c-b85d-02396d266262	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Barbara Cartland	1.0
f3e21ada-37ea-4437-8a0e-52ccdb096001	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
6ccba9be-368e-4dab-87c9-85ae98bfe380	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
d501de9e-28f6-45b9-b287-49794429bdb9	20f38dcb-9515-4149-a3c5-df9db702352f	d78f114d-3171-472e-8647-b372b74d5a10	Cosmic Crisp	1.0
0b4da9ea-e315-4161-be9e-e715fb6d9424	20f38dcb-9515-4149-a3c5-df9db702352f	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	Digeridoo	1.0
b8bbbf90-2a03-40a8-ab8d-cbc904d3107a	20f38dcb-9515-4149-a3c5-df9db702352f	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
f505c5fc-d3cf-4b0c-bd94-dc842a4143eb	1de93da7-5250-4050-9aa5-396db4430920	93dd081e-ae9d-4230-afa5-50afc3ecd99e	Dubai	1.0
639c3feb-4a9c-4453-8476-6e208a1d22bb	2852dcf2-331b-4d54-9bbc-1a734535da1c	38b415db-a685-4ae3-a883-097b3d8be296	Dodecahedron	1.0
f0741a06-cc25-4595-bb6c-69f7b7c88f15	8ebcbd57-0684-4908-85e9-c3088cc83832	eec9096b-2e69-40b5-a334-8169c5c885d5	No submission	1.0
d8333e3d-4738-418d-b0f7-806ade8ebe6a	8ebcbd57-0684-4908-85e9-c3088cc83832	e8528d5a-bf83-4c9b-ba96-92e39f204b75	No submission	1.0
5d6f54b9-a6ad-49d8-b518-f3fc35cea6c2	8ebcbd57-0684-4908-85e9-c3088cc83832	31e8e209-48ff-49eb-8891-50445e1b0456	No submission	1.0
280fb9ef-24da-4897-a1b0-90723d811271	8ebcbd57-0684-4908-85e9-c3088cc83832	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	No submission	1.0
7c7110ac-87ad-475c-b740-d94aba30eaec	8ebcbd57-0684-4908-85e9-c3088cc83832	6541051c-0452-492d-b054-9a1040393283	No submission	1.0
70eaa9cc-5910-4cca-b842-be92b2b261b6	8ebcbd57-0684-4908-85e9-c3088cc83832	2ca22c03-8408-4751-845a-288a00d80b12	No submission	0.0
8d3c33db-542f-4174-88c4-5d8270363a25	8ebcbd57-0684-4908-85e9-c3088cc83832	11c321e5-1143-4634-aa20-27a025c3e47e	No submission	1.0
e052c9af-fd4c-41d9-ae35-0d3f0978079f	8ebcbd57-0684-4908-85e9-c3088cc83832	4f907b77-fa2a-43c9-a20b-cf25754566fc	No submission	1.0
d3677c84-7ded-403d-803f-847a4e5179d8	8ebcbd57-0684-4908-85e9-c3088cc83832	b99de020-d815-4cdc-b389-e73aa2b34250	No submission	1.0
74fc5a93-926d-427c-abf2-999f5b7e2b19	8ebcbd57-0684-4908-85e9-c3088cc83832	12914612-937e-425f-bfd2-bb3886c6f5ad	No submission	1.0
4276e12a-9138-4b60-8f05-333a1e82f317	0ccd314e-3963-46bc-bf87-41f51aa191d5	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
7f15c48d-a5dd-42bb-90ed-68134c90ef6f	0ccd314e-3963-46bc-bf87-41f51aa191d5	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes Mountains	1.0
7d08617b-1107-4da5-9fd6-67fe3fad00e7	0ccd314e-3963-46bc-bf87-41f51aa191d5	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
fc2023d4-28ce-46a8-a029-074fab767d10	0ccd314e-3963-46bc-bf87-41f51aa191d5	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
c64d93c2-7dda-4b2d-a3e0-da71bfa6a65c	0ccd314e-3963-46bc-bf87-41f51aa191d5	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
ee8652f0-0e84-4ef4-9bfb-3e8ddff4270d	0ccd314e-3963-46bc-bf87-41f51aa191d5	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
2e704f92-32f0-4181-9852-4a886fc79474	0ccd314e-3963-46bc-bf87-41f51aa191d5	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
92e270aa-3943-4be7-848c-c59799282f2b	829831a8-3bdf-42b3-86aa-4a13a0938ab5	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
26207f38-d34d-4e51-a292-a7c2ce9fa212	0d74d13d-3cfb-4569-b71c-d831b5d119ce	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
b214fa5f-09b2-4fc3-8a72-6c959d1938cd	0d74d13d-3cfb-4569-b71c-d831b5d119ce	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
d76bc4af-48d3-4641-910d-9d83715b6491	0d74d13d-3cfb-4569-b71c-d831b5d119ce	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Danielle Steele	0.0
9ee2878c-f670-4b5e-b87e-db21a58c4fea	0d74d13d-3cfb-4569-b71c-d831b5d119ce	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
d6683199-77c2-452b-96d7-2d057a9a49a4	0d74d13d-3cfb-4569-b71c-d831b5d119ce	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
21ba8c7c-7a22-4fe5-9771-75e22d293b91	0d74d13d-3cfb-4569-b71c-d831b5d119ce	5a67bdb8-0b53-4496-a673-dc84506fe252	idk	0.0
21a6a0ba-24bf-473d-b543-77857c03a043	0d74d13d-3cfb-4569-b71c-d831b5d119ce	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Massachusetts	0.0
49b7259f-16e5-4192-8b9e-deb5c81c53bd	0d74d13d-3cfb-4569-b71c-d831b5d119ce	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
a731ea3f-4933-47c8-8967-9a1a75cda7b2	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut 	1.0
8d40c73a-0091-4caa-bdc7-8f646e0f21d0	0ccd314e-3963-46bc-bf87-41f51aa191d5	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
f9942050-4cb9-4f4a-84ef-8071f58af579	008b097f-27aa-4057-9163-ed8caa0e321d	e6e5c928-b872-4f49-98d2-674242dad63a	Blueberry Lane	1.0
ff8dbcc5-ccaa-4a2c-9930-2c98b43478a2	008b097f-27aa-4057-9163-ed8caa0e321d	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Drury Lane	0.0
665adf67-79a5-441f-8267-662aa7f5110d	008b097f-27aa-4057-9163-ed8caa0e321d	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
7f2501ec-800b-4abc-90a6-2a655c9679f2	008b097f-27aa-4057-9163-ed8caa0e321d	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
6f2e8cf2-a0d4-45fd-9e46-a7ef51d6f59a	008b097f-27aa-4057-9163-ed8caa0e321d	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Jane Austen	0.0
78b51b42-d751-4fa8-b0ad-ab195aa5d137	008b097f-27aa-4057-9163-ed8caa0e321d	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
6bcf95bd-93d9-431d-9e47-83ef35552035	008b097f-27aa-4057-9163-ed8caa0e321d	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom	1.0
5fdbb665-cdfa-43d0-8716-d9a85783b15a	008b097f-27aa-4057-9163-ed8caa0e321d	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
5d67d633-b08d-4b34-915f-dcbb345c53e1	008b097f-27aa-4057-9163-ed8caa0e321d	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
e42c8e47-d0b1-4cdf-9063-4c3819b5a207	0d74d13d-3cfb-4569-b71c-d831b5d119ce	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
d944e1af-1082-4cb8-8515-9856f719257b	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan 	1.0
a3c8d9ba-66cb-4382-aa03-19d453cdc1c0	829831a8-3bdf-42b3-86aa-4a13a0938ab5	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
a308a311-ea1e-4747-9aa6-d51c005fcbe8	829831a8-3bdf-42b3-86aa-4a13a0938ab5	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Johnny	0.0
932d884c-51bf-4e53-b8ca-3bd6861bc5a1	829831a8-3bdf-42b3-86aa-4a13a0938ab5	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
56c4e4a4-27dc-4715-8fe1-7a787f2ff4f9	829831a8-3bdf-42b3-86aa-4a13a0938ab5	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
d808cf44-255b-4618-bf74-b439bee9aa59	829831a8-3bdf-42b3-86aa-4a13a0938ab5	8a65e25c-ecb4-4775-9b88-7fd8c47df896	NA	0.0
7ec4f12f-ab14-4819-81ad-901d8aed5a43	829831a8-3bdf-42b3-86aa-4a13a0938ab5	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
28148b45-3cb1-4b20-85e2-92eecec24b92	829831a8-3bdf-42b3-86aa-4a13a0938ab5	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
a40ae89a-abe0-4a39-aeb5-0f4c1d2ea474	829831a8-3bdf-42b3-86aa-4a13a0938ab5	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
0c706e3e-0105-46a9-acdb-26a96b45facf	829831a8-3bdf-42b3-86aa-4a13a0938ab5	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
052c9adb-ad96-4643-997a-2c2a25705f5f	008b097f-27aa-4057-9163-ed8caa0e321d	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
77f5c5ea-a115-4ffc-91ee-66fb361681b5	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
97749e19-2e50-42e7-8180-ccd70a299b80	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
f93e35e1-31e5-4b2b-9cb3-9209efa384bd	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Mary Clarke	0.0
b6cf68d4-c5ec-435d-ba17-6064bfdd49fa	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	30294dd1-3e35-40ff-91b6-24c7401e62de	Australia	0.0
10c10ac5-fa23-4602-b80e-130be7f903e1	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
3680fadd-1b6a-4b19-a4f9-5a6fc2c7e2d4	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
857fd03d-7075-49ee-a19b-67ee9ef08ddc	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
c5d99f5c-ef5a-4910-b173-480b9126e8fd	04eab4e7-b484-4791-abb5-94163a43b2c0	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
49e2895d-356e-451f-923a-1e87a222cc19	04eab4e7-b484-4791-abb5-94163a43b2c0	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
ac5f5f7d-3546-4e31-a9f7-3b98158959c5	04eab4e7-b484-4791-abb5-94163a43b2c0	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Jo Armstrong	1.0
27481d94-c795-47a8-b6d8-bde6f0f37718	04eab4e7-b484-4791-abb5-94163a43b2c0	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
a8f22f8c-4d16-4b39-9a65-c79710027df6	04eab4e7-b484-4791-abb5-94163a43b2c0	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
7871b8b3-3951-4268-9609-7585cba58e83	04eab4e7-b484-4791-abb5-94163a43b2c0	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Barbara Cartland	1.0
b228bc0b-bcde-4cf7-801f-4e43dc45ca3a	04eab4e7-b484-4791-abb5-94163a43b2c0	30294dd1-3e35-40ff-91b6-24c7401e62de	China\n	1.0
d156869a-51b0-46f3-9043-573e0644cdc3	04eab4e7-b484-4791-abb5-94163a43b2c0	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
18706151-7222-4ad9-9603-a1d5c3325d44	04eab4e7-b484-4791-abb5-94163a43b2c0	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
a7dd7292-c466-4e97-82a0-75ac94d2cf0a	04eab4e7-b484-4791-abb5-94163a43b2c0	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
1d3cf9f4-74aa-44bb-90b0-3ff2b14fe60c	5cfa84fb-4faf-4df1-9eac-f68c23e37588	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
fd39d855-41c9-4bf9-bc74-de41c30d4164	5cfa84fb-4faf-4df1-9eac-f68c23e37588	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
7f9e36d7-4ec0-46cd-a923-7d873ee2b338	5cfa84fb-4faf-4df1-9eac-f68c23e37588	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billy Joe Armstrong	1.0
d20ad0f9-fc12-479c-b482-c4ab463abd75	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
d0f5f565-9495-4251-b691-a05c86847ba4	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
e500da4f-24b1-424d-83bb-812ba4fb09a1	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Steve	0.0
797da551-0aa1-432d-a227-a20fa5789717	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
5e62c72f-e26f-4712-ab0d-097160f31e0a	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
102e2b89-5213-4c78-880a-fdad0208d459	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Jane Austen	0.0
b9a7a17f-40ca-4bd6-b030-7f57e4e88a72	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
49fc23b3-48e1-44e0-9e83-1f28cff87d66	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	078e3c1f-6483-4869-a131-39c12603610e	Trash Can	1.0
7504e1f8-3cb5-4ab9-91e8-ea783e83c322	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	5a67bdb8-0b53-4496-a673-dc84506fe252	Ted	0.0
e45b48d5-7172-4f33-85d7-e925e99cca3d	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
a54af538-5b47-4ead-8f78-46458da7876a	50698525-1b92-4f5a-a411-9c3f7ac6977b	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
92070bd3-33e9-4a8e-b0de-c348169a091b	50698525-1b92-4f5a-a411-9c3f7ac6977b	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
df69b0a4-cad6-4d90-adda-7dae5067f905	50698525-1b92-4f5a-a411-9c3f7ac6977b	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
0b08b8df-0e95-414e-af99-ed404d673936	50698525-1b92-4f5a-a411-9c3f7ac6977b	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes Mountains	1.0
034e8455-2afd-4bc3-bd42-05e5d648f072	50698525-1b92-4f5a-a411-9c3f7ac6977b	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
95bb4d65-dc6c-4287-9899-a675ea4df525	50698525-1b92-4f5a-a411-9c3f7ac6977b	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
a833f02e-4336-4dca-813f-ae4a088dc437	50698525-1b92-4f5a-a411-9c3f7ac6977b	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
e0426b6f-0cd4-409a-a7d8-a6f37f100b8d	50698525-1b92-4f5a-a411-9c3f7ac6977b	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
a02aff0b-2613-4516-b5b2-d1340cc206f7	50698525-1b92-4f5a-a411-9c3f7ac6977b	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
96d72e3b-08d5-4b60-95ab-99e954f1d2ca	50698525-1b92-4f5a-a411-9c3f7ac6977b	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Jane Austen	0.0
3e74a165-50b0-4fa0-b8fe-5ddd004fe41a	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Grass	0.0
aebbb6db-8895-4974-b761-72f6844b5758	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
0ee018b9-355c-440b-a12d-86ba316ce281	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
2473978a-e81a-4e19-ae39-ef87323a93c5	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	e6e5c928-b872-4f49-98d2-674242dad63a	\nDrury Lane	1.0
2328e5d6-5c26-40c9-980c-43c7016058c9	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
8dc29362-f599-45b8-85a4-fbc91b8d0f8a	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	30294dd1-3e35-40ff-91b6-24c7401e62de	Australia	0.0
e8194219-75ad-4f39-8711-7dedad0fd7b2	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
bf062e27-c8cf-4a5a-ba35-ea1579726c49	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom	1.0
539e21c2-8cfc-4ace-bc22-14ef5ad28887	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	1dbd5c29-52c7-449b-865d-ab3a72d6d527	NA	0.0
3794bda8-03b1-48cb-b493-3dd264bc8ded	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	7052e44a-7137-4e7e-8827-358e304e7979	NA	0.0
4c1fffd9-af4c-45ad-a17b-92e94d292c1f	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	8a65e25c-ecb4-4775-9b88-7fd8c47df896	NA	0.0
6bb23ecc-b4cf-4c8a-b85c-7a432aefa7a6	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Vermont	0.0
d5928562-1da8-4190-b994-2a263ee03540	7896aa8b-721a-44b2-b111-f4be86ec089a	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
5e24a5af-f2ed-4993-86ee-f5425e04fcd8	7896aa8b-721a-44b2-b111-f4be86ec089a	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billy Joe Armstrong	1.0
e7d619d9-67ef-4c6a-907f-cc2e3e5683d7	7896aa8b-721a-44b2-b111-f4be86ec089a	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
9cafdc31-3581-4c7e-b52d-4411746c0e94	7896aa8b-721a-44b2-b111-f4be86ec089a	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
aa40a567-03f9-44cd-a78f-1cf097f9e4ac	7896aa8b-721a-44b2-b111-f4be86ec089a	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Beyonce	0.0
5a14ac5a-11e6-407b-bc22-58c132666795	7896aa8b-721a-44b2-b111-f4be86ec089a	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
98448b7a-d26b-4a00-a91a-9cf8ae168ef3	7896aa8b-721a-44b2-b111-f4be86ec089a	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
0bb1c2be-56a7-4d01-af83-4afbc768841f	7896aa8b-721a-44b2-b111-f4be86ec089a	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
b93b3dea-0c08-4cf8-8d39-1e9463018690	7896aa8b-721a-44b2-b111-f4be86ec089a	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
cac0d6fc-0120-401e-bab4-d3228fee6ad1	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
0fb0cbfc-eddd-49d1-be75-fe8158085ad9	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billy Joe Armstrong	1.0
04678ec6-ecd3-4dd2-acf2-bd429d14562d	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
c92f9dee-8690-4d64-bd2a-a7da42e1a72a	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
28195186-c010-4acd-8b62-becfefbd4285	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	30294dd1-3e35-40ff-91b6-24c7401e62de	Australia 	0.0
e0c0f2af-1822-4167-955f-8b147d87ee34	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	078e3c1f-6483-4869-a131-39c12603610e	Garbage Can	1.0
f596e083-77bc-4f27-bc38-5886a23b0d3f	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom	1.0
4ac7d4ae-bf4b-486e-bfa4-958345176c11	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
02d41a8c-6176-407d-9878-ad586a4c33c2	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Papa	0.0
24b85ff9-f8dd-494c-af1e-de58dc2189b6	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	8a65e25c-ecb4-4775-9b88-7fd8c47df896	<3 u, ethan	1.0
25ddbb1b-f0fe-4a58-a5f5-e07ecfc2221d	35085610-68af-4ce0-83b8-61f5fe0e872e	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	dipsy	1.0
54d396ce-f5c3-42ae-a17f-1e96d7ad96ef	35085610-68af-4ce0-83b8-61f5fe0e872e	e6e5c928-b872-4f49-98d2-674242dad63a	drury lane	1.0
e567cd12-ce77-4916-a9be-7ee0d3327554	35085610-68af-4ce0-83b8-61f5fe0e872e	1dbd5c29-52c7-449b-865d-ab3a72d6d527	billie joe armstrong	1.0
d60aa0bb-df7e-45ac-a48b-ef20d6da3728	35085610-68af-4ce0-83b8-61f5fe0e872e	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	andes	1.0
76ebe1b0-64f4-4ab1-aae3-94fd11c9769e	35085610-68af-4ce0-83b8-61f5fe0e872e	30294dd1-3e35-40ff-91b6-24c7401e62de	china	1.0
83a643ed-476a-4aec-aed7-2d26e7343c80	35085610-68af-4ce0-83b8-61f5fe0e872e	078e3c1f-6483-4869-a131-39c12603610e	trash can	1.0
a8939f49-8aa1-40ac-9f93-4557f364792d	35085610-68af-4ce0-83b8-61f5fe0e872e	5a67bdb8-0b53-4496-a673-dc84506fe252	tom	1.0
b66fed45-1b33-4a95-8804-064f87213842	35085610-68af-4ce0-83b8-61f5fe0e872e	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	connecticut 	1.0
72ae0509-e026-45df-9289-1c7b6a371736	35085610-68af-4ce0-83b8-61f5fe0e872e	7052e44a-7137-4e7e-8827-358e304e7979	greenland	0.0
6eedc001-6d83-4d4c-8e06-0bb277ff36ca	35085610-68af-4ce0-83b8-61f5fe0e872e	8a65e25c-ecb4-4775-9b88-7fd8c47df896	a bad guess	0.0
336bfd58-cb05-45a2-80b3-f3ae572245fd	5cfa84fb-4faf-4df1-9eac-f68c23e37588	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
bdd84977-fac7-44eb-8755-da077bb53dde	5cfa84fb-4faf-4df1-9eac-f68c23e37588	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
2d465f44-412b-4ed8-a822-35938ec8e283	5cfa84fb-4faf-4df1-9eac-f68c23e37588	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Dunno	0.0
f111a369-f400-4d20-9a25-ea87641674cb	5cfa84fb-4faf-4df1-9eac-f68c23e37588	30294dd1-3e35-40ff-91b6-24c7401e62de	China	1.0
d49b1842-1087-449e-ad0d-0f450dfa28d0	5cfa84fb-4faf-4df1-9eac-f68c23e37588	078e3c1f-6483-4869-a131-39c12603610e	Garbage Can	1.0
8d1c1c45-dba1-49d0-af0e-d287979b3e95	5cfa84fb-4faf-4df1-9eac-f68c23e37588	5a67bdb8-0b53-4496-a673-dc84506fe252	Dunno	0.0
50b74810-4718-439d-9b3e-808dc0fd9c82	5cfa84fb-4faf-4df1-9eac-f68c23e37588	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Dunno	0.0
8eb8684b-c6b7-4aca-bf78-d622efcff021	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
feb9a0a2-759e-48d3-b051-715303b7dceb	7896aa8b-721a-44b2-b111-f4be86ec089a	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
be6e3945-9f4e-4da5-9abc-7c8e0d46b285	07043c1d-41ba-45d8-9557-33afb8ee24cd	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Bronte	0.0
9dd7ad37-2da5-410b-9aa4-c7a0808b0f94	07043c1d-41ba-45d8-9557-33afb8ee24cd	30294dd1-3e35-40ff-91b6-24c7401e62de	Madagascar?	0.0
9df1ebca-ff1c-48b3-9a46-8dca4ba7e9cc	07043c1d-41ba-45d8-9557-33afb8ee24cd	078e3c1f-6483-4869-a131-39c12603610e	Trashcan	1.0
e6370425-5cf8-48f0-9cbd-faa8fd484f55	07043c1d-41ba-45d8-9557-33afb8ee24cd	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom	1.0
31829aa7-39c2-417d-a6ea-7a018e1c456c	07043c1d-41ba-45d8-9557-33afb8ee24cd	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Vermont	0.0
4b7eb656-900a-4932-a2dd-bbed3b08494f	3b68f8bb-589a-480b-bb39-cb47124f9680	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Dipsy	1.0
bda332e9-da9e-417c-9ac3-8a32b9bc3ace	3b68f8bb-589a-480b-bb39-cb47124f9680	e6e5c928-b872-4f49-98d2-674242dad63a	Drury lane	1.0
0883baac-6a79-4874-912e-b3c7c3f846c3	3b68f8bb-589a-480b-bb39-cb47124f9680	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
31da87cd-d7a8-4242-b267-c1ebce59e5c1	3b68f8bb-589a-480b-bb39-cb47124f9680	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
9f983f2c-322e-4c7f-8204-0026c4d1b5dc	3b68f8bb-589a-480b-bb39-cb47124f9680	7052e44a-7137-4e7e-8827-358e304e7979	Nuuk	1.0
f1ce0af6-b3d3-4321-9006-29a6c5dddebe	3b68f8bb-589a-480b-bb39-cb47124f9680	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Barbara Cartland	1.0
cb063665-c822-452c-a40d-e7d3d954a622	3b68f8bb-589a-480b-bb39-cb47124f9680	30294dd1-3e35-40ff-91b6-24c7401e62de	Indonesia	0.0
a81bbfa6-daab-47e0-ab16-80ed6994ab15	3b68f8bb-589a-480b-bb39-cb47124f9680	078e3c1f-6483-4869-a131-39c12603610e	Trash can	1.0
d77f7596-a740-43c5-b08c-cfc60fca732e	3b68f8bb-589a-480b-bb39-cb47124f9680	5a67bdb8-0b53-4496-a673-dc84506fe252	Tom Buchanan	1.0
fec6d110-0c89-4719-b7ef-4a4f91ff51bb	3b68f8bb-589a-480b-bb39-cb47124f9680	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	Connecticut	1.0
4842685a-4563-4aaa-9e25-920b33f1ca1a	0d74d13d-3cfb-4569-b71c-d831b5d119ce	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billy Joe Armstrong	1.0
161f779a-c976-4632-9dfc-ae9fdc65fe6e	0ccd314e-3963-46bc-bf87-41f51aa191d5	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Tippi	0.0
cb6e3d5d-3717-4e72-ac1c-0972b008a184	0ccd314e-3963-46bc-bf87-41f51aa191d5	8a65e25c-ecb4-4775-9b88-7fd8c47df896	Barbara Cartland	1.0
82782c18-68af-4848-8774-571aa26e92f0	07043c1d-41ba-45d8-9557-33afb8ee24cd	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	Poe?	0.0
482f8db7-cc06-413d-910a-5cf49e247c6e	07043c1d-41ba-45d8-9557-33afb8ee24cd	e6e5c928-b872-4f49-98d2-674242dad63a	Drury Lane	1.0
ddac0efc-a2be-4aba-9206-11cc541120b3	07043c1d-41ba-45d8-9557-33afb8ee24cd	1dbd5c29-52c7-449b-865d-ab3a72d6d527	Billie Joe Armstrong	1.0
9388afcb-d810-4014-9ded-430c03957fec	07043c1d-41ba-45d8-9557-33afb8ee24cd	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	Andes	1.0
435ee0d6-9bf5-4609-87cd-5512175e5c31	07043c1d-41ba-45d8-9557-33afb8ee24cd	7052e44a-7137-4e7e-8827-358e304e7979	???	0.0
9ee03133-6c2c-45f7-bf26-d8f4c29c710f	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Gobi Province	0.0
731cf1a8-acb3-45dd-b1d0-3c927af0f705	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
0d94ebfa-ab0d-4425-a3e4-799ae280656c	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
108f7f12-a6c1-4772-8b2a-b115bbfb69b3	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
8fd9cbcb-1516-4f7a-aac6-1feb4afdbedf	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch (one of the best songs of all time)	0.0
475fa897-f8b8-427c-93ca-8cba002fd9a1	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
a7c52296-586b-4b55-9b9d-a5f35ae36797	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
2eca96a4-fc51-4c65-9abd-c94830687d30	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
9c4414f0-5d1c-4370-bdb1-2ecdfda31769	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Ethan Erusha	0.0
1165deb2-0c71-4905-98fe-89ab849e7f8d	6ea12e70-ba7c-4d47-9a8a-663b93802bd9	36c14939-ae1b-41b7-ac59-13c044a8a978	The Russian Space Station	0.0
4fe1b49e-fa86-4465-83fc-1dda5879bb31	f5b5d87f-4099-43e3-bc79-c28d877543c1	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Szechuan	0.0
1e384df7-2a7a-4c4d-bdb1-be5a8ded2fd5	f5b5d87f-4099-43e3-bc79-c28d877543c1	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General Sherman	0.0
ca1b79c0-232f-4d40-b4eb-0cb903c1293f	f5b5d87f-4099-43e3-bc79-c28d877543c1	b9064a92-8b82-4e6c-9062-20aff438d14b	Great Gatsby	0.0
986c5276-73c1-446a-800b-27dfd2b75fa0	f5b5d87f-4099-43e3-bc79-c28d877543c1	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden 	0.0
d552fa1c-0565-4ffb-9d39-878e88c89530	f5b5d87f-4099-43e3-bc79-c28d877543c1	36c14939-ae1b-41b7-ac59-13c044a8a978	Sputnik	0.0
98e76851-3780-4dd8-a4ef-7abc3e97caf0	f5b5d87f-4099-43e3-bc79-c28d877543c1	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Still don’t know	0.0
6b53322c-0c25-437c-b5c5-1dbf061d2659	f5b5d87f-4099-43e3-bc79-c28d877543c1	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Drop kick Murphys 	0.0
1fbd0a6d-2727-4053-945b-6fdef95d350f	f5b5d87f-4099-43e3-bc79-c28d877543c1	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Idk	0.0
8b3b19ef-b229-40fa-8427-96f80bb27731	f5b5d87f-4099-43e3-bc79-c28d877543c1	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Mississippi 	0.0
05eff356-3d7f-45df-8077-0c2fe5aaa199	f5b5d87f-4099-43e3-bc79-c28d877543c1	18c15d90-1b14-41fa-bbab-43d115f5fd65	Days of our lives 	0.0
10a5ee9d-12f1-4ce9-adea-3b4fbb875096	72986d21-4025-4c8d-a373-4046ba74855b	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard 	0.0
b971616a-1be1-4fbe-a0bc-de62e9d77035	72986d21-4025-4c8d-a373-4046ba74855b	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
0f58ea48-fbea-4262-925e-1a11af982d43	72986d21-4025-4c8d-a373-4046ba74855b	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
63d666a6-6f4e-47a9-ada3-accd4eb4be7b	72986d21-4025-4c8d-a373-4046ba74855b	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
85f5fbc9-0310-4fd2-86cb-bfc3aca1dd66	72986d21-4025-4c8d-a373-4046ba74855b	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
8e2f2147-3bb2-487f-9337-9936fae02938	72986d21-4025-4c8d-a373-4046ba74855b	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
3626c0b0-3a7a-4e70-a682-247bc8ff0073	72986d21-4025-4c8d-a373-4046ba74855b	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
a8efd26a-9522-4887-9ef2-28a38254b3f4	72986d21-4025-4c8d-a373-4046ba74855b	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
8227d56a-f037-4cd7-b00b-ce2ace304457	72986d21-4025-4c8d-a373-4046ba74855b	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Chris Ward	0.0
1b9b8ccc-b52d-4cec-8262-66470f6f4d50	72986d21-4025-4c8d-a373-4046ba74855b	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Northwest China	0.0
a2ab7c3b-8a77-41bd-b895-ad72ca5771c5	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Xinjang	0.0
04de4fe8-0f77-4fd4-a144-328cff58e4f4	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General William Sherman	0.0
ad53fea2-97dc-45dd-954b-6d2501624d7e	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
696a453c-b150-4a52-af4d-5d2dbefb163d	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
4dd03cce-cb1c-4c92-8876-9e0b6b980ecc	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
ea472d01-adcb-4dc6-b37b-86ddf8073089	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	No clue	0.0
759a1f45-4021-49be-bee5-52b66034cce7	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
5f1acefe-d4c6-412b-9de4-9a6887f482ad	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
4f190b15-0d2d-410f-9398-2b94a3862bf6	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
f0b108a4-0300-4f42-8231-c42f505fd842	bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
026eef3f-0c68-47b8-938e-14c4b893c8b0	db79d40b-b30b-4e09-9586-3787d142e358	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Tian Shan	0.0
d7c116c1-9d2a-412b-bba2-d42d92a88df8	db79d40b-b30b-4e09-9586-3787d142e358	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
fa34b923-91f3-4438-b4a1-48bd238233c0	db79d40b-b30b-4e09-9586-3787d142e358	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
a6dc247e-6879-493b-96b0-84ed5b313dbe	db79d40b-b30b-4e09-9586-3787d142e358	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
da399c53-e0c6-4ced-b67d-042867b9b46e	db79d40b-b30b-4e09-9586-3787d142e358	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
5fb5919b-59c6-4cc8-b445-8d70da1c1c43	db79d40b-b30b-4e09-9586-3787d142e358	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	We don't know?	0.0
87caca0d-485d-445f-8776-fc0e177f7e9d	db79d40b-b30b-4e09-9586-3787d142e358	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dropkick Murphy?	0.0
7ca0195c-5c2a-40ba-9b2f-36054936408f	db79d40b-b30b-4e09-9586-3787d142e358	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
3e53656e-e43d-4450-bca2-dfa6283d6f07	db79d40b-b30b-4e09-9586-3787d142e358	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Alabama?	0.0
597673cd-186a-4b7a-bb42-efe80e3999b7	db79d40b-b30b-4e09-9586-3787d142e358	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
5f8873be-fa55-44a3-903c-5d6c70751197	aef1e58f-cb7e-434b-893b-724c3cb8d064	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Han	0.0
4cc52cec-2de7-4bdf-bb57-44d08d1c371a	aef1e58f-cb7e-434b-893b-724c3cb8d064	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Redwood	0.0
cd9f8d17-6de5-42ae-a895-fe7a47db24c1	aef1e58f-cb7e-434b-893b-724c3cb8d064	b9064a92-8b82-4e6c-9062-20aff438d14b	Goodfellows	0.0
b99898de-a429-4215-8efd-d43a3125fce6	aef1e58f-cb7e-434b-893b-724c3cb8d064	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
5e57db66-b907-4427-84af-3d147fc49b02	aef1e58f-cb7e-434b-893b-724c3cb8d064	36c14939-ae1b-41b7-ac59-13c044a8a978	Sputnik	0.0
e4a4e140-7128-4e92-a866-cd523e16dfff	aef1e58f-cb7e-434b-893b-724c3cb8d064	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Bill Johnson	0.0
c866c93a-f815-4913-97a8-54558f2dd318	aef1e58f-cb7e-434b-893b-724c3cb8d064	d0a3429e-a8aa-4825-913a-1d65dc38b1af	U2	0.0
730a8a6a-4d96-457d-905c-09d6d83f0a0f	aef1e58f-cb7e-434b-893b-724c3cb8d064	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
cbc0fc0a-622b-4980-92f8-cd49e02e82f6	aef1e58f-cb7e-434b-893b-724c3cb8d064	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
d0874f91-6278-4081-98d1-9d09d3b2fc6b	aef1e58f-cb7e-434b-893b-724c3cb8d064	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
f7aed85c-2ddb-49db-b3f5-a84580562c96	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Xinjiang	0.0
fe1c7544-810a-4cb7-92c8-0e89638513ea	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
e82b7a2d-49db-40dc-8c55-1d1b5323b4c0	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	b9064a92-8b82-4e6c-9062-20aff438d14b	sunset boulevard	0.0
a2ef8694-a4db-4832-87bc-9e6a8bc41ddc	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
2e1fb881-c09b-47a8-8641-f27108df4953	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
c56e97a5-00b0-44af-9e78-70831536beee	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Sushruta	0.0
ac453b96-2a9e-42cf-a0ea-e3b3415af908	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Arcade Fire	0.0
3f172612-cb32-4319-a8ff-ca73a485755c	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Tesla	0.0
62fa7555-bce8-4c99-92c2-e270868f6c91	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Florida	0.0
e0383597-0637-41c3-a159-cbc800e11198	003e1d36-bac3-4812-b4e4-aa2f4b10be0c	18c15d90-1b14-41fa-bbab-43d115f5fd65	Days of our lives	0.0
a3701512-270f-42b0-9f05-692b2666e0ca	121bfc6f-2561-47fd-90a3-e85c02bfe831	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Gobi	0.0
c0901da4-0c58-469c-a510-2b2b66f02bbd	121bfc6f-2561-47fd-90a3-e85c02bfe831	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
2806792d-787a-4994-b979-f74db5a94892	121bfc6f-2561-47fd-90a3-e85c02bfe831	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
33ec1b76-6324-442e-bc58-d8a2d07f61c7	121bfc6f-2561-47fd-90a3-e85c02bfe831	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
b1b0d251-a817-4282-8998-0e9158523fec	121bfc6f-2561-47fd-90a3-e85c02bfe831	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
2c983369-f14a-46cd-bcf6-5d2527fef991	121bfc6f-2561-47fd-90a3-e85c02bfe831	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Sushruta	0.0
a55f05f2-e6e7-4253-b76e-33b558ac2177	121bfc6f-2561-47fd-90a3-e85c02bfe831	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
1bdeec86-da42-42aa-9c36-f79df657a075	121bfc6f-2561-47fd-90a3-e85c02bfe831	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Fermi	0.0
0edaf83b-4c0c-463b-9ac8-7e3a42d041fc	121bfc6f-2561-47fd-90a3-e85c02bfe831	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
4a21364a-81a5-4859-bc47-96e63206b590	121bfc6f-2561-47fd-90a3-e85c02bfe831	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
f48312ce-7a72-4915-9ba1-7b9c5cb3bfbc	26fc2a88-9c13-4773-ae8c-eef8517a44a1	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
ffa0588a-bbab-4da3-99e3-efcdbeeee8d7	26fc2a88-9c13-4773-ae8c-eef8517a44a1	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Uygur province	0.0
cbb6e2ae-855f-4f55-b195-648d2f5f36f0	26fc2a88-9c13-4773-ae8c-eef8517a44a1	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Ohio	0.0
7ace43e0-6de2-4f98-bc2f-b744ad422698	26fc2a88-9c13-4773-ae8c-eef8517a44a1	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
e97f39c5-ba9d-455c-b508-fe221212b05f	26fc2a88-9c13-4773-ae8c-eef8517a44a1	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Kiss	0.0
59029fd9-faab-4ac0-809c-310f88da968f	26fc2a88-9c13-4773-ae8c-eef8517a44a1	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	x	0.0
f66b6878-b934-4222-9221-69785de7b872	26fc2a88-9c13-4773-ae8c-eef8517a44a1	36c14939-ae1b-41b7-ac59-13c044a8a978	x	0.0
daaad973-eda2-49e7-8f76-0ed64e62ee66	26fc2a88-9c13-4773-ae8c-eef8517a44a1	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
e7a8179c-90e5-4b13-bd39-2219f24f59cd	26fc2a88-9c13-4773-ae8c-eef8517a44a1	b9064a92-8b82-4e6c-9062-20aff438d14b	x	0.0
521081e4-2c67-48df-9a2d-4890b59bea51	26fc2a88-9c13-4773-ae8c-eef8517a44a1	5e97fc52-dff6-4b5b-812e-d55d34894a0f	x	0.0
8e05ad53-8ecb-4444-91a1-b5a402d6e797	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Xinjiang province	0.0
fed768c5-1388-44c7-beeb-cf9cdc1c2f15	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	b9064a92-8b82-4e6c-9062-20aff438d14b	Great Gatsby	0.0
c2b947e1-ddb6-4883-8682-f4f20edcf937	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
41ca0711-bb30-40d1-92e6-3284970918e6	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Tesla	0.0
35e6def5-8564-41e9-acb7-868471caa0f9	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	California	0.0
a6c44767-c5b2-416e-91e8-4aa41e313c68	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	18c15d90-1b14-41fa-bbab-43d115f5fd65	Days of our lives	0.0
04952d4c-f78c-4e93-95a2-c8f3647fef9c	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	NA	0.0
b3cc7f48-815e-47e3-aea9-dad5412b0458	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Boston	0.0
f58fe80a-e4b2-4ba5-8634-676626bf13da	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	36c14939-ae1b-41b7-ac59-13c044a8a978	Soyez	0.0
e934d75a-e23e-48fc-be1a-82eead156537	7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Lee	0.0
b18bf0f3-88eb-4d91-8170-23323f323017	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	e6e5c928-b872-4f49-98d2-674242dad63a	No submission	1.0
9a42ef6e-b062-4076-8808-d4703962e5d2	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	1dbd5c29-52c7-449b-865d-ab3a72d6d527	No submission	1.0
0b392b06-ef14-4a87-9c07-e59c574791a7	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	No submission	1.0
2992425a-dc84-4b0c-a237-3108e54a0345	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	7052e44a-7137-4e7e-8827-358e304e7979	No submission	1.0
167f379d-a40e-4fff-8fb3-c7d85568fb61	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	8a65e25c-ecb4-4775-9b88-7fd8c47df896	No submission	0.0
194767ea-8072-4e54-91c1-dc81b26412ab	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	30294dd1-3e35-40ff-91b6-24c7401e62de	No submission	1.0
f67a3d4d-9c0b-494a-972f-9c8c18866f28	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	078e3c1f-6483-4869-a131-39c12603610e	No submission	1.0
258de81d-8ed2-40e4-bda4-a8b9eb515384	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	5a67bdb8-0b53-4496-a673-dc84506fe252	No submission	1.0
583d8471-1785-4527-9d5d-087ee6361c4f	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	No submission	1.0
b8214e1c-c7bf-4bbd-bc9a-07d6f67305ff	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	No submission	1.0
71350751-ab03-479c-b22d-4082ed30f522	2335f405-1e68-48a0-8238-5bdb9959cab7	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Xinjiang Province	0.0
c45e8fd8-99d0-4c90-bcef-c7c3a45cd5c8	2335f405-1e68-48a0-8238-5bdb9959cab7	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General Sherman	0.0
72098218-92ab-493e-9d0e-da7ab843863a	2335f405-1e68-48a0-8238-5bdb9959cab7	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
ab3b6f23-ab53-4112-996f-87570b0b6891	2335f405-1e68-48a0-8238-5bdb9959cab7	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
28e97fa7-eaf4-4aeb-bf62-09a1c7b66ba0	2335f405-1e68-48a0-8238-5bdb9959cab7	36c14939-ae1b-41b7-ac59-13c044a8a978	\nMir	0.0
9d677c3d-b7c6-4288-9f2b-f2d5a25d5673	2335f405-1e68-48a0-8238-5bdb9959cab7	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Sushruta	0.0
6aeefe48-0f6f-4b1b-aa4c-594949531c01	2335f405-1e68-48a0-8238-5bdb9959cab7	d0a3429e-a8aa-4825-913a-1d65dc38b1af	DISPATCH	0.0
70e3b51b-fa6e-4c8b-858f-3ece179b2bd0	2335f405-1e68-48a0-8238-5bdb9959cab7	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Michael Faraday	0.0
5458ece3-4357-4aeb-ac54-d40fe06ffb71	2335f405-1e68-48a0-8238-5bdb9959cab7	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
5425f083-42ab-4cbd-a018-51773ded9b49	2335f405-1e68-48a0-8238-5bdb9959cab7	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
4e27aa57-a698-4b32-809d-d727a0d06793	0477931b-2340-4114-8186-980234965137	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Szeuchuan	0.0
882caac5-eea8-42a8-aac9-d9a50e575a53	0477931b-2340-4114-8186-980234965137	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Sherman	0.0
dff87d8d-fee2-4d99-ad8a-a073839a6ed2	0477931b-2340-4114-8186-980234965137	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
6673d858-a67b-4ab4-994d-7504ae1fc949	0477931b-2340-4114-8186-980234965137	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
5182eed9-27da-4f24-b272-26f9ab43d347	0477931b-2340-4114-8186-980234965137	36c14939-ae1b-41b7-ac59-13c044a8a978	Sputnik	0.0
a2537526-a0a4-4fe5-bcfd-5d84edde8d2a	0477931b-2340-4114-8186-980234965137	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Rajat	0.0
0809a048-7175-4196-9af1-529b969ef093	0477931b-2340-4114-8186-980234965137	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
b96963bb-8e6e-4cfa-bcee-5f1b8896b97a	0477931b-2340-4114-8186-980234965137	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
20b35007-cd6f-4a53-b8b3-ab957c7458a5	0477931b-2340-4114-8186-980234965137	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
31e6ea78-e4f2-46f1-9972-0a5bb5c55fe3	0477931b-2340-4114-8186-980234965137	18c15d90-1b14-41fa-bbab-43d115f5fd65	Days of our Lives	0.0
bfcfde79-16b4-488a-8942-7b1ef32ccf92	841d4879-ee75-4007-9c34-c11dbf9a69f0	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Sechuan?	0.0
2139bbfa-caa4-4ab1-bd93-4b4eab3a684d	841d4879-ee75-4007-9c34-c11dbf9a69f0	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General Sherman	0.0
6edb151a-b9d9-4922-bec0-fa63f82c2863	841d4879-ee75-4007-9c34-c11dbf9a69f0	b9064a92-8b82-4e6c-9062-20aff438d14b	Phantom of the Opera?	0.0
f653ba99-1e26-4454-8fcd-4640940f2ebe	841d4879-ee75-4007-9c34-c11dbf9a69f0	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
95e6628a-b7d9-43c6-bd0d-ea49ccfd14d5	841d4879-ee75-4007-9c34-c11dbf9a69f0	36c14939-ae1b-41b7-ac59-13c044a8a978	Soyuz	0.0
3616f46b-38fa-4984-987f-01309b4c9406	841d4879-ee75-4007-9c34-c11dbf9a69f0	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Ramanujan?	0.0
4f618e09-e1da-4c1a-9309-6ad7687df1d7	841d4879-ee75-4007-9c34-c11dbf9a69f0	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Flogging Molly?	0.0
62410a27-2743-4668-82cd-6c85d794f637	841d4879-ee75-4007-9c34-c11dbf9a69f0	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
1facfd70-aabf-478b-9785-2cf29a34c9ff	841d4879-ee75-4007-9c34-c11dbf9a69f0	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
cdca9bf0-ddee-46aa-98ff-0d996dbf95d7	841d4879-ee75-4007-9c34-c11dbf9a69f0	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
a6e98b63-b508-4c25-934d-7caa9faca34e	46374e4d-95ad-4154-afcd-308e634265ec	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General Sherman	0.0
b120a17d-08ff-4fac-a4f4-3fe0980e7cd5	46374e4d-95ad-4154-afcd-308e634265ec	b9064a92-8b82-4e6c-9062-20aff438d14b	Death of a Salesman	0.0
92f13e0b-f4bc-486c-acfd-59975696c11c	46374e4d-95ad-4154-afcd-308e634265ec	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
1467d421-3ccc-437a-9bf8-7aca24126514	46374e4d-95ad-4154-afcd-308e634265ec	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
f8b807f1-6b2b-4c16-9cfb-9f3c2a8fcf01	46374e4d-95ad-4154-afcd-308e634265ec	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Joule	0.0
5cb6d178-bddc-4e1c-8d8c-2359565c22ee	46374e4d-95ad-4154-afcd-308e634265ec	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
4ac4afc6-58df-4e40-b008-c7ecea29f589	46374e4d-95ad-4154-afcd-308e634265ec	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
80744f40-7e96-4918-9b3f-ae61d57784be	46374e4d-95ad-4154-afcd-308e634265ec	36c14939-ae1b-41b7-ac59-13c044a8a978	International Space Station	0.0
7f298fbe-8f74-44e5-b79a-359de25ef377	46374e4d-95ad-4154-afcd-308e634265ec	3073cbaa-3795-4e57-8e77-e78c7b21c79d	...	0.0
6d0b02bb-b690-4564-bfc7-5f5a7df7a241	46374e4d-95ad-4154-afcd-308e634265ec	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	...	0.0
ef9c2971-e9cb-498b-8fc7-b8dcfd777e95	7a9ad60d-042e-42f6-af87-19c2d7151e7d	3073cbaa-3795-4e57-8e77-e78c7b21c79d	Xinjiang	0.0
fa1df5e9-aedd-473a-8005-26f5b59ce5df	7a9ad60d-042e-42f6-af87-19c2d7151e7d	5e97fc52-dff6-4b5b-812e-d55d34894a0f	General Sherman	0.0
7d591113-9c13-4700-b47e-36f63f249f29	7a9ad60d-042e-42f6-af87-19c2d7151e7d	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
1b555d35-51f1-45ec-8fba-289edfe0bac8	7a9ad60d-042e-42f6-af87-19c2d7151e7d	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir Space Station	0.0
ad4c63b1-1f32-4e78-8de1-a06b060ed7cc	7a9ad60d-042e-42f6-af87-19c2d7151e7d	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	Sushruta	0.0
bd417c9f-8fee-4e04-8b92-d083fb5d6cf0	7a9ad60d-042e-42f6-af87-19c2d7151e7d	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Michael Faraday	0.0
fbab4c7a-0ca9-4754-bfc6-0f55bae2cdb1	7a9ad60d-042e-42f6-af87-19c2d7151e7d	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
2fd0d59c-555e-4e1d-abfd-c56a760e87df	7a9ad60d-042e-42f6-af87-19c2d7151e7d	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
161c4270-b42d-4092-8cb4-f2df061c0466	7a9ad60d-042e-42f6-af87-19c2d7151e7d	d0a3429e-a8aa-4825-913a-1d65dc38b1af	Dispatch	0.0
b02db5b3-14d5-4427-b3ab-6e10ce831293	7a9ad60d-042e-42f6-af87-19c2d7151e7d	b9064a92-8b82-4e6c-9062-20aff438d14b	Sunset Boulevard	0.0
7d1975a5-6eb2-42a9-b94b-f46325c35369	40ded797-97a4-41be-887c-19a48635b837	3073cbaa-3795-4e57-8e77-e78c7b21c79d	idk	0.0
a839c78a-4d9f-4c63-b5e9-83155fc9dd66	40ded797-97a4-41be-887c-19a48635b837	5e97fc52-dff6-4b5b-812e-d55d34894a0f	Stonewall Jackson	0.0
8995cccf-d78f-4b18-b635-78934e34e78b	40ded797-97a4-41be-887c-19a48635b837	b9064a92-8b82-4e6c-9062-20aff438d14b	idk	0.0
e202c9ca-73ba-4f49-9a8c-73787d70e0d7	40ded797-97a4-41be-887c-19a48635b837	6dbee58f-fc8a-4a82-886b-284f25399865	Olive Garden	0.0
2aec30fe-329d-4738-9f2c-5cdb0f810904	40ded797-97a4-41be-887c-19a48635b837	36c14939-ae1b-41b7-ac59-13c044a8a978	Mir	0.0
a2f462b3-f606-44e7-ae80-8007231ac1c7	40ded797-97a4-41be-887c-19a48635b837	2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	idk	0.0
424c4377-eeaf-479f-8bc2-c3da888d3616	40ded797-97a4-41be-887c-19a48635b837	d0a3429e-a8aa-4825-913a-1d65dc38b1af	idk	0.0
ad0b2bea-ea4c-457f-a8ff-e598cf752af4	40ded797-97a4-41be-887c-19a48635b837	5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	Faraday	0.0
763cd2b6-aee6-47e1-9632-dfbc1feefd91	40ded797-97a4-41be-887c-19a48635b837	3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	Texas	0.0
6a4abdc7-54c3-45ae-8b54-a86587e85707	40ded797-97a4-41be-887c-19a48635b837	18c15d90-1b14-41fa-bbab-43d115f5fd65	General Hospital	0.0
\.


--
-- Data for Name: champions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.champions (id, year, season, team_name, team_id, winning_score) FROM stdin;
6e03a079-3c41-4b45-9c7a-4c67791ae51d	2023	Season 3	The Denverites Unite	\N	0.0
f4212966-af53-4c0f-98dd-9bbe0c46a6b4	2022	Season 2	Beyonce KnowsItAll	\N	0.0
88d19be5-81be-497d-a681-ae4f0432cf85	2024	Season 4	Team Croniq	\N	0.0
35a83c94-635a-4dbf-a71c-93d458f261b0	2025	Season 5	Team Croniq	\N	0.0
d491e3eb-741b-43b4-8a0b-9e485dd56626	2021	Season 1	David's Angels	\N	0.0
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.questions (id, week_id, question_number, question_text, correct_answer, max_points, image_url) FROM stdin;
e54480ed-cc7a-404c-8bd8-68d66b5e9209	c4f01675-e13d-4053-8fb3-9d5eadb3f042	1	Bumble, the “Abominable Snowmonster of the North” from the stop-motion masterpiece Rudolph the Red-Nosed Reindeer gave young Ethan many a nightmare—even after Yukon Cornelius’s valiant reformation efforts. Moving to another reformed yeti, what food item did the Abominable Snowman serve to the newly banished Sulley and Mike Wazowski in Monsters Inc.?	Snow Cone	1	\N
eddfb55c-106c-4516-8c5a-0e7aeec6fd45	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2	In a different Christmas special movie, Frosty the snowman sports an enviable fit with his corn cob pipe and button nose. Much more enviable at least than having button eyes like Coraline. Question: What Stardust and American Gods author wrote the novel Coraline?	Neil Gaiman	1	\N
7251c912-433d-4305-b471-54f2b9877c98	c4f01675-e13d-4053-8fb3-9d5eadb3f042	3	Absolute Zero is 0 Kelvin. That's as cold as anything can possibly get. What is absolute zero (0 Kelvin) equal to in Celsius?	-273.15 degrees C	1	\N
f86a6563-e740-419a-b75b-1a4ce3a8a3bc	c4f01675-e13d-4053-8fb3-9d5eadb3f042	4	Snow White and the Seven Dwarves has been remade, spoofed, parodied, and imitated many times over (my personal favorite was Syndey White, starring Amanda Bynes, where Sydney meets seven frat boys instead of seven dwarves). I will do no such parodying however, and instead ask a question about the diamonds that the seven dwarves sought after so valiantly. Round diamonds are by far the most popular cut, but what is the name of the trendy diamond cut shown here?	Marquise Cut	1	https://www.brilliance.com/cdn-cgi/image/f=webp,width=720,height=720,quality=90/sites/default/files/engagement-rings/4.5x2.5-marquise-diamond-value/4.5x2.5-marquise-diamond-value-melee-diamonds-v1.jpg
5e20eb02-b9ba-4233-8b7e-9f3acc8e656f	c4f01675-e13d-4053-8fb3-9d5eadb3f042	5	What is songwriter, rapper, actor, producer, and "It Was a Good Day" creator Ice Cube's real name?	O'Shea Jackson	1	\N
8444d762-c013-4470-a00d-f626a5494c3d	c4f01675-e13d-4053-8fb3-9d5eadb3f042	6	Fun fact: -40 degrees Celsius and -40 degrees Fahrenheit is the same temperature. Also fun fact: Minnesota got colder than -40 this week. Hopefully you Freeport folk have developed some industry knowledge, because this question is about mining. Question: Minnesota is the largest producer of what metal in the United States?	Iron	1	\N
0856b4f2-0098-4f16-82fe-15c492450e95	c4f01675-e13d-4053-8fb3-9d5eadb3f042	7	I was going to do a poem by Robert Frost, but figured that would be too easy considering the category. Instead, what world famous poet wrote this:\n"This being human is a guest house.\nEvery morning a new arrival."	Jalaluddin Rumi	1	\N
83642d04-c127-4ef0-b12a-33e397e3b898	c4f01675-e13d-4053-8fb3-9d5eadb3f042	8	What type of North American frog shown here freezes solid from ~October-May each year, completely stopping its heartbeat, brain activity, and blood circulation?	Wood Frog	1	https://www.vtherpatlas.org/wp2016/wp-content/uploads/2017/08/R.-sylvatica-adult-face-on-birch-E.-Talmage.jpg
97d044fd-329c-4e54-a3e1-8a8374dae289	c4f01675-e13d-4053-8fb3-9d5eadb3f042	9	I can't think of a trivia question about fridges or freezers, but I can for microwave ovens. The first ever microwave oven made and sold for home use was invented in Amana, Iowa, five miles away from my dad's house. I know this only because my dad still to this day refuses to call a microwave a microwave, instead only using this name. Question: What was this brand name of the world's first commercial microwave oven? (fun fact: this brand name was used as part of a joke in the 1980 Airplane! movie)	Radar Range	1	\N
63c24528-abc9-4a55-9764-1f412ac2f6de	c4f01675-e13d-4053-8fb3-9d5eadb3f042	10	The thriller Snowden stars what Inception actor playing the role of famous/infamous whistleblower Edward Snowden?	Joseph Gordon-Levitt	1	\N
884b11fd-fa04-42a8-a903-8aa9f39e0a37	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	1	Maybe you know that George Washington was the first president of the United States. Maybe you even know the second president was John Adams. Maybe you even even know that John Adams was also the first vice president of the USA. But do you know who was the second vice president of the United States?	Thomas Jefferson	1	\N
541eec43-a9d5-44a4-a8c8-0d1f4879a02f	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2	If you were here for season 2 of Tuesday Trivia, you would already know that Buzz Aldrin was the second person to walk on the moon and the first most famous person I have ever met. Today's question will be about the second most famous person I have ever met. Question: What Soviet/Russian chess player has the second highest peak FIDE ranking of all time, currently lives in New York City after being exiled from Russia for staunchly speaking out against Putin, and was the first world chess champion to ever lose to a supercomputer?	Garry Kasparov	1	\N
69a8cee2-208b-415f-9cb3-868dcfe4d29a	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	3	In Hinduism, who is the god of preservation and the second deity of the Trimurti?	Vishnu	1	\N
f0f64982-dbc7-4f4c-98fe-c0f7746471c9	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	4	In 1960, Don Walsh and Jacques Piccard made a duo dive to Challenger Deep in the Mariana Trench, becoming the first people to reach the deepest part of the Earth. No one made it back again for 52 years. Who is the second-highest grossing movie director of all time and the man who completed the second dive ever into Challenger Deep?	James Cameron	1	\N
0b704edd-082f-444f-a8a8-3c398a16dadc	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	5	The first movie sequel to ever win the Best Picture Oscar was The Godfather Part II. What movie released in 2003 became the second ever sequel to win Best Picture? It is also the only movie to ever sweep every category it was nominated for (11/11).	The Lord of the Rings: The Return of the King	1	\N
b56d41fe-d1f5-4a9d-a02c-22be77bbe4e5	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	6	The greatest tennis player, athlete, and human being of all time, Rafael Nadal, has the second most men's grand slam titles of all time with 22, while first place Novak Djokovic could not improve on his record most 24 titles this Sunday. While the goat Serena Williams has the second most (23), what woman has the most grand slam singles titles of all time, with 24?	Margaret Court	1	\N
8a5643e0-ecbe-4e1a-9291-4e2e69401186	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	7	The Second Law of Thermodynamics says that disorder increases and heat flows from hot stuff to cold stuff. In scientific terms, what is the name of the concept that describes this disorder and randomness?	Entropy	1	\N
b3147c88-134f-4f05-92cb-9e76da08f786	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	8	A second was originally determined from dividing days into 24 hours and then hours into 60 minutes and then minutes into 60 seconds. Boom, easy. In 1967 things got fancier and the second is now measured by counting 9,192,631,770 oscillations of what element's atom?	Cesium	1	\N
f9343428-ec21-4cca-ac67-a7670687d600	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	9	The femur is the longest and strongest bone in the human body. In 2013, I was permanently scarred by watching Kevin Ware fracture what bone, the second longest bone in the human body?	Tibia	1	\N
e6ab9fb9-d328-4b4e-8fb0-5341ce522c54	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	10	In Harry Potter and the Chamber of Secrets, the second in both the Harry Potter book and movie series, what is the name of the memory-erasing spell that Gilderoy Lockhart casts on witches and wizards whose accomplishments he stole and the one he attempts to use on Ron and Harry?	Obliviate	1	\N
eec9096b-2e69-40b5-a334-8169c5c885d5	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	1	There's nothing quite like watching someone launch a 40 lb stone down the ice while their teammates sweep some brooms in front of it and yell as loud as they can in different languages; enter: curling. In The Princess Diaries curling is the enemy, as Paolo breaks his brush performing an anti-curling makeover on who, played by Anne Hathaway?	Mia Thermopolis	1	\N
e8528d5a-bf83-4c9b-ba96-92e39f204b75	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2	Biathlon is actually not just a triathlon for people who can't swim. The combination of cross-country skiing and target shooting allegedly started in Scandinavia hundreds of years ago to prepare soldiers for border defense measures. Biathlon today uses .22 caliber rifles. Question: what measurement does ".22 caliber" specifically refer to?	0.22 inch bore diameter	1	\N
31e8e209-48ff-49eb-8891-50445e1b0456	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	3	The absolute best Bobsled story I learned was about Billy Fiske, who at the ages of 16 and 20 years old won gold at the 1928 and 1932 Olympics as the USA Bobsled pilot, then built the first ski lodge at Aspen in 1937 and drew up the blueprints for the ski mountain, and finally in 1940 faked Canadian citizenship, joined the Royal Air Force, and then went down in history as the first American to die in World War II as he was shot down by a Nazi plane in an aerial dogfight in Britain. Question: Who was the UK Prime Minister at the time of the Battle of Britain in August 1940?	Winston Churchill	1	\N
0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	4	The Giant Slalom is a hybrid of other races, as it uses longer turns than the Slalom and goes slower than the Super-G. Similar to Giant Slalom, Giant Salamanders also turn and go slowly when they move. Question: what is the name of the only type of Giant Salamander that exists in the United States, which is an endangered species and is found in Eastern USA and the Ozarks.	Hellbender	1	\N
6541051c-0452-492d-b054-9a1040393283	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	5	Mystique Ro is representing the USA in Skeleton at the 2026 Winter Olympics, starting this Friday. She is an incredible ambassador for sliding sports as a whole, she won silver at the world championships last year, and she will be the single person I am most rooting for this Winter Olympics. Question: the adult human skeleton is commonly considered to contain how many bones?	206	1	\N
2ca22c03-8408-4751-845a-288a00d80b12	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	6	In January 1994, Nancy Kerrigan was assaulted by Tonya Harding's ex-husband two months before the Winter Olympics; heroically she was able to return from this injury in time to still win silver in Figure Skating. 8 months before this, a mentally disturbed, obsessive Steffi Graf fan ran on the court during a match and stabbed what 20-year-old World No. 1 tennis player, immediately following the greatest start to a career of all time, as she had won 8 total majors as a teenager, was the youngest ever French Open champion at 16 years old, and who took over two years to return to tennis after the stabbing, suffering from depression and other disorders on top of the health problems from being stabbed in the back?	Monica Seles	1	\N
11c321e5-1143-4634-aa20-27a025c3e47e	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	7	Erin Jackson was the first Black woman to ever win an individual Winter Olympic gold medal, winning the 500m speed skating gold in 2022 in Beijing, which she looks to defend on Sunday. Erin is not to be confused with the homonymic Aaron Jackson, who was hired in 2017 as the first ever WWT employee in what role?	Cloud Consultant	1	\N
4f907b77-fa2a-43c9-a20b-cf25754566fc	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	8	Ski Mountaineering, also called SkiMo, is debuting for the first time as an Olympic event in 2026. Not a homonymic question this time, but rather a rhyming question, Captain Nemo piloted a submarine named what in Jules Verne's Twenty Thousand Leagues Under the Sea and The Mysterious Island?	The Nautilus	1	\N
b99de020-d815-4cdc-b389-e73aa2b34250	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	9	Short Track Speed Skating is my personal favorite Winter Olympics sport to watch, with everyone starting at the same time, strategy and crashes abundant, and super high speed turns around the 111.111m track. Speaking of 11-11-11, what war famously ended on the 11th hour of the 11th day of the 11th month?	World War I	1	\N
12914612-937e-425f-bfd2-bb3886c6f5ad	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	10	Athletes in luge have to maintain near perfect calm and body relaxation while flying at 90+ mph and hitting 6Gs of force in order to control their sled. What is the name of the longest nerve in the autonomic nervous system, regulating heart rate and breathing and calming the body down during moments of high stress?	Vagus Nerve	1	\N
94d67cea-8f68-4646-bd8a-9c078d980ce1	d328396c-d796-4497-b1b1-54863974f30b	1	Diamond is the highest on the Mohs hardness scale, rated as a 10. What mineral is defined as a 1 on the Mohs scale of hardness as the softest mineral?	Talc	1	\N
cc766341-ed8b-4640-b479-004e220fc266	d328396c-d796-4497-b1b1-54863974f30b	2	What is the first name of Mr. Braille, the blind teenager who tweaked the raised dot reading system taught at his school, finally inventing the Braille system? If you speak Braille, his first name is: "⠠⠇⠳⠊⠎"	Louis	1	\N
0b96243d-6a1b-47ef-9d61-5be40ab6ee35	d328396c-d796-4497-b1b1-54863974f30b	3	In the age-old folktale, the Pied Piper uses his magic pipe to lure rats away from what German town?\n	Hamelin	1	\N
429a804d-41cc-43b3-af55-3ee1c6bd08fc	d328396c-d796-4497-b1b1-54863974f30b	4	What K-pop band has not been featured in Tuesday Trivia since Tuesday Trivia Season 2 and announced earlier this year they will be returning from military service for their 2026 Arirang World Tour?	BTS	1	\N
0f67ead7-5a1a-41a9-ae22-7f432eedf319	d328396c-d796-4497-b1b1-54863974f30b	5	Scream was released to theaters in 1996, and 30 years later the series is still going, with what number Scream movie coming to theaters next weekend?	Scream 7	1	\N
3f149c70-f473-4159-96e6-da43de13c388	d328396c-d796-4497-b1b1-54863974f30b	6	Referred to in the 1800s and earlier as "consumption", what is the modern name for one of the deadliest diseases of all time?	Tuberculosis	1	\N
49bbe70f-f339-4d32-a042-09426d6a7a07	d328396c-d796-4497-b1b1-54863974f30b	7	I paste the IMDb synopsis from a popular anime series, you tell me the name of the show: "Monkey D. Luffy, a pirate with rubber powers, forms the Straw Hat crew and sails the Grand Line, battling rivals and the World Government on a quest for the legendary treasure"	One Piece	1	\N
0d21d6f7-63b1-4758-a746-fbaf6871747a	74d22bb4-6a21-4576-b2dc-bf731486f17f	9	Insects are characterized by six legs, a three part body (head, thorax, abdomen), antennae, compound eyes, and they all have an exoskeleton made of what?	Chitin	1	\N
a9bdb28c-acbf-484b-b02f-c0679ad3ac75	d328396c-d796-4497-b1b1-54863974f30b	8	If you are reading this, it means Iowa State defeated Houston last night in Men's college basketball, and I am therefore including something Houston related to celebrate. The famous "Houston, we've had a problem" was spoken by Astronaut Jack Swigert aboard which space mission?	Apollo 13	1	\N
47d131b5-e18c-4a23-8663-2c1e859cd798	d328396c-d796-4497-b1b1-54863974f30b	9	What ancient Greek mathematician coined the discovery phrase "Eureka!" by running naked through the streets of Syracuse shouting it, after suddenly realizing in his bathtub that an object submerged in water displaces its own weight in fluid, and who now has a buoyancy principle named after him?	Archimedes	1	\N
29609503-20e1-4492-9819-5c0713d1691e	d328396c-d796-4497-b1b1-54863974f30b	10	No tennis questions? Fear not, I'll throw in a chess one at least. What Hungarian chess grandmaster is the greatest woman chess player of all time, the only woman to ever be ranked in the top 10 in the world rankings (peak of #8), and the only woman to ever compete in the final stage of a World Chess Championship.	Judit Polgar	1	\N
f32f9276-e3af-449e-b855-cdc81e2ed660	0ceafa7e-c327-4c76-8c25-4496e14dabac	1	First lady who remarried a guy named Aristotle | Retired #42 in MLB's first name + the name of the Space Center on Merritt Island, Florida	Jackie Kennedy	1	\N
f377b506-4977-4158-acdc-1f4c093ff55d	0ceafa7e-c327-4c76-8c25-4496e14dabac	2	Take Me Out band | first name of the author of Metamorphosis + 2017 movie about a gentle bull\n	Franz Ferninand	1	\N
e9e7ebae-d93f-48e3-b6fd-475a2b0af964	0ceafa7e-c327-4c76-8c25-4496e14dabac	3	"Float like a butterfly, sting like a bee" | Most common first name in the world + world's largest B2B marketplace - (2 * the sound a sheep makes)\n	Muhammad Ali	1	\N
cd885510-9d84-4643-b881-e4f52d624fa4	0ceafa7e-c327-4c76-8c25-4496e14dabac	4	Guy with tall hat | Hebrew patriarch for Judaism, Christianity, and Islam + the luxury car division of Ford Motor Company	Abraham Lincoln	1	\N
7da1e06a-b83c-4816-b6e3-60eec7eab605	0ceafa7e-c327-4c76-8c25-4496e14dabac	5	An actor who has played a famous detective, a cape-wearing superhero, and a hoarding dragon | the current bachelor protagonist in Bridgerton Season 4 + what someone may nickname a group of pre-pickled pickles	Benedict Cumberbatch	1	\N
722388ea-33de-42e0-a9b6-03608e8e461b	0ceafa7e-c327-4c76-8c25-4496e14dabac	6	Has an effect named after him about large groups of people misremembering things | wrestling move with full and half varieties + Deal or No Deal host last name + "a" 	Nelson Mandela	1	\N
ea095d63-fcaf-4bdf-80a7-34d160793c2a	0ceafa7e-c327-4c76-8c25-4496e14dabac	7	Cellist | a stringy toy + the abbreviation for the state with the most lighthouses\n	Yo-Yo Ma	1	\N
775bd148-0be2-4cd5-a67e-5f97f4a08509	0ceafa7e-c327-4c76-8c25-4496e14dabac	8	"Be like water" quote | the name of the shark in Finding Nemo + last name of To Kill a Mockingbird author	Bruce Lee	1	\N
58bf6902-dd91-4db2-9dd7-f5503dcce9c7	0ceafa7e-c327-4c76-8c25-4496e14dabac	9	First American woman in space | Who Harry met + "sit on and control the movement of (an animal, especially a horse), typically as a recreation or sport"	Sally Ride	1	\N
80d9024b-0bdb-485c-a0a0-1ab66e2d7f43	0ceafa7e-c327-4c76-8c25-4496e14dabac	10	Animated movie character | Tampa Bay team name + Elizabeth II if she was an item at McDonald's	Lightning McQueen	1	\N
1fbd051a-9a46-4743-8e32-f2b064edd9a6	74d22bb4-6a21-4576-b2dc-bf731486f17f	1	Counting Julius Caesar, who was the sixth emperor of Rome, whose reign marked the end of the first imperial dynasty after he died by forcing his secretary to help him stab himself in the throat? Staying with our theme of sixes, this emperor is also associated with 666, the "number of the beast", in the Book of Revelation in the Bible.	Emperor Nero	1	\N
3a08309f-da7d-4a81-b973-049736e0ef69	74d22bb4-6a21-4576-b2dc-bf731486f17f	2	The Iowa State Cyclones Men's Basketball is ranked #6 in the country in the AP poll currently, and will probably fall to something like a 6 seed in March Madness after their recent abysmal showings. The movie Twisters, with Glen Powell and Kiernan Shipka was a sequel to Twister, released in 1996 and written by whom? This Twisters writer also wrote Jurassic Park, The Andromeda Strain, and Westworld, and he graduated from Harvard Medical School.	Michael Crichton	1	\N
5182d01b-0798-48f5-9087-40969a5d641e	74d22bb4-6a21-4576-b2dc-bf731486f17f	3	The number 6 is permanently retired league-wide in the NBA to honor what Hall of Famer? He was also the first African American NBA coach, the #2 ranked track and field high jumper in the United States at one point, and he gave my favorite quote in basketball history: "What these youngbloods have to understand is that this game has always been, and will always be, about buckets"	Bill Russell	1	\N
a362d4d9-6e56-4e50-8dc0-45935ed91a11	74d22bb4-6a21-4576-b2dc-bf731486f17f	4	Henry VIII is famous for having six wives, who are sometimes remembered by the phrase "Divorced, beheaded, died, divorced, beheaded, survived". Who was the sixth wife, the first English Queen to publish books in her own name, later becoming the most published woman author of the English Renaissance? Her character in the musical "Six" was modeled on Ariana Grande and Emeli Sande.	Catherine Parr	1	\N
265c8bcf-d174-40ce-a3ef-231fc92c61e7	74d22bb4-6a21-4576-b2dc-bf731486f17f	5	What popularly bald actor played the lead role of Malcolm Crowe in "The Sixth Sense"? He also released multiple albums, appeared on Broadway, and was born in West Germany.	Bruce Willis	1	\N
5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	74d22bb4-6a21-4576-b2dc-bf731486f17f	6	A perfect hexagon has 6 interior angles. What is the angle in degrees of the six interior angles of a hexagon? 	120 degrees	1	https://www.splashlearn.com/math-vocabulary/wp-content/uploads/2022/05/image7.png
eef09846-d717-48e6-838d-30af16c6dda2	74d22bb4-6a21-4576-b2dc-bf731486f17f	7	The Sixth Amendment guarantees rights to criminal defendants, such as the right to a fair trial by jury. In what 1957 film does Henry Fonda help steer a group of fellow jurors away from giving the death penalty to a possibly innocent young man accused of murdering his father?	12 Angry Men	1	\N
59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	74d22bb4-6a21-4576-b2dc-bf731486f17f	8	In the Women's 4x6km Biathlon Relay, the team which placed sixth was made up of Anna Maka, Kamila Zuk, Joanna Jakiela, and Natalia Sidorowicz, from Zakopane, Wałbrzych, Zakopane, and Zakopane respectively. What country was this team from?	Poland	1	\N
dbd581c6-c54f-4aa1-9189-0de6967efdaf	74d22bb4-6a21-4576-b2dc-bf731486f17f	10	What NFL Player led the league in touchdowns (worth 6 points) this past season, with 20 total TDs? Fun fact: this player scored 17 of those 20 touchdowns in the first 10 weeks of the season, and I traded for him in the WWT Fantasy Football league in week 11.	Jonathan Taylor	1	\N
f52b9382-9b85-4a9f-9749-cf96a0a2fd89	007a6769-ef53-4a15-ba56-45c22a232b44	1	What movie is this character, named Minion, from? HINT: It is Ethan's favorite movie of all time.	Megamind	1	https://64.media.tumblr.com/715c0ba9daa1b48208f6b7abc280e84d/d514ba4ad34c3b60-b4/s500x750/5f65794b7bfd4feeae077b0ca16654dc8b6f8971.jpg
93dd081e-ae9d-4230-afa5-50afc3ecd99e	007a6769-ef53-4a15-ba56-45c22a232b44	2	In what city are these man-made islands found?	Dubai	1	https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcT0BRf8goWHYTeHgk6uOmrrbrkQjzuXFW_TFgHjFas30-C3vUklwTZCsnWNCPnbQrT-cZpOf2p0iSbVrP3dDhfAeCU&s=19
b9a81840-19d2-4ca9-90eb-97d14391050c	007a6769-ef53-4a15-ba56-45c22a232b44	3	What is the name of this flower? It is also the name of a character from Hunger Games.	Primrose	1	https://upload.wikimedia.org/wikipedia/commons/a/ad/Prole%C4%87no_cve%C4%87e_3.JPG
e59430e4-2538-4522-82ab-54a6fe259346	007a6769-ef53-4a15-ba56-45c22a232b44	4	What band made this 2013 album?	Artic Monkeys	1	https://i.scdn.co/image/ab67616d0000b2734ae1c4c5c45aabe565499163
d3f4136e-d770-4dae-8ff2-51c3091f4d12	007a6769-ef53-4a15-ba56-45c22a232b44	5	What is the name of this SUV?	Ford Expedition	1	https://di-uploads-pod41.dealerinspire.com/sunriseford/uploads/2024/03/2024-Ford-Expedition-2-1.jpg
37c12c30-e218-4cd9-a9b0-0ca51b80d895	007a6769-ef53-4a15-ba56-45c22a232b44	6	What is this iPhone model, a phone your trivia host had for over 5 years?\n	iPhone 4S	1	https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/12788531/iPhone4s_review1.1419962147.jpg?quality=90&strip=all&crop=0,10.558979792277,100,78.882040415445
0e6fce33-9670-41f7-a008-60873728ad08	007a6769-ef53-4a15-ba56-45c22a232b44	7	What is the name of this book, the fifth installment in A Court of Thorns and Roses by Sarah J. Maas?\n	A Court of Silver Flames	1	https://ih1.redbubble.net/image.3353396876.2384/hj,750x-pad,750x1000,f8f8f8.u9.jpg
d78f114d-3171-472e-8647-b372b74d5a10	007a6769-ef53-4a15-ba56-45c22a232b44	8	What type of apple is this, a cross between honeycrisp and enterprise apple varieties, which was bred at Washington State University?\n	Cosmic Crisp	1	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa8az-28IadoJoxc0PNFs__VXH-3o8mMW6SsJ5BAveJHdNh2n9jDNTGv6rq0II_kbD4yKEA4M90ag4I3VHr5r3lgrq1a9OIUQWRBSXRA&s=10
0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	007a6769-ef53-4a15-ba56-45c22a232b44	9	What is the super cool name of this instrument, originating down under in ancient Australia?\n	Didgeridoo	1	https://www.didgeproject.com/wp-content/uploads/2015/10/aboriginal-didgeridoo-player-1024x680.jpg
38b415db-a685-4ae3-a883-097b3d8be296	007a6769-ef53-4a15-ba56-45c22a232b44	10	What is the name of this polygon? 	Dodecahedron 	1	https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Dodecahedron.svg/1280px-Dodecahedron.svg.png
fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	962fd4a4-d0aa-4862-b4b3-99bff679844d	1	I started out this question with "I am wearing green for St. Patrick's Day today" but then I forgot to wear green so I had to change it day of. Moving on to the question: What is the name of the green Teletubby in the Teletubbies?\n	Dipsy	1	\N
e6e5c928-b872-4f49-98d2-674242dad63a	962fd4a4-d0aa-4862-b4b3-99bff679844d	2	Another character who permanently celebrated St. Patrick's Day by being colored green is Shrek. In Shrek 2, the gingerbread man is interrogated by Prince Charming about the whereabouts of The Muffin Man, and he tells him that the Muffin Man lives on which street, the same street the muffin man lives on in the nursery rhyme?\n	Drury Lane	1	\N
1dbd5c29-52c7-449b-865d-ab3a72d6d527	962fd4a4-d0aa-4862-b4b3-99bff679844d	3	Today is a green day, and so this question is about Green Day. What is the name of the lead singer of Green Day?\n	Billie Joe Armstrong	1	\N
2f3eb3fc-4131-4a33-bd20-ef47c684fd28	962fd4a4-d0aa-4862-b4b3-99bff679844d	4	Every year the Chicago River is dyed green for St. Patrick's Day, and they have a secret formula to make it (allegedly) safe and stuff. But did you know in 1900 the city of Chicago permanently reversed the flow of the Chicago River, making it flow away from Lake Michigan instead of into it. Trivia Question: The Amazon River used to flow from East to West, until a certain mountain range rose up and eventually reversed the direction. What mountain range is this?	Andes	1	\N
7052e44a-7137-4e7e-8827-358e304e7979	962fd4a4-d0aa-4862-b4b3-99bff679844d	5	What is the capital and most populous city of Greenland, encompassing over a third of the entire Greenland population?\n	Nuuk	1	\N
8a65e25c-ecb4-4775-9b88-7fd8c47df896	962fd4a4-d0aa-4862-b4b3-99bff679844d	6	Frankenstein was of course written by the goat, Mary Shelley. Tuesday Trivia has already asked about the best-selling author of all time, Agatha Christie (I don't count Shakespeare). So instead we ask who is the second best-selling author of all time (according to Wikipedia)? She was nicknamed "The True Queen of Romance", was the step-grandmother of the late Princess Diana, and titled her first novel "Jigsaw".	Barbara Cartland	1	\N
30294dd1-3e35-40ff-91b6-24c7401e62de	962fd4a4-d0aa-4862-b4b3-99bff679844d	7	The best green fruit is kiwifruit, which actually was introduced to New Zealand in the 1900s and is not endemic to New Zealand. What country is the kiwifruit (or kiwi) actually native to?	China	1	\N
078e3c1f-6483-4869-a131-39c12603610e	962fd4a4-d0aa-4862-b4b3-99bff679844d	8	On season 1 of Sesame Street, Oscar the Grouch was actually colored orange, before being changed to green permanently after season 1. What object does Oscar the Grouch live inside?	Trash can	1	\N
5a67bdb8-0b53-4496-a673-dc84506fe252	962fd4a4-d0aa-4862-b4b3-99bff679844d	9	In the Great Gatsby, the obsessive Gatsby looks at Daisy's green light on her dock every single night for years. What was the name of Daisy's husband in The Great Gatsby?	Tom Buchanan	1	\N
c4453ccd-cf24-46fb-9d4a-7c2d0c155523	962fd4a4-d0aa-4862-b4b3-99bff679844d	10	The famous McDonald's Shamrock Shake was created in 1967 in what US state, also the home of our very own Nutmegger, Becca Lubbert?	Connecticut	1	\N
3073cbaa-3795-4e57-8e77-e78c7b21c79d	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	1	General Tso's chicken briefly graced the buckets of Panda Express and perhaps will return some time. Zuo Zongtang, also called General Tso, led the Qing Dynasty in the 1880s in recapturing what Northwest Chinese province, the largest in China by land area, which is largely desert and mountainous regions?	Xinjiang	1	https://shared.prolewiki.org/uploads/thumb/9/91/Xinjiang_map.svg/800px-Xinjiang_map.svg.png
5e97fc52-dff6-4b5b-812e-d55d34894a0f	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2	What civil war general has the biggest tree in the world named after him? Hint: this tree was on a previous Tuesday Trivia round back before season 1.\n	General Sherman	1	\N
b9064a92-8b82-4e6c-9062-20aff438d14b	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	3	"The Pirates of Penzance" was a late 1800s opera that featured the character Major-General Stanley as the comic relief, and a Broadway musical spinoff was made in 1981, winning a Tony Award for Best Revival. "Pirates! The Penzance Musical" was again a Tony nominee in 2025 for Best Revival, losing out to what Andrew Lloyd Weber musical, which in 1995 won The Tony for Best Musical, Best Score, and Best Book, is based on a 1950 movie, and the opening scene begins with a man floating dead in a swimming pool?	Sunset Blvd.	1	\N
6dbee58f-fc8a-4a82-886b-284f25399865	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	4	In the 1980s, General Mills owned Red Lobster along with what "family" oriented Italian-American restaurant?	Olive Garden	1	\N
36c14939-ae1b-41b7-ac59-13c044a8a978	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	5	The greatest name in college football history is, of course, held by former Oklahoma Sooners backup QB General Booty, who played in two total games for Oklahoma. Shannon Lucid earned a PhD in Biochemistry from Oklahoma University and set the record in 1996 for most days in space by a woman, staying for 188 days aboard what Russian space station?	Mir	1	\N
2e5cfb37-9c7a-4077-b0bf-0aef14ce7f7d	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	6	The Surgeon General position is currently vacant, but who is commonly referred to as the world's first surgeon, often called "The Father of Surgery", an Indian man who invented rhinoplasty and lived around 600 CE?\n	Sushruta	1	\N
d0a3429e-a8aa-4825-913a-1d65dc38b1af	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	7	At 97 million listens, The General (1997) is the most listened to song on Spotify for what Boston indie/roots band, the first independent band to sell out Madison Square Garden?	Dispatch	1	\N
5e542a3f-0e72-4eb2-a82f-880d09aa4bd2	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	8	General Electric was split up in 2024. What man grew up with no education, taught himself to read and write, and then in 1821 discovered the foundation for electrical generators by moving a magnet through a coil of wire? He has a electrochemical constant named after him, represented by the symbol F, which is the total electric charge carried by one mole of electrons. 	Michael Faraday	1	\N
3bb21b7a-b2d6-4ad5-8c20-04140272a2b7	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	9	I have much bemoaned the Daily Tens site for errant data and unfun questions. However, I am taking a page out of their book with this one: What US state has the most Dollar General stores with 1755 stores?\n	Texas	1	\N
18c15d90-1b14-41fa-bbab-43d115f5fd65	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	10	What TV show fits the category and has aired on ABC for 62 straight years, is the longest running American soap opera, holds the record for most Daytime Emmy Awards for Outstanding Drama Series, and was the most watched event in daytime television history in 1981?\n	General Hospital	1	\N
20aff4c5-ea2d-4e3c-ad6a-de7bd5163415	5f134cdc-1b49-4cd6-b608-810bb6a1107a	1	This is the dress that caused massive online controversy in 2015, what are the actual colors of "The Dress"?\n	Blue and Black	1	https://upload.wikimedia.org/wikipedia/en/2/21/The_dress_blueblackwhitegold.jpg
20813146-dfcc-4e30-96ec-e2cd449173c1	5f134cdc-1b49-4cd6-b608-810bb6a1107a	2	White to move. What is the best move for white?	Qxf7#	1	https://chessify.me/media/uploads/easy_10-min.jpg
a3839c38-6697-4cdc-a0cf-e81472d43764	5f134cdc-1b49-4cd6-b608-810bb6a1107a	3	In this human eye diagram, what is #9 pointing to? This is also the reason you have a blind spot when you use only one eye.	Optic nerve	1	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjFRrqVTUXS5v3R_eBvkoxYEj_yYIhGNFEJA&s
563ab383-4af9-4a26-b9a1-bcd48588f74b	5f134cdc-1b49-4cd6-b608-810bb6a1107a	4	What Dutch artist painted this in the late 17th century?	Johannes Vermeer	1	https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/1665_Girl_with_a_Pearl_Earring.jpg/1280px-1665_Girl_with_a_Pearl_Earring.jpg
2d227fad-5b02-4de7-80f3-41645f67fe2e	5f134cdc-1b49-4cd6-b608-810bb6a1107a	5	What is the only landlocked country in Southeast Asia, shown here?	Laos	1	https://cod.pressbooks.pub/app/uploads/sites/89/2021/09/Laos_GlobeWiertz.jpg
c1f7b444-2582-476d-a45b-c6ce55f80029	5f134cdc-1b49-4cd6-b608-810bb6a1107a	6	What woman scored the game-winning penalty shootout goal to win the 1999 Women's World Cup and become the star one of the most iconic sports photographs of all time?	Brandi Chastain	1	https://i.guim.co.uk/img/media/d17970383ec1ef5a8c174d01a7191276f85d4650/318_363_3213_1927/master/3213.jpg?width=1200&quality=85&auto=format&fit=max&s=80bb59310cad0b0fceb20d3f7eee45d6
e7be2273-1eb4-432d-9dbf-14cdb52f4287	5f134cdc-1b49-4cd6-b608-810bb6a1107a	7	What animal, shown here, is native to central Africa and is the closest living animal to a giraffe? The St. Louis Zoo, one of the top zoos in the world for animal conservation research, says: "[these animals] live a quiet life in the lush rainforest. Their velvety dark striped coats create an almost perfect camouflage in the low light of the forest understory, and their keen hearing helps them detect predators at a far distance."	Okapi	1	https://www.marylandzoo.org/wp-content/uploads/2017/10/okapi_web.jpg
1b1b2df6-4e6a-4df1-bbde-eccb060742f1	5f134cdc-1b49-4cd6-b608-810bb6a1107a	8	What is the name of this french fry, cheese curd, and gravy dish, eh?	Poutine	1	https://hips.hearstapps.com/hmg-prod/images/poutine-1672765911.jpg?crop=0.8887179487179486xw:1xh;center,top&resize=1200:*
ae8c51b3-8ba8-402d-8dd3-6842f2c901e1	5f134cdc-1b49-4cd6-b608-810bb6a1107a	9	Who painted this self-portrait?	Frida Kahlo	1	https://sonyawinner.com/wp-content/uploads/2025/01/Frida-Kahlo-Self-Portrait-.jpg
d16077b1-887a-4dac-adc5-56e9360714b0	5f134cdc-1b49-4cd6-b608-810bb6a1107a	10	In NFL football, how many points are awarded when the referee does this signal?	2 points	1	https://archive.jsonline.com/Services/image.ashx?domain=www.jsonline.com&file=b99100396z.1_20130918000438_000_g8l2i50d.1-2.jpg&resize=660*579
\.


--
-- Data for Name: score_edits; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.score_edits (id, submission_id, question_id, old_points, new_points, reason, edited_by_id, edited_at) FROM stdin;
ebbfd811-5c75-46e6-8b69-e4053d6a1630	aee07542-11df-4bf4-a228-f7e11da5009f	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:23.814817
c3544b81-b153-46f7-95a7-975666d153e1	aee07542-11df-4bf4-a228-f7e11da5009f	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:23.874487
b8e063de-844c-40a0-b02e-7026b57a6bda	aee07542-11df-4bf4-a228-f7e11da5009f	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:23.918733
3a439743-48be-4d77-9bdf-175e595dfd84	aee07542-11df-4bf4-a228-f7e11da5009f	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:23.986333
ef78c8d0-df07-4f08-86c6-460c39706a59	aee07542-11df-4bf4-a228-f7e11da5009f	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.028476
028d384d-2e16-46a2-9770-5b80cdfcf07a	aee07542-11df-4bf4-a228-f7e11da5009f	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.072868
4aa41a7a-4262-4425-885f-088de1648e9f	aee07542-11df-4bf4-a228-f7e11da5009f	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.117043
9f677d6c-f229-4ef0-af0a-56a1dfba572c	aee07542-11df-4bf4-a228-f7e11da5009f	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.159769
e0304aee-375c-47db-ae92-d3e8feab75c1	aee07542-11df-4bf4-a228-f7e11da5009f	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.203091
f96858af-3fca-4dee-b26e-192bc51ec458	fd339ac5-cfc9-45c6-888a-8028f34879ec	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.291454
1bdf60d0-7d4d-40d2-bc28-e7863318f0f8	fd339ac5-cfc9-45c6-888a-8028f34879ec	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.3341
f15416a0-b33b-4b94-a3e7-a05775e258e8	fd339ac5-cfc9-45c6-888a-8028f34879ec	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.376509
ed9928ac-fb7a-484b-8df9-c190c36a0ad0	fd339ac5-cfc9-45c6-888a-8028f34879ec	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.418337
e63c3119-5709-47e1-8f03-c6a2ba2ba002	fd339ac5-cfc9-45c6-888a-8028f34879ec	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:24.503833
7347704a-ec3a-4fff-a3c7-40f4dc827e5d	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.01543
355bec98-2082-4348-adc1-fcc9526692ed	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.058366
991822ba-a527-4816-bf18-baca8d1274e5	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.101386
0c7fe2de-f9fb-448c-995e-e6d7427a556c	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.143941
efa809d4-6b2c-45e7-acd9-4b52b73b8834	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.186564
1380e75f-4ee9-4eeb-a154-4af8323f6c8d	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.229022
51aeb653-4d38-45dd-9dbb-68b07de5a8bb	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.271688
5291692d-8ec3-430e-9866-e66731b7dbea	c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.358408
feae4343-d866-47dd-aa02-3fa107c2bf54	af40f930-138a-4df4-a537-15bc309386a3	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.401563
39159bbb-c4fa-478a-ac13-aceb4381ca21	af40f930-138a-4df4-a537-15bc309386a3	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.443798
6b4d2c1b-f6d2-43ab-866d-c2fcd2706cbb	af40f930-138a-4df4-a537-15bc309386a3	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.485753
5d46fe17-9c25-42fc-948b-abacfecfda05	af40f930-138a-4df4-a537-15bc309386a3	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.52853
86db3756-0b1c-4969-9176-58843a1916a4	af40f930-138a-4df4-a537-15bc309386a3	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.570741
be497e14-0dea-45d1-991a-c30c298d2c53	af40f930-138a-4df4-a537-15bc309386a3	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.612617
4e8b24cd-f6df-419f-9d63-8c9725652428	af40f930-138a-4df4-a537-15bc309386a3	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.660953
01af1dc9-881c-4b76-8fee-041f43b8fc56	af40f930-138a-4df4-a537-15bc309386a3	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.703765
1bd3b40e-9fb7-438f-af09-7482e9beac73	af40f930-138a-4df4-a537-15bc309386a3	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.746047
d240d499-731d-4e4e-af4d-805528250c2b	af40f930-138a-4df4-a537-15bc309386a3	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.788967
af0f88c5-ee9e-4717-b8a3-4d607a69e794	af2179b0-d768-4c8f-9d26-abb437862899	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.831792
db70d9c9-2021-4338-9b31-02c910df64f1	af2179b0-d768-4c8f-9d26-abb437862899	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.875238
65fed0db-de13-4be3-943e-87be9edecd69	af2179b0-d768-4c8f-9d26-abb437862899	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:25.960732
e9767b89-6480-440e-9612-775fbffdd122	af2179b0-d768-4c8f-9d26-abb437862899	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.002571
2287dc16-757b-42f2-9fdd-734c29bdea09	af2179b0-d768-4c8f-9d26-abb437862899	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.044658
b2b19345-293f-4f8f-ba80-c7cf32d4cb4a	af2179b0-d768-4c8f-9d26-abb437862899	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.111579
62c247f2-c188-42ea-9c49-957f577a9c4d	48e5624f-068d-4694-aca7-4041b607aa79	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.444019
9ebe4333-9449-4e2f-bc29-5a9544932994	48e5624f-068d-4694-aca7-4041b607aa79	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.486589
f6bff64b-c4a6-47f7-8440-a443aab48cc9	48e5624f-068d-4694-aca7-4041b607aa79	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.528644
2f8605d2-8cb4-4658-8be3-82873fdeb722	48e5624f-068d-4694-aca7-4041b607aa79	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.570913
783cc1dd-475f-40fd-bc81-5380cf295aed	48e5624f-068d-4694-aca7-4041b607aa79	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.612923
d392a722-4b37-4878-a7ea-b1fabcfea8c2	48e5624f-068d-4694-aca7-4041b607aa79	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.667648
c4a58e9b-93cb-466e-a68a-d99a523c25a7	48e5624f-068d-4694-aca7-4041b607aa79	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.710749
16d9a599-9f6a-4654-83c7-99637970fac9	48e5624f-068d-4694-aca7-4041b607aa79	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.752565
d2afb554-ce34-4704-9f3f-086753902053	48e5624f-068d-4694-aca7-4041b607aa79	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.794337
d1278e25-6835-4742-a87f-ac1a5aaddbec	acef5f06-c17a-49b7-8f92-d55f6bc3846f	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.856663
0aa12da0-7d8b-441a-87d6-60fd5e71cfd0	acef5f06-c17a-49b7-8f92-d55f6bc3846f	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.940895
65269260-ecf0-4441-8e4f-49e72c0d903c	acef5f06-c17a-49b7-8f92-d55f6bc3846f	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:26.982399
9030cc64-57b0-4ba4-9e2b-304aaf1f8aaf	acef5f06-c17a-49b7-8f92-d55f6bc3846f	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.024573
937e8367-06ae-4c3d-808c-0c4166c30a9d	acef5f06-c17a-49b7-8f92-d55f6bc3846f	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.066338
f00f85a3-289b-4a2c-940f-e2c61f454dff	acef5f06-c17a-49b7-8f92-d55f6bc3846f	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.107986
5686fe49-82d8-4249-b948-a446a12704a9	acef5f06-c17a-49b7-8f92-d55f6bc3846f	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.15043
0a754489-35f8-49f7-9e00-8a06164a5af5	acef5f06-c17a-49b7-8f92-d55f6bc3846f	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.193827
6c3fff7b-b2bf-450e-970c-f7de0223c4e6	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.277251
aef11627-9a10-430d-9dba-024a25c7342f	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.319693
54460eb1-ec1b-4b50-bc71-d05c360053ea	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.362168
bc1f548e-b562-4850-96c6-daf716621a15	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.403706
1a4907ee-87cb-4fc4-94b3-7f25f8c170d8	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.445278
73240427-bbd6-4a94-bc65-d022055b030e	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.487175
befcbdbb-5e00-4488-8560-31f60b146945	77e2006b-9806-48ed-a5f1-5ff5515f2bd0	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.529158
d746dff8-57aa-4526-9b8a-beb0d9f91c2d	839176b9-558e-43c6-a1eb-47f16269e4db	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.592461
ebc7c25c-1b7b-49fd-8ee0-8ab08af1840d	839176b9-558e-43c6-a1eb-47f16269e4db	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.655332
6292b348-5706-409a-b21a-4e52341a9a36	839176b9-558e-43c6-a1eb-47f16269e4db	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.697557
d07ec11b-2191-483f-9f4c-1b95c1f9454c	839176b9-558e-43c6-a1eb-47f16269e4db	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.760225
8bfdb129-89f4-4c4d-ad2b-8842f2998393	839176b9-558e-43c6-a1eb-47f16269e4db	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.802444
bffdc134-e84e-444d-b405-54fa109a16e0	839176b9-558e-43c6-a1eb-47f16269e4db	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.845406
d27dbc9e-0f07-413d-af52-13a207ac3e9f	839176b9-558e-43c6-a1eb-47f16269e4db	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.887077
326181ed-7e03-4757-b751-0c1ee97e28de	eed34ef9-492e-455b-bc38-26568b1dccee	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:27.950359
a73a02e7-adcb-46fb-a0e8-5d4a40b1b0d9	eed34ef9-492e-455b-bc38-26568b1dccee	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.076536
305911aa-1741-4d75-a84c-2b19c952aedf	eed34ef9-492e-455b-bc38-26568b1dccee	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.118204
f4c7cf84-998e-45fc-9b33-6b9afe625e43	eed34ef9-492e-455b-bc38-26568b1dccee	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.159757
ee8e521f-cd94-4337-9e23-f0e39799f944	c41035c1-6eaf-4a48-9c97-6ea86861575d	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.244545
56dd3345-cd1a-4a8d-a49a-ec066cb6977e	c41035c1-6eaf-4a48-9c97-6ea86861575d	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.286541
765322e2-abc3-4822-919e-172010b6dce3	c41035c1-6eaf-4a48-9c97-6ea86861575d	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.349761
f0fd1294-d6b2-4689-92ac-4e6d2fd526df	c41035c1-6eaf-4a48-9c97-6ea86861575d	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.391692
6d3c4738-0f9f-4541-bee8-7fc190c1b7ac	c41035c1-6eaf-4a48-9c97-6ea86861575d	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.433542
64b7b288-2232-4737-b6fb-6ace083ed856	c41035c1-6eaf-4a48-9c97-6ea86861575d	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.479168
62e5d618-40b7-4297-9e4f-0d0dd8ad275a	c41035c1-6eaf-4a48-9c97-6ea86861575d	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.52159
5cedbd72-19ee-4566-bf0a-0ddbf86b4da4	f0feddb4-ef0d-454e-8052-2b11b39d89d8	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.60496
f0828ce7-7df0-4768-bcd4-b8e7e9bf3fd8	f0feddb4-ef0d-454e-8052-2b11b39d89d8	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.646719
82ea0897-fd07-4e0f-b4e1-fefb263e1a99	f0feddb4-ef0d-454e-8052-2b11b39d89d8	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.688636
88601789-25dd-46b3-8f8c-39903cc4013e	f0feddb4-ef0d-454e-8052-2b11b39d89d8	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.731032
3f07d80e-d9a3-4646-aed9-35c81cdd43b1	f0feddb4-ef0d-454e-8052-2b11b39d89d8	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.773721
e113fa94-b6a8-4996-a6cc-89e2aed1b754	f0feddb4-ef0d-454e-8052-2b11b39d89d8	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.815563
dbeb5b9f-cafa-41bb-82c6-c264c62bccf2	f0feddb4-ef0d-454e-8052-2b11b39d89d8	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.85794
c1e81cbb-55fb-489a-857d-2c76f862db1f	f0feddb4-ef0d-454e-8052-2b11b39d89d8	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.899963
5d48e063-2bcc-40ef-a9c1-b6219e6bd511	f0feddb4-ef0d-454e-8052-2b11b39d89d8	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.943567
dcb2aad5-cea5-4c5b-a23e-ee1a19d78682	f0feddb4-ef0d-454e-8052-2b11b39d89d8	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:28.985768
16dd5d34-26eb-4fcf-9c2a-5fa1ab840fa1	3f3a4921-8639-4f9c-8358-e366c38b18e9	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.0285
43d36536-af38-4cd8-bedf-10b9a71986b7	3f3a4921-8639-4f9c-8358-e366c38b18e9	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.070536
9da9a22d-0b9c-4ab3-bcca-3f7299261dc8	3f3a4921-8639-4f9c-8358-e366c38b18e9	5182d01b-0798-48f5-9087-40969a5d641e	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.113117
e2a45383-3cd0-4245-a72a-6b35e2423ea0	3f3a4921-8639-4f9c-8358-e366c38b18e9	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.155134
05ff215e-a5af-45ee-b51b-db781f376fc2	3f3a4921-8639-4f9c-8358-e366c38b18e9	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.200309
520965d2-e38a-4bd9-abc9-d0fadcebd074	3f3a4921-8639-4f9c-8358-e366c38b18e9	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.242919
f67338af-d85e-4b09-b4cb-62899a45556d	3f3a4921-8639-4f9c-8358-e366c38b18e9	eef09846-d717-48e6-838d-30af16c6dda2	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.284911
aeee7dda-c009-4e2a-ad99-bf2956fc5be8	3f3a4921-8639-4f9c-8358-e366c38b18e9	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.326651
84aadac1-f31a-4693-976b-0b57ee055c77	3f3a4921-8639-4f9c-8358-e366c38b18e9	0d21d6f7-63b1-4758-a746-fbaf6871747a	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.368579
ace5b7ba-fff8-456f-9f92-846e6ae578d1	3f3a4921-8639-4f9c-8358-e366c38b18e9	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.410816
dd338780-6986-4e6c-9b73-557980cdbc0b	bee362a7-4dd6-4227-904e-bfa3c3b44908	1fbd051a-9a46-4743-8e32-f2b064edd9a6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.452567
8b33ca9e-640e-4a7a-8180-17d2d277e398	bee362a7-4dd6-4227-904e-bfa3c3b44908	3a08309f-da7d-4a81-b973-049736e0ef69	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.494671
08c2b45a-8bac-4f9a-bfe3-4d01547588ba	bee362a7-4dd6-4227-904e-bfa3c3b44908	a362d4d9-6e56-4e50-8dc0-45935ed91a11	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.558705
743a0b4a-e670-48fe-960e-4ae1e108c6ee	bee362a7-4dd6-4227-904e-bfa3c3b44908	265c8bcf-d174-40ce-a3ef-231fc92c61e7	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.60229
0f27204f-de09-4e11-a5f4-6288ae29fe2e	bee362a7-4dd6-4227-904e-bfa3c3b44908	5fef51d9-0ae0-430f-9f8c-f3e9ab7eabb3	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.647801
190e4bd9-a668-46c8-96d4-827efed45964	bee362a7-4dd6-4227-904e-bfa3c3b44908	59ecebed-dcf9-4ea2-b48e-b01eae1a4ba6	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.7126
b7f7f366-7e94-4dd7-81cb-6de075e06830	bee362a7-4dd6-4227-904e-bfa3c3b44908	dbd581c6-c54f-4aa1-9189-0de6967efdaf	0.0	1.0	Updating all teams scores	105d5877-be9c-418c-8bad-46832e21f536	2026-03-10 18:14:29.77609
c97ab117-8c8e-4c09-a181-f63d1a404753	dc91f88c-a26e-4b94-b649-0255795b43d6	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.10643
9fd60a20-baed-4608-92c8-90f9c513e2e1	dc91f88c-a26e-4b94-b649-0255795b43d6	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.17625
c2c9146e-41f5-4d22-8ae5-1aa3d1a62b15	dc91f88c-a26e-4b94-b649-0255795b43d6	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.22598
2abcf8fe-7446-423e-9446-5761ad1a8eb6	dc91f88c-a26e-4b94-b649-0255795b43d6	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.272846
fa623b94-a663-49cc-a28a-c62d3c091300	dc91f88c-a26e-4b94-b649-0255795b43d6	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.466298
503082a5-8157-4f72-b20b-0c496358e650	dc91f88c-a26e-4b94-b649-0255795b43d6	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.534325
a237cb01-7c7e-4a12-a99f-c2db3c114dad	1de93da7-5250-4050-9aa5-396db4430920	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.583837
16bccfde-3a49-4b6d-b71b-9e030d167905	1de93da7-5250-4050-9aa5-396db4430920	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.688639
8e4e2c34-c035-490c-a02e-1235c96f8749	1de93da7-5250-4050-9aa5-396db4430920	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.835595
9d9e7857-c2a4-46f8-81e6-31bc23a025d2	1de93da7-5250-4050-9aa5-396db4430920	d3f4136e-d770-4dae-8ff2-51c3091f4d12	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:41.915677
6abc9418-235a-4084-8bb2-bd52e12fd8ae	1de93da7-5250-4050-9aa5-396db4430920	0e6fce33-9670-41f7-a008-60873728ad08	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.044715
56edd1ed-b226-41e2-a3aa-95d9f3c88528	1de93da7-5250-4050-9aa5-396db4430920	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.164552
c22265a0-5cca-4231-b54f-cba50f282b5e	1de93da7-5250-4050-9aa5-396db4430920	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.248846
072fde1d-bc0d-40e5-b22b-77e77606703f	fa9f16ef-ee61-4724-b74c-a1a59bbde834	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.320945
047c4bb0-94fb-47c5-8597-506ab7f851de	fa9f16ef-ee61-4724-b74c-a1a59bbde834	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.391325
e05d175d-0725-4d8d-9ad6-147cda649fdb	fa9f16ef-ee61-4724-b74c-a1a59bbde834	0e6fce33-9670-41f7-a008-60873728ad08	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.498168
0fbf0d1e-b018-46ed-85d6-5cbf53a7637b	fa9f16ef-ee61-4724-b74c-a1a59bbde834	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.569282
16eab15b-7c37-4181-a034-bf6fd1592646	9efe45f9-c782-40ea-b789-681ed7c82095	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.648681
13259013-28c8-4513-8848-3228b2fe3b36	9efe45f9-c782-40ea-b789-681ed7c82095	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.707987
d0ff7fc5-6bc4-4503-840d-a8b54eceb23a	9efe45f9-c782-40ea-b789-681ed7c82095	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.754292
18aca204-55e9-4227-83be-81d59293fc09	9efe45f9-c782-40ea-b789-681ed7c82095	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.853055
4dd37ba4-1abb-47d9-a853-051e9f056157	9efe45f9-c782-40ea-b789-681ed7c82095	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:42.898645
de65dc73-5d86-4afd-bb2b-5a69755629ef	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.052314
db54325e-0cda-43b8-8c4b-c64937722418	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.113549
7b9ca4c9-62c7-4969-8b31-b788f68b6065	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.163046
474a90ed-1fac-4e57-8cf2-58e334835d3d	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	d78f114d-3171-472e-8647-b372b74d5a10	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.295974
f2424e3d-78f5-4b7d-8aa5-423b8627934a	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.354998
b00f8246-d8fb-492f-b1c4-ea016644a72a	3efabaa1-98cb-4f6f-a538-6e7107c6dd25	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.412778
7296829f-e395-4e63-84ea-c4b8b14a8217	bbeeb813-d9dc-4da7-b86a-a08b81089a20	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.458857
8c209e63-eb15-4e28-ba35-a742d685f6de	bbeeb813-d9dc-4da7-b86a-a08b81089a20	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.507543
3afd5033-b2e2-4723-853a-ab1fbe360a74	bbeeb813-d9dc-4da7-b86a-a08b81089a20	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.553868
fb8d2f77-9c25-4e4a-91d8-1d3482b4382e	bbeeb813-d9dc-4da7-b86a-a08b81089a20	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.600538
654ce559-f095-4e4d-ac63-e7dffc328e5c	bbeeb813-d9dc-4da7-b86a-a08b81089a20	d3f4136e-d770-4dae-8ff2-51c3091f4d12	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.647676
59c136e3-6005-445f-bf87-7a1243425394	bbeeb813-d9dc-4da7-b86a-a08b81089a20	0e6fce33-9670-41f7-a008-60873728ad08	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.721546
1fe83e0a-afd0-4822-83cf-b08cef2a9bde	bbeeb813-d9dc-4da7-b86a-a08b81089a20	d78f114d-3171-472e-8647-b372b74d5a10	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.768377
4199e945-0acc-4497-bfa6-5df284c2701d	bbeeb813-d9dc-4da7-b86a-a08b81089a20	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.818016
b9a42cab-c10c-4c49-b50e-c1205f9c0edc	2852dcf2-331b-4d54-9bbc-1a734535da1c	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.894354
62f78eda-2df6-4935-b860-a68a8c3564b7	2852dcf2-331b-4d54-9bbc-1a734535da1c	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.94196
96647223-73d2-4a47-98de-e533ae6624f2	2852dcf2-331b-4d54-9bbc-1a734535da1c	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:43.997609
bf14cb60-7b12-43f1-a472-8653f8f3adf5	2852dcf2-331b-4d54-9bbc-1a734535da1c	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.048873
51a5ccac-c9db-42fc-b9d3-00c80f5fe5cf	2852dcf2-331b-4d54-9bbc-1a734535da1c	d3f4136e-d770-4dae-8ff2-51c3091f4d12	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.106383
35b9b8d7-5a35-434f-8fc5-e321fc759ed8	2852dcf2-331b-4d54-9bbc-1a734535da1c	0e6fce33-9670-41f7-a008-60873728ad08	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.180208
73242d7b-9969-491b-b214-621182a62eb6	2852dcf2-331b-4d54-9bbc-1a734535da1c	d78f114d-3171-472e-8647-b372b74d5a10	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.244035
56002db6-45be-4913-a346-be925cd07f58	2852dcf2-331b-4d54-9bbc-1a734535da1c	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.409986
7f8f7669-8367-40fa-95e9-0b756812d07b	2852dcf2-331b-4d54-9bbc-1a734535da1c	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.51529
27e40aeb-83b0-4967-b86e-1813c3dd1d5c	20f38dcb-9515-4149-a3c5-df9db702352f	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.599655
dd86fd5c-c8b8-4403-a209-e0c027aae641	20f38dcb-9515-4149-a3c5-df9db702352f	93dd081e-ae9d-4230-afa5-50afc3ecd99e	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.647656
4ef9aad6-49a8-47bf-90af-15a182b8093a	20f38dcb-9515-4149-a3c5-df9db702352f	e59430e4-2538-4522-82ab-54a6fe259346	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.739574
6ad39ef6-e8a6-43f5-a04b-042c1e65496f	20f38dcb-9515-4149-a3c5-df9db702352f	d3f4136e-d770-4dae-8ff2-51c3091f4d12	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.792091
fd3e6ab6-595f-4ce6-b479-b5ddada165b9	20f38dcb-9515-4149-a3c5-df9db702352f	d78f114d-3171-472e-8647-b372b74d5a10	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.906833
79048503-95d8-49e0-bf13-028335e447aa	20f38dcb-9515-4149-a3c5-df9db702352f	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:44.958536
4db548c4-c047-4b3e-9292-b60120284d92	20f38dcb-9515-4149-a3c5-df9db702352f	38b415db-a685-4ae3-a883-097b3d8be296	0.0	1.0	New team entries	105d5877-be9c-418c-8bad-46832e21f536	2026-03-17 18:10:45.004878
fb2e5b75-199a-4bcf-a3a3-e8ca3cd17de5	8ebcbd57-0684-4908-85e9-c3088cc83832	eec9096b-2e69-40b5-a334-8169c5c885d5	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.430537
3e35bdba-afe6-428e-984d-59ade1419f4f	8ebcbd57-0684-4908-85e9-c3088cc83832	e8528d5a-bf83-4c9b-ba96-92e39f204b75	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.483302
6b303065-afca-495f-a689-f7519fe571d4	8ebcbd57-0684-4908-85e9-c3088cc83832	31e8e209-48ff-49eb-8891-50445e1b0456	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.529608
9e4f5a4e-c270-4a31-b785-b7e66122e045	8ebcbd57-0684-4908-85e9-c3088cc83832	0bf4fe0b-3a4e-4b03-be5b-f0df69b339d6	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.575197
9c994f5f-2be0-48c2-a477-5c17b75c245a	8ebcbd57-0684-4908-85e9-c3088cc83832	6541051c-0452-492d-b054-9a1040393283	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.621263
0005321f-de3a-4263-8c48-e643dcb783eb	8ebcbd57-0684-4908-85e9-c3088cc83832	11c321e5-1143-4634-aa20-27a025c3e47e	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.693943
cb0a76e4-5898-4107-8a3d-fffe9a47b03f	8ebcbd57-0684-4908-85e9-c3088cc83832	4f907b77-fa2a-43c9-a20b-cf25754566fc	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.739791
01736e27-9683-462a-9b98-50cca06e918a	8ebcbd57-0684-4908-85e9-c3088cc83832	b99de020-d815-4cdc-b389-e73aa2b34250	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.785377
ce02116b-9bc3-405c-b0aa-600b006205d9	8ebcbd57-0684-4908-85e9-c3088cc83832	12914612-937e-425f-bfd2-bb3886c6f5ad	0.0	1.0	Entering Carbon Offset This score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:39:00.831326
608cbb7e-edc3-4588-918d-8a79ba836e4b	86d47cae-e1c1-41c1-8192-23cb607b0504	f52b9382-9b85-4a9f-9749-cf96a0a2fd89	0.0	1.0	entering World Wide Buffalos score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:40:21.923051
c9e514d6-68f4-4010-91a5-02ccc360ef2d	86d47cae-e1c1-41c1-8192-23cb607b0504	b9a81840-19d2-4ca9-90eb-97d14391050c	0.0	1.0	entering World Wide Buffalos score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:40:21.998557
b7b8be66-5aaa-42da-935b-00d3c69cc9c4	86d47cae-e1c1-41c1-8192-23cb607b0504	d3f4136e-d770-4dae-8ff2-51c3091f4d12	0.0	1.0	entering World Wide Buffalos score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:40:22.07025
6bc70e49-8f5d-448c-b99d-a568d76df8e4	86d47cae-e1c1-41c1-8192-23cb607b0504	d78f114d-3171-472e-8647-b372b74d5a10	0.0	1.0	entering World Wide Buffalos score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:40:22.164348
17ef31ba-8fb0-4d8e-9c09-5c7fecea30b1	86d47cae-e1c1-41c1-8192-23cb607b0504	0cb6f13f-15f7-41dd-9aba-b6a86dd33e66	0.0	1.0	entering World Wide Buffalos score	105d5877-be9c-418c-8bad-46832e21f536	2026-03-18 20:40:22.211962
6debfe3b-62f1-4d90-9d89-211bab4a6829	86d47cae-e1c1-41c1-8192-23cb607b0504	37c12c30-e218-4cd9-a9b0-0ca51b80d895	0.0	1.0	World Wide Buffalos change	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 15:12:10.949367
dea57ebd-c0c1-44db-82da-b433d2dbcf8e	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	Didn't upload correctly	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:33:14.713565
2711396a-a35d-4718-a686-533b51a586bb	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	Didn't upload correctly	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:33:14.782859
5ed19c50-959f-498c-a04a-634f2d9f77de	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	Didn't upload correctly	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:33:14.826991
10067917-aac6-4e8a-a7a0-61b548f95007	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	Didn't upload correctly	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:33:14.892299
13c81e53-e4f5-4c35-8d1b-4070e13dbff0	90ec5ba1-80ba-488b-b601-bd32b22f4bb3	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	Didn't upload correctly	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:33:14.935693
6e872a98-9444-4743-8107-c914f362d2ab	008b097f-27aa-4057-9163-ed8caa0e321d	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:07.757791
5e5b96a1-815e-4025-95af-f4be5d53cf4c	008b097f-27aa-4057-9163-ed8caa0e321d	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:07.810094
0060688c-d05e-42e8-99ad-26009e3e216b	008b097f-27aa-4057-9163-ed8caa0e321d	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:07.873613
8024fadf-393f-4a35-959a-083c6455aef4	008b097f-27aa-4057-9163-ed8caa0e321d	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:07.914876
8dd71f7c-4ed4-47ba-8317-6b18da74430c	008b097f-27aa-4057-9163-ed8caa0e321d	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:07.977742
f4b5334b-8d6c-41fd-ba07-cf48fbf953be	008b097f-27aa-4057-9163-ed8caa0e321d	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:08.019365
b3f45723-b7e6-405b-bf98-0ce2dddb50ff	008b097f-27aa-4057-9163-ed8caa0e321d	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:08.062573
c98dfd78-964d-446b-86b5-c6cf1cc66dc4	008b097f-27aa-4057-9163-ed8caa0e321d	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	Save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:08.107323
a42e4a91-db3e-44f1-a762-2f6c0ae8e290	3b68f8bb-589a-480b-bb39-cb47124f9680	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:24.795731
59983546-a256-4aec-9955-ae611707eecf	3b68f8bb-589a-480b-bb39-cb47124f9680	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:24.844336
27d925bf-986f-4af6-81d7-ee410995e039	3b68f8bb-589a-480b-bb39-cb47124f9680	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:24.888189
8d5f841d-7916-44a7-ab5d-6606c92b2cda	3b68f8bb-589a-480b-bb39-cb47124f9680	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:24.931255
cd500127-863e-44f9-9421-d8a3101073f0	3b68f8bb-589a-480b-bb39-cb47124f9680	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:24.974577
5ff3f93a-11a5-4194-9b2e-d6ffc30923cc	3b68f8bb-589a-480b-bb39-cb47124f9680	8a65e25c-ecb4-4775-9b88-7fd8c47df896	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:25.017839
a357628e-5c77-473f-9f38-0dbf262fd530	3b68f8bb-589a-480b-bb39-cb47124f9680	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:25.083911
c30ae11c-e688-4dd4-b63c-503a2fd3acff	3b68f8bb-589a-480b-bb39-cb47124f9680	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:25.12683
cf0aecb6-829d-4768-b13c-a66c9fa5b46b	3b68f8bb-589a-480b-bb39-cb47124f9680	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:25.169534
d638334e-1aaa-41de-9c21-85eb1a715d7f	0d74d13d-3cfb-4569-b71c-d831b5d119ce	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.563938
d402fbd1-57d4-40de-a9dd-9c17ad508a49	0d74d13d-3cfb-4569-b71c-d831b5d119ce	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.606677
bb2d4486-da8e-482b-890c-7a9c4c12afdb	0d74d13d-3cfb-4569-b71c-d831b5d119ce	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.646691
900dae38-a29e-493d-b214-948d9acdaa83	0d74d13d-3cfb-4569-b71c-d831b5d119ce	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.691558
2a5be4a4-58b9-4d30-b6b4-68d7b2a0fb51	0d74d13d-3cfb-4569-b71c-d831b5d119ce	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.732876
73f68f48-3bbd-4ef6-a176-6f3429031d28	0d74d13d-3cfb-4569-b71c-d831b5d119ce	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.794031
b0718b20-21c4-4c86-970e-97bdfb3a8d90	0d74d13d-3cfb-4569-b71c-d831b5d119ce	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:41.834192
5a73cbe6-5834-46c4-8a02-d6400b28a2f3	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.1574
fa73123c-9493-4f80-bd49-288bce07d7e5	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.20301
8214aa00-0f5e-4478-8600-fbbccc10a4f7	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.246962
21541bb0-b6ca-425b-aa75-f63b88f6b081	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.292266
fb6586c6-d42d-477d-b7ab-86f9d30f5e10	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.336616
4dadff68-f478-48a2-b729-77a9c5e97039	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	8a65e25c-ecb4-4775-9b88-7fd8c47df896	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.380574
a7187cc9-7bc8-41da-a12a-fb2f0a531bb1	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.429319
2ede2cb5-d95b-4d60-b32e-255fd611c8ba	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.473094
a978c204-2c32-435c-9f28-1ac7304f6b9d	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.516809
4d8d9357-d40e-4379-bacc-33204eb127d2	50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:37:57.564285
923ff4d4-780d-4767-9128-a9bae667bc6b	7896aa8b-721a-44b2-b111-f4be86ec089a	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.689954
b52ece9c-a2d6-4fd9-9964-b88e773d3540	7896aa8b-721a-44b2-b111-f4be86ec089a	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.73284
d64cc8d8-b705-4a73-8427-8b4d3d18a0f3	7896aa8b-721a-44b2-b111-f4be86ec089a	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.774574
76110953-c732-42c3-819b-63f33fa18074	7896aa8b-721a-44b2-b111-f4be86ec089a	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.81793
1e177811-5479-4340-b8bf-e3466e4b1226	7896aa8b-721a-44b2-b111-f4be86ec089a	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.861999
fd0e9199-5ad9-4181-b370-0cc043a4e5e4	7896aa8b-721a-44b2-b111-f4be86ec089a	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.926688
6e24d507-4b3e-4817-a56f-558727d445e3	7896aa8b-721a-44b2-b111-f4be86ec089a	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:20.971895
0421d8c0-08d6-4fc0-9ec2-84483e1f026f	7896aa8b-721a-44b2-b111-f4be86ec089a	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:21.014309
77ad2c9d-160d-4323-9fa1-7ca75012433f	7896aa8b-721a-44b2-b111-f4be86ec089a	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:21.057246
a9c1dbad-959f-4a05-926b-3e7c9f1376d2	07043c1d-41ba-45d8-9557-33afb8ee24cd	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:37.667308
66b008cf-407d-4535-900d-d37c88cc9b18	07043c1d-41ba-45d8-9557-33afb8ee24cd	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:37.709362
dfc74a01-b2b8-4191-9f28-c2502dc5f197	07043c1d-41ba-45d8-9557-33afb8ee24cd	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:37.75149
51bb1753-56c1-4273-8b68-253ec24c1745	07043c1d-41ba-45d8-9557-33afb8ee24cd	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:37.858751
201702b5-7e20-4832-8df7-f0d924e17c7e	07043c1d-41ba-45d8-9557-33afb8ee24cd	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:37.899196
b075c690-37c8-41c5-8811-b5ee498b078e	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.220695
754b5a52-4c1e-490b-941d-941ac130ec97	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.264099
b3419d06-a295-483c-96fc-2dc46b9d617e	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.305141
235db658-ce9e-4bfb-a70e-1f1c38a7de6c	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.345403
a07a5a9a-7a69-44c8-8f15-096f784fcd0d	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.428329
ab489cd7-4af1-4e65-b914-e8624e6a7ab4	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.473742
3ad63e13-7212-486f-8120-7f19411f979a	45f8013e-6d38-441b-a7c3-5e4fc213a5bc	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:38:53.514266
bdfdfae0-76b0-4a3b-b60a-be67abb7cd70	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.383241
2d1e51be-9479-4285-b93c-7642f384fead	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.428774
e3edbb93-3278-4a92-8dc8-a50131109d61	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.472448
ed6db4a3-d971-45a5-aa55-74f55749146c	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.516448
8f928e4e-8c1d-4073-8d2d-da3ccba70fee	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.583935
2cbd0b6f-2142-41b2-9aa0-c793d94af901	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.628036
1dca4144-d487-47fd-a03d-6d9f75723460	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.672127
150417a1-abc7-40c2-9cb1-cd983e0cacc1	92b0d7e4-c8a8-4b73-a5c3-b401f5392710	8a65e25c-ecb4-4775-9b88-7fd8c47df896	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:09.738463
8d99aae5-e773-4898-af9b-924777ea18dd	35085610-68af-4ce0-83b8-61f5fe0e872e	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:26.824215
956b1eb1-61e0-4693-a178-db50c75604fc	35085610-68af-4ce0-83b8-61f5fe0e872e	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:26.866995
5b4a88a0-3f96-418c-81ba-922d15f5780f	35085610-68af-4ce0-83b8-61f5fe0e872e	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:26.909905
7aa2479c-8f4b-4b73-aab3-408bc8d55c70	35085610-68af-4ce0-83b8-61f5fe0e872e	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:26.956173
e7d9624c-2fa5-43bd-b0f6-67bd0a26c975	35085610-68af-4ce0-83b8-61f5fe0e872e	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:26.998146
87614684-6fdd-4882-b044-196d015782a1	35085610-68af-4ce0-83b8-61f5fe0e872e	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:27.039957
f830578e-16eb-4a3b-8b72-5679e98e47ad	35085610-68af-4ce0-83b8-61f5fe0e872e	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:27.083026
f9cc4ad7-9632-40aa-8073-c7e7c52e2292	35085610-68af-4ce0-83b8-61f5fe0e872e	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:27.125193
0c67fdcd-c26e-4f18-ab7f-74757dace5ac	04eab4e7-b484-4791-abb5-94163a43b2c0	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:46.81071
1fc18b76-0d71-4a80-b04a-dbfc724e0fc2	04eab4e7-b484-4791-abb5-94163a43b2c0	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:46.858128
bf612532-083e-4c0c-aecf-c84fcd1d9ac5	04eab4e7-b484-4791-abb5-94163a43b2c0	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:46.905629
7330305f-c69b-4125-a568-ab666642a75e	04eab4e7-b484-4791-abb5-94163a43b2c0	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:46.951812
4cd1f73d-a443-417e-a9a1-1b12bc0c8f51	04eab4e7-b484-4791-abb5-94163a43b2c0	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:46.998242
362bedfc-f3d1-405f-b7c5-4ea2b3785ae6	04eab4e7-b484-4791-abb5-94163a43b2c0	8a65e25c-ecb4-4775-9b88-7fd8c47df896	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:47.045065
0accff50-a1d5-4605-94d6-9f2d7a3b6a41	04eab4e7-b484-4791-abb5-94163a43b2c0	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:47.091886
969489da-0f19-43ae-abeb-79e6dbff7232	04eab4e7-b484-4791-abb5-94163a43b2c0	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:47.143339
680cfe63-3457-4f68-9459-1f3ff709fb83	04eab4e7-b484-4791-abb5-94163a43b2c0	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:47.189379
590039ea-0043-4be9-b4ff-f3257db187ad	04eab4e7-b484-4791-abb5-94163a43b2c0	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:39:47.234992
5918dd86-11bf-4cf3-af1f-b39f1165cecb	5cfa84fb-4faf-4df1-9eac-f68c23e37588	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.024627
628db2d4-ba14-4287-871c-26fc7cd46394	5cfa84fb-4faf-4df1-9eac-f68c23e37588	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.066909
19415333-db4b-47df-9d99-90468e895c57	5cfa84fb-4faf-4df1-9eac-f68c23e37588	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.110296
1d28a62b-1c15-4e5f-a612-e1d1410401fe	5cfa84fb-4faf-4df1-9eac-f68c23e37588	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.152885
afaadb70-c164-4fee-aea8-a9ee844d8f3e	5cfa84fb-4faf-4df1-9eac-f68c23e37588	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.194487
96b022b8-0ddb-4e33-b2cc-4df7fdc3f1ea	5cfa84fb-4faf-4df1-9eac-f68c23e37588	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.259252
8f5a3152-db63-46e2-a9d0-75c3b46d466a	5cfa84fb-4faf-4df1-9eac-f68c23e37588	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:03.304729
1a492150-4b8e-44c7-b4e3-f7325c00107b	829831a8-3bdf-42b3-86aa-4a13a0938ab5	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.693978
ed184f50-533c-4718-8ac6-463231a04a2c	829831a8-3bdf-42b3-86aa-4a13a0938ab5	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.739329
dbba09c4-adb2-464a-acc8-259721a79183	829831a8-3bdf-42b3-86aa-4a13a0938ab5	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.804106
5a559fba-62f1-48e2-93c9-c5978d3da8f7	829831a8-3bdf-42b3-86aa-4a13a0938ab5	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.846322
7cdebd3f-6a47-4224-95ba-249f85ff46b3	829831a8-3bdf-42b3-86aa-4a13a0938ab5	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.913197
5f7597d4-457e-4373-be5d-d2ed02ea6075	829831a8-3bdf-42b3-86aa-4a13a0938ab5	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:18.959848
0e228fa5-6280-4da8-abad-208d71b1c09b	829831a8-3bdf-42b3-86aa-4a13a0938ab5	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:19.00262
c15c87b0-7252-4a9e-a77b-1b09517731d3	829831a8-3bdf-42b3-86aa-4a13a0938ab5	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:19.044171
f06284f8-1a95-4d04-8214-eeca3d2f5aba	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.178432
009613ba-3f15-4376-bd6f-1089db990d44	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.220227
1cbb755c-fdcd-4b87-9b1a-f76e976d5956	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.281888
211de41a-8c55-4095-912d-99325d4cf043	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.329801
364f9fa4-0ebf-47cc-8e13-a1351e13c612	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.389867
3c5f875f-09a2-462b-b6bc-b6c39ed98296	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.431115
f704f09b-0c34-4d42-acb2-539939e15dcd	ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:36.499881
0ed77fe4-72ef-4c13-8fca-a52255db7530	50698525-1b92-4f5a-a411-9c3f7ac6977b	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.373977
8f149801-ac36-4960-8eff-d988961a664b	50698525-1b92-4f5a-a411-9c3f7ac6977b	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.419898
ecd08bb9-0ad8-4690-a70c-2cec88fdb95b	50698525-1b92-4f5a-a411-9c3f7ac6977b	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.464874
c1cc2208-1695-4795-89b5-0930493a01f7	50698525-1b92-4f5a-a411-9c3f7ac6977b	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.510676
630b8f4b-9eda-42ec-b307-969b4a875eb8	50698525-1b92-4f5a-a411-9c3f7ac6977b	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.555873
13573619-77d6-4426-b1ac-e7fb5f75f426	50698525-1b92-4f5a-a411-9c3f7ac6977b	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.602335
fb60e80e-baa6-410e-8580-1704f3e60d9d	50698525-1b92-4f5a-a411-9c3f7ac6977b	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.648483
2686a743-f551-4a55-a90b-a2a64e054f17	50698525-1b92-4f5a-a411-9c3f7ac6977b	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.699065
5a6f96b4-f9d3-4d3c-9fdb-ab7fc8fe4cda	50698525-1b92-4f5a-a411-9c3f7ac6977b	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	save	105d5877-be9c-418c-8bad-46832e21f536	2026-03-24 19:40:53.744787
d1d3384b-447f-49a9-a268-268cb55a97aa	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	fd2faa0a-6b67-4aae-a0f8-72ed1c91ff6c	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.143078
f5417938-143b-4e5d-afc7-b52a720472f2	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	e6e5c928-b872-4f49-98d2-674242dad63a	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.159478
a2db5fdd-a42e-44ea-82e7-7e8a8144004e	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	1dbd5c29-52c7-449b-865d-ab3a72d6d527	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.202461
95d7f50f-2be7-46a2-ab68-b8a38d6fd459	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	2f3eb3fc-4131-4a33-bd20-ef47c684fd28	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.209166
b1423b36-610a-4b59-8992-e4c0f8cc131e	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	7052e44a-7137-4e7e-8827-358e304e7979	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.215783
f94ab849-e0d7-4d47-b0ab-39b4f6e2f9da	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	30294dd1-3e35-40ff-91b6-24c7401e62de	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.225314
1ac78350-9399-4c2b-8ef0-5bc9bf959a01	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	078e3c1f-6483-4869-a131-39c12603610e	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.232817
785c539b-5400-4cd3-8702-1cb2ee89b160	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	5a67bdb8-0b53-4496-a673-dc84506fe252	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.24014
6b864b9e-85c6-429e-8f6d-08e416941c69	c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	c4453ccd-cf24-46fb-9d4a-7c2d0c155523	0.0	1.0	Late submission	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:10:26.246103
9754e716-c83f-4831-88b1-4628d433f8ee	d3cdc313-b316-4503-8689-e88cdbdb8999	37c12c30-e218-4cd9-a9b0-0ca51b80d895	0.0	1.0	recount for 4S	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:51:03.16237
3658fef0-437f-4abe-b375-757da90afe3f	91cff167-69c2-436d-885d-9701027fd8e7	37c12c30-e218-4cd9-a9b0-0ca51b80d895	0.0	1.0	recount for 4S	105d5877-be9c-418c-8bad-46832e21f536	2026-03-31 15:51:03.863212
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.submissions (id, team_id, week_id, submitted_at, is_graded, total_points, submitted_by_id) FROM stdin;
ad9457fa-42fe-4196-9beb-274849ff9f93	db2929d8-5398-4f06-9596-ba65f8fb9926	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-27 20:53:23.380029	t	4.0	d4906e02-aaa1-4c9b-b7f0-138889c2d8ec
b06840bd-3ddc-403a-bc83-12ff97dbd510	484145ca-4a54-409c-89ef-e6fc80b80d5a	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-28 14:56:43.460921	t	7.0	64694778-aab5-4227-ab3f-476898a2cebf
fcaba2bb-db9f-49f3-a0f6-f77d95b8b60c	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 22:35:26.587753	t	5.0	d5b2c93d-e254-4507-bd78-aa2ca24e9959
375664fe-e8da-46c7-86ac-83a430b6b8c8	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-02 21:31:26.359591	t	4.0	4237aa27-6dcd-4847-8ba1-b53b17f3ed3b
ae05bc1d-f25c-4b9b-b7b4-0a07db64b75c	50aebd50-c4d5-43ea-86e3-2ce596fb9005	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-29 03:13:05.600531	t	7.0	486f0795-598a-40e2-a71d-c8289394774c
2dc85b4f-3c97-49a3-a662-d825d0a0d7c4	934519a9-40a0-420e-8f88-e6a9f0218539	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-29 14:37:37.534172	t	8.0	41bd831a-1bcd-43ec-af9d-9be32752195c
961da27c-0bd1-44ef-b132-2c2ad4eaf380	68395fad-a152-47aa-82d9-e5e6d821b914	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-29 19:52:21.206045	t	9.0	5110aa33-3dff-436c-b672-eee1b12db2e8
0a1b2f94-0921-445e-b1f6-157d01232314	a2247fce-faee-4edd-8a87-c176e3b3ea71	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 05:56:16.372413	t	8.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
8c9f13d4-de53-4715-a6c1-3e980be3cbf4	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:09:29.515105	t	7.0	4bb6defc-8622-4914-9fb3-6290dbe2e825
898fbb30-d96a-40c5-b01c-9e6ac59843f2	fddf0cb9-511e-4a4f-b209-94f037ace2ce	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:14:29.051292	t	6.0	f5d0c8ce-9a4d-47ad-b45a-082c5a878811
c41f72d7-e0e1-48c1-b895-33dc3445c1e4	ec9df79e-099c-41cc-888a-f232c7fd842d	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:29:25.24	t	8.0	3febacef-a453-4d68-aadf-9ebe4d41953d
bd4708aa-3963-4797-b680-d34cc61816d3	1a5f7fa4-b319-4f38-b190-684b78ad34d8	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 18:00:16.368183	t	8.0	7887b155-e9dc-437b-8ad9-095246eed3b2
d4c26f75-db5c-4538-b9c4-a8854ae01fd9	1a5f7fa4-b319-4f38-b190-684b78ad34d8	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-27 19:14:47.359553	t	4.0	8dba7324-2ac5-43a5-936c-fbd4332e6809
da9327d9-18a5-435f-a4ef-ca7ccf31c7db	2111eabe-cf32-45a3-81ef-df3844b62e43	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-27 19:32:29.192319	t	6.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
7ac8fc6f-1d06-4fa8-b721-f778d2d84694	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:31:27.51997	t	6.0	ea4d147a-e988-47d9-abd2-b53d67f31dd6
2a97dc7b-f8a8-4dc9-a5e2-1226f6e73440	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-30 18:49:13.26365	t	8.0	36f2179e-933e-4685-89c0-761eb540299d
57e81a1d-fce1-4c10-906e-13a628becb93	07e9f3ac-b43c-4147-9541-68a7182c1229	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-30 23:11:20.47458	t	6.0	f43f8dd1-cf0f-49df-8241-cf6bf37ed653
8396455b-6b9c-4715-a638-685ac712b05c	3d77402f-9116-4923-92ac-419ce694d4a0	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-02 20:38:12.417262	t	7.0	9b6b3cbb-190b-4920-8021-7c26926dac14
1b51f960-05c9-4830-b638-8cd1f85b00ad	33ef5766-3947-47b4-a87c-e5cac33aceee	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:57:47.416945	t	8.0	e7b87538-9731-4052-8505-7feb6d80545e
f148a5b6-20a8-4c22-a0d2-e70722eee85e	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 15:59:21.364285	t	5.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
e90a2d0b-7672-4c3b-82c7-44d72fff88d4	b89a8623-5137-413e-a4e7-3c13000f9fd4	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-02-03 16:07:08.995146	t	9.0	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163
485310a0-f7df-4b1f-8390-c28d6f86b495	e87d5571-b86e-451f-8083-637aa8da7e56	c4f01675-e13d-4053-8fb3-9d5eadb3f042	2026-01-27 17:57:41.65179	t	4.0	86a05a77-5359-478a-9a49-7c18b28cdf41
c05fe4e9-7050-400e-bbcf-34b9c582b18c	2111eabe-cf32-45a3-81ef-df3844b62e43	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 18:05:37.41601	t	8.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
59a20d9e-de5b-4ff1-b2ab-76dd17612e80	e87d5571-b86e-451f-8083-637aa8da7e56	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 18:35:51.164721	t	1.0	86a05a77-5359-478a-9a49-7c18b28cdf41
23f7ca06-6851-405c-b8ef-43cf620c3340	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 20:25:09.542381	t	5.0	ea4d147a-e988-47d9-abd2-b53d67f31dd6
b136563e-7150-47b0-91c6-73781d88c3e5	7151c747-207b-47ba-ae85-38ce92557dbf	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-05 19:54:44.027219	t	7.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
442a6a59-f7eb-4e6a-903c-aef886f66b2a	fddf0cb9-511e-4a4f-b209-94f037ace2ce	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-05 20:48:52.783018	t	3.0	f5d0c8ce-9a4d-47ad-b45a-082c5a878811
2b9fae16-d267-419f-98d3-4ea153cf3be4	db2929d8-5398-4f06-9596-ba65f8fb9926	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-06 15:52:03.219577	t	7.0	63927d70-f978-44a0-b519-cf27ad4868b9
febd5f05-a7db-4afc-a366-9289782fee2b	934519a9-40a0-420e-8f88-e6a9f0218539	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-06 16:34:25.128318	t	7.0	41bd831a-1bcd-43ec-af9d-9be32752195c
d3713227-c7e6-49c6-b0a0-9addebdc181c	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 00:28:47.443125	t	8.0	54508549-e38b-40c6-bdc4-22213c2fb461
b85d516c-6ffa-4f69-8c5d-d120dfd43be5	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 04:22:32.52067	t	8.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
783abb02-97b4-467c-ae0b-f1739337674b	33ef5766-3947-47b4-a87c-e5cac33aceee	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 15:23:39.257573	t	9.0	e7b87538-9731-4052-8505-7feb6d80545e
cbee09e7-3674-4d54-b3f5-ca288aa1071d	a2247fce-faee-4edd-8a87-c176e3b3ea71	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 23:11:32.100013	t	9.0	32e3d9cd-d660-41f9-b311-fbb74a9a89bf
a7076f01-f196-4b63-b197-9ad942687786	68395fad-a152-47aa-82d9-e5e6d821b914	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 00:22:59.223158	t	9.0	5110aa33-3dff-436c-b672-eee1b12db2e8
20d0245d-1f5a-47f1-90aa-2a03662a1e63	484145ca-4a54-409c-89ef-e6fc80b80d5a	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-06 20:02:50.67183	t	10.0	64694778-aab5-4227-ab3f-476898a2cebf
b09ca8bb-72c1-4ef7-9bf0-b55cde652ea0	07e9f3ac-b43c-4147-9541-68a7182c1229	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 01:44:28.21	t	8.0	f43f8dd1-cf0f-49df-8241-cf6bf37ed653
a78372e8-c6d9-4800-b826-a11709eab8e7	b89a8623-5137-413e-a4e7-3c13000f9fd4	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 14:35:02.3358	t	8.0	877fe5f5-166b-466c-909a-1da09a5de786
449dd37c-632f-496a-9aa1-f02666a47ea9	ec9df79e-099c-41cc-888a-f232c7fd842d	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-10 14:48:53.36	t	8.0	3febacef-a453-4d68-aadf-9ebe4d41953d
2c442598-df27-4604-87f6-301fe91fee77	3d77402f-9116-4923-92ac-419ce694d4a0	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 21:00:03.753276	t	7.0	9b6b3cbb-190b-4920-8021-7c26926dac14
80cab912-50ad-4f15-b475-d4fc6caf8874	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-09 20:40:24.250322	t	5.0	17be743c-7480-40d2-ad5a-dadc06a9e6bd
4b2187ab-ce4c-47b1-92c6-8da40344633a	3607af7b-9bf0-451d-86e6-65bb58425147	e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2026-02-04 18:50:35.625056	t	5.0	ef8ad12a-3bdd-4d4e-8f5c-09ca63889732
a775cc8b-6b1b-47f8-8db2-f6c2402d2898	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 21:02:29.65443	t	7.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
f277a447-6172-4535-a358-1d93f6549f58	3d77402f-9116-4923-92ac-419ce694d4a0	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 21:33:05.654731	t	8.0	9b6b3cbb-190b-4920-8021-7c26926dac14
c950b1fc-69d4-48d3-86a3-5ac401b34138	1a5f7fa4-b319-4f38-b190-684b78ad34d8	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 21:40:44.382041	t	8.0	b6c9dddf-715b-4dc1-9250-e9d176376f86
a706b7be-b597-4893-92f5-f95083d05de4	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 21:41:39.350556	t	7.0	54508549-e38b-40c6-bdc4-22213c2fb461
639136f8-b968-48b6-97e7-09683c743a22	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 22:52:46.390352	t	3.0	ea4d147a-e988-47d9-abd2-b53d67f31dd6
25ef8181-acf4-4dd2-ac23-5bb56794dd4c	ec9df79e-099c-41cc-888a-f232c7fd842d	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 03:21:06.529684	t	7.0	3febacef-a453-4d68-aadf-9ebe4d41953d
c188a1bb-7151-47b1-afb8-a11bc1a2fd35	53dc4b9e-8b7a-417d-b56e-10e55851c099	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 04:39:30.778031	t	3.0	64fc4a1d-7f6b-4a8f-b700-24df523152f5
203385f2-7ed8-41d5-9911-d3b4edc3715c	68395fad-a152-47aa-82d9-e5e6d821b914	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 13:40:02.181522	t	8.0	a2acb0a6-8323-43c7-a975-bb19b40833f3
700e94e2-b160-4d8a-bb02-e3b748483194	07e9f3ac-b43c-4147-9541-68a7182c1229	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 15:00:43.589	t	4.0	aa0ae7f5-8dda-42ca-92ef-cb7b48e9659c
404d6a9f-695d-4896-b8a6-03260fda9e65	68395fad-a152-47aa-82d9-e5e6d821b914	d328396c-d796-4497-b1b1-54863974f30b	2026-02-19 21:15:31.491249	t	8.0	5110aa33-3dff-436c-b672-eee1b12db2e8
857255dd-891c-4ea0-bdf8-a96b40cd1c20	fddf0cb9-511e-4a4f-b209-94f037ace2ce	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:02:01.641248	t	3.0	f5d0c8ce-9a4d-47ad-b45a-082c5a878811
95dd2780-2e0a-4f7d-a869-c44955822f9d	a2247fce-faee-4edd-8a87-c176e3b3ea71	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 23:12:20.832193	t	7.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
042d1ae9-d11d-4b04-a676-56592dd5420a	2111eabe-cf32-45a3-81ef-df3844b62e43	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-10 17:05:42.823242	t	6.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
3f6f114b-b511-4842-9eb1-b1c195b7bc5e	934519a9-40a0-420e-8f88-e6a9f0218539	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-10 17:14:43.713122	t	9.0	41bd831a-1bcd-43ec-af9d-9be32752195c
e7e898c0-090e-46c4-9261-b263ee596494	fddf0cb9-511e-4a4f-b209-94f037ace2ce	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-10 18:19:37.364576	t	7.0	f5d0c8ce-9a4d-47ad-b45a-082c5a878811
e04c4c4a-6075-4cd4-bdcd-38fc915e55b1	db2929d8-5398-4f06-9596-ba65f8fb9926	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-13 17:35:31.689621	t	7.0	63927d70-f978-44a0-b519-cf27ad4868b9
4c292138-6a33-44c6-befa-8d81692f3fab	484145ca-4a54-409c-89ef-e6fc80b80d5a	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-13 20:14:27.267889	t	8.0	64694778-aab5-4227-ab3f-476898a2cebf
52cb4736-576a-4bda-a8fd-cb252dc84d2f	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 19:41:22.157062	t	4.0	4237aa27-6dcd-4847-8ba1-b53b17f3ed3b
5cef652a-10e7-4094-a3ff-f099614bc2b3	7151c747-207b-47ba-ae85-38ce92557dbf	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-16 20:27:13.581452	t	6.0	bb66ba1d-e906-4183-b981-f6be182ebc21
55e4f319-c2ff-4ea6-a856-fb7041ba96bf	b89a8623-5137-413e-a4e7-3c13000f9fd4	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 15:04:15.064887	t	7.0	877fe5f5-166b-466c-909a-1da09a5de786
9fc8dc00-55b2-433a-9d83-f99086d4c90d	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 15:32:45.698032	t	5.0	4bb6defc-8622-4914-9fb3-6290dbe2e825
f92963a8-3216-4085-a00c-83c0be17df7a	e87d5571-b86e-451f-8083-637aa8da7e56	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-02-17 15:39:36.945156	t	6.0	86a05a77-5359-478a-9a49-7c18b28cdf41
554cb6f2-fdcc-4a4b-983c-88d996d69c63	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:40:27.133189	t	8.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
38a2f6ae-6558-43dc-984a-4bfafd616d11	53dc4b9e-8b7a-417d-b56e-10e55851c099	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 18:03:59.016439	t	3.0	64fc4a1d-7f6b-4a8f-b700-24df523152f5
a4c35b66-5dda-408c-ae6b-19a04eddc469	484145ca-4a54-409c-89ef-e6fc80b80d5a	d328396c-d796-4497-b1b1-54863974f30b	2026-02-20 20:00:22.540661	t	6.0	4e1be311-3dbe-4daf-bfbc-390b061d3e68
bca7d85d-de27-472c-99e9-ad2ff88bf923	db2929d8-5398-4f06-9596-ba65f8fb9926	d328396c-d796-4497-b1b1-54863974f30b	2026-02-21 04:33:26.406899	t	6.0	63927d70-f978-44a0-b519-cf27ad4868b9
79af663b-0c91-4782-ab8a-95dd32d58afa	07e9f3ac-b43c-4147-9541-68a7182c1229	d328396c-d796-4497-b1b1-54863974f30b	2026-02-23 19:53:43.499	t	9.0	aa0ae7f5-8dda-42ca-92ef-cb7b48e9659c
7a519f5d-68e4-473a-b1af-f119519887c1	b89a8623-5137-413e-a4e7-3c13000f9fd4	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 15:40:05.731	t	7.0	877fe5f5-166b-466c-909a-1da09a5de786
2543377e-aa52-47d9-8beb-b13a7b146b26	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 16:02:02.135172	t	2.0	4237aa27-6dcd-4847-8ba1-b53b17f3ed3b
2d37ba60-1577-4eb5-8c1e-1ede581dc559	ec9df79e-099c-41cc-888a-f232c7fd842d	d328396c-d796-4497-b1b1-54863974f30b	2026-02-18 14:58:23.794	t	10.0	3febacef-a453-4d68-aadf-9ebe4d41953d
d19226c5-9e7d-4ecf-b90c-d68536ea40ef	a2247fce-faee-4edd-8a87-c176e3b3ea71	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 16:13:38.103	t	8.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
3267c0e8-b8b0-4d37-a57e-d1c6da230554	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:02:11.82	t	9.0	4bb6defc-8622-4914-9fb3-6290dbe2e825
c7165fe2-4d3c-4a38-94c1-e1dbc4969457	1a5f7fa4-b319-4f38-b190-684b78ad34d8	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:08:46.07795	t	7.0	7887b155-e9dc-437b-8ad9-095246eed3b2
e48c7bec-d192-43dc-b1e3-c6470aca44fe	2111eabe-cf32-45a3-81ef-df3844b62e43	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:15:23.405719	t	9.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
7f56e55b-b5fd-41e1-95a3-a43f39a5bfde	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 17:35:40.623	t	10.0	54508549-e38b-40c6-bdc4-22213c2fb461
dd5f92cb-4f97-46de-9ba1-2a21806346e9	3d77402f-9116-4923-92ac-419ce694d4a0	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 00:13:51.473976	t	8.0	9b6b3cbb-190b-4920-8021-7c26926dac14
50277dea-52b8-44c8-9184-26d1d38a39b1	7151c747-207b-47ba-ae85-38ce92557dbf	d328396c-d796-4497-b1b1-54863974f30b	2026-02-24 15:56:13.089597	t	2.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
9b911cab-b8ed-4b00-adb4-c79afe6cc4f4	934519a9-40a0-420e-8f88-e6a9f0218539	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 17:37:18.440918	t	9.0	41bd831a-1bcd-43ec-af9d-9be32752195c
fcffac86-1285-460a-bc9a-0e1cf504a430	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 17:40:43.581784	t	10.0	4237aa27-6dcd-4847-8ba1-b53b17f3ed3b
083f1c0e-8593-440a-857d-64ed4a2fa1c0	33ef5766-3947-47b4-a87c-e5cac33aceee	d328396c-d796-4497-b1b1-54863974f30b	2026-02-19 22:15:20.738434	t	10.0	e7b87538-9731-4052-8505-7feb6d80545e
0588b19e-4a96-40e5-a0c0-53ab07a1eb9f	934519a9-40a0-420e-8f88-e6a9f0218539	d328396c-d796-4497-b1b1-54863974f30b	2026-02-17 18:56:40.624523	t	9.0	41bd831a-1bcd-43ec-af9d-9be32752195c
554f4b2f-78eb-485f-983d-25fbe8788151	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 20:08:01.666975	t	10.0	ea4d147a-e988-47d9-abd2-b53d67f31dd6
3a16123d-175c-4f4f-83e3-7e286c662fd4	ec9df79e-099c-41cc-888a-f232c7fd842d	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 20:10:42.647797	t	10.0	3febacef-a453-4d68-aadf-9ebe4d41953d
ebbbd0be-2299-4eb1-96bc-8fc01914739d	b89a8623-5137-413e-a4e7-3c13000f9fd4	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 20:44:22.592121	t	10.0	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163
c8fd6c79-c3eb-42ac-9cbc-fb7fefd5b706	a2247fce-faee-4edd-8a87-c176e3b3ea71	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 21:19:09.619987	t	10.0	32e3d9cd-d660-41f9-b311-fbb74a9a89bf
ab2b199c-3445-4cc2-be59-698d68272746	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-24 19:08:14.816	t	10.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
44117173-dda3-488d-bc86-6c33dbe9ec8e	484145ca-4a54-409c-89ef-e6fc80b80d5a	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-24 22:03:53.306389	t	10.0	4e1be311-3dbe-4daf-bfbc-390b061d3e68
9cd05538-1036-4823-a759-25a92e7329b1	1a5f7fa4-b319-4f38-b190-684b78ad34d8	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-25 15:59:51.645938	t	10.0	7887b155-e9dc-437b-8ad9-095246eed3b2
44c6ae69-53af-40a1-bd37-8cf0f2a58eab	db2929d8-5398-4f06-9596-ba65f8fb9926	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-25 18:11:05.665544	t	10.0	63927d70-f978-44a0-b519-cf27ad4868b9
f85546b6-b7f2-449c-a0aa-c38e5d88c61f	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-26 16:22:59.948314	t	10.0	54508549-e38b-40c6-bdc4-22213c2fb461
00a224b3-7b5a-4ef3-ad79-0d211d2477de	68395fad-a152-47aa-82d9-e5e6d821b914	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-26 16:24:55.934052	t	10.0	5110aa33-3dff-436c-b672-eee1b12db2e8
f5d77cfe-3b66-4c8c-84be-3a75b5a0cdf2	7151c747-207b-47ba-ae85-38ce92557dbf	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-26 19:59:41.8519	t	10.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
3c7ad9df-a442-47cb-8949-c61aaae09e02	33ef5766-3947-47b4-a87c-e5cac33aceee	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-27 05:15:30.257358	t	10.0	e7b87538-9731-4052-8505-7feb6d80545e
04477634-d57e-4983-8a74-43f48775f518	3d77402f-9116-4923-92ac-419ce694d4a0	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-02-27 19:09:05.601455	t	10.0	9b6b3cbb-190b-4920-8021-7c26926dac14
871d5fbf-7654-44ec-81b8-b880f2b720a0	53dc4b9e-8b7a-417d-b56e-10e55851c099	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-02 22:49:16.08179	t	6.0	7ebbfa1a-edc2-41f4-a57a-caefd2e3be0e
49e23d01-cc36-44a6-b744-35e91fb4c3d2	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-03 14:49:16.713169	t	10.0	4bb6defc-8622-4914-9fb3-6290dbe2e825
80665cd6-323d-4543-a58b-8328f4021250	07e9f3ac-b43c-4147-9541-68a7182c1229	0ceafa7e-c327-4c76-8c25-4496e14dabac	2026-03-03 16:23:34.105	t	6.0	82b7c768-127a-4c94-a861-27650bbceeb3
fd339ac5-cfc9-45c6-888a-8028f34879ec	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 16:59:39.881271	t	5.0	17be743c-7480-40d2-ad5a-dadc06a9e6bd
9737632c-0648-4d1d-8ddf-3a287fcb6572	33ef5766-3947-47b4-a87c-e5cac33aceee	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 15:39:06.67041	t	9.0	e7b87538-9731-4052-8505-7feb6d80545e
9a95d3da-6cd2-41d2-8c8d-13c36e8338f4	db2929d8-5398-4f06-9596-ba65f8fb9926	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-06 16:00:02.766786	t	7.0	63927d70-f978-44a0-b519-cf27ad4868b9
c564fd9a-4b68-4a84-a86f-55a2ecbe59ba	3d77402f-9116-4923-92ac-419ce694d4a0	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-06 16:12:43.21182	t	8.0	9b6b3cbb-190b-4920-8021-7c26926dac14
af40f930-138a-4df4-a537-15bc309386a3	68395fad-a152-47aa-82d9-e5e6d821b914	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-09 13:46:45.582116	t	10.0	5110aa33-3dff-436c-b672-eee1b12db2e8
af2179b0-d768-4c8f-9d26-abb437862899	7151c747-207b-47ba-ae85-38ce92557dbf	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-09 15:41:16.529822	t	6.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
48e5624f-068d-4694-aca7-4041b607aa79	a2247fce-faee-4edd-8a87-c176e3b3ea71	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-09 22:46:27.806504	t	9.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
acef5f06-c17a-49b7-8f92-d55f6bc3846f	07e9f3ac-b43c-4147-9541-68a7182c1229	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 02:45:43.653227	t	8.0	f43f8dd1-cf0f-49df-8241-cf6bf37ed653
77e2006b-9806-48ed-a5f1-5ff5515f2bd0	484145ca-4a54-409c-89ef-e6fc80b80d5a	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 03:36:54.290595	t	7.0	4e1be311-3dbe-4daf-bfbc-390b061d3e68
839176b9-558e-43c6-a1eb-47f16269e4db	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 13:27:33.026626	t	7.0	54508549-e38b-40c6-bdc4-22213c2fb461
eed34ef9-492e-455b-bc38-26568b1dccee	53dc4b9e-8b7a-417d-b56e-10e55851c099	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 13:56:25.190756	t	4.0	64fc4a1d-7f6b-4a8f-b700-24df523152f5
c41035c1-6eaf-4a48-9c97-6ea86861575d	1a5f7fa4-b319-4f38-b190-684b78ad34d8	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 15:49:49.752572	t	7.0	8dba7324-2ac5-43a5-936c-fbd4332e6809
f0feddb4-ef0d-454e-8052-2b11b39d89d8	ec9df79e-099c-41cc-888a-f232c7fd842d	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 15:53:56.940411	t	10.0	3febacef-a453-4d68-aadf-9ebe4d41953d
3f3a4921-8639-4f9c-8358-e366c38b18e9	934519a9-40a0-420e-8f88-e6a9f0218539	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 16:08:41.527898	t	10.0	604f1438-f5f4-4e45-a85e-1d1984969343
bee362a7-4dd6-4227-904e-bfa3c3b44908	b89a8623-5137-413e-a4e7-3c13000f9fd4	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 17:28:03.861	t	7.0	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163
aee07542-11df-4bf4-a228-f7e11da5009f	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	74d22bb4-6a21-4576-b2dc-bf731486f17f	2026-03-10 16:57:35.461	t	9.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
91cff167-69c2-436d-885d-9701027fd8e7	934519a9-40a0-420e-8f88-e6a9f0218539	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-11 14:00:25.83316	t	10.0	41bd831a-1bcd-43ec-af9d-9be32752195c
2f4fc88f-4371-4968-8598-164059301b73	3d77402f-9116-4923-92ac-419ce694d4a0	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-15 16:35:12.211293	t	7.0	9b6b3cbb-190b-4920-8021-7c26926dac14
8fe2128e-3075-458f-8885-34f07759772c	7151c747-207b-47ba-ae85-38ce92557dbf	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-16 22:53:37.488461	t	8.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
86d47cae-e1c1-41c1-8192-23cb607b0504	07e9f3ac-b43c-4147-9541-68a7182c1229	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 14:39:35.892	t	7.0	82b7c768-127a-4c94-a861-27650bbceeb3
dc91f88c-a26e-4b94-b649-0255795b43d6	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:03:48.809645	t	6.0	54508549-e38b-40c6-bdc4-22213c2fb461
1de93da7-5250-4050-9aa5-396db4430920	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:41:47.518994	t	7.0	17be743c-7480-40d2-ad5a-dadc06a9e6bd
0d74d13d-3cfb-4569-b71c-d831b5d119ce	3d77402f-9116-4923-92ac-419ce694d4a0	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-23 14:10:30.721561	t	7.0	9b6b3cbb-190b-4920-8021-7c26926dac14
829831a8-3bdf-42b3-86aa-4a13a0938ab5	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 13:52:59.242931	t	8.0	17be743c-7480-40d2-ad5a-dadc06a9e6bd
ca8b2ef5-9c93-418f-bf6d-b8f43bd469aa	7151c747-207b-47ba-ae85-38ce92557dbf	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 15:55:40.78917	t	7.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
50698525-1b92-4f5a-a411-9c3f7ac6977b	a2247fce-faee-4edd-8a87-c176e3b3ea71	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 15:56:33.931302	t	9.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
7896aa8b-721a-44b2-b111-f4be86ec089a	484145ca-4a54-409c-89ef-e6fc80b80d5a	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:16:14.750065	t	9.0	4e1be311-3dbe-4daf-bfbc-390b061d3e68
04eab4e7-b484-4791-abb5-94163a43b2c0	33ef5766-3947-47b4-a87c-e5cac33aceee	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 15:58:16.975647	t	10.0	e7b87538-9731-4052-8505-7feb6d80545e
8ebcbd57-0684-4908-85e9-c3088cc83832	33ef5766-3947-47b4-a87c-e5cac33aceee	4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	2026-03-18 20:38:59.922733	t	9.0	105d5877-be9c-418c-8bad-46832e21f536
92b0d7e4-c8a8-4b73-a5c3-b401f5392710	db2929d8-5398-4f06-9596-ba65f8fb9926	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:27:47.861298	t	8.0	d4906e02-aaa1-4c9b-b7f0-138889c2d8ec
90ec5ba1-80ba-488b-b601-bd32b22f4bb3	53dc4b9e-8b7a-417d-b56e-10e55851c099	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:31:59.942877	t	5.0	7ebbfa1a-edc2-41f4-a57a-caefd2e3be0e
35085610-68af-4ce0-83b8-61f5fe0e872e	b89a8623-5137-413e-a4e7-3c13000f9fd4	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:33:37.677277	t	8.0	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163
3b68f8bb-589a-480b-bb39-cb47124f9680	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:45:21.537	t	9.0	dd42dc24-f228-406c-858a-c8fc7100fa64
fa9f16ef-ee61-4724-b74c-a1a59bbde834	b89a8623-5137-413e-a4e7-3c13000f9fd4	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:42:40.068867	t	4.0	877fe5f5-166b-466c-909a-1da09a5de786
9efe45f9-c782-40ea-b789-681ed7c82095	2111eabe-cf32-45a3-81ef-df3844b62e43	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:45:09.426898	t	5.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
3efabaa1-98cb-4f6f-a538-6e7107c6dd25	1a5f7fa4-b319-4f38-b190-684b78ad34d8	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:52:59.924728	t	6.0	8dba7324-2ac5-43a5-936c-fbd4332e6809
bbeeb813-d9dc-4da7-b86a-a08b81089a20	db2929d8-5398-4f06-9596-ba65f8fb9926	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:54:11.844565	t	8.0	e173c701-0383-4b09-a0b8-bbf392804c2b
2852dcf2-331b-4d54-9bbc-1a734535da1c	a2247fce-faee-4edd-8a87-c176e3b3ea71	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 15:55:56.664	t	9.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
d3cdc313-b316-4503-8689-e88cdbdb8999	68395fad-a152-47aa-82d9-e5e6d821b914	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 11:48:35.367856	t	10.0	5110aa33-3dff-436c-b672-eee1b12db2e8
1d132142-d768-45cc-a2de-5134d0fa1386	ec9df79e-099c-41cc-888a-f232c7fd842d	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 13:35:47.184395	t	9.0	3febacef-a453-4d68-aadf-9ebe4d41953d
6922c3b9-bf2f-46e8-a872-6e06e55082fa	484145ca-4a54-409c-89ef-e6fc80b80d5a	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 14:29:51.229803	t	8.0	4e1be311-3dbe-4daf-bfbc-390b061d3e68
07043c1d-41ba-45d8-9557-33afb8ee24cd	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:59:22.873	t	5.0	67caf4f1-e82f-4abb-879a-fcea3a46eb60
50c2054b-ccdc-4da9-b8c0-1bc19e106b4c	68395fad-a152-47aa-82d9-e5e6d821b914	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-18 13:56:50.646128	t	10.0	5110aa33-3dff-436c-b672-eee1b12db2e8
0ccd314e-3963-46bc-bf87-41f51aa191d5	934519a9-40a0-420e-8f88-e6a9f0218539	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-18 14:16:06.225268	t	9.0	604f1438-f5f4-4e45-a85e-1d1984969343
008b097f-27aa-4057-9163-ed8caa0e321d	ec9df79e-099c-41cc-888a-f232c7fd842d	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 13:53:06.602446	t	8.0	3febacef-a453-4d68-aadf-9ebe4d41953d
2335f405-1e68-48a0-8238-5bdb9959cab7	ec9df79e-099c-41cc-888a-f232c7fd842d	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 15:38:30.253	f	0.0	3febacef-a453-4d68-aadf-9ebe4d41953d
45f8013e-6d38-441b-a7c3-5e4fc213a5bc	1a5f7fa4-b319-4f38-b190-684b78ad34d8	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 15:11:58.790404	t	7.0	b6c9dddf-715b-4dc1-9250-e9d176376f86
6ea12e70-ba7c-4d47-9a8a-663b93802bd9	db2929d8-5398-4f06-9596-ba65f8fb9926	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-27 17:23:21.633719	f	0.0	d4906e02-aaa1-4c9b-b7f0-138889c2d8ec
f5b5d87f-4099-43e3-bc79-c28d877543c1	c811b678-8fde-43b9-967e-03d92bd30fa3	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-27 20:29:20.86	f	0.0	bb26e025-d4df-4219-a213-18cbf44dd6ea
72986d21-4025-4c8d-a373-4046ba74855b	68395fad-a152-47aa-82d9-e5e6d821b914	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-30 13:48:21.506891	f	0.0	5110aa33-3dff-436c-b672-eee1b12db2e8
bd2c2d77-36b5-49fc-a207-ecb7fe4fb28b	934519a9-40a0-420e-8f88-e6a9f0218539	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:16:25.150023	f	0.0	41bd831a-1bcd-43ec-af9d-9be32752195c
db79d40b-b30b-4e09-9586-3787d142e358	33ef5766-3947-47b4-a87c-e5cac33aceee	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:23:33.650665	f	0.0	e7b87538-9731-4052-8505-7feb6d80545e
20f38dcb-9515-4149-a3c5-df9db702352f	33ef5766-3947-47b4-a87c-e5cac33aceee	007a6769-ef53-4a15-ba56-45c22a232b44	2026-03-17 16:33:40.519923	t	7.0	e7b87538-9731-4052-8505-7feb6d80545e
aef1e58f-cb7e-434b-893b-724c3cb8d064	7151c747-207b-47ba-ae85-38ce92557dbf	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:36:44.468668	f	0.0	f50d8d33-8020-4a69-86c0-22d47ebb0581
003e1d36-bac3-4812-b4e4-aa2f4b10be0c	2111eabe-cf32-45a3-81ef-df3844b62e43	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:37:07.085156	f	0.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
121bfc6f-2561-47fd-90a3-e85c02bfe831	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:52:03.331	f	0.0	dd42dc24-f228-406c-858a-c8fc7100fa64
26fc2a88-9c13-4773-ae8c-eef8517a44a1	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 14:54:19.641514	f	0.0	4bb6defc-8622-4914-9fb3-6290dbe2e825
7f1f1b7d-54d7-4f43-8c47-ccf7f8d10090	53dc4b9e-8b7a-417d-b56e-10e55851c099	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 15:00:43.493712	f	0.0	64fc4a1d-7f6b-4a8f-b700-24df523152f5
841d4879-ee75-4007-9c34-c11dbf9a69f0	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 16:30:11.294	f	0.0	fa46bf65-d71a-48cd-8ec2-fa85915f2781
5cfa84fb-4faf-4df1-9eac-f68c23e37588	2111eabe-cf32-45a3-81ef-df3844b62e43	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-24 16:08:08.392617	t	7.0	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
c6ffde35-8fb9-436c-b39e-f3e9b9df7bb8	07e9f3ac-b43c-4147-9541-68a7182c1229	962fd4a4-d0aa-4862-b4b3-99bff679844d	2026-03-31 15:10:25.798854	t	9.0	105d5877-be9c-418c-8bad-46832e21f536
0477931b-2340-4114-8186-980234965137	1a5f7fa4-b319-4f38-b190-684b78ad34d8	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 16:02:14.524256	f	0.0	b6c9dddf-715b-4dc1-9250-e9d176376f86
46374e4d-95ad-4154-afcd-308e634265ec	b89a8623-5137-413e-a4e7-3c13000f9fd4	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 16:45:47.629439	f	0.0	877fe5f5-166b-466c-909a-1da09a5de786
7a9ad60d-042e-42f6-af87-19c2d7151e7d	a2247fce-faee-4edd-8a87-c176e3b3ea71	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 16:56:39.186184	f	0.0	2f9876f3-f53a-4ae9-ae61-16bcda66845f
40ded797-97a4-41be-887c-19a48635b837	3d77402f-9116-4923-92ac-419ce694d4a0	c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	2026-03-31 17:21:43.464799	f	0.0	9b6b3cbb-190b-4920-8021-7c26926dac14
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.team_members (id, team_id, user_id, is_approved, is_lead) FROM stdin;
0d6d8f3c-cc22-4847-8d3b-ae43cb62c13f	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	d5b2c93d-e254-4507-bd78-aa2ca24e9959	t	t
eddf2d5d-acfe-4bb5-9bd5-956be1745c73	07e9f3ac-b43c-4147-9541-68a7182c1229	aa0ae7f5-8dda-42ca-92ef-cb7b48e9659c	t	t
b26e932b-bc28-4334-aaa3-1505bc98b914	ec9df79e-099c-41cc-888a-f232c7fd842d	3febacef-a453-4d68-aadf-9ebe4d41953d	t	t
4d880b50-932c-4b06-a926-3cd59e10152e	50aebd50-c4d5-43ea-86e3-2ce596fb9005	425e8a2b-4162-4f60-ba54-f9cf4156fdb1	t	t
35dba615-f0f4-466f-a285-34f5f9de32df	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	4237aa27-6dcd-4847-8ba1-b53b17f3ed3b	t	t
92904991-9a0b-49e9-b157-c4e6f2a5707b	26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	0d79b6f4-43a6-4193-8389-08eff75c9a36	t	t
d996aad7-8d64-49bd-95cc-ea7be4c3bee8	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	710ff1fa-f978-4fe1-87d2-42afb79a7b43	t	t
722582a8-389b-4738-9a89-b77c2f79ac96	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	36f2179e-933e-4685-89c0-761eb540299d	t	t
c44f669a-43fb-4719-8179-3596b3447591	ec9df79e-099c-41cc-888a-f232c7fd842d	3a7a892b-a738-44cd-96aa-db8fdd7d1e02	t	t
342c7386-60f7-4b6e-b75b-187941b2e43f	3d77402f-9116-4923-92ac-419ce694d4a0	824b5e22-4f6b-4339-aada-65c31d333c47	t	t
93abdecc-5067-4b44-9716-02f7429b2215	68395fad-a152-47aa-82d9-e5e6d821b914	5110aa33-3dff-436c-b672-eee1b12db2e8	t	t
b192f39a-d0b9-47ff-ac0b-3fdd88a56090	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	54508549-e38b-40c6-bdc4-22213c2fb461	t	t
5edae42d-6ac1-4e76-993b-5a59add90ec9	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	ea4d147a-e988-47d9-abd2-b53d67f31dd6	t	t
b3c6367a-4d94-49ea-891b-368f1d4761b4	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	73f709ab-27d3-4e1f-b2d7-42c4eac09468	t	t
a240bdc6-a21e-4468-9745-d7576ac04462	68395fad-a152-47aa-82d9-e5e6d821b914	a2acb0a6-8323-43c7-a975-bb19b40833f3	t	t
87c9b435-e92a-4bff-8413-f2324adc4d31	3d77402f-9116-4923-92ac-419ce694d4a0	9b6b3cbb-190b-4920-8021-7c26926dac14	t	t
46f358a4-67ad-439b-80d9-d66f732de463	3d77402f-9116-4923-92ac-419ce694d4a0	d2a0e7e0-2692-45e8-a923-468eb9906b7a	t	t
4cda8396-c778-4eba-ab37-03006cb00e41	50aebd50-c4d5-43ea-86e3-2ce596fb9005	9997929e-8f7d-456e-b19f-a9945933889f	t	t
d50b19da-9b41-44b3-80a7-6f490f833333	e87d5571-b86e-451f-8083-637aa8da7e56	86a05a77-5359-478a-9a49-7c18b28cdf41	t	t
f549e1c8-d15d-43b6-a79a-bb153bdfa71a	934519a9-40a0-420e-8f88-e6a9f0218539	41bd831a-1bcd-43ec-af9d-9be32752195c	t	t
e1671acf-2ef2-4bed-9101-03b6d82229c8	07e9f3ac-b43c-4147-9541-68a7182c1229	f43f8dd1-cf0f-49df-8241-cf6bf37ed653	t	t
2f46a5ed-b342-4f21-baaa-f4d5373dbe3d	07e9f3ac-b43c-4147-9541-68a7182c1229	82b7c768-127a-4c94-a861-27650bbceeb3	t	t
3ed92718-1b5a-4f75-933b-f12145caa242	07e9f3ac-b43c-4147-9541-68a7182c1229	50349c70-f24a-4bb1-8348-98b1ce8889dd	t	t
3d675db6-f474-41ff-a71c-b60e0699d2d4	484145ca-4a54-409c-89ef-e6fc80b80d5a	4e1be311-3dbe-4daf-bfbc-390b061d3e68	t	t
c2edd56b-0fc4-4c84-8b85-0cf2408dd2a5	484145ca-4a54-409c-89ef-e6fc80b80d5a	64694778-aab5-4227-ab3f-476898a2cebf	t	t
1eb91e14-3301-4ab1-b36d-366d87c34884	5724d727-5a72-47e0-a44b-2a4b76c0fb00	f5e03765-f03c-4b97-bbcd-c06fdae73a77	t	t
058eaa7d-d565-4159-bd37-bedd7521b858	4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	dd42dc24-f228-406c-858a-c8fc7100fa64	t	t
c8ad2faa-a85f-4b72-a52f-4b9dfdbcebf7	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	322a2624-2a0d-416d-9b3d-f1c245266731	t	t
c9f64238-6cdb-4ddd-8b29-33b990aa1bb7	934519a9-40a0-420e-8f88-e6a9f0218539	604f1438-f5f4-4e45-a85e-1d1984969343	t	t
4feb727f-b640-46df-98d0-8802e711178d	934519a9-40a0-420e-8f88-e6a9f0218539	d87a96e8-d5ea-4d74-b415-2d1caacf586a	t	t
d45d6f62-7714-4da0-a314-c2936008d549	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	fa46bf65-d71a-48cd-8ec2-fa85915f2781	t	t
96b2a4aa-1af1-4edd-a2c2-c3566bcef5f8	3d77402f-9116-4923-92ac-419ce694d4a0	cfc333a4-22dd-48b9-8b01-633414242492	t	t
d6ee240d-bee4-4b68-bc88-564fc5f814ca	5724d727-5a72-47e0-a44b-2a4b76c0fb00	45684f47-ab74-4b6e-8ac7-4eab6f0785a7	t	t
5e1a4dda-5e98-4eb6-9d2c-ff464ca5f854	1a5f7fa4-b319-4f38-b190-684b78ad34d8	7887b155-e9dc-437b-8ad9-095246eed3b2	t	t
f8adb374-9981-4cb3-a4a2-580a9d5b4c41	db2929d8-5398-4f06-9596-ba65f8fb9926	d4906e02-aaa1-4c9b-b7f0-138889c2d8ec	t	t
ba8ea671-4fcd-4884-b1ab-6be0c2aa04de	1a5f7fa4-b319-4f38-b190-684b78ad34d8	b6c9dddf-715b-4dc1-9250-e9d176376f86	t	t
8b99d673-97f8-447b-b81a-2db9ac24f08e	1a5f7fa4-b319-4f38-b190-684b78ad34d8	8dba7324-2ac5-43a5-936c-fbd4332e6809	t	t
5c3dd76c-3f1c-4ddd-b93e-ef29f2e8b941	3607af7b-9bf0-451d-86e6-65bb58425147	999f9734-12b2-49ea-b8e0-1bbf9d845f44	t	t
ff2c8984-ddc7-4599-820f-e3b7335cbf59	3607af7b-9bf0-451d-86e6-65bb58425147	ef8ad12a-3bdd-4d4e-8f5c-09ca63889732	t	t
0cc2365a-a8f8-46e4-9b69-973a246d5f3a	b89a8623-5137-413e-a4e7-3c13000f9fd4	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163	t	t
4a1fcf31-f255-4a32-b5bc-923859da36ba	db2929d8-5398-4f06-9596-ba65f8fb9926	63927d70-f978-44a0-b519-cf27ad4868b9	t	t
bdebf154-4cbc-4d11-a040-ac802d5ad3d3	33ef5766-3947-47b4-a87c-e5cac33aceee	e7b87538-9731-4052-8505-7feb6d80545e	t	t
acdd240c-59a1-459b-a9bf-d16285e5c893	db2929d8-5398-4f06-9596-ba65f8fb9926	e173c701-0383-4b09-a0b8-bbf392804c2b	t	t
9de3b07b-94e6-4b6e-b4b7-bb19f908f8c8	2111eabe-cf32-45a3-81ef-df3844b62e43	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163	t	t
10e4aae1-3238-463d-8e49-68eff4310afc	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	503fbed0-e326-480a-908b-fc306c65fd50	t	t
97a5572c-b5dd-42b9-a3e1-b8f9090ad5c0	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	17be743c-7480-40d2-ad5a-dadc06a9e6bd	t	t
e80ec51f-04a6-47a3-8993-1449f54181c2	7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	4bb6defc-8622-4914-9fb3-6290dbe2e825	t	t
d73961f3-4cfd-481e-90ec-d7e2c34f9055	b89a8623-5137-413e-a4e7-3c13000f9fd4	877fe5f5-166b-466c-909a-1da09a5de786	t	t
43b5352d-9d82-4411-9a29-0ee5f0ab0025	7151c747-207b-47ba-ae85-38ce92557dbf	f50d8d33-8020-4a69-86c0-22d47ebb0581	t	t
e1571e0c-b5bb-494a-a1e7-3f20ecc32e9f	7151c747-207b-47ba-ae85-38ce92557dbf	8f7019ab-9dcd-44fe-8bc4-a14e7aaa82d2	t	t
0b6532ca-69a1-4fa7-8633-07c6b01ea389	7151c747-207b-47ba-ae85-38ce92557dbf	bb66ba1d-e906-4183-b981-f6be182ebc21	t	t
de6e84f7-bf5d-4027-8d54-56f94b000d9a	a2247fce-faee-4edd-8a87-c176e3b3ea71	2f9876f3-f53a-4ae9-ae61-16bcda66845f	t	t
bbcddb10-a4a8-4e4e-8f44-de0c162a88f2	50aebd50-c4d5-43ea-86e3-2ce596fb9005	486f0795-598a-40e2-a71d-c8289394774c	t	t
d07684fb-16ab-4a4e-92bc-529ca1c66dd5	c4dcee58-3656-4ac5-8398-2d1ae91f824c	bff2a058-b34f-48ce-af98-23ecdf7293a9	t	t
d8b7031c-87ad-40f4-9ce9-c212170a4d3b	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	c053fd17-5bd1-4871-970c-46591b133b23	t	t
7c190da8-b889-4100-920d-a002864277a8	68395fad-a152-47aa-82d9-e5e6d821b914	d7933b27-7849-4b43-b692-993290696563	t	t
e53468df-d1f9-4836-b278-f76b511e05f6	a2247fce-faee-4edd-8a87-c176e3b3ea71	cb4f7bc7-0359-4725-86ff-0c6cbbbebccd	t	t
a7b89100-1f0c-458b-a24b-6589527d9c34	53dc4b9e-8b7a-417d-b56e-10e55851c099	7ebbfa1a-edc2-41f4-a57a-caefd2e3be0e	t	t
a69d3a19-16a3-4832-8af0-004dbf956e54	53dc4b9e-8b7a-417d-b56e-10e55851c099	a1792d66-8c31-4b26-bb68-0c7895f75898	t	t
0f3f68e0-0aa4-4369-afee-2206d14888e9	fddf0cb9-511e-4a4f-b209-94f037ace2ce	f5d0c8ce-9a4d-47ad-b45a-082c5a878811	t	t
31fc94d7-ac1a-4424-a9ca-576cf7195594	33ef5766-3947-47b4-a87c-e5cac33aceee	492223d2-fe89-4726-a2e7-5e215bd40be2	t	t
98d41ab3-8cfa-4ce8-9de1-989fa94b044d	33ef5766-3947-47b4-a87c-e5cac33aceee	507f5106-91c5-4de7-aaa9-4d2de6f3c844	t	t
89b8c8a9-a039-4a83-a920-889a20a7f81f	a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	9e6843ad-ab99-48ff-b907-721cd378cad5	t	t
7cd20c2d-06e4-462f-b9cb-8555fbfe4f8a	ec9df79e-099c-41cc-888a-f232c7fd842d	59853ff0-31c2-4201-9a18-4485a65b8c6e	t	t
f853c49a-048c-4abf-ad63-f3ed447e5704	a2247fce-faee-4edd-8a87-c176e3b3ea71	32e3d9cd-d660-41f9-b311-fbb74a9a89bf	t	t
da50c184-9d63-4481-8092-35e7c5669383	b89a8623-5137-413e-a4e7-3c13000f9fd4	91af89c0-1035-4336-9d16-bab22ede66a2	t	t
95447abb-f925-4699-b448-78b1e1b09b3c	e87d5571-b86e-451f-8083-637aa8da7e56	584b0f26-051d-4036-9b19-8c7691fa3eb2	t	t
baee27a2-102f-40d5-a7fc-4314d68f2ff5	7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	67caf4f1-e82f-4abb-879a-fcea3a46eb60	t	t
c85a81c9-a110-422c-b46e-e3189261731e	6c8d94db-d4b8-4bb2-8daf-48cf045e3451	357fdbf3-de05-4c96-bc15-a242a93a0ed8	t	t
1f212249-9551-480c-b96b-fb47ecdfbbe4	53dc4b9e-8b7a-417d-b56e-10e55851c099	64fc4a1d-7f6b-4a8f-b700-24df523152f5	t	t
52bbee2e-097b-42e2-85b0-9e39fd82743c	c811b678-8fde-43b9-967e-03d92bd30fa3	bb26e025-d4df-4219-a213-18cbf44dd6ea	t	t
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.teams (id, name, lead_id) FROM stdin;
26a49c1d-ec2b-4f9b-8da8-ea386f6d9f2f	Air Gapped and Unbothered	d5b2c93d-e254-4507-bd78-aa2ca24e9959
07e9f3ac-b43c-4147-9541-68a7182c1229	World Wide Buffalos	aa0ae7f5-8dda-42ca-92ef-cb7b48e9659c
ec9df79e-099c-41cc-888a-f232c7fd842d	Techs and the City	3febacef-a453-4d68-aadf-9ebe4d41953d
50aebd50-c4d5-43ea-86e3-2ce596fb9005	Cute Puppies	425e8a2b-4162-4f60-ba54-f9cf4156fdb1
4229ebe7-cf7a-48b5-ab1f-0f21e0013a18	Cookie Club	710ff1fa-f978-4fe1-87d2-42afb79a7b43
3d77402f-9116-4923-92ac-419ce694d4a0	GenXYZ	824b5e22-4f6b-4339-aada-65c31d333c47
68395fad-a152-47aa-82d9-e5e6d821b914	Team Croniq (+ Rachel)	5110aa33-3dff-436c-b672-eee1b12db2e8
a2c5cf9a-36e9-4b17-95e2-d4a26d9235d5	The Ben Dalton Fan Club	ea4d147a-e988-47d9-abd2-b53d67f31dd6
e87d5571-b86e-451f-8083-637aa8da7e56	The Interns	86a05a77-5359-478a-9a49-7c18b28cdf41
934519a9-40a0-420e-8f88-e6a9f0218539	Hellfire Club	41bd831a-1bcd-43ec-af9d-9be32752195c
484145ca-4a54-409c-89ef-e6fc80b80d5a	Phoenix Sky Harbor Terminal 3	4e1be311-3dbe-4daf-bfbc-390b061d3e68
5724d727-5a72-47e0-a44b-2a4b76c0fb00	Triple Dipper	f5e03765-f03c-4b97-bbcd-c06fdae73a77
7fbbb0f9-245e-4f04-ac8d-8b992e54a60f	Better Than Google	322a2624-2a0d-416d-9b3d-f1c245266731
1a5f7fa4-b319-4f38-b190-684b78ad34d8	MC? Nah That Ain’t Me.	7887b155-e9dc-437b-8ad9-095246eed3b2
db2929d8-5398-4f06-9596-ba65f8fb9926	Second Best Denver Trivia Team	d4906e02-aaa1-4c9b-b7f0-138889c2d8ec
b89a8623-5137-413e-a4e7-3c13000f9fd4	Smartinis	2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163
3607af7b-9bf0-451d-86e6-65bb58425147	Titans of Industry	999f9734-12b2-49ea-b8e0-1bbf9d845f44
33ef5766-3947-47b4-a87c-e5cac33aceee	Carbon Offset This!	e7b87538-9731-4052-8505-7feb6d80545e
2111eabe-cf32-45a3-81ef-df3844b62e43	CerebRum	bc1cdbb5-6cc1-44ad-b749-a0185f7fc163
7b05c8fd-4e06-4fdd-bfcf-dfa3cf897281	NYC Uncs	503fbed0-e326-480a-908b-fc306c65fd50
7151c747-207b-47ba-ae85-38ce92557dbf	The Ellison Frequenters	f50d8d33-8020-4a69-86c0-22d47ebb0581
a2247fce-faee-4edd-8a87-c176e3b3ea71	Walkin the Blank	2f9876f3-f53a-4ae9-ae61-16bcda66845f
c4dcee58-3656-4ac5-8398-2d1ae91f824c	STARters	bff2a058-b34f-48ce-af98-23ecdf7293a9
53dc4b9e-8b7a-417d-b56e-10e55851c099	The Conformity Gate	7ebbfa1a-edc2-41f4-a57a-caefd2e3be0e
fddf0cb9-511e-4a4f-b209-94f037ace2ce	Ghost Protocol	f5d0c8ce-9a4d-47ad-b45a-082c5a878811
6c8d94db-d4b8-4bb2-8daf-48cf045e3451	Test team	357fdbf3-de05-4c96-bc15-a242a93a0ed8
c811b678-8fde-43b9-967e-03d92bd30fa3	Test team 1	bb26e025-d4df-4219-a213-18cbf44dd6ea
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, name, is_admin, is_verified, verification_token) FROM stdin;
105d5877-be9c-418c-8bad-46832e21f536	ethan.erusha@wwt.com	$2b$10$lIgMou68fLiiEy71gbDjCOOF51rNoq.q7P54JXiA6chpM9QI97KDe	Ethan Erusha	t	t	\N
d5b2c93d-e254-4507-bd78-aa2ca24e9959	scott.robinson@wwt.com	$2b$10$MJteXMGvCW4hLO2lOPJZ0.pPQTRRMWah0leb6Flm13n19uCAMou1G	Scott Robinson	f	t	\N
aa0ae7f5-8dda-42ca-92ef-cb7b48e9659c	lim@wwt.com	$2b$10$MhCdOR6YZuEphvzr7lsfGOK52a17XNa/6sV4zFet4nOeguvJ65S/C	Manni Li	f	t	\N
3febacef-a453-4d68-aadf-9ebe4d41953d	gigi.gamez@wwt.com	$2b$10$a4ew2Ok7WbbhcHmgRDM7RufsDsGmCSUuKWCC91bn4HYCwMvKh4I0e	Gigi Gamez	f	t	\N
6d5a2e9b-6a52-41b2-839b-2557654291cc	henry.ditmore@gmail.com	$2b$10$8nHlPt2innHDoQyX3ijjRODA1J0bDI6GuODu3FRCFyrswxO9/dZT6	Henry Ditmore	f	t	\N
425e8a2b-4162-4f60-ba54-f9cf4156fdb1	stevesharpy6@gmail.com	$2b$10$SJgQCYeX2Mhn9YNSOpTBi.YFFbBf1tZB8eK7ol2JHuVKfoEackq.q	Steve Sharp	f	t	\N
824b5e22-4f6b-4339-aada-65c31d333c47	nathan.diepenbrock@wwt.com	$2b$10$zb9QjPDby9RCkHuW/CyU/.VsiK9GZ2ytCGfwHrvcyIJzE9kRk/CEG	Nate Diepenbrock	f	t	\N
4237aa27-6dcd-4847-8ba1-b53b17f3ed3b	kareena.patel@wwt.com	$2b$10$ZWm38tRvKh9S4o79CAUZc.pXnRfpbMc27GEMLBXk9hnmK8NVAVvKW	Kareena Patel	f	t	\N
710ff1fa-f978-4fe1-87d2-42afb79a7b43	viva.naini@wwt.com	$2b$10$O5nJshMbZXcy4vF3mlId4uQo959.on8Mbqo3jeKhzISYWK3vZ25mW	Vivaswath Naini	f	t	\N
0d79b6f4-43a6-4193-8389-08eff75c9a36	martinrh@wwt.com	$2b$10$EgB29NHjk4Dif.F3PX98M.2mC/fsAg6YEornlEVARGqja85XRaTOG	Rhiannon Martin	f	t	\N
36f2179e-933e-4685-89c0-761eb540299d	gaby.walton@wwt.com	$2b$10$/mPgxZqfkD5Xe/kBwSDyKOBWQUwu6ERR0oEXccvhMRO0HlpsP.2xm	Gaby Walton	f	t	\N
3a7a892b-a738-44cd-96aa-db8fdd7d1e02	karan.jain@wwt.com	$2b$10$p5xLwV.WLy2j98nzjAq82OBylPTWcTxfU6v2GvdIEuHO4kqKsDH/2	Karan Jain	f	t	\N
5110aa33-3dff-436c-b672-eee1b12db2e8	henry.cronic@wwt.com	$2b$10$WKiFURU96RLY1LivqHHKmeHOKfuyiR7JUe5H8eFExQ1e4c66AAwd6	Henry Cronic	f	t	\N
54508549-e38b-40c6-bdc4-22213c2fb461	akiva.dienstfrey@wwt.com	$2b$10$xSUm.FpKw64BqRZAqjWO5epoJWQ/vqTLW/r9gMeBbBrBGUZ/v.ole	Akiva Dienstfrey	f	t	\N
8d1a9417-749b-4de5-8726-b3c48306109c	charlie.krug@wwt.com	$2b$10$slq25etHYk3J.cnIQFEkjOskac6jgQe9f.lpG9IQsx9a/cSRSx0za	Charlie Krug	t	t	\N
ea4d147a-e988-47d9-abd2-b53d67f31dd6	frickep@wwt.com	$2b$10$v9Eu6.8i9uad6BFKK4XWpOJl85LBir7ghvzrFw7go0OHrEAZUWgg6	Pierce Fricke	f	t	\N
73f709ab-27d3-4e1f-b2d7-42c4eac09468	henry.ditmore@wwt.com	$2b$10$WQglXIgKW/2XYgzSZuKGduerCWl48bRCOm14uaWnIBCu85fpicDLK	Henry Ditmore	f	t	\N
a2acb0a6-8323-43c7-a975-bb19b40833f3	ferrisr@wwt.com	$2b$10$8sePb6hu53bxgpxYnGudDeG1iRp2vXqmoeh0pRtPs9FCFT2D86Sb2	Rachel Ferris	f	t	\N
a1792d66-8c31-4b26-bb68-0c7895f75898	joyce.zheng@wwt.com	$2b$10$AUBpA4c.ZWr16HclgvPaWOj8/TLbX9rutkur5lBWAci13/MLDBszm	Joyce Zheng	f	t	\N
9b6b3cbb-190b-4920-8021-7c26926dac14	nani.mcdaniel@wwt.com	$2b$10$X3eV45wCBQg41tYk5to4i.s3vfP21.cEzHx/32KI/q4Pm9oSxU/vm	Nani McDaniel	f	t	\N
2f9876f3-f53a-4ae9-ae61-16bcda66845f	sadlerd@wwt.com	$2b$10$RF9llpE9iypWKGKE2cq6i.6U1Ls1xQgpTnDplFprTqeJM5VuBhRp2	Dakota Sadler	f	t	\N
d2a0e7e0-2692-45e8-a923-468eb9906b7a	travis.diepenbrock@wwt.com	$2b$10$yB06UydsqstKtOqqFw88s.Ywf1dUljrtJXedrdG9JiGyoTtaztVDu	Travis Diepenbrock	f	t	\N
9997929e-8f7d-456e-b19f-a9945933889f	eschark@kpmg.com	$2b$10$1nK8qQuDKR.wi7FfFZL3J.5bhTHMWntm.f2YHDOlA4kXI/5Ps754e	Erich Schark	f	t	\N
41bd831a-1bcd-43ec-af9d-9be32752195c	Courtney.roberts@wwt.com	$2b$10$1vkvWyrguWdYKImKaaJOAuY4R.0fy9lJ0LRL5RtziVdB9FFZC09YK	Courtney Roberts	f	t	\N
86a05a77-5359-478a-9a49-7c18b28cdf41	patrick.fuller@wwt.com	$2b$10$NLKODMZyAql001n.Q6pMJu33Wv.0MF4fIGSfDCaeqNDP1bE848tBS	Patrick Fuller	f	t	\N
f43f8dd1-cf0f-49df-8241-cf6bf37ed653	sandhya.narasimharaj@wwt.com	$2b$10$zciBEvYqmRyiNfMEDsj.WepHOuwgc9jD7XoiFoUvD/WR2.jIZ2R/C	Sandhya Narasimharaj	f	t	\N
82b7c768-127a-4c94-a861-27650bbceeb3	young.chong@wwt.com	$2b$10$KAQZHrcnkZRFZ6FUmlmBO.gN1EQTyl6HFCLiwT7W6N32R.OkkLjZS	Young Chong	f	t	\N
4e1be311-3dbe-4daf-bfbc-390b061d3e68	alex.stone@wwt.com	$2b$10$j.AUWzvfpwxUS0.WjMGkkeGbWA/k45wqxAqSCCaAyBQlqfzGyFpZC	Alex Stone	f	t	\N
50349c70-f24a-4bb1-8348-98b1ce8889dd	bright.throngprasertchai@wwt.com	$2b$10$CXDFXbFolK95nhUqcblmqOaU4Bm15LhHNlJTdt14.17VBz2INuMha	Bright Throngprasertchai	f	t	\N
64694778-aab5-4227-ab3f-476898a2cebf	sasha.warren@wwt.com	$2b$10$xktUo2MdU8NbyIOu9R0dK.1VYsMMsTBV/pPmNt0UgOT4scuxlTOgW	Sasha Warren	f	t	\N
f5e03765-f03c-4b97-bbcd-c06fdae73a77	adam.cunningham@wwt.com	$2b$10$SDzE4GI0esZYt3N3ZJ.LIu/7YdcZ1KNMyhJmUc04QDBudu.v1DKCS	Adam Cunningham	f	t	\N
dd42dc24-f228-406c-858a-c8fc7100fa64	lilo.blank@wwt.com	$2b$10$Ie2pU.ALtntlWj79HzphOe.cvM6i8T9gYQbB6HYldW1LhBjqEbTtW	Lilo Blank	f	t	\N
322a2624-2a0d-416d-9b3d-f1c245266731	Nick.Walker@wwt.com	$2b$10$amZFlK4zfXAod8HOmu5N4eq2jZNNtNZj.8HJkV9gKjMlapfp6a3sa	Nick W	f	t	\N
604f1438-f5f4-4e45-a85e-1d1984969343	jillian.embrey@wwt.com	$2b$10$2O7sFi.scPP9X04D84JSROMzLPPvcXu7nH2/cKLA4GFhFeQjgM6IG	Jillian Embrey	f	t	\N
d87a96e8-d5ea-4d74-b415-2d1caacf586a	brandon.duke@wwt.com	$2b$10$i3zJzb2rJo/AWy/Ts8Cyu.jUNOROafzpAMn6nXWIwGTP7A3TQs3Na	Brandon Duke	f	t	\N
fa46bf65-d71a-48cd-8ec2-fa85915f2781	nick.macke@wwt.com	$2b$10$1O7XbOgIEadsGP36oEs6HedngHDPgVFXerVVSDb4oqOBlCHWwBYrG	Nick Macke	f	t	\N
cfc333a4-22dd-48b9-8b01-633414242492	nate.mckie@wwt.com	$2b$10$o1UdVyFkwky/qcYM2Pm3lOvPjDsjYFlscfFd9oFn86ZGbsiYRVK8C	Nate McKie	f	t	\N
45684f47-ab74-4b6e-8ac7-4eab6f0785a7	jack.ledbetter@richmond.edu	$2b$10$jHPwCcEyN0wKg.EaNJdtnOcBxwNyuoBjuWpw1nv1VWsCnuqNULFa.	Jack Ledbetter	f	t	\N
7887b155-e9dc-437b-8ad9-095246eed3b2	daniel.mccown@wwt.com	$2b$10$Fc2.k8mtyDVz.vz73S9TGOIrmsjnh3KGKosYPZ1S14NtZLLnwbdNG	Daniel McCown	f	t	\N
d4906e02-aaa1-4c9b-b7f0-138889c2d8ec	rebecca.lubbert@wwt.com	$2b$10$PmD2pgc5B3T8kxL21.PwZOnXYgKa/QQ7cvN2m/23.WP2lrhFSLvBy	Becca Lubbert	f	t	\N
b6c9dddf-715b-4dc1-9250-e9d176376f86	sarah.malzberg@wwt.com	$2b$10$XOXYFJ1QUriiHjLYfGjQ4upZZ3xvwJQNPmKRTI6NOR34QkSrK5fPS	Sarah Malzberg	f	t	\N
2a8e455b-5a2f-4901-b9fb-4e8b7a8dd163	cassidy.manns@wwt.com	$2b$10$y8ERtXMonymHTlxe.U1a7eaRGqywkAcF1KQLxREzWmwA7W7XT5fOC	Cassidy Manns	f	t	\N
8dba7324-2ac5-43a5-936c-fbd4332e6809	chris.infanti@wwt.com	$2b$10$FIpZ1aAmoj88pY6Oh4YH..qcfxCafMlkOvlzdGehdvidEIVWokJpm	Chris Infanti	f	t	\N
999f9734-12b2-49ea-b8e0-1bbf9d845f44	jeb2727@gmail.com	$2b$10$5hAs.X141U5U/tS7GypQO.FQkZn2L.hY7EdYWUoYR9PJgT0msq4xa	John Bruce	f	t	\N
ef8ad12a-3bdd-4d4e-8f5c-09ca63889732	jbrightman@kpmg.com	$2b$10$pDjUo0vSlbfwTTa9W7f7heJRjolxBnUVK2IkC55ClzXSZxeFGJ5x.	John Brightman	f	t	\N
63927d70-f978-44a0-b519-cf27ad4868b9	dana.anderson@wwt.com	$2b$10$VHbh2lJVMglDkDn2JZWFH.BPChqSNxjDJGDwU65Gf1GaTzY8FlGsu	Dana Anderson	f	t	\N
e7b87538-9731-4052-8505-7feb6d80545e	chris.brozyna@wwt.com	$2b$10$vW5PKYLPJTBZouwJtEAxxeQURXhgMIyrC66M5j443eRFW8k0Sa3hm	Chris Brozyna	f	t	\N
bc1cdbb5-6cc1-44ad-b749-a0185f7fc163	sid.thyagarajan@wwt.com	$2b$10$.hilU0j2ww6.xdoMdrcBEeg8D5cyuVq17IQcp6r8gqoZX5aNR6vQG	Sid Thyagarajan	f	t	\N
e173c701-0383-4b09-a0b8-bbf392804c2b	ross.schrader@wwt.com	$2b$10$CCZAJrA9ILNcCaxb1ki.4eNqw6.0lHiNmSgYdtBswOj8CRucr.w2y	Ross Schrader	f	t	\N
503fbed0-e326-480a-908b-fc306c65fd50	Andrew.Gally@wwt.com	$2b$10$8TzyD68J.0QGwiq70OvXEeVHKbbooS4CWJXd58AsG4tu399NzToHS	Drew Gally	f	t	\N
17be743c-7480-40d2-ad5a-dadc06a9e6bd	yoonh@wwt.com	$2b$10$AhQnmMuc56gXWUjho6doMuzi8qJgHyJdq4qSlnnbjWkBhT3dRYw6S	Haeon	f	t	\N
4bb6defc-8622-4914-9fb3-6290dbe2e825	felix.ma@wwt.com	$2b$10$Sc3feipOYuN6NNIIVBvlve6UdUwVfRgl1tx5vjCsKCGUQoHu9ey9a	Felix Ma	f	t	\N
877fe5f5-166b-466c-909a-1da09a5de786	livi.logan-wood@wwt.com	$2b$10$rT5BnS69/dvK3x7JmlJ/huElHUDAmfFhf6lLOmawyDo5lMRLIXtBy	Livi Logan-Wood	f	t	\N
f50d8d33-8020-4a69-86c0-22d47ebb0581	lauren.sutter@wwt.com	$2b$10$y27Gfjgkx10Yz7KmJFL9Wu8bezruWCLkmOBEhLHqPD.IvChTziOcS	Lauren Sutter	f	t	\N
8f7019ab-9dcd-44fe-8bc4-a14e7aaa82d2	Dan.Croghan@wwt.com	$2b$10$ZWZdllAYLvlMfmFizHAmCemuOyT/rPkTz9JTvtqwwFw4PO94MI8Uy	Dan Croghan	f	t	\N
bb66ba1d-e906-4183-b981-f6be182ebc21	margo.beck@wwt.com	$2b$10$DWEfQ6OC9Gf3U5YTWwo8Uu3PvO5kjMJPwN1RR9vu9re9QnsFbLzFC	Margo Beck	f	t	\N
fc3bcadf-7dd6-4364-bdf5-523aab8c141d	grace.lee@wwt.com	$2b$10$fo.eDpRVj20nXlxTTqpy8udcMaLvsYrtEXhklR/pIF23hZxwmHAt6	Grace Lee	f	t	\N
486f0795-598a-40e2-a71d-c8289394774c	stevensharp@kpmg.com	$2b$10$3tF50xXB7vcRWxnbO/UQ9OJZr5mxuvxnryfPbOADMOPiqH5.vOza6	Ron Mexico	f	t	\N
71fb0602-4158-4f94-9442-df5969d3184a	Kirsten.Guilliams@wwt.com	$2b$10$z.jGel.EiRvva1J47yfjvOzQxmvCTPOVtv44tIN9AwY8X9sL0SIke	Kirsten Guilliams	f	t	\N
bff2a058-b34f-48ce-af98-23ecdf7293a9	aliya.lyons@wwt.com	$2b$10$Y9l9IS0sxnOp6cL3.2c.9utC7p7y2ta7LSE6mjcacLystdY4B73MO	STARters	f	t	\N
c053fd17-5bd1-4871-970c-46591b133b23	Jeffrey.Timmermann@wwt.com	$2b$10$Rz1EXBgMD8Xmd/TEBgDg1uSl5v5CsrJz0j1MVR0oEq/Euj7vjuqRu	Jeff Timmermann	f	t	\N
d7933b27-7849-4b43-b692-993290696563	yas.seddiq@wwt.com	$2b$10$ggV5jaQcxFxY03evL8DiuuccUQpjNVwAI0Ev.rPRWU8DuglP3dniy	Yasin Seddiq	f	t	\N
cb4f7bc7-0359-4725-86ff-0c6cbbbebccd	logan.cooper2@wwt.com	$2b$10$xN/QI.La5ih7yP7qWi3TxeKNbWLDfw5C.zuzYQmJMrMBtc5.fs12i	Logan Cooper	f	t	\N
7ebbfa1a-edc2-41f4-a57a-caefd2e3be0e	tenzin.choden@wwt.com	$2b$10$exo80YRTSwwkAYG0P7plKeBFd0qhYck6rB23/Cc5e1sKwcH1YEuDG	Tenzin Choden	f	t	\N
f5d0c8ce-9a4d-47ad-b45a-082c5a878811	tom.cruise@gmail.com	$2b$10$yR92UzxFHd7DbpbeMGYrfePF3To/PiQnPf6SDGermkCAOFFAVrZu.	Tom Cruise	f	t	\N
492223d2-fe89-4726-a2e7-5e215bd40be2	sherry.apel@wwt.com	$2b$10$eHtEEnKBenHf116AHsgZlull58W69shYQE3PbQJvDFTHK5IYqDmje	Sherry Apel	f	t	\N
507f5106-91c5-4de7-aaa9-4d2de6f3c844	david.chopin@wwt.com	$2b$10$tZk.XkETphtJcQ/h.ca4xuX3mrSBIcFUhmqjDh.vd1pFzHiOfXE.m	David Chopin	f	t	\N
9e6843ad-ab99-48ff-b907-721cd378cad5	lawrence.toomey@wwt.com	$2b$10$Q738G9pyaUhyf6I3R5A8E.ehi/N3/udgUaMKNTBBgUf78SRHap9Ou	Larry Toomey	f	t	\N
59853ff0-31c2-4201-9a18-4485a65b8c6e	patelac@wwt.com	$2b$10$nMVwnUoXJ90MUEqCzwwwJuKDVJ2b3A8.hdS93tNLsjXiTwHrr4uKO	Achal Patel	f	t	\N
64fc4a1d-7f6b-4a8f-b700-24df523152f5	andrew.cummings@wwt.com	$2b$10$2tJoQT6FovvtyvJUjYNT3Ok8xM0o8t7kHyGI301PzdZOQKCF6AQCy	Andrew Cummings 	f	t	\N
32e3d9cd-d660-41f9-b311-fbb74a9a89bf	steltenj@wwt.com	$2b$10$zGVmCL6jRx3JQuSkA90kr.TU698S22dkN0KvWW4u1G5gSKwoGVvym	Jon Steltenpohl	f	t	\N
91af89c0-1035-4336-9d16-bab22ede66a2	tommy.ward@wwt.com	$2b$10$c392Dk1.2riZf7pBArH0XOVWXsT1N0zDjsdcL8g8LXMatKYqQ5Azi	Tommy Ward	f	t	\N
584b0f26-051d-4036-9b19-8c7691fa3eb2	abby.williams2@wwt.com	$2b$10$81TIZ8JhBuR444NSofLBVe5N.CtUWzitMeZginNKM3q9f.Oo6EP5e	Abby Williams	f	t	\N
205cbe81-ef13-44d4-9928-035a035373a1	amatya.agarwal@wwt.com	$2b$10$QlqDqAO4YBwHkxHb2JVOWu0tg93FDz2I3xSQGYeW9/0YJ5DAxB54G	Amatya Agarwal	f	t	\N
67caf4f1-e82f-4abb-879a-fcea3a46eb60	matt.lopes@wwt.com	$2b$10$UdxlgaAy/MgQwmmYIsMxzuKM/p3ug7sGqDxzP03R31B9o2wtbCub2	Matt Lopes	f	t	\N
357fdbf3-de05-4c96-bc15-a242a93a0ed8	ethanerusha@gmail.com	$2b$10$6tDZ/jbvm7wccy3tMY3/tuY9Aysbp.9daq/qe4DIoXZXht3I48H6q	Test	f	t	\N
bb26e025-d4df-4219-a213-18cbf44dd6ea	kristinerusha@gmail.com	$2b$10$13S21sy7qws9dNrcmZUmIezN3dOs8LzhjRukdtFaily7T.yORwN7m	Kristin Erusha	f	t	\N
\.


--
-- Data for Name: weeks; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.weeks (id, week_number, title, is_active, is_graded, is_published, intro_text, deadline) FROM stdin;
c4f01675-e13d-4053-8fb3-9d5eadb3f042	1	S6W1: Tuesday Snowpocalypsivia	f	t	t	Welcome to Upgraded Tuesday Trivia on the new website! If you are reading this, it means the website successfully works so far and that you survived Snowpocalypse 2026. Since I've moved to Denver I have learned that it never snows in Colorado, but the rest of the country regularly gets multiple feet. I hope everyone here is safe and warm and just waiting for some trivia to tide them over. Here are 10 of the hottest questions yet, guaranteed to melt any snow near you.	\N
d328396c-d796-4497-b1b1-54863974f30b	4	S6W4: Tuesday Mardi Grasrivia	f	t	t	Thank you all who submitted feedback about the site, some updates may be coming soon.	\N
c4bc4dc5-8cc0-4142-8f10-5ed1de8a618a	9	S6W9: General Knowledge Tuesday Trivia	t	f	f	The penultimate week in Season 6 is upon us. Here are ten of the finest general knowledge trivia questions ever concocted. Good luck.	2026-03-31 19:00:00
e1dbf99f-679c-4a9e-b863-c90c7cf3eb3f	2	S6W2: Second Week of Twosday Trivia	f	t	t	This week is all about that which comes after the first: the seconds. Toss away those thoughts of gold and focus on the silver medals of the world. Here are ten second-best trivia questions about the runner-ups of the trivia world.	\N
5f134cdc-1b49-4cd6-b608-810bb6a1107a	10	S6W10: Final Countdownuesday Trivia	f	f	f	If an image is worth 1000 words, there are 10,000 words waiting for you in this Tuesday Trivia round. Whether you are fighting tooth and nail for a championship or casually riding it out for love of the game, good luck this week!	2026-04-07 23:00:00
74d22bb4-6a21-4576-b2dc-bf731486f17f	6	S6W6: Tuesday Hexatrivia	f	t	t	Well last week was the easiest week of all time in Tuesday Trivia history, with an average score of 9.5. Seems I underestimated you all. I liked doing the trivia round entirely about seconds, so we're kinda running it back today. Everyone cares about the firsts and the seconds and the thirds. Sometimes even the fourths. Top 5 lists exist. But today we celebrate those forgotten souls who were the pernicious sixths. Shoutout to the sixths of the world.	2026-03-10 23:00:00
4e294a5a-0b1c-4fc4-a272-a82e8e2a2db3	3	S6W3: Tuesday Winter Olympicsivia	f	t	t	I am sure this comes as a surprise to absolutely no one, but this week is Winter Olympics Trivia! I have probably already done Olympics related trivia weeks like 5 times, but we're back for another. I would tell you to strap in and get ready, but I learned the hard way there are no straps in Winter Olympics sports; so just hang on and hope for the best as you fly down the mountain of these ten icy Tuesday Trivia questions.	\N
0ceafa7e-c327-4c76-8c25-4496e14dabac	5	S6W5: Tuesday Name Gameivia	f	t	t	You thought Tuesday Trivia questions were confusing so far? This Tuesday we are pressing our luck. The theme is name game. I will give an original clue for a person. Then I will use the | sign like that, and give a formula of clues that add up to that person's name. The answer will be one person.\nEXAMPLE QUESTION: Chicago Bulls star | biggest Jackson 5 star's first name + Peele from Key and Peele's first name\nAnswer: Michael Jordan	\N
962fd4a4-d0aa-4862-b4b3-99bff679844d	8	S6W8: St. Patrick's Tuesday Trivia	f	t	t	Super tight race at the top going into week 8, will Team Croniq defend their threepeat? Can anyone catch them? Here are ten of the greenest and Irishest questions yet.	2026-03-24 17:00:00
007a6769-ef53-4a15-ba56-45c22a232b44	7	S6W7: Tuesday Picturivia	f	t	t	Picture Round! All trivia questions this week are picture related, find your answer from the picture.	2026-03-17 17:00:00
\.


--
-- Name: replit_database_migrations_v1_id_seq; Type: SEQUENCE SET; Schema: _system; Owner: neondb_owner
--

SELECT pg_catalog.setval('_system.replit_database_migrations_v1_id_seq', 2, true);


--
-- Name: replit_database_migrations_v1 replit_database_migrations_v1_pkey; Type: CONSTRAINT; Schema: _system; Owner: neondb_owner
--

ALTER TABLE ONLY _system.replit_database_migrations_v1
    ADD CONSTRAINT replit_database_migrations_v1_pkey PRIMARY KEY (id);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: champions champions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.champions
    ADD CONSTRAINT champions_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: score_edits score_edits_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: teams teams_name_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_unique UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weeks weeks_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_pkey PRIMARY KEY (id);


--
-- Name: weeks weeks_week_number_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_week_number_unique UNIQUE (week_number);


--
-- Name: idx_replit_database_migrations_v1_build_id; Type: INDEX; Schema: _system; Owner: neondb_owner
--

CREATE UNIQUE INDEX idx_replit_database_migrations_v1_build_id ON _system.replit_database_migrations_v1 USING btree (build_id);


--
-- Name: answers answers_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: answers answers_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: champions champions_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.champions
    ADD CONSTRAINT champions_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: questions questions_week_id_weeks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_week_id_weeks_id_fk FOREIGN KEY (week_id) REFERENCES public.weeks(id);


--
-- Name: score_edits score_edits_edited_by_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_edited_by_id_users_id_fk FOREIGN KEY (edited_by_id) REFERENCES public.users(id);


--
-- Name: score_edits score_edits_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: score_edits score_edits_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: submissions submissions_submitted_by_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_submitted_by_id_users_id_fk FOREIGN KEY (submitted_by_id) REFERENCES public.users(id);


--
-- Name: submissions submissions_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: submissions submissions_week_id_weeks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_week_id_weeks_id_fk FOREIGN KEY (week_id) REFERENCES public.weeks(id);


--
-- Name: team_members team_members_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: team_members team_members_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: teams teams_lead_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_lead_id_users_id_fk FOREIGN KEY (lead_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict xTIj1AMTtl7XK4QDwOUbpfI3VDsJk3kfxE04V8gDfFHaTFWxlbHsoNspG4FL795

