--
-- PostgreSQL database cluster dump
--

-- Started on 2020-03-18 14:48:50

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE autumn;
ALTER ROLE autumn WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE autumn IS 'Login group for Project Autumn';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md52d23885398da31fc33ebb36aca995157';






\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2020-03-18 14:48:50

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

-- Completed on 2020-03-18 14:48:51

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2020-03-18 14:48:51

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
-- TOC entry 2806 (class 1262 OID 24673)
-- Name: AutumnBot; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "AutumnBot" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


\connect "AutumnBot"

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
-- TOC entry 6 (class 2615 OID 24733)
-- Name: Autumn; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Autumn";


--
-- TOC entry 2807 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA "Autumn"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "Autumn" IS 'Main database used by Project Autumn';


-- Completed on 2020-03-18 14:48:52

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2020-03-18 14:48:52

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
-- TOC entry 2837 (class 1262 OID 24674)
-- Name: Sessions; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "Sessions" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


\connect "Sessions"

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
-- TOC entry 2838 (class 0 OID 0)
-- Dependencies: 2837
-- Name: DATABASE "Sessions"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE "Sessions" IS 'Sessions database for Project Autumn';


--
-- TOC entry 6 (class 2615 OID 24700)
-- Name: Reports; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Reports";


--
-- TOC entry 2839 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA "Reports"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "Reports" IS 'Any reports generated from users will go here';


--
-- TOC entry 8 (class 2615 OID 24675)
-- Name: Sessions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Sessions";


--
-- TOC entry 2840 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA "Sessions"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "Sessions" IS 'Houses all information relating to sessions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 201 (class 1259 OID 24717)
-- Name: HelpReports; Type: TABLE; Schema: Reports; Owner: -
--

CREATE TABLE "Reports"."HelpReports" (
    session_id bigint NOT NULL,
    user_id bigint NOT NULL,
    reason text
);


--
-- TOC entry 2841 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE "HelpReports"; Type: COMMENT; Schema: Reports; Owner: -
--

COMMENT ON TABLE "Reports"."HelpReports" IS 'Any reports made on a person seeking help';


--
-- TOC entry 202 (class 1259 OID 24725)
-- Name: HelperReports; Type: TABLE; Schema: Reports; Owner: -
--

CREATE TABLE "Reports"."HelperReports" (
    session_id bigint NOT NULL,
    user_id bigint NOT NULL,
    reason text
);


--
-- TOC entry 2842 (class 0 OID 0)
-- Dependencies: 202
-- Name: TABLE "HelperReports"; Type: COMMENT; Schema: Reports; Owner: -
--

COMMENT ON TABLE "Reports"."HelperReports" IS 'Any reports made on a helper';


--
-- TOC entry 199 (class 1259 OID 24678)
-- Name: ActiveSessions; Type: TABLE; Schema: Sessions; Owner: -
--

CREATE TABLE "Sessions"."ActiveSessions" (
    session_id bigint NOT NULL,
    help_id bigint NOT NULL,
    helper_id bigint NOT NULL
);


--
-- TOC entry 2843 (class 0 OID 0)
-- Dependencies: 199
-- Name: TABLE "ActiveSessions"; Type: COMMENT; Schema: Sessions; Owner: -
--

COMMENT ON TABLE "Sessions"."ActiveSessions" IS 'All currently-active sessions';


--
-- TOC entry 198 (class 1259 OID 24676)
-- Name: ActiveSessions_session_id_seq; Type: SEQUENCE; Schema: Sessions; Owner: -
--

CREATE SEQUENCE "Sessions"."ActiveSessions_session_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2844 (class 0 OID 0)
-- Dependencies: 198
-- Name: ActiveSessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: Sessions; Owner: -
--

ALTER SEQUENCE "Sessions"."ActiveSessions_session_id_seq" OWNED BY "Sessions"."ActiveSessions".session_id;


--
-- TOC entry 200 (class 1259 OID 24692)
-- Name: ChatLogs; Type: TABLE; Schema: Sessions; Owner: -
--

CREATE TABLE "Sessions"."ChatLogs" (
    session_id bigint NOT NULL,
    user_id bigint,
    message_content text NOT NULL,
    message_id bigint NOT NULL
);


--
-- TOC entry 2845 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE "ChatLogs"; Type: COMMENT; Schema: Sessions; Owner: -
--

COMMENT ON TABLE "Sessions"."ChatLogs" IS 'Chat logs for Project Autumn';


--
-- TOC entry 2702 (class 2604 OID 24681)
-- Name: ActiveSessions session_id; Type: DEFAULT; Schema: Sessions; Owner: -
--

ALTER TABLE ONLY "Sessions"."ActiveSessions" ALTER COLUMN session_id SET DEFAULT nextval('"Sessions"."ActiveSessions_session_id_seq"'::regclass);


--
-- TOC entry 2708 (class 2606 OID 24724)
-- Name: HelpReports HelpReports_pkey; Type: CONSTRAINT; Schema: Reports; Owner: -
--

ALTER TABLE ONLY "Reports"."HelpReports"
    ADD CONSTRAINT "HelpReports_pkey" PRIMARY KEY (session_id, user_id);


--
-- TOC entry 2710 (class 2606 OID 24732)
-- Name: HelperReports HelperReports_pkey; Type: CONSTRAINT; Schema: Reports; Owner: -
--

ALTER TABLE ONLY "Reports"."HelperReports"
    ADD CONSTRAINT "HelperReports_pkey" PRIMARY KEY (session_id, user_id);


--
-- TOC entry 2704 (class 2606 OID 24683)
-- Name: ActiveSessions ActiveSessions_pkey; Type: CONSTRAINT; Schema: Sessions; Owner: -
--

ALTER TABLE ONLY "Sessions"."ActiveSessions"
    ADD CONSTRAINT "ActiveSessions_pkey" PRIMARY KEY (session_id, help_id, helper_id);


--
-- TOC entry 2706 (class 2606 OID 24699)
-- Name: ChatLogs ChatLogs_pkey1; Type: CONSTRAINT; Schema: Sessions; Owner: -
--

ALTER TABLE ONLY "Sessions"."ChatLogs"
    ADD CONSTRAINT "ChatLogs_pkey1" PRIMARY KEY (session_id);


-- Completed on 2020-03-18 14:48:53

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2020-03-18 14:48:53

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
-- TOC entry 2823 (class 1262 OID 24636)
-- Name: chat_logs; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE chat_logs WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


\connect chat_logs

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
-- TOC entry 2824 (class 0 OID 0)
-- Dependencies: 2823
-- Name: DATABASE chat_logs; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON DATABASE chat_logs IS 'Chat log database for Juniper';


--
-- TOC entry 5 (class 2615 OID 24638)
-- Name: logs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA logs;


--
-- TOC entry 2825 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA logs; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA logs IS 'All logs from Juniper';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 24650)
-- Name: logs; Type: TABLE; Schema: logs; Owner: -
--

CREATE TABLE logs.logs (
    session_id bigint NOT NULL,
    message_id bigint NOT NULL,
    message_content text NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 24658)
-- Name: sessions; Type: TABLE; Schema: logs; Owner: -
--

CREATE TABLE logs.sessions (
    session_id bigint NOT NULL,
    user_id bigint NOT NULL,
    helper_id bigint NOT NULL
);


--
-- TOC entry 2826 (class 0 OID 0)
-- Dependencies: 197
-- Name: TABLE sessions; Type: COMMENT; Schema: logs; Owner: -
--

COMMENT ON TABLE logs.sessions IS 'Sessions stored by Juniper';


--
-- TOC entry 2689 (class 2606 OID 24664)
-- Name: logs logs_message_id_key; Type: CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.logs
    ADD CONSTRAINT logs_message_id_key UNIQUE (message_id);


--
-- TOC entry 2691 (class 2606 OID 24657)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (session_id, message_id);


--
-- TOC entry 2693 (class 2606 OID 24662)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id, user_id, helper_id);


--
-- TOC entry 2695 (class 2606 OID 24666)
-- Name: sessions sessions_session_id_key; Type: CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.sessions
    ADD CONSTRAINT sessions_session_id_key UNIQUE (session_id);


--
-- TOC entry 2696 (class 2606 OID 24667)
-- Name: logs logs_session_id_fkey; Type: FK CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.logs
    ADD CONSTRAINT logs_session_id_fkey FOREIGN KEY (session_id) REFERENCES logs.sessions(session_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2020-03-18 14:48:54

--
-- PostgreSQL database dump complete
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2020-03-18 14:48:54

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
-- TOC entry 1 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 2827 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16425)
-- Name: monsterdat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.monsterdat (
    monsterid text NOT NULL,
    name text NOT NULL,
    theme text,
    protector integer,
    mage integer,
    warrior integer,
    cleric integer,
    hero integer,
    titan integer,
    paladin integer,
    berserk integer,
    wizard integer,
    sagacious integer,
    sorcerer integer,
    knight integer,
    defender integer,
    mercenary integer,
    priest integer,
    assassin integer,
    bandit integer,
    str integer,
    dex integer,
    dur integer,
    intel integer,
    cha integer,
    wis integer,
    prot integer,
    mana integer,
    currentaura integer,
    currenthealth integer,
    currentmana integer,
    abilities text NOT NULL,
    ai integer
);


--
-- TOC entry 199 (class 1259 OID 16433)
-- Name: playerdat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.playerdat (
    userid text NOT NULL,
    name text,
    exp integer,
    rank text,
    age integer,
    birthday text,
    height text,
    year integer,
    gender text,
    aura text,
    image1 text,
    image2 text,
    theme text,
    info text,
    backstory text,
    protector integer,
    mage integer,
    warrior integer,
    cleric integer,
    hero integer,
    titan integer,
    paladin integer,
    berserk integer,
    wizard integer,
    sagacious integer,
    sorcerer integer,
    knight integer,
    defender integer,
    mercenary integer,
    priest integer,
    assassin integer,
    bandit integer,
    str integer,
    dex integer,
    dur integer,
    intel integer,
    cha integer,
    wis integer,
    prot integer,
    mana integer,
    currentaura integer,
    currenthealth integer,
    currentmana integer,
    abilities text,
    info_em text,
    stat_em text,
    skill_em text,
    study_em text,
    class_em text
);


--
-- TOC entry 197 (class 1259 OID 16417)
-- Name: userdat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.userdat (
    userid text NOT NULL,
    rankexp integer NOT NULL,
    warnings text
);


--
-- TOC entry 2698 (class 2606 OID 16432)
-- Name: monsterdat monsterdat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monsterdat
    ADD CONSTRAINT monsterdat_pkey PRIMARY KEY (monsterid);


--
-- TOC entry 2700 (class 2606 OID 24635)
-- Name: playerdat playerdat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.playerdat
    ADD CONSTRAINT playerdat_pkey PRIMARY KEY (userid);


--
-- TOC entry 2696 (class 2606 OID 16424)
-- Name: userdat userdat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.userdat
    ADD CONSTRAINT userdat_pkey PRIMARY KEY (userid);


-- Completed on 2020-03-18 14:48:55

--
-- PostgreSQL database dump complete
--

-- Completed on 2020-03-18 14:48:55

--
-- PostgreSQL database cluster dump complete
--

