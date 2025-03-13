--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)

CREATE TABLE public.a (
    a boolean
);

ALTER TABLE public.a OWNER TO sudoers;


CREATE TABLE public.b (
    b boolean
);


ALTER TABLE public.b OWNER TO sudoers;


CREATE TABLE public.impares (
    id integer
);


ALTER TABLE public.impares OWNER TO sudoers;


CREATE TABLE public.notas (
    cpf bigint,
    id serial NOT NULL,
    tentativa1 integer,
    tentativa2 integer
);


ALTER TABLE public.notas OWNER TO sudoers;


CREATE TABLE public.pares (
    id integer
);


ALTER TABLE public.pares OWNER TO sudoers;


CREATE TABLE public.pessoas (
    cpf bigint NOT NULL,
    nome character varying(100),
    dt_nast date,
    sexo character(1)
);


ALTER TABLE public.pessoas OWNER TO sudoers;


ALTER TABLE ONLY public.notas ALTER COLUMN id SET DEFAULT nextval('public.notas_id_seq'::regclass);


COPY public.a (a) FROM stdin;
t
f
\.


COPY public.impares (id) FROM stdin;
0
1
3
5
7
9
\.


COPY public.notas (cpf, id, tentativa1, tentativa2) FROM stdin;
12345678900	1	10	\N
12345678900	2	5	8
12345678900	3	8	10
12345678900	4	\N	9
22345678922	5	10	\N
22345678922	6	10	\N
22345678922	7	9	10
22345678922	8	\N	10
32345678933	9	\N	10
32345678933	10	6	10
32345678933	10	6	5
32345678933	11	6	5
32345678933	12	7	3
32345678933	13	\N	\N
32345678933	14	\N	10
32345678933	15	\N	8
32345678933	16	10	\N
32345678933	17	9	7
\N	18	9	7
\N	19	9	10
\N	20	10	10
\N	21	\N	10
\.


COPY public.pares (id) FROM stdin;
0
2
4
6
8
\.

COPY public.pessoas (cpf, nome, dt_nast, sexo) FROM stdin;
12345678900	Administrador	1985-10-01	M
32345678931	Anne Frank	1929-06-12	F
22345678922	Edgar Allan Poe	1849-10-07	M
3234567893	Edward VII	1894-10-07	M
44345678944	Facebookson de Oliveira	2005-10-23	\N
43445678944	Jadice Denovo	2000-01-13	F
340008999	Rever SonarVida	\N	I
88345678999	Sidney	\N	M
99345678999	Sidney	\N	F
24345678944	Tepergueson Lafora	2000-10-03	M
88345678999	Sidney	\N	M
\.


SELECT pg_catalog.setval('public.notas_id_seq', 1, false);

