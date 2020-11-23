--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 13.1

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
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: public-user
--

CREATE SEQUENCE public.albums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO "public-user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: albums; Type: TABLE; Schema: public; Owner: public-user
--

CREATE TABLE public.albums (
    id integer DEFAULT nextval('public.albums_id_seq'::regclass) NOT NULL,
    artist_id integer,
    title character varying(100),
    year character varying(4),
    record_condition character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    thumbnail character varying(100),
    condition_id integer
);


ALTER TABLE public.albums OWNER TO "public-user";

--
-- Name: artist_id_seq; Type: SEQUENCE; Schema: public; Owner: public-user
--

CREATE SEQUENCE public.artist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artist_id_seq OWNER TO "public-user";

--
-- Name: artists; Type: TABLE; Schema: public; Owner: public-user
--

CREATE TABLE public.artists (
    id integer DEFAULT nextval('public.artist_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.artists OWNER TO "public-user";

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: public-user
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO "public-user";

--
-- Name: categories; Type: TABLE; Schema: public; Owner: public-user
--

CREATE TABLE public.categories (
    id integer DEFAULT nextval('public.categories_id_seq'::regclass) NOT NULL,
    title character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO "public-user";

--
-- Name: categorizations; Type: TABLE; Schema: public; Owner: public-user
--

CREATE TABLE public.categorizations (
    source_id integer,
    source_type character varying(100),
    category_id integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categorizations OWNER TO "public-user";

--
-- Name: conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: public-user
--

CREATE SEQUENCE public.conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conditions_id_seq OWNER TO "public-user";

--
-- Name: conditions; Type: TABLE; Schema: public; Owner: public-user
--

CREATE TABLE public.conditions (
    id integer DEFAULT nextval('public.conditions_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.conditions OWNER TO "public-user";

--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: public-user
--

COPY public.albums (id, artist_id, title, year, record_condition, created_at, updated_at, thumbnail, condition_id) FROM stdin;
1	1	Badmotorfinger	1991	good	2020-11-07 22:26:53.192687	2020-11-07 22:26:53.192687	https://upload.wikimedia.org/wikipedia/en/6/63/Soundgarden_-_Badmotorfinger.jpg	\N
4	4	Nevermind	1991	good	2020-11-08 00:44:34.101733	2020-11-08 00:44:34.101733	https://upload.wikimedia.org/wikipedia/en/b/b7/NirvanaNevermindalbumcover.jpg	\N
5	8	Dirt	1992	excellent	2020-11-08 00:45:32.754132	2020-11-08 00:45:32.754132	https://images-na.ssl-images-amazon.com/images/I/51WSBLdJGAL.jpg	\N
6	8	Facelift	1990	excellent	2020-11-08 03:37:43.378457	2020-11-08 03:37:43.378457	https://upload.wikimedia.org/wikipedia/en/4/43/Alice_In_Chains-Facelift.jpg	\N
7	1	Superunknown	1994	poor	2020-11-08 03:42:06.942834	2020-11-08 03:42:06.942834	https://upload.wikimedia.org/wikipedia/en/3/3a/Superunknown.jpg	\N
8	1	Down on the Upside	1996	excellent	2020-11-08 03:42:55.503569	2020-11-08 03:42:55.503569	https://upload.wikimedia.org/wikipedia/en/c/c9/Soundgarden-DownOnTheUpside.jpg	\N
9	4	In Utero	1993	excellent	2020-11-08 03:43:31.190103	2020-11-08 03:43:31.190103	https://upload.wikimedia.org/wikipedia/en/e/e5/In_Utero_(Nirvana)_album_cover.jpg	\N
10	8	Self-Titled	1995	excellent	2020-11-08 03:44:33.988893	2020-11-08 03:44:33.988893	https://upload.wikimedia.org/wikipedia/en/2/24/Alice_in_Chains_(album).jpg	\N
11	6	Siamese Dream	1993	good	2020-11-08 03:45:49.195316	2020-11-08 03:45:49.195316	https://images-na.ssl-images-amazon.com/images/I/71od0Ktt2HL._SX522_.jpg	\N
12	6	Mellon Collie and the Inifinite Sadness	1995	good	2020-11-08 03:46:41.276805	2020-11-08 03:46:41.276805	https://images-na.ssl-images-amazon.com/images/I/411RYY901TL._QL70_ML2_.jpg	\N
13	9	Ten	1991	good	2020-11-08 03:49:58.047672	2020-11-08 03:49:58.047672	https://images-na.ssl-images-amazon.com/images/I/81eaKFGNhSL._SL1500_.jpg	\N
14	9	Vs.	1993	good	2020-11-08 03:50:26.629564	2020-11-08 03:50:26.629564	https://upload.wikimedia.org/wikipedia/en/f/f9/PearlJam-Vs.jpg	\N
15	9	Vitalogy	1994	good	2020-11-08 03:51:00.593414	2020-11-08 03:51:00.593414	https://upload.wikimedia.org/wikipedia/en/3/30/PearlJamVitalogy.jpg	\N
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: public-user
--

COPY public.artists (id, name, created_at, updated_at) FROM stdin;
1	Soundgarden	2020-11-04 04:59:15.130897	2020-11-04 04:59:15.130897
4	Nirvana	2020-11-07 08:32:57.740819	2020-11-07 08:32:57.740819
6	Smashing Pumkins	2020-11-07 08:35:12.690917	2020-11-07 08:35:12.690917
8	Alice In Chains	2020-11-07 08:40:36.022201	2020-11-07 08:40:36.022201
9	Pearl Jam	2020-11-07 08:42:56.997623	2020-11-07 08:42:56.997623
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: public-user
--

COPY public.categories (id, title, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categorizations; Type: TABLE DATA; Schema: public; Owner: public-user
--

COPY public.categorizations (source_id, source_type, category_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: conditions; Type: TABLE DATA; Schema: public; Owner: public-user
--

COPY public.conditions (id, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: public-user
--

SELECT pg_catalog.setval('public.albums_id_seq', 15, true);


--
-- Name: artist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: public-user
--

SELECT pg_catalog.setval('public.artist_id_seq', 9, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: public-user
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, false);


--
-- Name: conditions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: public-user
--

SELECT pg_catalog.setval('public.conditions_id_seq', 1, false);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: conditions conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT conditions_pkey PRIMARY KEY (id);


--
-- Name: albums fk_artist; Type: FK CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES public.artists(id);


--
-- Name: categorizations fk_category; Type: FK CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.categorizations
    ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: albums fk_condition; Type: FK CONSTRAINT; Schema: public; Owner: public-user
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT fk_condition FOREIGN KEY (condition_id) REFERENCES public.conditions(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: cloudsqlsuperuser
--

REVOKE ALL ON SCHEMA public FROM cloudsqladmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO cloudsqlsuperuser;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

