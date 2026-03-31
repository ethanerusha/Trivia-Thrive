--
-- PostgreSQL database dump
--

\restrict KPR6LwEuP0xCCONyPFcv7ZQsG10EycZ04asTDC8jj2hTkNflfYzNGyzvOsB1eEO

-- Dumped from database version 16.10
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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    submission_id character varying NOT NULL,
    question_id character varying NOT NULL,
    answer_text text NOT NULL,
    points_awarded numeric(2,1) DEFAULT '0'::numeric
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- Name: champions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.champions (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    year integer NOT NULL,
    season text,
    team_name text NOT NULL,
    team_id character varying,
    winning_score numeric(6,1) DEFAULT '0'::numeric
);


ALTER TABLE public.champions OWNER TO postgres;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: score_edits; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.score_edits OWNER TO postgres;

--
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.submissions OWNER TO postgres;

--
-- Name: team_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_members (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    team_id character varying NOT NULL,
    user_id character varying NOT NULL,
    is_approved boolean DEFAULT false NOT NULL,
    is_lead boolean DEFAULT false NOT NULL
);


ALTER TABLE public.team_members OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    lead_id character varying NOT NULL
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: weeks; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.weeks OWNER TO postgres;

--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answers (id, submission_id, question_id, answer_text, points_awarded) FROM stdin;
3cdc45b7-e9c8-4269-90f5-3313f31acae9	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	695f24ce-5c33-4a5d-a01b-cd34f3938782	Answer 1	0.0
bc73f3c5-f4fa-48d7-a24d-9e678eba6cd1	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	6f0c3bcb-85f8-4136-a924-5d27084ba128	Answer 2	0.0
8c6ee885-7228-452d-b1fd-e02105ae5718	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	25f76629-9374-4b2f-8aad-34a6cf0bf648	Answer 3	0.0
ae67bae4-aacf-4469-85c3-c0d6d6741b18	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	ae8343a9-a41c-45cf-9cb7-b7e663e5514c	Answer 4	0.0
c1733a01-2e6d-4f62-8ba4-08a426516ba4	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	2799f9e3-45de-4f8f-8254-b636df6a700f	Answer 5	0.0
a937d190-b040-4991-b8dc-19292cf41566	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	1af69c35-947a-43fe-8308-34e1891c637c	Answer 6	0.0
c6d3abe9-9001-4c82-9309-ab0bc0e23d52	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	a5e5e17c-95dd-4091-b449-c0597666c830	Answer 7	0.0
e7d451c8-d6f6-4a41-a145-b73324be293e	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	a15fd4f2-3fc0-445a-85be-c0b9c25516d3	Answer 8	0.0
492222c0-ea1e-4321-be86-95e8f5b51c85	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	88f4edbc-099f-4560-9da1-1059b4ae5d52	Answer 9	0.0
1fdabb15-bd92-48ab-a32c-65b361c5baee	2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	b671e657-da99-4640-977a-79c5a63458f0	Answer 10	0.0
4536d4eb-0faf-438c-84db-a0d4752161f6	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	b9c17f95-fcaa-4bef-a443-02d32021afe7	No submission	1.0
24892191-7645-4df5-8518-60595a3b2569	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	63854e3b-2c12-4c90-9afc-0aee6361706c	No submission	0.0
7edbbd90-e3f1-47c3-9f97-789e37c2cb54	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	88d0af74-724e-457e-baf0-9b0eaa481a20	No submission	0.0
2b479859-9b82-4508-97d3-739cfefeb9f4	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	68bccd5e-4d97-4fe3-9329-3bc871201cbc	No submission	0.0
e9f13106-278e-4455-b648-82a55b0171e3	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	44789cec-d277-489b-8fdd-72cb8f54a4d1	No submission	0.0
f56e4189-1476-4999-a2b8-66b677e07f59	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	1f94bbe8-9d3f-4c15-9a85-95ddfe280427	No submission	0.0
19200361-1c6f-46c9-a18c-61175381d8b5	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	0e49042f-af7b-4414-9c94-f963c1244ec2	No submission	0.0
df630193-291f-4763-b40c-17861814bd89	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	1ead5283-35c2-4207-b9bc-b5ab79cecc9d	No submission	0.0
ac9517d7-5ea8-424d-89e4-27c6538a3d2d	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	79d99553-b9c4-4d78-8b70-5a8b4e7bad38	No submission	0.0
41d9abdb-588b-4f56-9997-e4640a75d482	a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	84342dcb-467c-4965-aa92-959e49a39bd4	No submission	0.0
\.


--
-- Data for Name: champions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.champions (id, year, season, team_name, team_id, winning_score) FROM stdin;
c09d042f-0031-4095-827e-84b7aaf8b43b	2025	Season 5	The Champions	\N	100.0
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, week_id, question_number, question_text, correct_answer, max_points, image_url) FROM stdin;
695f24ce-5c33-4a5d-a01b-cd34f3938782	10658f57-dca2-4c7a-8526-fc2306546d64	1	Question 1	Answer 1	1	\N
6f0c3bcb-85f8-4136-a924-5d27084ba128	10658f57-dca2-4c7a-8526-fc2306546d64	2	Question 2	Answer 2	1	\N
25f76629-9374-4b2f-8aad-34a6cf0bf648	10658f57-dca2-4c7a-8526-fc2306546d64	3	Question 3	Answer 3	1	\N
ae8343a9-a41c-45cf-9cb7-b7e663e5514c	10658f57-dca2-4c7a-8526-fc2306546d64	4	Question 4	Answer 4	1	\N
2799f9e3-45de-4f8f-8254-b636df6a700f	10658f57-dca2-4c7a-8526-fc2306546d64	5	Question 5	Answer 5	1	\N
1af69c35-947a-43fe-8308-34e1891c637c	10658f57-dca2-4c7a-8526-fc2306546d64	6	Question 6	Answer 6	1	\N
a5e5e17c-95dd-4091-b449-c0597666c830	10658f57-dca2-4c7a-8526-fc2306546d64	7	Question 7	Answer 7	1	\N
a15fd4f2-3fc0-445a-85be-c0b9c25516d3	10658f57-dca2-4c7a-8526-fc2306546d64	8	Question 8	Answer 8	1	\N
88f4edbc-099f-4560-9da1-1059b4ae5d52	10658f57-dca2-4c7a-8526-fc2306546d64	9	Question 9	Answer 9	1	\N
b671e657-da99-4640-977a-79c5a63458f0	10658f57-dca2-4c7a-8526-fc2306546d64	10	Question 10	Answer 10	1	\N
b9c17f95-fcaa-4bef-a443-02d32021afe7	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	1	Test question 1 - no submit	Answer 1	1	\N
63854e3b-2c12-4c90-9afc-0aee6361706c	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	2	Test question 2 - no submit	Answer 2	1	\N
88d0af74-724e-457e-baf0-9b0eaa481a20	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	3	Test question 3 - no submit	Answer 3	1	\N
68bccd5e-4d97-4fe3-9329-3bc871201cbc	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	4	Test question 4 - no submit	Answer 4	1	\N
44789cec-d277-489b-8fdd-72cb8f54a4d1	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	5	Test question 5 - no submit	Answer 5	1	\N
1f94bbe8-9d3f-4c15-9a85-95ddfe280427	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	6	Test question 6 - no submit	Answer 6	1	\N
0e49042f-af7b-4414-9c94-f963c1244ec2	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	7	Test question 7 - no submit	Answer 7	1	\N
1ead5283-35c2-4207-b9bc-b5ab79cecc9d	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	8	Test question 8 - no submit	Answer 8	1	\N
79d99553-b9c4-4d78-8b70-5a8b4e7bad38	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	9	Test question 9 - no submit	Answer 9	1	\N
84342dcb-467c-4965-aa92-959e49a39bd4	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	10	Test question 10 - no submit	Answer 10	1	\N
\.


--
-- Data for Name: score_edits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.score_edits (id, submission_id, question_id, old_points, new_points, reason, edited_by_id, edited_at) FROM stdin;
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (id, team_id, week_id, submitted_at, is_graded, total_points, submitted_by_id) FROM stdin;
2a4e183a-6e31-42f2-b38f-e56c4a95e7f0	ae598e58-0736-46d0-92c4-3b2c9eb26a98	10658f57-dca2-4c7a-8526-fc2306546d64	2026-03-02 17:39:45.269853	f	0.0	e33cd6c7-ca5b-4f9c-9bbc-4f1b426da584
a39a34ba-7ffa-44e0-96c2-e5aa423bc9de	85ed754e-a46d-4946-8a11-f2e99c6f918b	5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	2026-03-18 20:23:57.931181	t	1.0	d646a8b5-4b81-463a-8378-e5d3e0e3d9bb
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_members (id, team_id, user_id, is_approved, is_lead) FROM stdin;
060aea8c-87a7-4353-b487-8c8cf1b28b1f	ae598e58-0736-46d0-92c4-3b2c9eb26a98	e33cd6c7-ca5b-4f9c-9bbc-4f1b426da584	t	t
5421cb35-0b3e-494c-8c70-843d459aff69	85ed754e-a46d-4946-8a11-f2e99c6f918b	d646a8b5-4b81-463a-8378-e5d3e0e3d9bb	t	t
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (id, name, lead_id) FROM stdin;
ae598e58-0736-46d0-92c4-3b2c9eb26a98	Timer Test Team 1772473007126	e33cd6c7-ca5b-4f9c-9bbc-4f1b426da584
85ed754e-a46d-4946-8a11-f2e99c6f918b	Non-Submitting Team 1773865300007	d646a8b5-4b81-463a-8378-e5d3e0e3d9bb
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, name, is_admin, is_verified, verification_token) FROM stdin;
3dd43c90-78ce-472f-9049-00bff94441e5	testuser_1772472873502@test.com	$2b$10$1Y4aumt9y6F30X448M/7XeuH4SdRHXz0rUwBLHXBsPBYhg5TNKt32	Test User	t	t	\N
e33cd6c7-ca5b-4f9c-9bbc-4f1b426da584	admintimer_1772473007126@test.com	$2b$10$02iO33b1BpxQ6QP1mtOBUOGPDs5rHdSW87ZNl3VJ32pTdiOX.Vg4q	Admin Timer	t	t	\N
d646a8b5-4b81-463a-8378-e5d3e0e3d9bb	gradetest_1773865300007@test.com	$2b$10$/Cu27u4zcXVsG6Hw.YWAYO0eo5rN6wQ4nfDbY6edkv.lOC/CWXMg2	Grade Admin	t	t	\N
\.


--
-- Data for Name: weeks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.weeks (id, week_number, title, is_active, is_graded, is_published, intro_text, deadline) FROM stdin;
10658f57-dca2-4c7a-8526-fc2306546d64	99	Test Week Timer	f	f	f		2026-12-31 23:59:00
5d8db765-9b8e-49b6-a2ba-6fef9ab01bc9	88	No Submit Test Week	t	t	f		\N
\.


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: champions champions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champions
    ADD CONSTRAINT champions_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: score_edits score_edits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: teams teams_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_unique UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weeks weeks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_pkey PRIMARY KEY (id);


--
-- Name: weeks weeks_week_number_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_week_number_unique UNIQUE (week_number);


--
-- Name: answers answers_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: answers answers_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: champions champions_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.champions
    ADD CONSTRAINT champions_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: questions questions_week_id_weeks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_week_id_weeks_id_fk FOREIGN KEY (week_id) REFERENCES public.weeks(id);


--
-- Name: score_edits score_edits_edited_by_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_edited_by_id_users_id_fk FOREIGN KEY (edited_by_id) REFERENCES public.users(id);


--
-- Name: score_edits score_edits_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: score_edits score_edits_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.score_edits
    ADD CONSTRAINT score_edits_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: submissions submissions_submitted_by_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_submitted_by_id_users_id_fk FOREIGN KEY (submitted_by_id) REFERENCES public.users(id);


--
-- Name: submissions submissions_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: submissions submissions_week_id_weeks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_week_id_weeks_id_fk FOREIGN KEY (week_id) REFERENCES public.weeks(id);


--
-- Name: team_members team_members_team_id_teams_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_team_id_teams_id_fk FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: team_members team_members_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: teams teams_lead_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_lead_id_users_id_fk FOREIGN KEY (lead_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict KPR6LwEuP0xCCONyPFcv7ZQsG10EycZ04asTDC8jj2hTkNflfYzNGyzvOsB1eEO

